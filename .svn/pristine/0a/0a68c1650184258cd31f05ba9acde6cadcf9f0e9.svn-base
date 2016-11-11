<?php

/**
 * TypeInfoModel.class.php - 商户类型标签信息模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-08 10:40 Zhaoxizhan(441534536@qq.com)
 */


namespace Admin\Model;
use Think\Model;

class TypeInfoModel extends Model {
    protected $tableName = 'type_info';
    
    /**
     * 获取类型详情-通过ID
     * @param type $id
     */
    public function getInfo($id){
        $_map['id'] = $id;
        return $this->where($_map)->find();
    }
}