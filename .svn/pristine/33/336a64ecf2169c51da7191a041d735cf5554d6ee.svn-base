<?php
/**
 * ShopsettingController.class.php - 酒店界面设置
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-16 11:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
class ShopsettingController extends CommonController {
    /**
     * 酒店服务指南
     */
    public function service(){
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
     * 添加编辑酒店服务指南
     */
    public function addEditService(){
        if(IS_POST){
            $result = D('Shop', 'Logic')->saveServer( $this->post['flag'] );
           
           if( $result === true ){
               $this->ajaxReturnSuccess();
           }else{
               $this->ajaxReturnErr(array('msg'=>$result['msg']));
           }
        }
    }
    
    /**
     * 服务指南详情
     */
    public function serviceInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //酒店详情
            $hotel_info = self::$CommonLogic->getRow('HotelInfo', array('id'=>$id, 'data_status'=>array('neq',99)), array('id', 'hotel_name'));
            $hotel_info['hotel_id'] = $hotel_info['id'];
            unset($hotel_info['id']);
            if( $hotel_info ){
                //酒店服务指南
                $server = self::$CommonLogic->getRow('HotelService', array('hotel_id'=>$hotel_info['hotel_id'], 'data_status'=>array('neq',99)));
                
                if( $server ){
                    $hotel_info['id']           = $server['id'];
                    $hotel_info['pic_num']      = $server['pic_num'];
                }
            }
        
        }
        
        if( $hotel_info ){
            $result['data']         = $hotel_info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->result['msg'] = "未获取到商户详情";
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 删除服务指南
     */
    public function deleteService(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'hotel_id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('HotelService',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除服务指南；商户ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * WIFI服务
     */
    public function wifi(){
        $hotel_name     = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq', 99),
        );
        
        if( !empty($hotel_name) ){
            $hotel_map = array(
                'hotel_name'        => array('like','%'. $hotel_name .'%'),
                'data_status'       => array('neq', 99)
            );
            
            $hotel_ids = self::$CommonLogic->getRows('HotelInfo', $hotel_map, array('id'));
            if( !empty($hotel_ids) ){
                $hotel_ids = array_column($hotel_ids, 'id');
                $map['hotel_id']        = array('in', $hotel_ids);
            }else{
                $map['hotel_id']        = 0;
            }
            
        }
        
        $page = self::$CommonLogic->page(array('name'=>'WifiService', 'where'=>$map));
        
        $this->assign('page', $page);
        $this->display();
    }
    
    /**
     * 新增编辑WIFI
     */
    public function addEditWifi(){
        if(IS_POST){
            $result = D('Shop', 'Logic')->saveWifi( $this->post['flag'] );
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除WIFI
     */
    public function deleteWifi(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('WifiService',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除WIFI服务；商户ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * wifi详情
     */
    public function wifiInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //详情
            $info = self::$CommonLogic->getRow('WifiService', array('id'=>$id, 'data_status'=>array('neq',99)));
            if( $info ){
                //酒店信息
                $hotel_name = self::$CommonLogic->getField('HotelInfo', array('hotel_name'), array('id'=>$info['hotel_id'], 'data_status'=>array('neq',99)));
        
                if( $hotel_name ){
                    $info['hotel_name']           = $hotel_name;
                }
            }
        
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->result['msg'] = "未获取到商户详情";
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 服务电话
     */
    public function tel(){
        $hotel_name     = trim($this->get['hotel_name']);
        
        $map = array(
            'data_status'       => array('neq',99),
        );
        
        if( !empty($hotel_name) ){
            $map['hotel_name']  = array('like','%'. $hotel_name .'%');
        }
        
        $page = self::$CommonLogic->page(array('name'=>'HotelInfo', 'where'=>$map));
        
        if( !empty($page['list']) ){
            foreach($page['list'] as $k=>$v){
                $tel_map = array(
                    'hotel_id'      => $v['id'],
                    'data_status'   => array('neq', 99)
                );
                $page['list'][$k]['tel_list'] = self::$CommonLogic->getRows('PhoneService', $tel_map, '', array('data_sort'=>'asc'));
            }
        }
        
        //ICON图标
        $icon_map = array(
            'data_status'       => array('neq', 99)
        );
        $icon_log = self::$CommonLogic->getRows('ServiceIcon', $icon_map, array('id', 'icon_name', 'icon_path'));
        $this->assign('icon', $icon_log);
        
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 新增编辑服务电话
     */
    public function addEditTel(){
        if(IS_POST){
            
            $result = D('Shop', 'Logic')->saveTel( $this->post['flag'] );
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除服务电话
     */
    public function deleteTel(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('PhoneService',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除电话服务；电话ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 服务电话详情
     */
    public function telInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //详情
            $info = self::$CommonLogic->getRow('PhoneService', array('id'=>$id, 'data_status'=>array('neq',99)));
            if( $info ){
                //商户名称
                $info['hotel_name'] = self::$CommonLogic->getField('HotelInfo', array('hotel_name'), array('id'=>$info['hotel_id'], 'data_status'=>array('neq',99)));
            
                //ICON图标
                $info['icon_path'] = default_img(self::$CommonLogic->getField('ServiceIcon', array('icon_path'), array('id'=>$info['icon_id'], 'data_status'=>array('neq',99))));
            }
        
        }
        
        if( $info ){
            $result['data']         = $info;
            $this->ajaxReturnSuccess($result);
        }
        
        $this->result['msg'] = "未获取到商户详情";
        
        $this->ajaxReturnErr($this->result);
    }
    
    /**
     * 客房服务
     */
    public function room(){
        $this->display();
    }
    
    /**
     * 服务意见反馈
     */
    public function quest(){
        $this->display();
    }
}