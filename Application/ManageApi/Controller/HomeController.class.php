<?php
/**
 * HomeController.class.php - 管家部APP接口首页信息
 * @package ManageApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author PAD PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月10日  09:05
 * @version V1.0.0
 */
namespace ManageApi\Controller;

class HomeController extends CommonController {
    public function getHotelInfo(){
        //获取酒店信息
        $device_address = trim($this->I['only_token']); //设备唯一识别码
        if(isset($device_address) && !empty($device_address)) {
            $room_info = M("room_info");
            $_room_info = $room_info->field('a.id as room_id, a.hotel_id, a.room_name, a.room_code, a.build_id, a.floor_id, b.id as device_id, b.telephone, b.position') -> alias('a')
                ->join('__ROOM_DEVICE__ b ON a.id = b.room_id', 'left')
                ->where(array('b.device_address' => $device_address, 'a.data_status' => 1))
                ->find();

            if($_room_info){
                $_info = M("hotel_info");

                $app_version = trim($this->I['app_version']); //APP版本号
                M('room_device') -> where(['id' => $_room_info['device_id']]) -> save(['app_version' => $app_version]);

                $_hotel_info = $_info->field('a.hotel_code, a.group_code, a.customer_code, a.hotel_name, a.interface_type, a.interface_url, a.para1, a.para2, a.para3, a.para4, a.city_id, b.res_path as logo_path')
                    -> alias('a')
                    -> join('__RESOURCE__ b ON a.resource_id = b.id', 'LEFT')
                    ->where(array('a.id' => $_room_info['hotel_id'], 'a.data_status' => 1))
                    ->find();

                if($_hotel_info){
                    $_hotel_info['logo_path'] = generateImagePath($_hotel_info['logo_path']);
                    $_hotel_info = array_merge($_hotel_info, $_room_info);
                    $this -> result = array_merge($this -> result, $_hotel_info) ;

                    $_conf_info = M("config_info");
                    $_conf_info = $_conf_info->field('conf_name, conf_value')
                        ->where(array('conf_code' => 'PIC_PATH', 'data_status' => 1))
                        ->find();

                    $this -> result['pic_path'] = '';
                    if($_conf_info){
                        $_pic_path = M('resource') -> field('res_path') -> where(['id' => trim($_conf_info['conf_value'])]) -> find();
                        if($_pic_path){
                            $this -> result['pic_path'] = generateImagePath($_pic_path['res_path']);
                        }
                    }

                    $_wifi_info = M("wifi_service");
                    $_wifi_info = $_wifi_info->field('link_method')
                        ->where(array('hotel_id' => $_room_info['hotel_id'], 'data_status' => 1))
                        ->find();

                    if($_wifi_info){
                        $this -> result['link_method'] = $_wifi_info['link_method'];
                    }else{
                        $this -> result['link_method'] = '';
                    }
                }else{
                    $this -> result = array_merge($this -> result, $this -> status['100000']) ;
                }
            }else{
                $this -> result = array_merge($this -> result, $this -> status['300000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['400000']) ;
        }

        $this->ajaxReturn($this->result);
    }


    //获取迷你吧未处理订单列表
    public function getOrderList(){
        $hotel_id = trim($this->I['hotel_id']);
        $floor_ids = trim($this->I['floor_ids'], ','); //二级服务ID
        $page_no = trim($this->I['page_no']);
        $list_count = trim($this->I['list_count']);

        if( isset($floor_ids) && !empty($floor_ids) && isset($hotel_id) ) {
            $_order_list = M("order_info");
            $_result = true;

            $_map['data_status'] = 1;
            $_map['hotel_id'] = $hotel_id;

            if( is_numeric($floor_ids) && $floor_ids>0) {
                $_map['floor_id'] = array('eq', $floor_ids);
            }else if(false !== stristr($floor_ids, '[')){
                $_map['floor_id'] = array('in', json_decode($floor_ids, true));
            }else if(false !== stristr($floor_ids, ',')){
                $_map['floor_id'] = array('in', $floor_ids);
            }else if('AA' !== $floor_ids){
                $_result = false;
            }

            if(!isset($page_no)){
                $page_no = 1;
            }else if($page_no<=0){
                $page_no = 1;
            }

            if(!isset($list_count)){
                $list_count = 10;
            }else if($list_count<=0){
                $list_count = 10;
            }


            if($_result) {
                $msg_count = $_order_list -> where($_map) -> count('order_no');

                if(isset($msg_count) && $msg_count>0) {
                    //获取订单列表
                    $order_list = $_order_list->field(
                        'order_no,                           
                      create_time,                        
                      room_name,                       
                      room_phone,                         
                      data_status as order_status,       
                      null as goods_list                  
                     ')->where($_map)
                        ->limit(($page_no - 1) * $list_count, $list_count)
                        ->order(['create_time' => 'desc'])
                        ->select();

                    if($order_list) {
                        $_arr_order_no = array_unique(array_column($order_list, 'order_no'));
                        unset($_map);
                        $_map['order_no'] = ['in', $_arr_order_no];

                        //获取对应订单的商品信息列表
                        $goods_list = M('order_goods')->field('order_no, goods_name, goods_quantity')
                            ->where($_map)
                            ->select();

                        //初始化中间数组(订单号为键值)
                        $arrOrderNo = array_fill_keys($_arr_order_no, []);

                        //将商品信息关联到订单号
                        foreach ($goods_list as $item) {
                            array_push($arrOrderNo[$item['order_no']], ['goods_name' => $item['goods_name'], 'goods_count' => $item['goods_quantity']]);
                        }

                        //通过订单号，将对应商品列表信息，关联到订单列表上
                        foreach ($order_list as $key => $value) {
                            if(array_key_exists($value['order_no'], $arrOrderNo)){
                                $order_list[$key]['goods_list'] = &$arrOrderNo[$value['order_no']];
                            }else{
                                $order_list[$key]['goods_list'] = [];
                            }
                        }

                        $this->result = array_merge($this->result, ['msg_count' => $msg_count, 'page_no' => $page_no, 'list_count' => $list_count]);
                        $this->result = array_merge($this->result, ['list' => $order_list]);
                    }else {
                        $this->result = array_merge($this->result, ['msg_count' => $msg_count, 'page_no' => $page_no, 'list_count' => $list_count]);
                        $this->result = array_merge($this->result, ['list' => []]);
                        $this->result = array_merge($this->result, $this->status['900005']);
                    }
                }else{
                    $this->result = array_merge($this->result, ['msg_count' => 0, 'page_no' => $page_no, 'list_count' => $list_count]);
                    $this->result = array_merge($this->result, ['list' => []]);
                    $this->result = array_merge($this->result, $this->status['900005']);
                }
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100007']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取迷你吧订单数量
    public function getOrderCount(){
        $hotel_id = trim($this->I['hotel_id']);
        $floor_ids = trim($this->I['floor_ids'], ',');

        if( isset($floor_ids) && !empty($floor_ids) && isset($hotel_id) ) {
            $_order_list = M("order_info");
            $_result = true;

            $_map['data_status'] = 1;
            $_map['hotel_id'] = $hotel_id;

            if( is_numeric($floor_ids) && $floor_ids>0) {
                $_map['floor_id'] = array('eq', $floor_ids);
            }else if(false !== stristr($floor_ids, '[')){
                $_map['floor_id'] = array('in', json_decode($floor_ids, true));
            }else if(false !== stristr($floor_ids, ',')){
                $_map['floor_id'] = array('in', $floor_ids);
            }else if('AA' !== $floor_ids){
                $_result = false;
            }

            if($_result) {
                $msg_count = $_order_list -> where($_map) -> count('order_no');
                $this->result = array_merge($this->result, ['msg_count' => $msg_count]);
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100007']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //订单状态修改
    function setOrderStatus(){
        $order_no = trim($this->I['order_no']); //订单号
        $staff_id = trim($this->I['staff_id']); //接收服务的员工ID
        $order_status = trim($this->I['order_status']); //消息状态
        $cancel_content = trim($this->I['cancel_content']); //取消原因

        if(isset($order_no) && !empty($order_no) && isset($order_status) && (3 == intval($order_status) or 4 == intval($order_status))) {
            $cancel_content = strlen($cancel_content)>0?$cancel_content:null;
            $_msg = array_merge($this->I, ['msg' => '']);

            $_order_info = M("order_info");

            $_data = [
                'staff_id' => $staff_id,
                'data_status' => (intval($order_status) == 4)?4:3,
                'cancel_content' => $cancel_content,
                'update_time' => time()
            ];

            $order_info = $_order_info -> field('order_no') -> where(['order_no' => $order_no, 'data_status' => 1]) -> find();
            if($order_info) {
                $_order_info->startTrans();
                $rs = $_order_info->data($_data)->where(['order_no' => $order_no, 'data_status' => 1])->save();
                if (!$rs) {
                    $_msg['msg'] = $this -> status['900007']['resMsg'];
                    D('Order', 'Api') -> logs($_msg, $order_no);
                    $this->result = array_merge($this->result, $this->status['900007']);
                    $_order_info->rollback();
                } else {
                    $_msg_service = M('msg_service');
                    $condition['a.data_status'] = 1;
                    $condition['_string'] = 'b.order_no="' . $order_no . '" OR c.order_no = "' . $order_no . '"';


                    $_msg_list = $_msg_service->field('a.id')->alias('a')
                        ->join('__MSG_ORDER__ b ON a.id = b.msg_id', 'LEFT')
                        ->join('__ORDER_CALL__ c ON a.id = c.msg_id', 'LEFT')
                        ->where($condition)->select();

                    if ($_msg_list) {
                        $_msg_ids = array_unique(array_column($_msg_list, 'id'));
                        $msg_change = $_msg_service->data(['staff_id' => $staff_id, 'update_time' => time(), 'data_status' => (intval($order_status) == 4) ? 2 : 99])->where(['id' => ['in', $_msg_ids]])->save();

                        if (!$msg_change) {
                            $_msg['msg'] = $this -> status['900010']['resMsg'];
                            D('Order', 'Api') -> logs($_msg, $order_no);
                            $_order_info->rollback();
                            $this->result = array_merge($this->result, $this->status['900010']);
                        } else {
                            $_msg['msg'] = (intval($order_status) == 4)?'订单配送，接收服务完成，':'订单取消完成, ';
                            $_msg['msg'] .= $this -> status['900012']['resMsg'];
                            $_msg['log_type'] = (intval($order_status) == 4)?2:3;
                            D('Order', 'Api') -> logs($_msg, $order_no);
                            $_order_info->commit();
                        }
                    } else {
                        $_msg['msg'] = $this -> status['900009']['resMsg'];
                        D('Order', 'Api') -> logs($_msg, $order_no);
                        $_order_info->rollback();
                        $this->result = array_merge($this->result, $this->status['900009']);
                    }
                }
            }else{
                $_msg['msg'] = $this -> status['900011']['resMsg'];
                D('Order', 'Api') -> logs($_msg, $order_no);
                $this->result = array_merge($this->result, $this->status['900011']);
            }
        }else{
            $_msg['msg'] = $this -> status['4']['resMsg'];
            D('Order', 'Api') -> logs($_msg, $order_no);
            $this->result = array_merge($this->result, $this->status['4']);
        }

        $this->ajaxReturn($this->result);
    }


    //获取迷你吧历史订单列表
    public function getOrderHistoryList(){
        $hotel_id = trim($this->I['hotel_id']);
        $staff_id = trim($this->I['staff_id']); //员工ID
        $page_no = trim($this->I['page_no']);
        $list_count = trim($this->I['list_count']);

        if( isset($staff_id) && !empty($staff_id) && isset($hotel_id) ) {
            $_order_list = M("order_info");
            $_result = true;
            $_map['data_status'] = ['gt', 1];
            $_map['hotel_id'] = $hotel_id;

            if( is_numeric($staff_id) && $staff_id>0) {
                $_map['staff_id'] = array('eq', $staff_id);
            }

            if(!isset($page_no)){
                $page_no = 1;
            }else if($page_no<=0){
                $page_no = 1;
            }

            if(!isset($list_count)){
                $list_count = 10;
            }else if($list_count<=0){
                $list_count = 10;
            }


            if($_result) {
                //获取订单列表
                $order_list = $_order_list->field(
                   'order_no,  
                 create_time,
                 update_time,                        
                 room_name,                       
                 room_phone,                         
                 data_status as order_status,       
                 null as goods_list                  
                ')
                   -> where($_map)
                   -> limit(($page_no - 1) * $list_count, $list_count)
                   -> order(['update_time' => 'desc'])
                   -> select();

                if($order_list) {
                    $_arr_order_no = array_unique(array_column($order_list, 'order_no'));
                    unset($_map);
                    $_map['order_no'] = ['in', $_arr_order_no];

                    //获取对应订单的商品信息列表
                    $goods_list = M('order_goods')->field('order_no, goods_name, goods_quantity')
                        ->where($_map)
                        ->select();

                    //初始化中间数组(订单号为键值)
                    $arrOrderNo = array_fill_keys($_arr_order_no, []);

                    //将商品信息关联到订单号
                    foreach ($goods_list as $item) {
                        array_push($arrOrderNo[$item['order_no']], ['goods_name' => $item['goods_name'], 'goods_count' => $item['goods_quantity']]);
                    }

                    //通过订单号，将对应商品列表信息，关联到订单列表上
                    foreach ($order_list as $key => $value) {
                        if(array_key_exists($value['order_no'], $arrOrderNo)){
                            $order_list[$key]['goods_list'] = &$arrOrderNo[$value['order_no']];
                        }else{
                            $order_list[$key]['goods_list'] = [];
                        }
                    }

                    $this->result = array_merge($this->result, ['page_no' => $page_no, 'list_count' => $list_count]);
                    $this->result = array_merge($this->result, ['list' => $order_list]);
                }else {
                    $this->result = array_merge($this->result, ['list' => []]);
                    $this->result = array_merge($this->result, $this->status['900005']);
                }
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100007']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取订单未处理催叫列表
    /*public function getUnCallList(){
        $floor_ids = trim($this->I['floor_ids'], ',');
        $page_no = trim($this->I['page_no'], ',');
        $list_count = trim($this->I['list_count'], ',');

        if(isset($floor_ids) && !empty($floor_ids)) {
            $_msg_service = M("msg_service");
            $_result = true;

            $_map['data_status'] = 1;
            $_map['msg_type'] = 4;
            $_map['create_time'] = ['lt', time()];


            if( is_numeric($floor_ids) && $floor_ids>0) {
                $_map['floor_id'] = array('eq', $floor_ids);
            }else if(false !== stristr($floor_ids, '[')){
                $_map['floor_id'] = array('in', json_decode($floor_ids, true));
            }else if(false !== stristr($floor_ids, ',')){
                $_map['floor_id'] = array('in', $floor_ids);
            }else if('AA' !== $floor_ids){
                $_result = false;
            }

            if($_result) {
                if(!isset($page_no)){
                    $page_no = 1;
                }else if($page_no<=0){
                    $page_no = 1;
                }

                if(!isset($list_count)){
                    $list_count = 10;
                }else if($list_count<=0){
                    $list_count = 10;
                }

                $msg_service = $_msg_service->field('a.id as msg_id, a.msg_content, a.room_name, a.room_phone, a.create_time, b.order_no')
                    -> join('__MSG_ORDER__ b ON a.id = b.msg_id')
                    ->where($_map)
                    ->limit(($page_no - 1) * $list_count, $list_count)
                    ->order('create_time desc')->select();

                if ($msg_service) {
                    $this->result = array_merge($this->result, ['page_no' => $page_no, 'list_count' => $list_count]);
                    $this->result = array_merge($this->result, ['list' => $msg_service]);
                    /*$_arr_msg_id = array_column($msg_service, 'msg_id');
                    $_data = [
                        'data_status' => 2
                    ];
                    $_msg_service -> startTrans();
                    $rs = $_msg_service -> data($_data) -> where(['id' =>['in', $_arr_msg_id]]) -> save();
                    if($rs){
                        $_msg_service -> commit();
                        $this -> result = array_merge($this -> result, ['list' => $msg_service]);
                    }else{
                        $_msg_service ->rollback();
                        $this -> result = array_merge($this -> result, ['list' => []]);
                        $this -> result = array_merge($this -> result, $this -> status['600008']) ;
                    }*/
                /*} else {
                    $this->result = array_merge($this->result, ['page_no' => $page_no, 'list_count' => $list_count]);
                    $this->result['list'] = [];
                    $this->result = array_merge($this->result, $this->status['300012']);
                }
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }*/

    //获取催叫服务总数，根据msg_type区分客房催叫还是订单催叫
    public function getServiceCallCount(){
        $hotel_id = trim($this->I['hotel_id']);
        $msg_type = trim($this->I['msg_type']);
        $floor_ids = trim($this->I['floor_ids'], ',');

        if( isset($floor_ids) && !empty($floor_ids) && isset($hotel_id) && isset($msg_type) ) {
            $_msg_service = M("msg_service");
            $_result = true;

            $_map['hotel_id'] = $hotel_id;
            $_map['data_status'] = 1;
            $_map['msg_type'] = $msg_type;
            $this -> result['call_count'] = 0;


            if (is_numeric($floor_ids) && $floor_ids > 0) {
                $_map['floor_id'] = array('eq', $floor_ids);
            } else if (false !== stristr($floor_ids, '[')) {
                $_map['floor_id'] = array('in', json_decode($floor_ids, true));
            } else if (false !== stristr($floor_ids, ',')) {
                $_map['floor_id'] = array('in', $floor_ids);
            } else if ('AA' !== $floor_ids) {
                $_result = false;
            }

            if ($_result) {
                $msg_service_count = $_msg_service -> where($_map) -> count('id');
                if ($msg_service_count) {
                    $this -> result = array_merge($this -> result, ['call_count' => $msg_service_count]);
                }
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }

        $this->ajaxReturn($this->result);
    }


    //获取迷你吧催叫订单列表
    public function getCallOrderList(){
        $hotel_id = trim($this->I['hotel_id']);
        $floor_ids = trim($this->I['floor_ids'], ','); //二级服务ID
        $page_no = trim($this->I['page_no']);
        $list_count = trim($this->I['list_count']);

        if( isset($floor_ids) && !empty($floor_ids) && isset($hotel_id) ) {
            $_order_list = M("order_info");
            $_result = true;

            $_map['a.data_status'] = 1;
            $_map['a.msg_type'] = 4;
            $_map['a.hotel_id'] = $hotel_id;

            if( is_numeric($floor_ids) && $floor_ids>0) {
                $_map['a.floor_id'] = array('eq', $floor_ids);
            }else if(false !== stristr($floor_ids, '[')){
                $_map['a.floor_id'] = array('in', json_decode($floor_ids, true));
            }else if(false !== stristr($floor_ids, ',')){
                $_map['a.floor_id'] = array('in', $floor_ids);
            }else if('AA' !== $floor_ids){
                $_result = false;
            }

            if(!isset($page_no)){
                $page_no = 1;
            }else if($page_no<=0){
                $page_no = 1;
            }

            if(!isset($list_count)){
                $list_count = 10;
            }else if($list_count<=0){
                $list_count = 10;
            }


            if($_result) {
                $_msg_service = M("msg_service");
                $msg_count = $_msg_service -> alias('a') -> where($_map) -> count('id');

                if (isset($msg_count) && $msg_count > 0) {
                    $msg_service = $_msg_service->field('a.id as msg_id, b.order_no') -> alias('a')
                        -> join('__ORDER_CALL__ b ON a.id = b.msg_id')
                        ->where($_map)
                        ->limit(($page_no - 1) * $list_count, $list_count)
                        ->order('a.create_time desc') -> select();


                    if($msg_service) {
                        unset($_map);
                        $_arr_order_no = array_unique(array_column($msg_service, 'order_no'));
                        $_map['data_status'] = 1;
                        $_map['order_no'] = ['in', $_arr_order_no];
                        //获取订单列表
                        $order_list = $_order_list->field(
                            'order_no,                           
                         create_time,                        
                         room_name,                       
                         room_phone,                         
                         data_status as order_status,       
                         null as goods_list                  
                        ')->where($_map)
                            ->order(['create_time' => 'desc'])
                            ->select();
                        //$_arr_order_no = array_column($order_list, 'order_no');
                        //$_map['order_no'] = ['in', $_arr_order_no];
                        unset($_map['data_status']);

                        //获取对应订单的商品信息列表
                        $goods_list = M('order_goods')->field('order_no, goods_name, goods_quantity')
                            ->where($_map)
                            ->select();

                        //初始化中间数组(订单号为键值)
                        $arrOrderNo = array_fill_keys($_arr_order_no, []);

                        //将商品信息关联到订单号
                        foreach ($goods_list as $item) {
                            array_push($arrOrderNo[$item['order_no']], ['goods_name' => $item['goods_name'], 'goods_count' => $item['goods_quantity']]);
                        }


                        if ($order_list) {
                            //通过订单号，将对应商品列表信息，关联到订单列表上
                            foreach ($order_list as $key => $value) {
                                if(array_key_exists($value['order_no'], $arrOrderNo)){
                                    $order_list[$key]['goods_list'] = &$arrOrderNo[$value['order_no']];
                                }else{
                                    $order_list[$key]['goods_list'] = [];
                                }
                            }

                            $this->result = array_merge($this->result, ['msg_count' => $msg_count, 'page_no' => $page_no, 'list_count' => $list_count]);
                            $this->result = array_merge($this->result, ['list' => $order_list]);
                        } else {
                            $this->result = array_merge($this->result, ['msg_count' => 0, 'page_no' => $page_no, 'list_count' => $list_count, 'list' => []]);
                            $this->result = array_merge($this->result, $this->status['900005']);
                        }
                    }else{
                        $this->result = array_merge($this->result, ['msg_count' => 0, 'page_no' => $page_no, 'list_count' => $list_count, 'list' => []]);
                        $this->result = array_merge($this->result, $this->status['900008']);
                    }
                } else {
                    $this->result = array_merge($this->result, ['msg_count' => 0, 'page_no' => $page_no, 'list_count' => $list_count]);
                    $this->result = array_merge($this->result, ['list' => []]);
                    $this->result = array_merge($this->result, $this->status['900008']);
                }

            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100007']) ;
        }
        $this->ajaxReturn($this->result);
    }
}