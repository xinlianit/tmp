<?php
/**
 * 通过节点获取Url
 * @author JiRY
 * @param int $nodeId       节点ID
 * @return string
 */
function get_url_by_node($nodeId){
    $name = D('Common' , 'Logic')->getField('AuthRule', 'name', array('id'=>$nodeId));
    
    @list($module , $controller , $action) = explode('/', $name);
    
    if(isset($controller) && isset($action))
        return U($controller.'/'.$action);
    
    return '';
}

/**
 * 空值默认返回值
 * @param string|array $value          初始值
 * @param string $default              默认值
 * @return string|array
 */
function _default($value, $default=null){
    $default = !empty($default) ? $default : C('FIELD_DEFAULT_VALUE');
    return !empty($value) ? $value : $default;
}

/**
 * 获取字段值
 * @param string $modelName         模型名称
 * @param string $field             获取字段
 * @param array $condition          查询条件
 * @return string
 */
function get_field($modelName, $field, $condition=array()){
    return D('Common', 'Logic')->getField($modelName, $field, $condition);
}

/**
 * 获取多行单个字段,以字符串形式返回
 * @param string $modelName         模型名称
 * @param string|array $field       获取字段
 * @param array $condition          查询条件
 * @param string $flag              分隔符
 * @return string
 */
function get_fields_to_string($modelName, $field, $condition=array(), $flag='、'){
    
    if( !empty($condition) ){
        foreach($condition as $k=>$v){
            if( $v[0] == 'in' && empty($v[1])){
                unset($condition[$k]);
            }
               
        }
    }
    

    if( !empty($condition) ){
        $data = D('Common', 'Logic')->getFields($modelName, $field, $condition);
        
        $string = implode($flag, array_column($data, $field));
    }
    
    return $string ? $string : '';
}

/**
 * 获取多条记录单个字段以数组格式返回
 * @param string $modelName         模型名称
 * @param string $field             字段名称
 * @param array $condition          查询条件
 * @param array
 */
function get_fields_to_array($modelName, $field, $condition){
    $data = D('Common', 'Logic')->getRows($modelName, $condition, $field);
    
    $arr = array();
    if( !empty($data) && is_array($data) ){
        foreach($data as $v){
            array_push($arr, $v[$field]);
        }
    }
    
    return $arr;
}

/**
 * 后台调试工具
 * @author JiRY
 * @param string $message       调试信息
 * @param string $level         调试级别
 * @return null
 */
function debug($message, $level='log'){
    import('socketLog.slog',APP_LIBRARY,'.function.php');
    
    if(!function_exists('slog')){
        return null;
    }
    
    $config = array(
        'host'                => '192.168.1.180',   //websocket服务器地址，默认localhost
        'optimize'            => true,             //是否显示利于优化的参数，如果运行时间，消耗内存等，默认为false
        'show_included_files' => true,             //是否显示本次程序运行加载了哪些文件，默认为false
        'error_handler'       => true,             //是否接管程序错误，将程序错误显示在console中，默认为false
        'force_client_ids'    => array(             //日志强制记录到配置的client_id,默认为空,client_id必须在allow_client_ids中
        ),
        'allow_client_ids'    => array(             //限制允许读取日志的client_id，默认为空,表示所有人都可以获得日志。
            'JiRY',
        ),
    );
    
    slog( $config , 'config' );
    slog( $message , $level );
}