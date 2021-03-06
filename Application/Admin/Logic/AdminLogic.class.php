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
    
    /**
     * 添加编辑管理员
     */
    public function saveAdmin($flag='add'){
        $model = self::getModel('AdminInfo');
        
        $data = $model->create();
        
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
        
        //账号唯一性检测
        $exists_map = array(
            'admin_account'     => $data['admin_account'],
            'data_status'       => array('neq', 99)
        );
        
        if($flag == 'edit'){
            $exists_map['id']       = array('neq', $data['id']);
        }
        $exists = $model->where($exists_map)->getField('id');
        if( $exists ){
            $this->result['msg']    = "管理员账号已存在！";
            return $this->result;
        }
        
        $startTrans = false;
        
        //编辑
        if($flag == 'edit'){
            $model->startTrans();
            $startTrans = true;
            
            unset($data['admin_pass']);
            
            //编辑基础信息
            $update_map = array(
                'id'          => $data['id']
            );
            $admin_rs      = $model->where($update_map)->save($data);
        
            //编辑组明细
            $group_acc_data = array(
                'group_id'      => trim(I('post.group_id'))
            );
            $group_acc_rs = D('AuthGroupAccess')->where(array('uid'=>$data['id']))->save($group_acc_data);
        
        //添加
        }else{
            
            $model->startTrans();
            $startTrans = true;
            
            unset($data['id']);
            //密码加密
            $data['admin_salt'] = get_salt();
            $data['admin_pass'] = pass_encode($data['admin_pass'], $data['admin_salt']);
            
            //添加基础信息
            $admin_rs        = $model->add($data);
            
            //添加管理员和组关系
            $group_acc_data = array(
                'uid'           => $admin_rs,
                'group_id'      => trim(I('post.group_id'))
            );
            
            $group_acc_rs = D('AuthGroupAccess')->add($group_acc_data);
        
        }
        
        if($startTrans){
            
            if( $admin_rs == false || $group_acc_rs === false ){
                $model->rollback();
                
                return $this->result;
            }else{
                $model->commit();
            }
            
        }else{
            if( !$admin_rs ){
                return $this->result;
            }
        }
        
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 管理员账号；账号：' . $data['admin_account'];
        self::recodeLog($info);
        
        //全部通过，返回真
        return true;
    }
    
    /**
     * 重置密码
     */
    public function resetPwd(){
        $model = self::getModel('AdminInfo');
    
        $data = $model->create();
        
        //管理员详情
        $admin_info = $model->where(array('id'=>self::$loginInfo['id']))->find();
        
        //原始密码验证
        $old_map = array(
            'id'                => self::$loginInfo['id'],
            'admin_pass'        => $data['admin_pass'],
            'data_status'       => array('neq', 99)
        );
        
        if( pass_encode(trim(I('post.old_pwd')), $admin_info['admin_salt']) !== $admin_info['admin_pass'] ){
            $this->result['msg']        = "原始密码输入错误！";
            return $this->result;
        }
        
        //数据处理
        $data['admin_salt']     = get_salt();
        $data['admin_pass']     = pass_encode($data['admin_pass'], $data['admin_salt']);
        
        //更新密码
        $reset_result = $model->where(array('id'=>self::$loginInfo['id']))->save($data);
        
        if($reset_result === false){
            $this->result['msg']        = "密码更新失败！";
            return $this->result;
        }
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 初始化密码
     * @param array $ids            管理员ID
     * @return 
     */
    public function initAdminPwd($ids){
        
        $model = $this->getModel('AdminInfo');
        
        $status = array();
        
        foreach($ids as $v){
            
            //管理员信息
            $admin_info = $model->field('admin_email')->where(array('id'=>$v))->find();
            
            //获取盐值
            $salt = get_salt();
            //生成随机6位密码
            $pwd = get_salt(6);
            
            $data = array(
                'admin_salt'        => $salt,
                'admin_pass'        => pass_encode($pwd, $salt),
            );
            
            $map = array(
                'id'        => $v,
            );
            
            $rs = $model->where($map)->save($data);
            
            if( $rs === false ){
                array_push($status, 0);
            }else{
                array_push($status, 1);
                
                //发送新密码到邮箱...
                if( !empty($admin_info['admin_email']) && filter_var($admin_info['admin_email'], FILTER_VALIDATE_EMAIL)){
                    
                    $title      = '后台管理员账户密码初始化';
                    $message    = '密码初始化成功，新密码：' . $pwd;
                    
                    send_mail($admin_info['admin_email'], $title, $message);
                }
            }
        }
        
        //全部失败
        if(in_array(0, $status) && !in_array(1, $status)){
            return false;
        //部分失败
        }else if(in_array(0, $status) && in_array(1, $status)){
            return null;
        //全部成功
        }else if(!in_array(0, $status) && in_array(1, $status)){
            return true;
        }
    }
    
    /**
     * 添加编辑组别
     */
    public function saveGroup($flag='add'){
        $model = self::getModel('AuthGroup');
    
        $data = $model->create();
    
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
    
        //组别唯一性检测
        $exists_map = array(
            'title'             => $data['title'],
            'status'            => 1
        );
    
        if($flag == 'edit'){
            $exists_map['id']       = array('neq', $data['id']);
        }
        $exists = $model->where($exists_map)->getField('id');
        if( $exists ){
            $this->result['msg']    = "组别已存在！";
            return $this->result;
        }
        
        $data['rules']      = implode(',', $data['rules']);
    
        //编辑
        if($flag == 'edit'){
            $update_map = array(
                'id'        => $data['id']
            );
            $group_rs       = $model->where($update_map)->save($data);
            
            if($group_rs === false){
                $this->result['msg']    = '编辑组别失败！';
                return $this->result;
            }
        //添加
        }else{
    
            unset($data['id']);
            //添加基础信息
            $group_rs        = $model->add($data);
            
            if( !$group_rs ){
                $this->result['msg'] = '添加组别失败';
                return $this->result;
            }
    
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 组别；组别名称：' . $data['title'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
    
    /**
     * 添加编辑商户账号
     */
    public function saveBusineAcc($flag='add'){
        $model = self::getModel('StaffInfo');
    
        $data = $model->create();
    
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
    
        //账号唯一性检测
        $exists_map = array(
            'hotel_id'          => $data['hotel_id'],
            'staff_account'     => $data['staff_account'],
            'data_status'       => array('neq', 99)
        );
    
        if($flag == 'edit'){
            $exists_map['id']       = array('neq', $data['id']);
        }
        $exists = $model->where($exists_map)->getField('id');
        if( $exists ){
            $this->result['msg']    = "商户账号已存在！";
            return $this->result;
        }
    
        //编辑
        if($flag == 'edit'){
    
            if( $data['staff_pwd'] == '******' ){
                unset($data['staff_pwd']);
            }else{
                //密码加密
                $data['staff_salt'] = get_salt();
                $data['staff_pwd']  = pass_encode($data['staff_pwd'], $data['staff_salt']);
            }
    
            //编辑基础信息
            $update_map = array(
                'id'          => $data['id']
            );
            $busine_account_rs      = $model->where($update_map)->save($data);
    
            if( $busine_account_rs === false ){
                $this->result['msg']    = '编辑商户账号失败！';
                return $this->result;
            }
        //添加
        }else{
    
            unset($data['id']);
            //密码加密
            $data['staff_salt'] = get_salt();
            $data['staff_pwd']  = pass_encode($data['staff_pwd'], $data['staff_salt']);
    
            //添加基础信息
            $busine_account_rs        = $model->add($data);
            
            if( !$busine_account_rs ){
                $this->result['msg']    = '添加商户账号失败！';
                return $this->result;
            }
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 商户账号；账号：' . $data['staff_account'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
}