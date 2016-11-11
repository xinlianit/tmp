<?php
/**
 * AdminInfoModel.class.php - 管理员模型
 * @package Model
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-10-31 14:40
 */
namespace Admin\Model;
use Think\Model;
class AdminInfoModel extends Model {
    protected $tableName = 'admin_info';
    
    protected $_validate = array();
    
    /**
     * 验证用户名
     * @return boolean
     */
    public function checkName($account){
        /**
         * 账号规则：
         * 1、字母/数字/下划线/中划线开头(a-zA-Z0-9_-)
         * 2、长度在 4-16 位字符
         * 3、允许输入字符为：a-zA-Z0-9_-@\.
         * 4、不能以 @ 或 . 结尾
         * */
        $pattern        = '/^[a-zA-Z0-9_-]{1}(\@*\.*[a-zA-Z0-9_-]){3,15}$/';
    
        if( !preg_match($pattern, $account) ){
            return false;
        }
    
        return true;
    }
    
    /**
     * 验证密码
     * @return boolean
     */
    public function checkPwd($passwd){
        /**
         * 密码规则：
         * 1、字母/数字/下划线/中划线开头(a-zA-Z0-9_-)
         * 2、长度在 6-18 位字符
         * 3、允许输入字符为：a-zA-Z0-9_-
         * */
        $pattern        = '/^[a-zA-Z0-9_-]{6,18}$/';
    
        if( !preg_match($pattern, $passwd) ){
            return false;
        }
    
        return true;
    }
    
    
}