<?php
/**
 * ShopController.class.php - 商户管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-03 17:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class ShopController extends CommonController {
    /**
     * 商户列表
     */
    public function index(){
        
        $hotel_name     = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($hotel_name) ){
            $map['hotel_name']  = array('like','%'. $hotel_name .'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'HotelInfo', 'where'=>$map));
        $this->assign('page',$page);
        
        //默认商圈信息
        $map = array(
            'city_id'       => '440304',
            'data_status'   => 1,
        );
        
        $trand = self::$CommonLogic->getRows('TradingArea', $map, array('id', 'area_name'));
        $this->assign('trand', $trand);
        
        $this->display();
    }
    
    /**
     * 新增/编辑商户
     */
    public function addEdit(){
       if(IS_POST){
           $result = D('Shop', 'Logic')->saveShop( $this->post['flag'] );
           
           if( $result['status'] == 1 ){
               $this->ajaxReturnSuccess();
           }else{
               $this->ajaxReturnErr(array('msg'=>$result['msg']));
           }
       }
    }
    
    /**
     * 删除商户
     * @param string $_GET['ids']           要删除的记录ID
     * @return json
     */
    public function deleteShop(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
            
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('HotelInfo',$map);
             
            if( $result ){
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除商户；商户ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 商户详情
     * @param int $_GET['id']       商户ID
     * @return json            
     */
    public function shopInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //酒店详情
            $hotel_info = self::$CommonLogic->getRow('HotelInfo', array('id'=>$id, 'data_status'=>array('neq',99)));
            
            //酒店类型
            if( $hotel_info ){
                $type_type = get_fields_to_array('HotelType', 'type_id', array('hotel_id'=>$id));
                
                if( !empty($type_type) ){
                    $type       = self::$CommonLogic->getRows('TypeInfo', array('id'=>array('in',$type_type), 'data_status'=>array('neq',99)), array('id', 'type_name'));
                    
                    $hotel_info['hotel_type_name']  = array_column($type, 'type_name');
                    $hotel_info['hotel_type']       = array_column($type, 'id');
                }
                //省市区名称
                $hotel_info['city_all_name']          = self::$CommonLogic->getField('CityInfo', 'all_name', array('id'=>$hotel_info['region_id'],'data_status'=>array('neq',99)));
                
                //图片
                $hotel_info['res_path']         = default_img($hotel_info['resource_id']);
                
                //商圈信息
                $hotel_info['trade_id']         = self::$CommonLogic->getField('BusinessDistrict', 'trade_id', array('hotel_id'=>$hotel_info['id']));
                $hotel_info['trade_name']       = self::$CommonLogic->getField('TradingArea', 'area_name', array('id'=>$hotel_info['trade_id']));
                
                //商圈列表
                $map = array(
                    'city_id'       => $hotel_info['region_id'],
                    'data_status'   => 1,
                );
                $hotel_info['trand'] = self::$CommonLogic->getRows('TradingArea', $map, array('id', 'area_name'));
                
            }
            
        }
        
        if( $hotel_info ){
            $result['data']         = $hotel_info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->result['msg'] = "未获取到商户详情";
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 楼层管理
     */
    public function floor(){
        $hotel_name     = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($hotel_name) ){
            $map['hotel_name']  = array('like','%'. $hotel_name .'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'HotelInfo', 'where'=>$map));
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加编辑楼层
     */
    public function addEditFloor(){
        if(IS_POST){
            //楼层数据
            $floor_list = array();
            
            foreach( $this->post['floor_name'] as $k=>$v ){
                $tmp = array(
                    'floor_name'            => $v,
                    'room_number'           => $this->post['room_number'][$k],
                    'hotel_id'              => $this->post['hotel_id']
                );
                
                array_push($floor_list, $tmp);
            }
            
            $result = D('Shop', 'Logic')->saveFloor($floor_list, $this->post['flag']);
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除楼层
     */
    public function deleteFloor(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'hotel_id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('FloorInfo',$map);
             
            if( $result ){
                
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除楼层；商户ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 楼层详情
     * @param int $_GET['id']       商户ID
     * @return json
     */
    public function floorInfo(){
        $id     = trim(I('get.id', null));
    
        if( $id !== null ){
            //酒店详情
            $hotel_info = self::$CommonLogic->getRow('HotelInfo', array('id'=>$id, 'data_status'=>array('neq',99)), array('id', 'hotel_name'));
    
            //酒店楼层
            if( $hotel_info ){
                $hotel_info['floor_list'] = self::$CommonLogic->getRows('FloorInfo', array('hotel_id'=>$id,'data_status'=>array('neq',99)), array('floor_name','room_number'));
            
                //房间数
                $room_number = get_fields_to_array('FloorInfo', 'room_number', array('hotel_id'=>$hotel_info['id'], 'data_status'=>array('neq',99)));
                $hotel_info['total_room_number'] = array_sum($room_number);
            }
    
        }
    
        if( $hotel_info ){
            $result['data']         = $hotel_info;
            $this->ajaxReturnSuccess($result);
        }
    
        $this->result['msg'] = "未获取到商户详情";
    
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 设备管理
     */
    public function device(){
        $hotel_name             = trim($this->get['hotel_name']);
        $device_address         = trim($this->get['device_address']);
        $room_type              = trim($this->get['room_type']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        //酒店名称查询
        if( !empty($hotel_name) ){
            //商户ID
            $hotel_id = self::$CommonLogic->getRows('HotelInfo', array('hotel_name'=>array('like','%'.$hotel_name.'%'), 'data_status'=>array('neq',99)), array('id'));
            
            if( $hotel_id ){
                $hotel_ids = array_column($hotel_id, 'id');
                
                $map['hotel_id']    =  array('in', $hotel_ids);
            }else{
                $map['hotel_id']    =  0;
            }
        }
        
        //设备地址查询
        if( !empty($device_address) ){
            //房间ID
            $room_id = self::$CommonLogic->getRows('RoomDevice', array('device_address'=>array('like','%'.$device_address.'%')), array('room_id'));
            
            if( $room_id ){
                $room_ids = array_column($room_id, 'room_id');
            
                $map['id']    =  array('in', $room_ids);
            }else{
                $map['id']    =  0;
            }
        }
        
        //类型查询
        if( !empty($room_type) ){
            $map['room_type']       = $room_type;
        }
        
        $page = self::$CommonLogic->page(array('name'=>'RoomInfo', 'where'=>$map));
        
        if( !empty($page['list']) ){
            foreach($page['list'] as $k=>$v){
                $page['list'][$k]['device'] = self::$CommonLogic->getRows('RoomDevice',array('room_id'=>$v['id'], 'data_status'=>array('neq',99)), array('id', 'device_address', 'position'));
            }
        }
        
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加编辑设备
     */
    public function addEditDev(){
        if(IS_POST){
            //设备数据
            $device_list = array();
            
            foreach( $this->post['device_address'] as $k=>$v ){
                $tmp = array(
                    'device_address'            => $v,
                    'position'                  => $this->post['position'][$k],
                );
                
                if( $this->post['device_id'][$k] ){
                    $tmp['id']  = $this->post['device_id'][$k];
                }
                
                array_push($device_list, $tmp);
            }
            
            $result = D('Shop', 'Logic')->saveRoom($device_list, $this->post['flag']);
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除设备
     */
    public function deleteDev(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $model = D('RoomDevice');
            $model->startTrans();
            
            //删除房间
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('RoomInfo', $map);
            
            //删除设备
            $dev_map = array(
                'room_id'       => array('in', $id),
            );
            $dev_result = $model->where($dev_map)->delete();
             
            if( $result && $dev_result !== false ){
                $model->commit();
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除房间设备绑定；房间ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $model->rollback();
                
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 设备信息
     */
    public function devInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //详情
            $info = self::$CommonLogic->getRow('RoomInfo', array('id'=>$id, 'data_status'=>array('neq',99)));
            
            if( $info ){
                //商户信息
                $hotel_info = self::$CommonLogic->getRow('HotelInfo', array('id'=>$info['hotel_id'], 'data_status'=>array('neq',99)), array('id','hotel_name'));
                $info['hotel_id']   = $hotel_info['id'];
                $info['hotel_name'] = $hotel_info['hotel_name'];
                //商户楼层
                $info['floor_list'] = self::$CommonLogic->getRows('FloorInfo', array('hotel_id'=>$info['hotel_id'], 'data_status'=>array('neq',99)), array('id','floor_name'));
                //设备列表
                $info['device_list'] = self::$CommonLogic->getRows('RoomDevice', array('room_id'=>$info['id']), array('id','device_address','position'));
            }
        
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->result['msg'] = "未获取到详情";
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 获取酒店列表，按字母排列
     */
    public function getHotelListWithLetter(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }   
        
        $_map['data_status'] = 1;
        $list = M('HotelInfo')->where($_map)->order('first_letter asc,id')->select();
        
        foreach ($list as $val) {           
            $_list[$val['first_letter']][] = array(
                'id'=>$val['id'],
                'hotel_name' => $val['hotel_name']
            );
        }
        
        $this->ajaxReturnSuccess($_list);
    }
    
    /**
     * 获取酒店列表-有制定上架商品的
     */
    public function getHotelListWithGoodsId(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }   
        //参数校验
        $goods_id = I('post.id',0);
        if(!$goods_id){
            $this->ajaxReturnErr();
        } 
        
        $_map['goods_id'] = $goods_id;
        $list = M('goods_shelves')->where($_map)->field('hotel_id')->select();
        
        foreach ($list as &$val) {    
            $hotel_info = D('Hotel','Cache')->getHotelInfo($val['hotel_id']);
            $val['hotel_name'] = $hotel_info['hotel_name'];            
        }
        
        $this->ajaxReturnSuccess($list);
    }
}