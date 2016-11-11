<?php

namespace Common\Logic;

class UserLogic {
    private $_model_name = 'staff_info';
    public function test(){
        echo 'public logic';
    }

    /**
     * 通过账户名称获取账户信息
     * @param String $account_name
     */
    public function getInfoByAccount($hotel_id, $account_name){
        if(isset($hotel_id) && isset($account_name) && strlen($account_name)>0){
            return $this -> _getInfoByAccount($hotel_id, $account_name);
        }
    }


    /**
     * 通过账户名称判断账户是否存在
     * @param String $account_name
     */
    public function hasAccount($hotel_id, $account_name){
        if(isset($account_name) && strlen($account_name)>0){
            return $this -> _getInfoByAccount($hotel_id, $account_name, 'id');
        }
        return false;
    }


    /**
     * 通过账户信息获取账户指定字段信息
     * @param string $account_name  账户名称
     * @param string/boolean $fields        查询字段
     */
    private function _getInfoByAccount($hotel_id, $account_name, $fields = false){
        if(isset($hotel_id) && isset($account_name) && strlen($account_name)>0){
            $sql = M($this -> _model_name);

            if($fields){
                $sql = $sql -> field($fields);
            }
            return $sql -> where(array('hotel_id' => $hotel_id, 'data_status' => array('neq', 99), 'staff_account' => $account_name)) -> find();
        }
    }


    public function getInfoById($staff_id = 0){
        if($staff_id > 0){
            $sql = M($this -> _model_name);
            return $sql -> where(array('staff_id' => $staff_id)) -> find();
        }
    }
}