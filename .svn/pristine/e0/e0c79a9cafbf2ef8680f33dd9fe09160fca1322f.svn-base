<?php
/**
 * RoomController.class.php - 客房服务接口
 * @package RoomApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月10日  13:52
 * @version V1.0.0
 */
namespace RoomApi\Controller;

class RoomController extends CommonController {
    //获取当前客房房态信息
    public function getRoomStatus(){
        $room_id = trim($this->I['room_id']); //酒店ID
        if(isset($room_id) && !empty($room_id)) {
            $_room_status = M("room_info");
            $room_status = $_room_status -> field('only_code, in_time, out_time, room_status')
                -> where(array('id' => $room_id, 'data_status' => 1))
                -> find();

            if($room_status){
                $this -> result = array_merge($this -> result, $room_status) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['300000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['300001']) ;
        }
        $this->ajaxReturn($this->result);
    }

    //客房入住数据更新
    public function setRoomStatus(){
        $room_id = trim($this->I['room_id']);            //房间ID
        $only_code = trim($this->I['only_code']);       //入住唯一编码
        $in_time = trim($this->I['in_time']);           //入住时间(时间戳)
        $out_time = trim($this->I['out_time']);         //离开时间(时间戳)
        $room_status = trim($this->I['room_status']);   //实时房态信息,1:空房,2:有人

        if(isset($room_id) && isset($only_code) && isset($room_status)) {
            $_room_info = M("room_info");
            $_data = [
                'only_code'   => $only_code,
                'in_time'     => $in_time,
                'out_time'    => $out_time,
                'room_status' => $room_status
            ];

            $_map['room_id'] = $room_id;
            $_map['data_status'] = 1;

            $room_info = $_room_info -> where($_map) -> save($_data);
            if(!$room_info){
                $this -> result = array_merge($this -> result, $this -> status['0']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }

        $this->ajaxReturn($this->result);
    }
}