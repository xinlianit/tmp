<?php
/**
 * ShopController.class.php - 商户管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-03 17:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class ShopController extends CommonController {
    /**
     * 商户列表
     */
    public function index(){
        //商圈列表
        $page = D('Common' , 'Logic')->page(array('name'=>'HotelInfo'));
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 新增商户
     */
    public function add(){
       if(IS_POST){
           //添加商户信息
           $result = D('Shop', 'Logic')->addShop();
           
           if( $result['status'] == 1 ){
               $this->ajaxReturnSuccess();
           }else{
               $this->ajaxReturnErr(array('msg'=>$result['msg']));
           }
           
       }
    }
    
    /**
     * 编辑商户
     */
    public function edit(){
        
    }
    
    /**
     * 酒店类型
     * @param json
     */
    public function hotelType(){
        if( IS_AJAX ){
            $field = array('id', 'type_name', 'type_class');
            
            $condition = array(
                'data_status'       => array('eq',1),
            );
            $type_list = D('Common','Logic')->getRows('TypeInfo', $condition, $field);
            
            $result['data'] = $type_list;
            
            $this->ajaxReturnSuccess($result);
        }
    }
    
    /**
     * 楼层管理
     */
    public function floor(){
        $this->display();
    }
    
    /**
     * 设备管理
     */
    public function device(){
        $this->display();
    }
}