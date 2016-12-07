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
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件    
        if(!empty($search_key)){
            $_map['order_no'] = array('like','%'.$search_key.'%');
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
        $order_info['logs'] = M('OrderLogs')->where(array('order_no'=>$order_no))->order('create_time asc')->select();
        
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