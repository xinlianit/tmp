<?php
/**
 * HomeController.class.php - 管家部APP接口首页信息
 * @package ManageApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
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
                $_hotel_info = $_info->field('hotel_code, group_code, customer_code, hotel_name, interface_type, interface_url, para1, para2, para3, para4 ')
                    ->where(array('id' => $_room_info['hotel_id'], 'data_status' => 1))
                    ->find();

                if($_hotel_info){
                    $_hotel_info = array_merge($_hotel_info, $_room_info);
                    $this -> result = array_merge($this -> result, $_hotel_info) ;

                    $_conf_info = M("config_info");
                    $_conf_info = $_conf_info->field('conf_name, conf_value')
                        ->where(array('conf_code' => 'PIC_PATH', 'data_status' => 1))
                        ->find();

                    if($_conf_info){
                        $this -> result['pic_path'] = $_conf_info['conf_value'];
                    }else{
                        $this -> result['pic_path'] = '';
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
        $floor_ids = trim($this->I['floor_ids'], ','); //二级服务ID
        $page_no = trim($this->I['page_no']);
        $list_count = trim($this->I['list_count']);

        if( isset($floor_ids) && !empty($floor_ids) ) {
            $_order_list = M("order_info");
            $_result = true;

            $_map['data_status'] = 1;

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
                //获取订单列表
                $order_list = $_order_list->field(
                    'order_no,                           
                  create_time,                        
                  room_name,                       
                  room_phone,                         
                  data_status as order_status,       
                  null as goods_list                  
                 ')->where($_map)
                    -> limit(($page_no - 1) * $list_count, $list_count)
                    -> order(['create_time' => 'desc'])
                    -> select();

                $_arr_order_no = array_column($order_list, 'order_no');
                $_map['order_no'] = ['in', $_arr_order_no];
                unset($_map['floor_id']);

                //获取对应订单的商品信息列表
                $goods_list = M('order_goods')->field('order_no, goods_name, goods_quantity')
                                                -> where($_map)
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
                        $order_list[$key]['goods_list'] = &$arrOrderNo[$value['order_no']];
                    }

                    $this->result = array_merge($this->result, ['list' => $order_list]);
                } else {
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
}