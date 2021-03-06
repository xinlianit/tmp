<?php

/**
 * ServiceIconModel.class.php - ICON图标基础信息模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-09 10:40 Zhaoxizhan(441534536@qq.com)
 */


namespace Common\Model;
use Think\Model;

class ServiceIconModel extends Model {
    
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'service_icon';
    
    /**
     * 字段验证
     * @var array
     */
    protected $_validate = array();
    
    /**
     * 字段填充
     * @var array
     */
    protected $_auto = array();
    
    /**
     * 获取类型详情-通过ID
     * @param type $id
     */
    public function getInfo($id){
        $_map['id'] = $id;
        return $this->where($_map)->find();
    }
}