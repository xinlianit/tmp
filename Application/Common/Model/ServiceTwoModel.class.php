<?php
/**
 * ServiceTwoModel.class.php - 客房二级服务信息模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-09 10:40 JiRY(390066398@qq.com)
 */


namespace Common\Model;
use Think\Model;

class ServiceTwoModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'service_two';
    
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
}