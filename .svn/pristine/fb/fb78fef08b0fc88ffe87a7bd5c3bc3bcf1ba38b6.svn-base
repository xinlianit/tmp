<?php

/**
 * FileApi.class.php - 图片处理类
 * @package Common\Api
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月29日 上午11:35
 * @version V1.0.0
 */

namespace Common\Api;

class ImageApi {
    
    /**
     * 图片配置参数
     * @var type 
     */
    protected $config = array(
        'goods' => array(
            '1'=>'600x600',
            '2'=>'200x200'
        )
    );
    
    /**
     * 获取图片尺寸信息
     * @param string $type 图片类型  $config 中的键
     * @param type $key
     * @return boolean
     */
    public function getImageSize($type,$key=null){
        if(!isset($this->config[$type])){
            return false;
        }
        //返回规格列表
        if(is_null($key)){
            return $this->config[$type];
        }
        
        //返回具体规格
        if(!isset($this->config[$type][$key])){
            return false;
        }        
        return $this->config[$type][$key];
    }
    
    
    
    /**
     * 生成缩略图
     */
    public function makeThumb($res_id,$type){
        //资源服务器地址
        $fastdfs_url = C('FASTDFS_URL');
        //资源详情
        $res_info = D('Resource')->getInfo($res_id);
        if(!$res_info){
            return false;
        }
        
        $uploadfile = $fastdfs_url.$res_info['res_path'];
        
        $master_filename = (substr($res_info['res_path'],0,7) === 'group1/')?substr($res_info['res_path'],7):$res_info['res_path'];
        
        //缩略图列表
        $size_list = $this->getImageSize($type);
        if(!$size_list){
            return false;
        }
        
        //缩略图生成
        $success = $failed = 0;//初始化成功失败个数
        foreach ($size_list as $val) {  
            $size_arr = explode('x', $val);
            $rs = D('File','Api')->makeThumb($uploadfile,$master_filename,$size_arr[0],$size_arr[1]);
            if(!$rs){
                $failed++;
                continue;
            }
            //$rs = D('File','Api')->makeThumb($uploadfile,$master_filename,120,80);
            dump($rs);
            if($rs){
                $rs2 = D('File','Api')->deleteFile($rs['groupname'],$rs['filename']);
                dump($rs2);
            }

            dump(D('File','Api')->fileExists($rs['groupname'],$rs['filename']));
        }
        
        
    }


     
}