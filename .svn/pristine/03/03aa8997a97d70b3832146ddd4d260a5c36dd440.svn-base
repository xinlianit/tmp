<?php

/**
 * TypeInfoModel.class.php - 广告主基础信息表模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-17 10:40 Zhaoxizhan(441534536@qq.com)
 */
namespace Common\Model;
use Think\Model;

class AdvertisersInfoModel extends Model {
    /**
     * 广告主详情
     * @param int $id   广告主ID
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
     * 商户广告数加一
     * @param type $id
     * @param type $step
     * @return type
     */
    public function setAdvertNumInc($id,$step=1){
        $_map['id'] = $id;
        return $this->where($_map)->setInc('advert_num',$step);
    }
    
    /**
     * 商户广告数减一
     * @param type $id
     * @param type $step
     * @return type
     */
    public function setAdvertNumDec($id,$step=1){
        $_map['id'] = $id;
        return $this->where($_map)->setDec('advert_num',$step);
    }
    
    
}
