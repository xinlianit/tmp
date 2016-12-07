<?php
/**
 * IndexController.class.php - 商家管理后台首页
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-10-28 9:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class IndexController extends CommonController {
    /**
     * 后台首页
     */
    public function index(){
        $this->display();
    }
    
    /**
     * 修改密码
     */
    public function resetPwd(){
        if(IS_POST){
            
            $new_pwd            = trim($this->post['admin_pass']);
            $new_pwd_repeat     = trim($this->post['admin_pass_repeat']);
            
            if( $new_pwd !== $new_pwd_repeat){
                $this->ajaxReturnErr(array('msg'=>"新密码两次输入不一致！"));
            }
            
            $result = D('Admin', 'Logic')->resetPwd();
            
            if($result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }else{
            $this->display();
        }
    }
}