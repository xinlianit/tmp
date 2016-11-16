<?php
/**
 * FloorInfoModel.class.php - 楼层模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-31 14:40
 */

namespace Admin\Model;
use Think\Model;

class FloorInfoModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'floor_info';
    
    /**
     * 字段验证
     * @var array
     */
    protected $_validate = array(
        array('hotel_id', 'require', '商户不能为空'),
        array('floor_name', 'require', '楼层名称不能为空'),
        array('room_number', 'require', '楼层不能为空')
    );
    
    /**
     * 字段填充
     * @var array
     */
    protected $_auto = array();
}