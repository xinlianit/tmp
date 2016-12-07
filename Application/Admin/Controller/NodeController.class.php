<?php
/**
 * NodeController.class.php - 权限节点
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-16 11:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class NodeController extends CommonController {
    /**
     * 权限节点
     */
    public function index(){
        
        $map = array();
        
        $name       = trim(I('get.name'));
        $id         = trim(I('get.id'));
        
        if( $name ){
            $map['name']        = array('like', '%'.$name.'%');
            $map['_logic']      = 'OR';
            $map['title']       = array('like', '%'.$name.'%');
        }
        
        if( $id ){
            $map['pid']         = $id;
        }
        
        $page = D('Common' , 'Logic')->page(array('name'=>'AuthRule', 'where'=>$map));
            
        $this->assign('page',$page);
        
        //模块、控制器级节点
        $map = array(
            'type'      => array('in', array(1,2)),
            'status'    => 1
        );
        $parent_node = self::$CommonLogic->getRows('AuthRule', $map, array('id', 'name', 'title', 'type'), array('sort'=>'asc'));
        $this->assign('parent_node', $parent_node);
        $this->display();
    }
    
    /**
     * 添加编辑权限节点
     */
    public function addEditNode(){
        if(IS_POST){
            $result = D('Auth', 'Logic')->saveNode( $this->post['flag'] );
        
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除节点
     */
    public function deleteNode(){
        $id         = trim($this->get['ids']);
        
        if( !$id || empty($id) ){
            $this->ajaxReturnErr();
        }
        
        $map = array(
            'id'        => array('in', $id)
        );
        $result = D('AuthRule')->where($map)->delete();
        
        if( $result ){
        
            $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除节点；节点ID：" . $id;
            self::$CommonLogic->recodeLog($log);
            $this->ajaxReturnSuccess();
        }else{
            $this->ajaxReturnErr();
        }
    }
    
    /**
     * 节点详情
     */
    public function nodeInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            $info = self::$CommonLogic->getRow('AuthRule', array('id'=>$id));
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 用户管理
     */
    public function user(){
        
        $group_id           = trim($this->get['group_id']);
        $admin_account      = trim($this->get['admin_account']);
        $admin_name         = trim($this->get['admin_name']);
        $admin_mobile       = trim($this->get['admin_mobile']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($group_id) ){
            $group_acc_map = array(
                'group_id'      => $group_id
            );
            $admin_ids = get_fields_to_array('AuthGroupAccess', 'uid', $group_acc_map);
            if( !empty($admin_ids) ){
                $map['id']  = array('in', $admin_ids);
            }
        }
        
        if( !empty($admin_account) ){
            $map['admin_account']       = array('like', '%'.$admin_account.'%');
        }
        
        if( !empty($admin_name) ){
            $map['admin_name']       = array('like', '%'.$admin_name.'%');
        }
        
        if( !empty($admin_mobile) ){
            $map['admin_mobile']       = array('like', '%'.$admin_mobile.'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'AdminInfo', 'where'=>$map));
        $this->assign('page',$page);
        
        //管理员组
        $group_map = array(
            'status'        => array('neq', 99)
        );
        $group = self::$CommonLogic->getRows('AuthGroup', $group_map);
        $this->assign('group', $group);
        $this->display();
    }
    
    /**
     * 添加编辑管理员
     */
    public function addEditAdmin(){
        if(IS_POST){
            $result = D('Admin', 'Logic')->saveAdmin( $this->post['flag'] );
            
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除管理员账号
     */
    public function deleteAdmin(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('AdminInfo',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除管理员账号；账号ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 管理员账号详情
     */
    public function adminInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            $info = self::$CommonLogic->getRow('AdminInfo', array('id'=>$id, 'data_status'=>array('neq',99)));
            
            if($info){
                //所属组
                $info['group_id'] = self::$CommonLogic->getField('AuthGroupAccess', 'group_id', array('uid'=>$info['id']));
                //是否超级管理员
                $info['is_super'] = C('AUTH_CONFIG.AUTH_ADMINISTRATOR') == $info['admin_account'] ? 1 : 0;
            }
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 账户启用停用
     */
    public function adminOnOff(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
            $flag       = trim($this->get['flag']);
        
            $map = array(
                'id'                => array('in', $id),
            );
            $result = self::$CommonLogic->onOffRows('AdminInfo', $map, $flag);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 启用停用管理员账号；账号ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 初始化密码
     */
    public function initPwd(){
        if(IS_AJAX){
            $ids = explode(',', $this->get['ids']);
            
            if( empty($ids) ){
                $this->ajaxReturnErr(array('msg'=>'未获取到记录ID！'));
            }
            
            $result = D('Admin', 'Logic')->initAdminPwd($ids);
        
            if( $result === true ){
                $this->ajaxReturnSuccess( array('msg'=>'密码初始化成功，新密码将邮件通知到预留电子邮箱。') );
            }else{
                $this->ajaxReturnErr(array('msg'=>'初始化密码失败！'));
            }
        }
    }
    
    /**
     * 组别管理
     */
    public function group(){
        $title           = trim($this->get['title']);
        
        $map = array(
            'status'       => array('neq',99),
        );
        
        if( !empty($title) ){
            $map['title']       = array('like', '%'.$title.'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'AuthGroup', 'where'=>$map));
        $this->assign('page',$page);
        
        //权限节点
        $rule_map = array(
            'type'          => 2,
            'status'        => 1
        );
        $rule = self::$CommonLogic->getRows('AuthRule', $rule_map, array('id', 'pid', 'title', 'name') , array('sort'=>'asc'));
        
        foreach($rule as $k=>$v){
            $rule_map['type']       = 3;
            $rule_map['pid']        = $v['id'];
            
            $rule[$k]['list'] = self::$CommonLogic->getRows('AuthRule', $rule_map, array('id', 'pid', 'title', 'name') , array('sort'=>'asc'));
        }
        $this->assign('rule', $rule);
        
        $this->display();
    }
    
    /**
     * 添加编辑组别
     */
    public function addEditGroup(){
        if(IS_POST){
            $result = D('Admin', 'Logic')->saveGroup( $this->post['flag'] );
        
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除组别
     */
    public function deleteGroup(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
            
            $result = D('AuthGroup')->where($map)->save(array('status'=>99));
             
            if( $result !== false ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除组别；组别ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 组别详情
     */
    public function groupInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            $info = self::$CommonLogic->getRow('AuthGroup', array('id'=>$id, 'data_status'=>array('neq',99)), array('id', 'rules', 'title'));
            if( !empty($info['rules']) ){
                $info['rules'] = explode(',', $info['rules']);
            }
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 商户账号管理
     */
    public function merchant(){
        $hotel_name           = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($hotel_name) ){
            //获取商户ID
            $hotel_map = array(
                'hotel_name'        => array('like', '%'.$hotel_name.'%'),
                'data_status'       => 1
            );
            
            $hotel_id   = get_fields_to_array('HotelInfo', 'id', $hotel_map);
            
            if( !empty($hotel_id) ){
                $map['hotel_id']       = array('in', $hotel_id);
            }else{
                $map['hotel_id']       = 0;
            }
            
        }
        
        $page = self::$CommonLogic->page(array('name'=>'StaffInfo', 'where'=>$map, 'order'=>array('id'=>'desc')));
        
        $this->assign('page',$page);
        
        $this->display();
    }
    
    /**
     * 商户账户启用停用
     */
    public function busineAccOnOff(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
            $flag       = trim($this->get['flag']);
    
            $map = array(
                'id'                => array('in', $id),
            );
            $result = self::$CommonLogic->onOffRows('StaffInfo', $map, $flag);
             
            if( $result ){
    
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 启用停用商户账号；账号ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 添加编辑商户账号
     */
    public function addEditBusiAcc(){
        if(IS_POST){
            $result = D('Admin', 'Logic')->saveBusineAcc( $this->post['flag'] );
        
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除商户账号
     */
    public function deleteBusiAcc(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
        
            $result = self::$CommonLogic->deleteRows('StaffInfo',$map);
             
            if( $result !== false ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除商户账号；账号ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 商户账号详情
     */
    public function busineAccInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            $info = self::$CommonLogic->getRow('StaffInfo', array('id'=>$id, 'data_status'=>array('neq',99)));
            
            if( $info ){
                $info['hotel_name'] = self::$CommonLogic->getField('HotelInfo', 'hotel_name', array('id'=>$info['hotel_id'], 'data_status'=>1));
            }
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->ajaxReturnErr($this->result);
    }
}