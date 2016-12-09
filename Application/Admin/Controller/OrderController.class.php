<?php
/**
 * OrderController.class.php - 订单管理-订单信息管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 2016-11-28 10:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;

class OrderController extends CommonController {
    
    /**
     * 订单列表
     */
    public function orderList(){
        
        //搜索信息
        $search['hotel_name']  = I('get.hotel_name','');
        $search['order_no']  = I('get.order_no',0);
        $search['begin_time']   = I('get.begin_time','');
        $search['end_time']     = I('get.end_time','');        
        $search['data_status']     = I('get.data_status',0);        
        $search['payment']     = I('get.payment',0);        
        $this->assign($search);        
        
        
        //搜索条件
        $_map['data_status'] = array('neq',99);
        
        //订单号
        if(!empty($search['order_no'])){
            $_map['order_no'] = array('like','%'.$search['order_no'].'%');
        }
        //订单状态
        if($search['data_status']){
            $_map['data_status'] = $search['data_status'];
        }
        //订单时间
        if(!empty($search['begin_time']) && !empty($search['end_time'])){
            $_begin_time = strtotime($search['begin_time']);
            $_end_time = strtotime($search['end_time'])+24*60*60;
            $_map['create_time'] = array(array('egt',$_begin_time),array('elt',$_end_time)) ;
        }elseif (!empty($search['begin_time'])) {
            $_begin_time = strtotime($search['begin_time']);
            $_map['create_time'] = array('egt',$_begin_time);
        }elseif (!empty($search['end_time'])) {
            $_end_time = strtotime($search['end_time'])+24*60*60;
            $_map['create_time'] = array('elt',$_end_time);
        }
        //销售商户
        if(!empty($search['hotel_name'])){
            //查询所有酒店ID（like）
            $_where['hotel_name'] = array('like','%'.$search['hotel_name'].'%');
            $hotel_list = D('HotelInfo')->field('id')->where($_where)->select();
            foreach ($hotel_list as $val) {
                $hotel_id[] = $val['id'];
            }
            //酒店条件
            if(!empty($hotel_id)){
                $_map['hotel_id'] = array('in',$hotel_id);
            }else{
                $_map['hotel_id'] = 0;
            }
        }
        //支付方式
        if(!empty($search['payment'])){
            $_map['payment'] = $search['payment'];
        }
        
        //当前页数
        $page_index  = I('get.p',1);
        
        $model = D('OrderInfo');
        $list = $model->where($_map)->order('create_time desc')->page($page_index,C('PAGE_SIZE'))->select();
        $count = $model->where($_map)->count();
        
        //遍历
        foreach ($list as &$val) {
            //订单商品信息
            $_list = D('OrderGoods')->where(array('order_no'=>$val['order_no']))->select();
            foreach ($_list as $v) {
                $val['goods_info'] .= $v['goods_name'].';';
            }
            $val['goods_info'] = (substr($val['goods_info'], -1) === ';')?substr($val['goods_info'],0,-1):'';
        }
        
        $page = show_page($count);
        $page['list'] = $list;
        
        

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 获取订单详情
     */
    public function getOrderInfo(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        $order_no = I('post.order_no');
        if(!$order_no){
            $this->ajaxReturnErr();
        }
        
        //订单详情
        $order_info = D('OrderInfo')->where(array('order_no'=>$order_no))->find();
        
        $order_info['payment'] = ($order_info['payment'] == 1)?'在线支付':($order_info['payment'] == 2)?'货到付款':'转房账';
        $order_info['pay_status'] = ($order_info['pay_status'] == 1)?'未支付':'已支付';
        
        //订单日志
        $order_info['logs'] = M('OrderLogs')->where(array('order_no'=>$order_no,'log_type'=>array('gt',0)))->order('create_time asc')->select();
        
        foreach ($order_info['logs'] as &$v) {
            switch ($v['log_type']) {
                case 1:
                    $v['order_msg'] = '下单成功';
                    break;
                case 2:
                    $v['order_msg'] = '配送完成';
                    break;
                case 3:
                    $v['order_msg'] = '订单取消';
                    break;                
            }            
        }
        
        //订单商品详情 $order_info['goods_list']
        $_list = D('OrderGoods')->where(array('order_no'=>$order_no))->select();
        foreach ($_list as &$val) {
            $src = get_src($val['resource_id']);
            $val['res_path'] = $src?$src:'';
        }
        $order_info['goods_list'] = $_list;
        
        //设备详情
        $order_info['device_info'] = M('RoomDevice')->where(array('id'=>$order_info['device_id']))->find();
        
        $this->ajaxReturnSuccess($order_info);
    }
}