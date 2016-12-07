<?php

/**
 * TypeInfoModel.class.php - 广告内容基础信息表
 * @link http://www.pad-phone.com
 * @copyright 2016-11-17 10:40 Zhaoxizhan(441534536@qq.com)
 */
namespace Common\Model;
use Think\Model;

class AdvertInfoModel extends Model {
    
    /**
     * 编辑广告内容
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function editInfo($id,$data){
        $_map['id'] = $id;
        //广告主表添加
        $rs = $this->where($_map)->save($data);
        if($rs === false){
            return false;
        }
        return true;
    }
    
    /**
     * 删除广告内容
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function delInfo($id){
        $_map['id'] = $id;
        $data['data_status'] = 99;
        
        $rs = $this->where($_map)->save($data);
        if($rs === false){
            return false;
        }
        return true;
    }
    
    /**
     * 广告内容
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function getInfo($id){
        $_map['id'] = $id;
        //广告主表添加
        $rs = $this->where($_map)->find();
        if($rs === false){
            return false;
        }
        return $rs;
    }
    
    /**
     * 展示商户数更新
     * @param type $id
     * @param type $step
     * @return type
     */
    public function setHotelNumInc($id,$step=1){
        $_map['id'] = $id;
        return $this->where($_map)->setInc('hotel_num',$step);
    }
    
    /**
     * 展示商户数更新
     * @param type $id
     * @param type $step
     * @return type
     */
    public function setHotelNumDec($id,$step=1){
        $_map['id'] = $id;
        return $this->where($_map)->setDec('hotel_num',$step);
    }
    
    
}
