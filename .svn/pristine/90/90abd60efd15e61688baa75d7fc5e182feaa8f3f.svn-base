<?php
namespace ManageApi\Controller;

class RoomController extends CommonController {
    function setMsgStatus(){
        $msg_id = trim($this->I['msg_id']); //消息ID
        $msg_status = trim($this->I['msg_status']); //消息ID

        if(isset($msg_id) && !empty($msg_id) && isset($msg_status)) {
            $_msg_service = M("msg_service");
            $_data = [
                'data_status' => $msg_status
            ];

            $rs = $_msg_service->data($_data)->where(['id' => $msg_id])->save();
            if (!$rs) {
                $this->result = array_merge($this->result, $this->status['600008']);
            }
        }
    }
}