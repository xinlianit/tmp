<?php
namespace RoomApi\Controller;

class IndexController extends CommonController {
    public function index(){
        $this->result['order_no'] = generate_order_no(1, 1);
        $this->ajaxReturn($this->result);
    }
}