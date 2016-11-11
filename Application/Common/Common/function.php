<?php
/**
 * 验证码验证
 * @author Create by JiRY
 * @param string $code      验证码
 * @param string $id        验证码ID
 * @return boolean
 */
function check_verify($code , $id = ''){
    $verify = new \Think\Verify();
    return $verify->check($code, $id);
}

/**
 * 获取salt值
 * @author Create by JiRY
 * @param integer $length      salt字符长度
 * @return string
 */
function get_salt($length=10){
    $str = null;
    $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
    $max = strlen($strPol)-1;
    srand(microtime()*100000);

    for($i=0;$i<$length;$i++){
        //rand($min,$max)生成介于min和max两个数之间的一个随机整数
        $str.=$strPol[rand(0,$max)];
    }

    return $str;
}

/**
 * 密码加密
 * @author Create by JiRY
 * @param string $user_pass     用户明文密码
 * @param string $encode_salt   密码加密私钥
 * @return boolean
 */
function pass_encode($user_pass,$encode_salt){
    //取密钥最后一个字母，求模。在模的位置插入该字母
    $encode_salt = str_split($encode_salt);
    $num = count($encode_salt);
    foreach($encode_salt as $l){
        $i = ord($l) % $num ;
        $user_pass = substr($user_pass,0,$i) . $l . substr($user_pass,$i) ;
    }
    return md5($user_pass);
}


/**
 * arrayKeyValChange函数调用方法，内部调用使用，大小写快捷转换函数
 * @param string $type          类型；upper：大写、lower：小写
 * @param string $string        字符串
 */
function upperlower(&$item, $key, $type){
    switch( $type ){
        case 'upper':
            $item = strtoupper( $item );
            break;
        case 'lower':
            $item = strtolower( $item );
            break;
        default:
            break;
    }
}


/**
 * 数组键值大小写转换
 * @param array $array              数组元素
 * @param string $type              转换类型；upper：大写、lower：小写
 * @param number $option            转换选项；1:数组值转换、2：数组键转换、3：数组键值转换
 * @return array $_result           失败返回false，否则返回转换后的数组
 */
function arrayKeyValChange(&$array , $type = 'upper' , $option = 1)
{
    if (empty($array) || !is_array($array)) return false;
    $_result = false;
    $_type = 'upper' == $type ? CASE_UPPER : CASE_LOWER;

    switch (intval($option)) {
        case 1:
            $_result = array_walk_recursive($array, 'upperlower', $type);
            $_result = $_result ? $array : false;
            break;
        case 2:
            $_result = array_change_key_case($array, $_type);
            break;
        case 3:
            $_result = array_walk_recursive($array, 'upperlower', $type);
            $_result = $_result ? array_change_key_case($array, $_type) : false;
            break;
    }
    return $_result;
}

/**
 * 日志记录-手动日志
 * @param string $msg  日志消息
 * @param string $level 日志级别
 * @param string $prefix 文件前缀
 * @author zhaoxz(441534536@qq.com)
 */
function logs($msg,$level='ERR',$prefix=''){
    // 检测模块是否存在
    if( MODULE_NAME && (defined('BIND_MODULE') || !in_array_case(MODULE_NAME,C('MODULE_DENY_LIST')) ) && is_dir(APP_PATH.MODULE_NAME)){
        $log_path = str_replace(MODULE_NAME.'/', '', C('LOG_PATH'));
    }else{
        $log_path = C('LOG_PATH');
    }
    
    //日志路径
    if(!empty($prefix)){
        $destination = $log_path.'Diy/'.$prefix.'_'.date('y_m_d').'.log'; 
    }else{
        $destination = $log_path.'Diy/'.date('y_m_d').'.log'; 
    }
    
    //对象或数组数据，JSON格式化
    if( is_array($msg) || is_object($msg) ){
        $msg = json_decode($msg);
    }
    
    //写入日志
    \Think\Log::write($msg,MODULE_NAME.'_'.$level,'File',$destination);
}