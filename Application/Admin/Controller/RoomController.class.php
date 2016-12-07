<?php
/**
 * RoomController.class.php - 客房管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-16 11:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class RoomController extends CommonController {
    /**
     * 客房信息查询
     */
    public function infoFind_(){
        $hotel_name     = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($hotel_name) ){
            $map['hotel_name']  = array('like','%'. $hotel_name .'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'HotelInfo', 'where'=>$map));
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 客房服务查询
     */
    public function serviceFind_(){
        $this->display();
    }
    
}