<?php

/**
 * 签名通用方法
 * @param arr $param 默认为空，按POST 数据去做签名
 * @return string 签名数据
 * @author zhaoxz
 */
function make_sign($param = null) {
    //初始化变量
    $buff = '';
    //要签名的数据 
    $data = is_null($param) ? I("post.") : $param;
    //所有数据做排序
    ksort($data);
    //循环拼接加密串
    foreach ($data as $k => $v) {
        $v = html_entity_decode($v);
        //排除键值为 sign ,及值为空的数据
        if ($k != "sign" && $v != "" && !is_array($v)) {
            $v = str_replace('&quot;', '"', $v);
            $buff .= $k . "=" . $v . "&";
        }
    }
    $buff = trim($buff, "&");
    $key = C("SIGNKEY");
    //拼接公钥
    $string = $buff . "&key=" . $key;
    //MD5加密
    $string = md5($string);
    //所有字符转为大写
    $result = strtoupper($string);
    return $result;
}

/**
 * 签名验证检测
 * @param string $sign 要验证的签名结果
 * @param array $param 签名数据
 * @return boolean
 * @author zhaoxz
 */
function check_sign($sign = null, $param = null) {
    //当前签名
    $server_sign = make_sign($param);
    //要验证的签名结果
    $client_sign = is_null($sign) ? I("post.sign", '') : $sign;
    
    //签名对比
    if ($server_sign !== $client_sign) {
        return false;
    }
    return true;
}
