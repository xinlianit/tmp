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
        $map = self::seach(array('data_status' => array('neq',99)));
        
        $page = self::$CommonLogic->page(array('name'=>'HotelService', 'where'=>$map));
        
        foreach ($page['list'] as &$val) {
            $hotel_info = D('Hotel','Cache')->getHotelInfo($val['hotel_id']);
            $val['hotel_name'] = $hotel_info['hotel_name'];
        }
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加编辑酒店服务指南
     */
    public function addEditService(){;
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
        
        //参数错误
        if(is_null($id)){    
            $this->ajaxReturnErr('未获取到商户详情');
        }
        
        //酒店服务指南
        $server = self::$CommonLogic->getRow('HotelService', array('id'=>$id, 'data_status'=>array('neq',99)));
        
        if(!$server){   
            $this->ajaxReturnErr('未获取到服务详情');
        }
        
        //酒店详情
        $hotel_info = self::$CommonLogic->getRow('HotelInfo', array('id'=>$server['hotel_id'], 'data_status'=>array('neq',99)), array('hotel_name'));
        if(!$hotel_info){   
            $this->ajaxReturnErr('未获取到商户详情');
        }        
        $server['hotel_name'] = $hotel_info['hotel_name'];
     
        //服务指南图片
        $server_list = self::$CommonLogic->getRows('HotelServicePic', array('service_id'=>$id));
        foreach ($server_list as &$val) {
            $res_info = D('Resource')->getInfo($val['resource_id']);
            $val['pic_path'] = C('FASTDFS_URL').$res_info['res_path'];
        }
        
        $server['list'] = $server_list;
        
        $this->ajaxReturnSuccess($server);
        
        
    }
    
    /**
     * 删除服务指南
     */
    public function deleteService(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('HotelService',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除服务指南；ID：" . $id;
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
        $map = self::seach(array('data_status' => array('neq',99)));
        
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
        $map = self::seach(array('data_status' => array('neq',99)));
        
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
            'icon_category'     => 1,
            'data_status'       => array('neq', 99)
        );
        $icon_log = self::$CommonLogic->getRows('ServiceIcon', $icon_map, array('id', 'icon_name', 'resource_id'));
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
                $resource_id = self::$CommonLogic->getField('ServiceIcon', array('resource_id'), array('id'=>$info['icon_id'], 'data_status'=>array('neq',99)));
                $info['icon_path'] = default_img($resource_id);
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
        $map = self::seach(array('data_status' => array('neq',99)));
        
        $page = self::$CommonLogic->page(array('name'=>'HotelInfo', 'where'=>$map));
        
        if( !empty($page['list']) ){
            foreach($page['list'] as $k=>$v){
                $tel_map = array(
                    'hotel_id'      => $v['id'],
                    'data_status'   => array('neq', 99)
                );
                $page['list'][$k]['server_list'] = self::$CommonLogic->getRows('RoomService', $tel_map, '', array('data_sort'=>'asc'));
            }
        }
        
        $this->assign('page',$page);
        
        //客房服务
        $server_map = array(
            'hotel_id'          => 0,
            'data_status'       => 1
        );
        $server = self::$CommonLogic->getRows('ServiceInfo', $server_map, array('id','service_name', 'service_type'));
        $this->assign('server', $server);
        
        //ICON图标
        $icon_map = array(
            'icon_category'     => 2,
            'data_status'       => array('neq', 99)
        );
        $icon = self::$CommonLogic->getRows('ServiceIcon', $icon_map, array('id', 'icon_name', 'resource_id'));
        $this->assign('icon', $icon);
        
        $this->display();
    }
    
    /**
     * 新增编辑客房服务
     */
    public function addEditRoom(){
        if(IS_POST){
            $result = D('Shop', 'Logic')->saveRoomServer( $this->post['flag'] );
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除客房服务
     */
    public function deleteRoomSer(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
            
            $map = array(
                'id'        => array('in', $id)
            );
            $result = self::$CommonLogic->deleteRows('RoomService',$map);
             
            if( $result ){
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除客房服务；客房服务ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 客房服务详情
     */
    public function roomServerInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //详情
            $info = self::$CommonLogic->getRow('RoomService', array('id'=>$id, 'data_status'=>array('neq',99)));
            if( $info ){
                //商户名称
                $info['hotel_name'] = self::$CommonLogic->getField('HotelInfo', array('hotel_name'), array('id'=>$info['hotel_id'], 'data_status'=>array('neq',99)));
        
                //服务详情
                $server_map = array(
                    'id'        => $info['service_id'],
                );
                $server_info = self::$CommonLogic->getRow('ServiceInfo', $server_map, array('id', 'hotel_id', 'icon_id', 'service_name'));
                $info['server_type']    = $server_info['hotel_id'] == 0 ? 1 : 2;
                $info['icon_id']        = $server_info['icon_id'];
                $info['icon_path']      = default_img( self::$CommonLogic->getField('ServiceIcon', 'resource_id', array('id'=>$server_info['icon_id'])) );
                $info['service_name']   = $server_info['service_name'];
                
                //二级服务
                if( $server_info['hotel_id'] == 0 ){
                    $two_map = array(
                        'service_id'        => $info['service_id']
                    );
                    $info['service_two'] = self::$CommonLogic->getRows('ServiceTwo', $two_map);
                    
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
     * 服务意见反馈
     */
    public function quest(){
        $map = self::seach(array('data_status' => array('neq',99)));
        
        $page = self::$CommonLogic->page(array('name'=>'FeedbackInfo', 'where'=>$map));
        
        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加编辑问卷
     */
    public function addEditQuest(){
        if(IS_POST){
            
            $result = D('Shop', 'Logic')->saveQuest( $this->post['flag'] );
             
            if( $result === true ){
                $this->ajaxReturnSuccess();
            }else{
                $this->ajaxReturnErr(array('msg'=>$result['msg']));
            }
        }
    }
    
    /**
     * 删除问卷
     */
    public function deleteQuest(){
        if(IS_AJAX){
            $id         = trim($this->get['ids']);
        
            $model = M();
            
            $model->startTrans();
            
            //删除问卷
            $map = array(
                'id'        => array('in', $id)
            );
            $info_result = self::$CommonLogic->deleteRows('FeedbackInfo', $map);
            
            //删除题目
            $item_map = array(
                'feedback_id'       => array('in', $id)
            );
            $subject_id = get_fields_to_array('FeedbackSubject', 'id', $item_map);
            $subject_result = self::$CommonLogic->deleteRows('FeedbackSubject', $item_map);
            
            //删除选项
            $option_map = array(
                'subject_id'       => array('in', $subject_id)
            );
            $subject_result = D('FeedbackOption')->where($option_map)->delete();
             
            if( $info_result && $subject_result && $subject_result !== false ){
                $model->commit();
        
                $log['log_msg'] = self::$loginInfo['admin_account'] . " 删除服务意见反馈；服务意见ID：" . $id;
                self::$CommonLogic->recodeLog($log);
                $this->ajaxReturnSuccess();
            }else{
                $model->rollback();
                
                $this->ajaxReturnErr();
            }
        }
    }
    
    /**
     * 问卷详情
     */
    public function questInfo(){
        $id     = trim(I('get.id', null));
        
        if( $id !== null ){
            //详情
            $info = self::$CommonLogic->getRow('FeedbackInfo', array('id'=>$id, 'data_status'=>array('neq',99)));
            if( $info ){
                //酒店名称
                $info['hotel_name'] = self::$CommonLogic->getField('HotelInfo', array('hotel_name'), array('id'=>$info['hotel_id'], 'data_status'=>array('neq',99)));
        
                //问卷题目
                $subject_map = array(
                    'feedback_id'       => $info['id'],
                    'data_status'       => 1,
                );
                $info['items']      = self::$CommonLogic->getRows('FeedbackSubject', $subject_map, '', array('data_sort'=>'asc'));
            
                if( $info['items'] ){
                    //题目选项
                    foreach($info['items'] as $k=>$v){
                        if($v['subject_type'] == 3){
                            continue;
                        }
                        $option_map = array(
                            'subject_id'        => $v['id'],
                        );
                        $info['items'][$k]['options']   = self::$CommonLogic->getRows('FeedbackOption', $option_map);
                    }
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
}