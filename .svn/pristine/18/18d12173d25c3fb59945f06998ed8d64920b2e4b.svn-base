<?php
/**
 * AdminLogic.class.php - 管理员逻辑
 * @package Logic
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-10-31 14:40
 */
namespace Admin\Logic;
use Admin\Logic\CommonLogic;
class AdminLogic extends CommonLogic{
    /**
     * 验证登陆数据
     * @param array $data   验证数据
     * @return boolean|string
     */
    public function validateLoginData($data){
        //验证规则
        $rules = array(
            array('admin_account','checkName','loginname-账号格式错误',0,'callback'),  // 只在登录时候验证
            array('admin_pass','checkPwd','password-密码格式错误',0,'callback'), // 只在登录时候验证
            array('verify','require','code-验证码不能为空！'), 
        );
        
        $model = D('AdminInfo');
        
        $validate_result = $model->validate($rules)->create($data);
        
        if( !$validate_result ){
            return $model->getError();
        }
        
        return true;
    }
    
}