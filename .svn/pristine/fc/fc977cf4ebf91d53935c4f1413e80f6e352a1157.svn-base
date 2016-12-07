<?php
/**
 * FeedbackSubjectModel.class.php - 问卷反馈模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-12-1 14:40
 */

namespace Admin\Model;
use Think\Model;

class FeedbackSubjectModel extends Model {
    /**
     * 表名
     * @var string
     */
    protected $tableName = 'feedback_subject';
    
    /**
     * 字段验证
     * @var array
     */
    protected $_validate = array();
    
    /**
     * 字段填充
     * @var array
     */
    protected $_auto = array(
        array('create_time', 'time', 1, 'function'),
        array('update_time', 'time', 3, 'function'),
    );
}