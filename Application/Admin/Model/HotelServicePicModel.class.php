<?php
/**
 * HotelServicePicModel.class.php - 酒店服务指南图片信息
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-16 14:40
 */

namespace Admin\Model;
use Think\Model;

class HotelServicePicModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'hotel_service_pic';
    
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