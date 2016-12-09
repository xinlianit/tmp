<?php
/**
 * ShopLogic.class.php - 商户逻辑
 * @package Logic
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-10 14:40
 */
namespace Admin\Logic;
use Admin\Logic\CommonLogic;
class ShopLogic extends CommonLogic{
    /**
     * 添加编辑商户
     * @param string $flag          操作标志；add:添加、edit:编辑
     * @return boolean
     */
    function saveShop($flag='add'){
        $model = self::getModel('HotelInfo');
        
        $model->startTrans();
        
        if( @$data = $model->create() ){
            
            $check_condition = array(
                'data_status'=>1
            );
            
            //唯一性验证
            $hotel_code_map             = array('hotel_code'=>$data['hotel_code']);
            $group_code_map             = array('group_code'=>$data['group_code']);
            $customer_code_map          = array('customer_code'=>$data['customer_code']);
            
            $delete_type_result         = true;
            $delete_trade_result        = true;
            $insert_id                  = 0;
            
            if($flag == 'edit'){
                $hotel_code_map['id']           = array('neq', $data['id']);
                $group_code_map['id']           = array('neq', $data['id']);
                $customer_code_map['id']        = array('neq', $data['id']);
                
                $log_msg = '添加商户';
            }else{
                unset($data['id']);
                
                $log_msg = '编辑商户';
            }
            
            $log_info['log_msg'] = self::$loginInfo['admin_account'] . $log_msg . '，商户名称：' . $data['hotel_name'];
            
            //酒店编码唯一
            if( !empty($data['hotel_code']) ){
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $hotel_code_map)) ){
                    $this->result['msg']        = "酒店编码已经存在！";
                    return $this->result;
                }
            }
            
            /*
            //客户集团编码唯一
            if( !empty($data['group_code']) ){
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $group_code_map))){
                    $this->result['msg']        = "客户集团编码已经存在！";
                    return $this->result;
                }
            }
            
            //客户酒店编码唯一
            if( !empty($data['customer_code']) ){
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $customer_code_map))){
                    $this->result['msg']        = "客户酒店编码已经存在！";
                    return $this->result;
                }
            }
            */
            
            //商户图片资源ID
            if( !empty(I('post.pic_md5')) ){
                $data['resource_id']    = $this->getResourceId(I('post.pic_md5'));
            }
            
            //开机音频资源ID
            if( !empty(I('post.voice_md5'))  ){
                
                $data['voice_id']       = $this->getResourceId(I('post.voice_md5'));
                
            }
            //酒店首字母
            $data['first_letter']       = getfirstchar($data['hotel_name']);
            
            //添加商户信息
            if($flag == 'edit'){
                $shop_result    = $model->where(array('id'=>$data['id']))->save($data);
                if( $shop_result !== false){
                    $insert_id = $data['id'];
                }
                
                //删除酒店对应的类型
                $delete_type_result     = D('HotelType')->where( array('hotel_id'=>$insert_id) )->delete();
                
                //删除酒店对应的商圈
                $delete_trade_result    = D('BusinessDistrict')->where( array('hotel_id'=>$insert_id) )->delete();
            }else{
                $data['admin_id']       = self::$loginInfo['id'];
                $data['hotel_code']     = 0;
                
                $insert_id = $model->add($data);
                
                //写入酒店编码
                $code_map = array(
                    'id'        => $insert_id
                );
                
                $code_data = array(
                    'hotel_code'        => 'P' . sprintf('%09d', $insert_id),
                );
                $model->where($code_map)->save($code_data);
                
            }
            
            //添加商户类型
            $type_list = explode(',', I('post.hotel_type'));
            $type_data = array();
            foreach($type_list as $v){
                $tmp = array('hotel_id'=>$insert_id, 'type_id'=>$v);
                array_push($type_data, $tmp);
            }
            $type_result = D('HotelType')->addAll($type_data);
            
            //添加商圈
            $trade_list = explode(',', I('post.trade_id'));
            $trade_data = array();
            foreach($trade_list as $v){
                $tmp = array('hotel_id'=>$insert_id, 'trade_id'=>$v);
                array_push($trade_data, $tmp);
            }
            $trade_result = D('BusinessDistrict')->addAll($trade_data);
            
            //成功
            if( $insert_id && $type_result && $trade_result && $delete_type_result !== false && $delete_trade_result !== false){
                $this->result['status']     = 1;
                $this->result['msg']        = $insert_id;
                
                $model->commit();
                
                //记录日志
                $this->recodeLog($log_info);
            }else{
                $this->result['msg']        = $model->getError();
                
                $model->rollback();
            }
        }else{
            $this->result['msg']            = $model->getError();
        }
        
        return $this->result;
    }
    
    /**
     * 添加编辑楼层
     * @param array $floor_list     楼层列表
     * @param string $flag          操作标志；add:添加、edit:编辑
     * @return boolean
     */
    function saveFloor($floor_list, $flag='add'){
        
        $model = self::getModel('FloorInfo');
        
        //编辑
        if($flag == 'edit'){
            
            //已存在的楼层ID集合
            $exists_id = array();
            //新增的数据
            $add_data = array();
            
            foreach($floor_list as $k=>$v){
                $exists_map = array(
                    'hotel_id'      => $v['hotel_id'],
                    'floor_name'    => $v['floor_name'],
                );
                //楼层存在验证
                $exists = $model->where($exists_map)->find();
                
                $update_status = true;
                
                if($exists){
                    array_push($exists_id, $exists['id']);
                    
                    $update_map = array(
                        'id'        => $exists['id']
                    );
                    
                    $update_data = array(
                        'floor_name'        => $v['floor_name'],
                        'room_number'       => $v['room_number'],
                    );
                    
                    //更新已存在的
                    $update_result = $model->where( $update_map )->save( $update_data );
                    
                    if( $update_result === false ){
                        $update_status = false;
                    }
                }else{
                    //新增
                    $add_id    = $model->add( $v );
                    
                    //加入已存在的集合
                    if( $add_id ){
                        array_push($exists_id, $add_id);
                    }else{
                        $update_status = false;
                    }
                }
                
                //楼层更新失败
                if( $update_status == false ){
                    $this->result['msg'] = "更新失败";
                    return $this->result;
                }
            }
            
            if( !empty($floor_list) ){
                $delete_map = array(
                    'id'            => array('not in',$exists_id),
                    'hotel_id'      => $floor_list[0]['hotel_id'],
                );
                
                //删除已移除的楼层
                $delete_result = $model->where( $delete_map )->delete();
            
                //楼层更新失败
                if( $delete_result === false ){
                    $this->result['msg'] = "更新失败";
                    return $this->result;
                }
            
                //写入操作日志
                $hotel_name = $this->getField('HotelInfo', 'hotel_name', array('id'=>$floor_list[0]['hotel_id']));
                $info['log_msg'] = self::$loginInfo['admin_account'] . ' 编辑 ' . $hotel_name . ' 酒店的楼层';
                self::recodeLog($info);
            }
            
        //新增
        }else{
            foreach($floor_list as $k=>$v){
                
                //楼层存在验证
                $exist_map = array(
                    'floor_name'        => $v['floor_name'],
                    'hotel_id'          => $v['hotel_id'],
                );
                
                $exists = $model->where( $exist_map )->find();
                
                if( $exists ){
                    //楼层已存在
                    $this->result['msg'] = $v['floor_name'] . " 楼层已存在！";
                    return $this->result;
                }
                
                //添加新楼层
                $data = $model->create($v);
            
                if( !$data ){
                    //创建数据失败
                    $this->result['msg'] = $model->getError();
                    return $this->result;
                }
            
                $result = $model->add( $v );
            
                if( !$result ){
                    //添加失败
                    $this->result['msg'] = $model->getError();
                    return $this->result;
                }
            }
            
            if( !empty($floor_list) ){
                //写入操作日志
                $hotel_name = $this->getField('HotelInfo', 'hotel_name', array('id'=>$floor_list[0]['hotel_id']));
                $info['log_msg'] = self::$loginInfo['admin_account'] . ' 新增 ' . $hotel_name . ' 酒店的楼层';
                self::recodeLog($info);
            }
            
        }
        
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑房间（绑定设备）
     * @param array $floor_list     楼层列表
     * @param string $flag          操作标志；add:添加、edit:编辑
     * @return boolean
     */
    function saveRoom($device_list, $flag='add'){
    
        $model = self::getModel('RoomInfo');
        
        $model->startTrans();
        
        $room_data = $model->create();
        
        $room_data['update_time']   = time();
        
        $room_data['room_code'] = $room_data['room_name'];
        
        //创建数据失败
        if( !$room_data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
        
        //房间唯一检测
        $exists_map = array(
            'data_status'   => 1,
            'hotel_id'      => $room_data['hotel_id'],
            'room_name'     => $room_data['room_name'],
        );
        
        if($flag == 'edit'){
            $exists_map['id']           = array('neq', $room_data['id']);
        }
        
        $exists = $this->getField('RoomInfo', 'id', $exists_map);
        if($exists){
            $this->result['msg']    = "房间已经存在！";
            return $this->result;
        }
        
        foreach($device_list as $k=>$v){
            
            //设备地址唯一
            $exists_dev_map = array(
                'device_address'        => $v['device_address'],
            );
            
            if($flag == 'edit'){
                $exists_dev_map['id']       = array('neq', $v['id']);
            }
        
            $exists_dev = self::getField('RoomDevice', 'id', $exists_dev_map);
            if($exists_dev){
                $this->result['msg']    = "设备地址已经存在，不能重复添加！";
                return $this->result;
            }
        }
        
        //编辑
        if($flag == 'edit'){
            //编辑房间数据
            $update_map = array(
                'id'            => $room_data['id'],
            );
            
            //更新房间
            $update_result = $model->where($update_map)->save($room_data);
            
            $exists_id = array();
            //更新已存在的
            if( !empty($device_list) ){
                foreach($device_list as $k=>$v){
                    
                    $v['room_id']           = $room_data['id'];
                    $v['telephone']         = $room_data['room_name'];
                    
                    $exists_map = array(
                        'device_address'        => $v['device_address'],
                        'room_id'               => $room_data['id']
                    );
                    
                    $exists_device_id = self::getField('RoomDevice', 'id', $exists_map);
                    
                    if( $exists_device_id ){
                        array_push($exists_id, $exists_device_id);
                        
                        //更新设备
                        $update_dev_result  = D('RoomDevice')->where($exists_map)->save($v);
                    }else{
                        //添加新增的
                        unset($v['id']);
                        $add_dev_id         = D('RoomDevice')->add($v);
                        if( $add_dev_id ){
                            array_push($exists_id, $add_dev_id);
                        }
                    }
                }
            }
            
            //删除已移除的
            $delete_map = array(
                'room_id'       => $room_data['id'],
                'id'            => array('not in',$exists_id)
            );
            $delete_result         = D(RoomDevice)->where($delete_map)->delete();
            
            if( $update_result === false || $update_dev_result === false || $add_dev_id === false){
                $model->rollback();
                
                return $this->result;
            }
            
            //执行成功
            $model->commit();
            
        //添加
        }else if($flag == 'add'){
            $room_data['create_time']   = time();
            //添加房间数据
            $room_id        = $model->add($room_data);
            //添加设备绑定信息
            if( $room_id ){
                foreach($device_list as $k=>$v){
                    $device_list[$k]['room_id']         = $room_id;
                    $device_list[$k]['telephone']       = $room_data['room_name'];
                }
            }
            $device_result = D('RoomDevice')->addAll($device_list);
            
            if( !$room_id || !$device_result ){
                $model->rollback();
                
                return $this->result;
            }
            
            $model->commit();
        }
        
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 房间设备；房间号：' . $room_data['room_name'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑酒店服务指南
     * @param string $flag          操作标识
     * @return boolean
     */
    public function saveServer($flag='add'){

        $model = self::getModel('HotelService');
        
        $base_data = $model->create();
        
        //创建数据失败
        if( !$base_data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
        
        //唯一性检测
        $exists_map = array(
            'hotel_id'          => array('eq', $base_data['hotel_id']),
            'data_status'       => array('neq', 99)
        );
        if($flag == 'edit'){
            $exists_map['id'] = array('neq', $base_data['id']);
        }
        $exists = self::getField('HotelService', 'id', $exists_map);
        if( $exists ){
            $this->result['msg']    = "酒店服务指南已存在！";
            return $this->result;
        }
        
        //图片不能为空
        $pic_md5 = I('post.pic_md5');
        //添加时图片为必选
         if( empty($pic_md5) && ($flag != 'edit') ){
             $this->result['msg']    = "图片不能为空！";
             return $this->result;
         }
        
         //图片信息pic_md5
        $pic_list = array();
        $pic_md5_arr = explode(',', $pic_md5);
        $pic_num = 0;
        foreach($pic_md5_arr as $v){
            $res_info = D('Resource')->getResourceByMd5($v);
            if(!$res_info){
                continue;
            }
            $tmp = array(
                'service_id'        => $base_data['id'],
                'resource_id'       => $res_info['id']
            );
            array_push($pic_list, $tmp);
            $pic_num++;
        }
        
        //编辑
        if($flag == 'edit'){
            //编辑基础信息
            $update_map = array(
                'id'          => $base_data['id']
            );
            $base_data['pic_num'] = $pic_num;
            $update_result      = $model->where($update_map)->save($base_data);
            
            //图片编辑
            if(!empty($pic_md5)){                
                $delete_map = array(
                    'service_id'  => $base_data['id']
                );
                //删除酒店图片
                D('HotelServicePic')->where($delete_map)->delete();
                //新增酒店图片
                D('HotelServicePic')->addAll($pic_list);
            }
            
            if($update_result === false){
                $this->result['msg']    = "编辑酒店服务指南失败！";
                return $this->result;
            }
            
        //添加
        }else{
            $base_data['pic_num'] = $pic_num;
            //添加基础信息
            $add_base_result        = $model->add($base_data);
            
            foreach ($pic_list as &$val) {
                $val['service_id'] = $add_base_result;
            }
            //添加图片信息
            $add_pic_result         = D('HotelServicePic')->addAll($pic_list);
            
            if(!$add_base_result || (!$add_pic_result && !empty($pic_list))){
                $this->result['msg']    = "添加酒店服务指南失败！";
                return $this->result;
            }
            
        }
        
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 酒店服务指南；酒店ID：' . $base_data['hotel_id'];
        self::recodeLog($info);
        
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑WIFI服务
     * @param string $flag          操作标识
     * @return boolean
     */
    public function saveWifi($flag='add'){
    
        $model = self::getModel('WifiService');
    
        $data = $model->create();
    
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
    
        //wifi唯一性检测
//         $exists_map = array(
//             'hotel_id'          => array('eq', $data['hotel_id']),
//             'data_status'       => array('neq', 99)
//         );
//         if($flag == 'edit'){
//             $exists_map['id'] = array('neq', $data['id']);
//         }
//         $exists = self::getField('WifiService', 'id', $exists_map);
//         if( $exists ){
//             $this->result['msg']    = "WIFI已存在！";
//             return $this->result;
//         }
    
        //验证
        switch( $data['link_method'] ){
            //账号连接
            case 1:
                if( empty($data['wifi_account']) ){
                    $this->result['msg']    = "WIFI账号不能为空！";
                    return $this->result;
                }
                if( empty($data['wifi_password']) ){
                    $this->result['msg']    = "WIFI密码不能为空！";
                    return $this->result;
                }
                break;
            //二维码连接
            case 2:
                if( empty($data['qrcode_path']) ){
                    $this->result['msg']    = "二维码图片不能为空！";
                    return $this->result;
                }
                break;
            //短信连接
            case 3:
                if( empty($data['wifi_account']) ){
                    $this->result['msg']    = "WIFI账号不能为空！";
                    return $this->result;
                }
                break;
        }
    
        //编辑
        if($flag == 'edit'){
            //编辑基础信息
            $update_map = array(
                'id'          => $data['id']
            );
    
            $update_result      = $model->where($update_map)->save($data);
    
            if($update_result === false){
                $this->result['msg']    = "编辑WIFI服务失败！";
                return $this->result;
            }
    
        //添加
        }else{
            //添加基础信息
            $add_result        = $model->add($data);
    
            if( !$add_result ){
                $this->result['msg']    = "添加WIFI服务失败！";
                return $this->result;
            }
    
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 酒店WIFI服务；酒店ID：' . $data['hotel_id'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑服务电话
     * @param string $flag          操作标识
     * @return boolean
     */
    public function saveTel($flag='add'){
    
        $model = self::getModel('PhoneService');
    
        $data = $model->create();
    
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
    
        //服务电话唯一性检测
        $exists_map = array(
            'telephone'         => $data['telephone'],
            'data_status'       => array('neq', 99)
        );
        
        //呼叫名称唯一
        $name_unique_map = array(
            'call_name'         => $data['call_name'],
            'hotel_id'          => $data['hotel_id'],
            'data_status'       => array('neq', 99)
        );
        
        if($flag == 'edit'){
            $exists_map['id']       = array('neq', $data['id']);
            
            $name_unique_map['id']  = array('neq', $data['id']);
        }
        $exists = self::getField('PhoneService', 'id', $exists_map);
        if( $exists ){
            $this->result['msg']    = "服务电话已存在！";
            return $this->result;
        }
        
        $name = self::getField('PhoneService', 'id', $name_unique_map);
        if( $name ){
            $this->result['msg']    = "呼叫名称已存在！";
            return $this->result;
        }
    
        //编辑
        if($flag == 'edit'){
            //编辑基础信息
            $update_map = array(
                'id'          => $data['id']
            );
    
            $update_result      = $model->where($update_map)->save($data);
    
            if($update_result === false){
                $this->result['msg']    = "编辑服务电话失败！";
                return $this->result;
            }
    
        //添加
        }else{
            //添加基础信息
            $add_result        = $model->add($data);
    
            if( !$add_result ){
                $this->result['msg']    = "添加服务电话失败！";
                return $this->result;
            }
    
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 服务电话；酒店ID：' . $data['hotel_id'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑客房服务
     * @param string $flag          操作标识
     * @return boolean
     */
    public function saveRoomServer($flag='add'){
    
        $model = self::getModel('RoomService');
        
        $data = $model->create();
        
        //服务类型；1：推荐服务、2：自定义服务
        $server_type = I('post.server_type');
        
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
        
        //基础数据处理
        $data['two_service_ids'] = implode(',', $data['two_service_ids']);
        
        //资源ID
        if( !empty(I('post.pic_md5')) ){
            $data['resource_id']    = $this->getResourceId(I('post.pic_md5'));
        }
    
        //酒店ID对应服务ID唯一
        $server_exists_map = array(
            'hotel_id'      => $data['hotel_id'],
            'service_id'    => $data['service_id'],
            'data_status'   => array('neq', 99)
        );
        
        if($flag == 'edit'){
            $server_exists_map['id']      = array('neq', $data['id']);
        }
        
        $room_service_exists = self::getField('RoomService', 'id', $server_exists_map);
        if($room_service_exists){
            $this->result['msg']        = "客房服务已存在！";
            return $this->result;
        }
        
        //事务启用标识
        $startTrans = 0;
        
        //编辑
        if($flag == 'edit'){
            
            //当前服务类型
            $service_map = array(
                'id'        => I('post.server_type') == 2 ? I('post.custom_service_id') : $data['service_id'],
            );
            $service_type = self::getField('ServiceInfo', 'hotel_id', $service_map);
            
            //服务类型不变,(推荐服务)不做处理
            
            //服务类型不变，(自定义服务)更新服务信息
            if($service_type != 0 && $server_type == 2){
                
                $data['service_id'] = I('post.custom_service_id');
                
                $update_map = array(
                    'id'        => $data['service_id']
                );
                
                //更新自定义服务到服务信息表
                $service_data = array(
                    'service_name'      => trim(I('post.service_name')),
                    'icon_id'           => trim(I('post.icon_id')),
                    'service_type'      => 1,
                );
                
                $model->startTrans();
                $startTrans = 1;
                
                //更新自定义服务
                $service_update_rs = D('ServiceInfo')->where($update_map)->save($service_data);
            }
            
            //推荐服务转自定义服务
            if($service_type == 0 && $server_type == 2){
                //擦除二级服务ID
                $data['two_service_ids'] = '';
                //新增自定义服务到服务信息表
                $service_data = array(
                    'service_name'      => trim(I('post.service_name')),
                    'icon_id'           => trim(I('post.icon_id')),
                    'hotel_id'          => $data['hotel_id'],
                    'service_type'      => 1,
                );
                
                $model->startTrans();
                $startTrans = 2;
                
                //写入自定义服务到服务信息表
                $service_id = D('ServiceInfo')->add($service_data);
                
                //重置服务ID
                $data['service_id'] = $service_id;
                
            }
            
            //自定义服务转推荐服务
            if($service_type != 0 && $server_type == 1){
                $model->startTrans();
                $startTrans = 3;
                
                $delete_map = array(
                    'hotel_id'      => $data['hotel_id']
                );
                //删除自定义服务
                $delete_result = D('ServiceInfo')->delete($delete_map);
                
            }
            
            //编辑基础信息
            $update_map = array(
                'id'          => $data['id']
            );
            
            $update_result      = $model->where($update_map)->save($data);
            
            
            switch($startTrans){
                //未启用事务
                case 0:
                    if($update_result === false){
                        $this->result['msg']    = "编辑客房服务失败！";
                        return $this->result;
                    }
                    break;
                //服务类型不变，(自定义服务)更新服务信息
                case 1:
                    if($service_update_rs === false || $update_result === false){
                        $model->rollback();
                        
                        $this->result['msg']    = "编辑客房服务失败！";
                        return $this->result;
                    }
                    break;
                //推荐服务转自定义服务
                case 2:
                    if(!$service_id || $update_result === false){
                        $model->rollback();
                    
                        $this->result['msg']    = "编辑客房服务失败！";
                        return $this->result;
                    }
                    break;
                //自定义服务转推荐服务
                case 3:
                    if(!$delete_result || $update_result === false){
                        $model->rollback();
                    
                        $this->result['msg']    = "编辑客房服务失败！";
                        return $this->result;
                    }
                    break;
            }
            
            if( $startTrans != 0 ){
                $model->commit();
            }
            
        //添加
        }else{
            unset($data['id']);
            
            //自定义服务
            if( $server_type == 2 ){
                $model->startTrans();
                
                $service_data = array(
                    'service_name'      => trim(I('post.service_name')),
                    'icon_id'           => trim(I('post.icon_id')),
                    'hotel_id'          => $data['hotel_id'],
                    'service_type'      => 1,
                );
                //写入自定义服务到服务信息表
                $service_id = D('ServiceInfo')->add($service_data);
                
                //重置服务ID
                $data['service_id'] = $service_id;
                
                //添加基础信息
                $add_result        = $model->add($data);
                
                if($service_id && $add_result){
                    $model->commit();
                }else{
                    $model->rollback();
                    
                    $this->result['msg']    = "添加客房服务失败！";
                    return $this->result;
                }
            }else{
                
                //添加基础信息
                $add_result        = $model->add($data);
                
                if(!$add_result){
                    $this->result['msg']    = "添加客房服务失败！";
                    return $this->result;
                }
            }
            
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 客房服务；酒店ID：' . $data['hotel_id'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑问卷
     * @param string $flag          操作标识
     * @return boolean
     */
    public function saveQuest($flag='add'){
    
        $model = self::getModel('FeedbackSubject');
        
        //数据处理
        $hotel_id           = I('post.hotel_id', 0);
        $quest_items        = I('post.items');
        $info_id            = I('post.id', 0);
        
        //反馈数据
        $info_data = array(
            'hotel_id'           => $hotel_id,
            'topic_quantity'     => count($quest_items),
            'update_time'        => time(),
        );
        
        if( !$quest_items ){
            $this->result['msg']    = '问卷题目不能为空！';
            return $this->result;
        }
        
        //事务启用
        $model->startTrans();
        
        //事务状态
        $trans_status = true;
        
        //编辑
        if($flag == 'edit'){
            //编辑反馈
            $info_map = array(
                'id'        => $info_id
            );
            $info_result        = D('FeedbackInfo')->where($info_map)->save( $info_data );
            
            //编辑存在的题目
            $exists_quest_id    = array();
            
            foreach($quest_items as $k=>$v){
                
                if( $v['subject_id'] ){
                   array_push($exists_quest_id, $v['subject_id']); 
                   
                   $subject_map    = array(
                       'id'            => $v['subject_id'],
                       'feedback_id'   => $info_id,
                   );
                   
                   $subject_data = array(
                       'hotel_id'       => $hotel_id,
                       'title'          => trim($v['title']),
                       'subject_type'   => $v['subject_type'],
                       'data_sort'      => $k + 1,
                       'update_time'    => time()
                   );
                    
                   $subject_result  = $model->where($subject_map)->save($subject_data);
                   
                   if( $subject_result === false ){
                       $trans_status = false;
                   }
                   
                   //编辑存在选项
                   $exists_option_id   = array();
                   
                   if( count($v['options']) > 0 ){
                       foreach($v['options'] as $o_k=>$o_v){
                           //原来的选项
                           if( $o_v['option_id'] ){
                               array_push($exists_option_id, $o_v['option_id']);
                   
                               $option_map = array(
                                   'id'                => $o_v['option_id'],
                                   'subject_id'        => $v['subject_id']
                               );
                   
                               $option_data = array(
                                   'option_name'        => $o_v['option_name'],
                               );
                                
                               //更新选项
                               $option_result = D('FeedbackOption')->where($option_map)->save($option_data);
                               
                               if( $option_result === false ){
                                   $trans_status = false;
                               }
                           }else{
                   
                               //忽略已经存在的选项
                               $option_exists_map = array(
                                   'subject_id'        => $v['subject_id'],
                                   'option_name'       => $o_v['option_name']
                               );
                               $option_exists_id  = D('FeedbackOption')->where($option_exists_map)->getField('id');
                               if( $option_exists_id ){
                                   array_push($exists_option_id, $option_exists_id);
                               }else{
                                   //新增选项
                                   $option_data = array(
                                       'subject_id'        => $v['subject_id'],
                                       'option_name'       => $o_v['option_name']
                                   );
                   
                                   $option_id = D('FeedbackOption')->add($option_data);
                                   
                                   if( $option_id ){
                                       array_push($exists_option_id, $option_id);
                                   }else{
                                       $trans_status = false;
                                   }
                                   
                               }
                   
                           }
                   
                       }
                   }
                   
                   //删除已移除选项
                   if( !empty($exists_option_id) ){
                       $option_delete_map = array(
                           'id'            => array('not in', $exists_option_id),
                           'subject_id'    => $v['subject_id']
                       );
                       $delete_option = D('FeedbackOption')->where($option_delete_map)->delete();
                       if( $delete_option === false ){
                           $trans_status = false;
                       }
                   }
                   
                }else{
                    //忽略已存在的题目
                    $exists_quest_map = array(
                        'feedback_id'       => $info_id,
                        'title'             => trim($v['title']),
                        'subject_type'      => $v['subject_type'],
                        'data_status'       => array('neq',99),
                    );
                    $quest_exists_id  = $model->where($exists_quest_map)->getField('id');
                    if( $quest_exists_id ){
                        array_push($exists_quest_id, $quest_exists_id);
                    }
                    
                    //新增新加入的题目
                    $subject_data = array(
                        'hotel_id'       => $hotel_id,
                        'title'          => trim($v['title']),
                        'subject_type'   => $v['subject_type'],
                        'feedback_id'    => $info_id,
                        'data_sort'      => $k + 1,
                        'update_time'    => time()
                    );
                     
                    $subject_result  = $model->add($subject_data);
                    
                    if($subject_result){
                        array_push($exists_quest_id, $subject_result);
                        
                        //添加题目选项
                        if( count($v['options']) > 0 ){
                            $options_data    = array();
                            foreach($v['options'] as $o_k=>$o_v){
                                $option = array(
                                    'subject_id'         => $subject_result,
                                    'option_name'        => $o_v['option_name']
                                );
                                 
                                array_push($options_data, $option);
                            }
                             
                            $option_result   = D('FeedbackOption')->addAll($options_data);
                            
                            if( $option_result === false ){
                                $trans_status = false;
                            }
                        }
                    }else{
                        $trans_status = false;
                    }
                    
                }
            }
            
            //删除已移除的题目
            if( !empty($exists_quest_id) ){
                $delete_map = array(
                    'id'                => array('not in', $exists_quest_id),
                    'feedback_id'       => $info_id
                );
                $delete_result = $this->deleteRows('FeedbackSubject', $delete_map);
                
                if( $delete_result == false ){
                    $trans_status = false;
                }
            }
            
            //事务不通过回滚
            if( !$trans_status ){
                $model->rollback();
                
                $this->result['msg']    = '编辑问卷失败！';
                return $this->result;
            } 
            
        //添加
        }else{
           
           $info_data['create_time']    = time();
           
           //事务状态
           $trans_status    = true;
           
           //添加反馈
           $info_result     = D('FeedbackInfo')->add( $info_data );
           
           //添加题目
           foreach($quest_items as $k=>$v){
               $subject_data = array(
                   'hotel_id'       => $hotel_id,
                   'title'          => trim($v['title']),
                   'subject_type'   => $v['subject_type'],
                   'feedback_id'    => $info_result,
                   'data_sort'      => $k + 1,
                   'create_time'    => time(),
                   'update_time'    => time()
               );
               
               $subject_result  = $model->add($subject_data);
               
               if( !$subject_result ){
                   $trans_status = false;
               }
               
               //添加题目选项
               if( count($v['options']) > 0 ){
                   $options_data    = array();
                   foreach($v['options'] as $o_k=>$o_v){
                       $option = array(
                           'subject_id'         => $subject_result,
                           'option_name'        => $o_v['option_name']
                       );
                       
                       array_push($options_data, $option);
                   }
                   
                   $option_result   = D('FeedbackOption')->addAll($options_data);
                   
                   if( !$option_result ){
                       $trans_status = false;
                   }
               }
           }
           
           if( !$trans_status ){
               $model->rollback();
               
               $this->result['msg']     = "添加问卷失败！";
               return $this->result;
           }
           
        }
        
        $model->commit();
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 问卷；问卷ID：' . $info_result;
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
}