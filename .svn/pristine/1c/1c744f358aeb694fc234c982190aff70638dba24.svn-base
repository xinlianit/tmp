<?php
/**
 * @description of develop.php 运行时共享函数
 * @link http://www.pad-phone.com/
 * @author PAD PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright PAD Co., Ltd. 2016/11/18 10:31
 * @since V1.0.0
 */

/**
 * 天气预报请求接口返回内容(聚合接口)
 * @param  string $url [请求的URL地址]
 * @param  string $params [请求的参数]
 * @param  int $ipost [是否采用POST形式]
 * @return  string
 */
function juhecurl($url,$params=false,$ispost=0){
    $httpInfo = array();
    $ch = curl_init();

    curl_setopt( $ch, CURLOPT_HTTP_VERSION , CURL_HTTP_VERSION_1_1 );
    curl_setopt( $ch, CURLOPT_USERAGENT , 'JuheData' );
    curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT , 60 );
    curl_setopt( $ch, CURLOPT_TIMEOUT , 60);
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER , true );
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    if( $ispost )
    {
        curl_setopt( $ch , CURLOPT_POST , true );
        curl_setopt( $ch , CURLOPT_POSTFIELDS , $params );
        curl_setopt( $ch , CURLOPT_URL , $url );
    }
    else
    {
        if($params){
            curl_setopt( $ch , CURLOPT_URL , $url.'?'.$params );
        }else{
            curl_setopt( $ch , CURLOPT_URL , $url);
        }
    }
    $response = curl_exec( $ch );
    if ($response === FALSE) {
        //echo "cURL Error: " . curl_error($ch);
        return false;
    }
    $httpCode = curl_getinfo( $ch , CURLINFO_HTTP_CODE );
    $httpInfo = array_merge( $httpInfo , curl_getinfo( $ch ) );
    curl_close( $ch );
    return $response;
}


/**
 *  php多种方式完美实现下载远程图片保存到本地
 * @param String $url  文件url,保存文件名称，使用的下载方式
 * @param String $filename 当保存文件名称为空时则使用远程文件原来的名称
 * @param Integer $type 下载方式，curl还是readfile
 * @return String filename 保存的文件名
 */
function getImage($url,$filename='',$type=0){
    $arr_ext = ['.gif' => '', '.jpg' => '', '.png' => ''];
    if($url==''){return false;}
    if($filename==''){
        $ext=strrchr($url,'.');
        if(!array_key_exists($ext, $arr_ext)){return false;}
        //$filename=time().$ext;
        $arr_url = explode('/', $url);
        if(count($arr_url)>1){
            $filename = 'Public\\static\\images\\weather\\night\\'. $arr_url[count($arr_url) - 1];
        }else{
            $filename=time().$ext;
        }
    }
    //文件保存路径
    if($type){
        $ch=curl_init();
        $timeout=5;
        curl_setopt($ch,CURLOPT_URL,$url);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);
        $img=curl_exec($ch);
        curl_close($ch);
    }else{
        ob_start();
        readfile($url);
        $img=ob_get_contents();
        ob_end_clean();
    }

    $size=strlen($img);
    //文件大小
    $fp2=@fopen($filename,'a');
    fwrite($fp2,$img);
    fclose($fp2);
    return $filename;
}