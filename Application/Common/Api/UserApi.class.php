<?php

namespace Common\Api;

class UserApi {
    //员工登录令牌生成键值前缀
    private $_User_Key = 'staff_info_key';

    public function test(){
        echo 'public api';
        echo '<br>';
        D('User','Logic')->test();        
    }

    /** 员工登录接口
     * @param $account
     * @param $password
     * @param $hotel_id
     * @return array
     */
    public function login(& $account, $password, $hotel_id){
        $result = ['code' => 0, 'data' => ''];

        if(isset($account) && empty($account)){
            $result['code'] = $result['code'] | 1;//账户名为空
        }

        if(isset($password) && empty($password)){
            $result['code'] = $result['code'] | 2;//账户密码为空
        }else if(strlen($password)>16){
            $result['code'] = $result['code'] | 4;//密码长度超过16位
        }

        if(isset($hotel_id) && empty($hotel_id)){
            $result['code'] = $result['code'] | 8;//酒店ID为空
        }else if(is_integer($hotel_id) && $hotel_id>0){
            $result['code'] = $result['code'] | 16;//酒店ID不是数字或小于等于0
        }

        if( 0 === $result['code'] ){

            $validate_account = D('User', 'Logic')->getInfoByAccount( $hotel_id, $account );

            if($validate_account) {
                $pwd = pass_encode($password, $validate_account['staff_salt']);

                if($pwd && $pwd === $validate_account['staff_pwd']){
                    if(1 == $validate_account['data_status']) {
                        $_key = md5(sprintf('%s::%s::%s', $this->_User_Key, $validate_account['id'], time()));
                        $data = array(
                            'staff_id' => $validate_account['id'],
                            'staff_name' => $validate_account['staff_name'],
                            'staff_account' => $account,
                            'account_type' => $validate_account['account_type'],
                            'create_time' => $validate_account['create_time'],
                            'hotel_id' => $hotel_id,
                            //'data_status'     => $validate_account['data_status']
                        );

                        S($_key, $data);
                        $result['data'] = $_key;
                    }else{
                        $result['code'] = $result['code'] |128;//账号信息已停用或删除
                    }
                } else {
                    $result['code'] = $result['code'] | 64;//员工密码错误
                }
            }else{
                $result['code'] = $result['code'] | 32;//员工账户不存在
            }
        }
        return $result;
    }


    public function logout($token = null){
        $result = false;
        if($token){
            $result = S($token, null);
        }
        return $result;
    }

    public function getStaffByToken($token = null){
        $result = false;
        if($token){
            $result = S($token);
        }
        return $result;
    }


    public function accountStatusCheck($staff_id, $status = 1){
        if($staff_id && $staff_id>0){
            $_staff_info = D('User', 'Logic') -> getInfoById($staff_id);

            if($_staff_info){
                if($status == $_staff_info['data_status']){
                    return true;
                }
            }
        }
        return false;
    }
}