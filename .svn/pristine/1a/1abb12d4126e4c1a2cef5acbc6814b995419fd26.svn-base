<?php
/**
 * HotelCache.class.php - 专门处理缓存类-酒店相关类缓存
 * @package Core\Functions
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月21日 上午11:35
 * @version V1.0.0
 */

namespace Common\Cache;
use Common\Cache\BaseCache;

class HotelCache extends BaseCache {
    
    /**
     * icon 图标详情
     * @access public
     * @param int $id 图标ID
     * @param boolean $is_set 是否为更新
     * @param array/string $val 更新值
     * @return boolea/array
     */
    public function getHotelInfo($id,$is_set = false, $val = null){
        return D('HotelInfo')->getInfo($id);
        
        $key = self::$KEY_HOTEL_INFO.$id;
        //是否为修改缓存
        if($is_set){
            //删除缓存
            if(is_null($val)){
                return S($key,null);
            }
            //更新缓存值
            return S($key, $val);
        }
        
        //读取当前缓存
        $info = S($key);
        if($info){
            return $info;
        }
        
        //当前缓存不存在，通过数据库重新获取数据 写入缓存并且返回
        $rs_info = D('ServiceIcon')->getInfo($id);
        //如果数据库没有找到对应值返回false
        if(!$rs_info){
            return false;
        }
        //写入缓存并返回
        if(S($key, $rs_info)){
            return $rs_info;
        }
        
        return false;
    }
}