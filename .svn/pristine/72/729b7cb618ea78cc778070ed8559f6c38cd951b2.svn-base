<?php
/**
 * StaffInfoModel.class.php - 员工模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-28 14:40
 */

namespace Admin\Model;
use Think\Model;

class StaffInfoModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'staff_info';
    
    /**
     * 字段验证
     * @var array
     */
    protected $_validate = array(
        array('hotel_id', 'require', '商户不能为空'),
        array('staff_account', 'require', '账号不能为空'),
        array('staff_pwd', 'require', '密码不能为空'),
    );
    
    /**
     * 字段填充
     * @var array
     */
    protected $_auto = array(
        array('create_time', 'time', 1, 'function'),
        array('update_time', 'time', 3, 'function'),
    );
}