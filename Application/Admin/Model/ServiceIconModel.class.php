<?php
/**
 * ServiceIconModel.class.php - ICON图标模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-17 11:45
 */

namespace Admin\Model;
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
}