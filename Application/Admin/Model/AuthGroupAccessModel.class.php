<?php
/**
 * AuthGroupAccessModel.class.php - 管理员组明细模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-25 10:40
 */
namespace Admin\Model;
use Think\Model;
class AuthGroupAccessModel extends Model {
    protected $tableName = 'auth_group_access';
    
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