<?php
/**
 * AuthLogic.class.php - 权限逻辑
 * @package Logic
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-01 14:40
 */
namespace Admin\Logic;
use Admin\Logic\CommonLogic;
class AuthLogic extends CommonLogic{
    /**
     * 添加编辑权限节点
     */
    public function saveNode($flag='add'){
        $model = self::getModel('AuthRule');
    
        $data = $model->create();
    
        //创建数据失败
        if( !$data ){
            $this->result['msg']    = $model->getError();
            return $this->result;
        }
    
        //节点规则唯一性检测
        $exists_map = array(
            'name'     => $data['name'],
        );
    
        if($flag == 'edit'){
            $exists_map['id']       = array('neq', $data['id']);
        }
        $exists = $model->where($exists_map)->getField('id');
        if( $exists ){
            $this->result['msg']    = "该节点已存在！";
            return $this->result;
        }
    
        //编辑
        if($flag == 'edit'){
            $map = array(
                'id'        => $data['id'],
            );
            
            //编辑基础信息
            $auth_rs        = $model->where($map)->save($data);
            
            if( $auth_rs === false ){
                $this->result['msg']    = '节点编辑失败！';
                return $this->result;
            }
    
        //添加
        }else{
            unset($data['id']);
    
            //添加基础信息
            $auth_rs        = $model->add($data);
            
            if( !$auth_rs ){
                $this->result['msg']    = '节点添加失败！';
                return $this->result;
            }
        }
    
        //写入操作日志
        $info['log_msg'] = self::$loginInfo['admin_account'] . ($flag == 'edit' ? ' 编辑' : ' 添加') . ' 权限节点；节点名称：' . $data['title'];
        self::recodeLog($info);
    
        //全部通过，返回真
        return true;
    }
}