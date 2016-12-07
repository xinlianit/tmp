<?php
/**
 * InnerController.class.php - 后台内部私有
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-24 11:40
 */
namespace Admin\Controller;
use Think\Controller;
class InnerController extends Controller {
    /**
     * 结果集
     * @var array
     */
    private $result = array( 'status' => 0 );
    
    /**
     * 获取二级服务
     * @param int $_GET['id']           服务ID
     * @return json
     */
    public function getServerTow(){
        $id         = trim(I('get.id'));
        
        if( !$id ){
            $this->ajaxReturn($this->result);
        }
        
        $server_two_map = array(
            'service_id'        => $id
        );
        $rows = D('Common', 'Logic')->getRows('ServiceTwo', $server_two_map, array('id','server_name'));
        
        $this->result['status']             = 1;
        $this->result['data']               = $rows;
        $this->ajaxReturn($this->result);
        
    }
    
    /**
     * 获取商圈
     * @param int $_GET['id']           城市ID
     * @return json
     */
    public function getTrad(){
        $city_id        = trim(I('get.id'));
        
        $map = array(
            'city_id'       => $city_id ? $city_id : 0,
            'data_status'   => 1,
        );
        
        $rows = D('Common', 'Logic')->getRows('TradingArea', $map, array('id','area_name'));
        
        $this->result['status']             = 1;
        $this->result['data']               = $rows;
        $this->ajaxReturn($this->result);
    }
    
    /**
     * 获取酒店类型
     * @param json
     */
    public function hotelType(){
        if( IS_AJAX ){
            $field = array('id', 'type_name', 'type_class');
    
            $condition = array(
                'data_status'       => array('eq',1),
            );
            $type_list = D('Common','Logic')->getRows('TypeInfo', $condition, $field);
    
            $this->result['status']             = 1;
            $this->result['data']               = $type_list;
            $this->ajaxReturn($this->result);
        }
    }
    
    /**
     * 楼层搜索
     * @param string $_POST['hotel_name']           楼层名称
     * @return json
     */
    public function seach(){
        $hotel_name         = trim($this->post['hotel_name']);
    
        $map = array(
            'data_status'       => array('neq',99),
        );
    
        if($hotel_name){
            $map['hotel_name'] = array('like', '%'. $hotel_name .'%');
        }
        $rows = D('Common', 'Logic')->getRows('HotelInfo', $map, array('id', 'hotel_name'));
    
        if( !empty($rows) ){
            foreach($rows as $k=>$v){
                $type_ids = get_fields_to_array('HotelType', 'type_id', array('hotel_id'=>$v['id']));
                if( !empty($type_ids) ){
                    $hotel_type = get_fields_to_string('TypeInfo', 'type_name', array('id'=>array('in', $type_ids)));
                }
    
                //酒店类型
                $rows[$k]['hotel_type'] =  _default($hotel_type);
    
                //酒店楼层
                $rows[$k]['floor_list'] =  D('Common', 'Logic')->getRows('FloorInfo', array('hotel_id'=>$v['id'], 'data_status'=>array('neq',99)), array('id', 'floor_name'));
            }
        }
    
        $this->result['status']             = 1;
        $this->result['data']               = $rows;
        $this->ajaxReturn($this->result);
    }
    
    public function tmp(){
//         $address    = trim(I('get.address'));
        
//         if(!$address){
//             exit("empty");
//         }
        
//         $model = D('RoomDevice');
//         $dev_map = array(
//             'device_address'       => $address,
//         );
//         $dev_result = $model->where($dev_map)->delete();
        
//         if($dev_result){
//             echo "success!";
//         }else{
//             echo "error!";
//         }
    }
}