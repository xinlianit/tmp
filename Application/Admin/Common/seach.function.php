<?php
/**
 * 获取酒店ID - 通过酒店名称
 * @param string $hotel_name        酒店名称
 * @param array $params             附加参数
 * @return array
 */
function get_hotel_ids_by_name($hotel_name, $params=array()){
    if( !$hotel_name ){
        return array();
    }
    
    //查询条件
    $_map   = array(
        'hotel_name'        => array('like','%'.$hotel_name.'%'),
        'data_status'       => array('neq',99)
    );
    
    //商户ID
    $hotel_id = D('Common', 'Logic')->getRows('HotelInfo', $_map, array('id'));
    
    if( $hotel_id ){
        $hotel_ids = array_column($hotel_id, 'id');
    
        $map['hotel_id']    =  array('in', $hotel_ids);
    }else{
        $map['hotel_id']    =  0;
    }
    
    return $map;
}

/**
 * 获取房间ID - 通过设备地址
 * @param string $device_address        设备地址
 * @param array $params                 附加参数
 * @return array
 */
function get_room_ids_by_address($device_address, $params=array()){
    if( !$device_address ){
        return array();
    }
    
    //查询条件
    $_map = array(
        'device_address'        => array('like', '%'.$device_address.'%')
    );
    
    //房间ID
    $room_id = D('Common', 'Logic')->getRows('RoomDevice', $_map, array('room_id'));
    
    if( $room_id ){
        $room_ids = array_column($room_id, 'room_id');
        $map['id']    =  array('in', $room_ids);
    }else{
        $map['id']    =  0;
    }
    
    return $map;
}

/**
 * 获取房间ID - 通过设备APP版本号
 * @param string $app_version           APP版本号
 * @param array $params                 附加参数
 * @return array
 */
function get_room_ids_by_version($app_version, $params=array()){
    if( !$app_version ){
        return array();
    }
    
    //查询条件
    $_map = array(
        'app_version'        => array('like', '%'.$app_version.'%')
    );

    //房间ID
    $room_id = D('Common', 'Logic')->getRows('RoomDevice', $_map, array('room_id'));

    if( $room_id ){
        $room_ids = array_column($room_id, 'room_id');
        $map['id']    =  array('in', $room_ids);
    }else{
        $map['id']    =  0;
    }

    return $map;
}

/**
 * 获取房间ID - 通过设备通过设备地址 和 APP版本号
 * @return array        
 */
function get_room_ids_by_address_version(){
    
    $device_address     = urldecode(I('get.device_address'));
    $app_version        = urldecode(I('get.app_version'));
    
    if( !$device_address && !$app_version ){
        return array();
    }
    
    $device_map = array();
    
    //设备地址查询
    if( !empty($device_address) ){
        $device_map['device_address']   = array('like', '%'.$device_address.'%');
    }

    //设备APP版本号查询
    if( !empty($app_version) ){
        $device_map['app_version']      = array('like', '%'.$app_version.'%');
    }
    
    //房间ID
    if( !empty($device_map) ){
        $room_id = D('Common', 'Logic')->getRows('RoomDevice', $device_map, array('room_id'));
    }
    
    if( $room_id ){
        $room_ids = array_column($room_id, 'room_id');
        $map['id']    =  array('in', $room_ids);
    }else{
        $map['id']    =  0;
    }

    return $map;
}

/**
 * 获取节点查询 - 通过节点名称或节点规则
 * @param string $name
 * @return array
 */
function get_query_by_name($name){
    if( !$name ){
        return array();
    }
    
    $map['name']        = array('like', '%'.$name.'%');
    $map['_logic']      = 'OR';
    $map['title']       = array('like', '%'.$name.'%');
    
    return $map;
}

/**
 * 获取模块和控制节点
 * @return array
 */
function get_module_controller_node(){
    //模块、控制器级节点
    $map = array(
        'type'      => array('in', array(1,2)),
        'status'    => 1
    );
    $parent_node = D('Common', 'Logic')->getRows('AuthRule', $map, array('id', 'name', 'title', 'type'), array('sort'=>'asc'));
    
    return $parent_node;
}

/**
 * 获取管理员ID - 通过组ID
 * @param int $group_id         组别ID
 * @return array
 */
function get_admin_ids_by_group_id($group_id){
    if( !$group_id ){
        return array();    
    }
    
    if( !empty($group_id) ){
        $group_acc_map = array(
            'group_id'      => $group_id
        );
        $admin_ids = get_fields_to_array('AuthGroupAccess', 'uid', $group_acc_map);
        if( !empty($admin_ids) ){
            $map['id']  = array('in', $admin_ids);
        }else{
            $map['id']  = 0;
        }
    }
    
    return $map;
}

/**
 * 获取组列表
 * @return array
 */
function get_group(){
    //管理员组
    $group_map = array(
        'status'        => array('neq', 99)
    );
    $group = D('Common', 'Logic')->getRows('AuthGroup', $group_map);
    
    return $group;
}