<?php
namespace ManageApi\Controller;

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
        '128'=> '账号信息已停用或删除',
        '256'=> '写入Redis缓存失败',
    );


    //员工登录接口
    public function login(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        $account = trim($this->I['staff_account']); //酒店ID
        $staff_pwd = trim($this->I['staff_pwd']); //酒店ID

        $_only_token = S($account . '_' . $hotel_id);
        if(isset($_only_token) && strlen(trim($_only_token))>0){
            S($_only_token, null);
            S($account . '_' . $hotel_id, null);
        }

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


    //获取楼层列表信息
    public function getFloorList(){
        $hotel_id = trim($this->I['hotel_id']); //酒店ID
        $build_id = trim($this->I['build_id']); //楼宇ID
        if(isset($hotel_id) && isset($build_id)) {
            $_floor_info = M("floor_info");
            $_map['hotel_id'] = $hotel_id;
            $_map['data_status'] = 1;

            $floor_list = $_floor_info -> field('id as floor_id, floor_name, floor_code, room_number, floor_remark')
                -> where($_map) -> select();

            if($floor_list){
                $this -> result = array_merge($this -> result, ['list' => $floor_list]) ;
            }else{
                $this -> result['list'] = [];
                $this -> result = array_merge($this -> result, $this -> status['100015']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取楼层未处理消息列表
    public function getUntreatedMsgList(){
        $floor_ids = trim($this->I['floor_ids'], ','); //二级服务ID
        $page_no = trim($this->I['page_no'], ',');
        $list_count = trim($this->I['list_count'], ',');

        if(isset($floor_ids) && !empty($floor_ids)) {
            $_msg_service = M("msg_service");
            $_result = true;

            $_map['data_status'] = 1;
            $_map['create_time'] = ['lt', time()];


            if( is_numeric($floor_ids) && $floor_ids>0) {
                $_map['floor_id'] = array('eq', $floor_ids);
            }else if(false !== stristr($floor_ids, '[')){
                $_map['floor_id'] = array('in', json_decode($floor_ids, true));
            }else if(false !== stristr($floor_ids, ',')){
                $_map['floor_id'] = array('in', $floor_ids);
            }else if('AA' !== $floor_ids){
                $_result = false;
            }

            if($_result) {
                if(!isset($page_no)){
                    $page_no = 1;
                }else if($page_no<=0){
                    $page_no = 1;
                }

                if(!isset($list_count)){
                    $list_count = 10;
                }else if($list_count<=0){
                    $list_count = 10;
                }

                $msg_service = $_msg_service->field('id as msg_id, msg_content, room_name, room_phone, create_time')->alias('a')
                    -> where($_map)
                    -> limit(($page_no - 1) * $list_count, $list_count)
                    -> order('create_time desc')->select();

                if ($msg_service) {
                    $this->result = array_merge($this->result, ['list' => $msg_service]);
                    /*$_arr_msg_id = array_column($msg_service, 'msg_id');
                    $_data = [
                        'data_status' => 2
                    ];
                    $_msg_service -> startTrans();
                    $rs = $_msg_service -> data($_data) -> where(['id' =>['in', $_arr_msg_id]]) -> save();
                    if($rs){
                        $_msg_service -> commit();
                        $this -> result = array_merge($this -> result, ['list' => $msg_service]);
                    }else{
                        $_msg_service ->rollback();
                        $this -> result = array_merge($this -> result, ['list' => []]);
                        $this -> result = array_merge($this -> result, $this -> status['600008']) ;
                    }*/
                } else {
                    $this->result['list'] = [];
                    $this->result = array_merge($this->result, $this->status['300012']);
                }
            }else{
                $this->result = array_merge($this->result, $this->status['200000']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //订单状态修改
    function setOrderStatus(){
        $order_no = trim($this->I['order_no']); //消息ID
        $order_status = trim($this->I['msg_status']); //消息ID

        if(isset($order_no) && !empty($order_no) && isset($order_status)) {
            $_msg_service = M("order_info");
            $_data = [
                'data_status' => $order_status
            ];

            $rs = $_msg_service->data($_data)->where(['order_no' => $order_no])->save();
            if (!$rs) {
                $this->result = array_merge($this->result, $this->status['900007']);
            }
        }
    }
}