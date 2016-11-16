<?php
/**
 * PhoneServiceModel.class.php - 服务电话模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-17 11:40
 */

namespace Admin\Model;
use Think\Model;

class PhoneServiceModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'phone_service';
    
    /**
     * 字段验证
     * @var array
     */
    protected $_validate = array(
        array('hotel_id', 'require', '商户不能为空'),
    );
    
    /**
     * 字段填充
     * @var array
     */
    protected $_auto = array();
}