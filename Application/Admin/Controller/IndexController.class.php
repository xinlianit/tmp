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
     * 模板实例
     * @desc 供开发使用
     */
    public function tpl(){
        if( IS_POST ){
            $result = array(
                //返回状态；0：操作失败、1：操作成功
                'status'    => 0,
                //成功或失败提示信息
                'msg'       => '',
                'post_data' => $_POST
            );
            $this->ajaxReturn($result);
        }else{
            $page = D('Common' , 'Logic')->page(array('name'=>'AuthRule'));
            
            //debug($page);
            $this->assign('page',$page);
            $this->display();
        }
    }
    
    public function upload(){
        //layout(false);
        $this->display('Layout/upload');
    }
}