<?php
/**
 * FeedBackController.class.php - 客房服务APP接口酒店服务
 * @package RoomApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月10日  09:05
 * @version V1.0.0
 */
namespace RoomApi\Controller;

class HotelController extends CommonController {
    //登录出错对应编码及说明文字
    private $_login_error = array(
        '1' => '用户名为空',
        '2' => '用户密码为空',
        '4' => '密码长度超过16位',
        '8' => '酒店ID为空',
        '16' => '酒店ID不是数字或小于等于0',
        '32' => '员工账户不存在',
        '64' => '员工密码错误',
        '128'=> '账号信息已停用或删除'
    );

    //获取酒店服务指南信息
    public function getServiceDirectory(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        if(isset($hotel_id) && !empty($hotel_id)) {
            $_hotel_servers = M("hotel_service");
            $hotel_servers = $_hotel_servers -> field('a.id as directory_id, b.pic_path as image_path') -> alias('a')
                -> join('__HOTEL_SERVICE_PIC__ b ON a.id = b.service_id', 'left')
                -> where(array('a.hotel_id' => $hotel_id, 'a.data_status' => 1))
                -> select();

            if($hotel_servers){
                $this -> result['list'] = $hotel_servers ;
            }else{
                $this -> result['list']  = [];
                $this -> result = array_merge($this -> result, $this -> status['100002']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100001']) ;
        }

        $this->ajaxReturn($this->result);
    }


    //获取酒店服务指南图片数量
    public function getDirectoryCount(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        if(isset($hotel_id) && !empty($hotel_id)) {
            $_hotel_servers = M("hotel_service");
            $hotel_servers = $_hotel_servers -> field('pic_num as image_count')
                -> where(array('hotel_id' => $hotel_id, 'data_status' => 1))
                -> find();

            if($hotel_servers){
                $this -> result = array_merge($this -> result, $hotel_servers) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['100002']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100001']) ;
        }

        $this->ajaxReturn($this->result);
    }


    //员工登录接口
    public function login(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        $account = trim($this->I['staff_account']); //酒店ID
        $staff_pwd = trim($this->I['staff_pwd']); //酒店ID

        $rs = D('User', 'Api') -> login($account, $staff_pwd, $hotel_id);

        if($rs && 0 == $rs['code']){
            $staff_info = S($rs['data']);
            $this->result['token'] = $rs['data'];
            $this->result['staff_id'] = $staff_info['staff_id'];
            $this->result['staff_name'] = $staff_info['staff_name'];
            $this->result['account_type'] = $staff_info['account_type'];
        }else{
            $error_msg = array();
            foreach ($this -> _login_error as $key => $val) {
                if($key & $rs['code']){
                    $error_msg[] = $val;
                }
            }

            $this->result['resCode'] = 'ERROR';
            $this->result['resMsg'] = implode('、', $error_msg);
        }

        $this->ajaxReturn($this->result);
    }


    //员工退出接口
    public function logout(){
        $token = trim($this->I['token']); //酒店ID
        $rs = D('User', 'Api') -> logout($token);
        if($rs){
            $this -> result = array_merge($this -> result, $this -> status['1']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取酒店wifi信息
    public function getWifiService(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        if(isset($hotel_id) && !empty($hotel_id)) {
            $_wifi_servers = M("wifi_service");
            $wifi_servers = $_wifi_servers -> field('id as wifi_service_id, link_method, wifi_account, wifi_password as wifi_pwd, qrcode_path')
                -> where(array('hotel_id' => $hotel_id, 'data_status' => 1))
                -> find();

            if($wifi_servers){
                $this -> result = array_merge($this -> result, $wifi_servers) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['100012']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100001']) ;
        }

        $this->ajaxReturn($this->result);
    }


    //获取服务电话列表
    public function getPhoneList(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        if(isset($hotel_id) && !empty($hotel_id)) {
            $_phone_servers = M("phone_service");
            $phone_servers = $_phone_servers -> field('call_name, telephone, icon_path, data_sort')
                -> where(array('hotel_id' => $hotel_id, 'data_status' => 1))
                -> select();

            if($phone_servers){
                $this -> result['list'] = $phone_servers ;
            }else{
                $this -> result['list']  = [];
                $this -> result = array_merge($this -> result, $this -> status['100013']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['100001']) ;
        }

        $this->ajaxReturn($this->result);
    }
}