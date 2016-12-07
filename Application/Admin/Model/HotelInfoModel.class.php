<?php
/**
 * HotelInfoModel.class.php - 酒店商户模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-10-31 14:40
 */

namespace Admin\Model;
use Think\Model;

class HotelInfoModel extends Model {
    protected $tableName = 'hotel_info';
    
    //验证字段 （必须）、验证规则 （必须）、提示信息 （必须）、验证条件 （可选）、附加规则 （可选）、验证时间（可选）
    protected $_validate = array(
        array('hotel_name', '', '商户名称已经存在！', 0, 'unique', 1),
        array('hotel_type', 'require', '商户类型不能为空！'),
    );
    
    //完成字段（必须）、完成规则（必须）、完成时间（可选）、附加规则（可选）
    protected $_auto = array(
        array('create_time', 'time', 1, 'function'),
        array('update_time', 'time', 3, 'function'),
        array('data_status', 1)
    );
    
    /**
     * 获取酒店详情
     * @param type $id
     * @return boolean
     */
    public function getInfo($id){
        $_map['id'] = $id;
        $rs =  $this->where($_map)->find();
        if($rs){
            return $rs;
        }
        
        return false;
    }
    
}