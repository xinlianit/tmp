<?php
/**
 * ShopLogic.class.php - 商户逻辑
 * @package Logic
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-11-10 14:40
 */
namespace Admin\Logic;
use Admin\Logic\CommonLogic;
class ShopLogic extends CommonLogic{
    /**
     * 添加商户
     */
    function addShop(){
        $model = self::getModel('HotelInfo');
        
        $model->startTrans();
        
        if( @$data = $model->create() ){
            
            $check_condition = array(
                'data_status'=>1
            );
            
            //酒店编码唯一
            if( !empty($data['hotel_code']) ){
                
                $condition = array('hotel_code'=>$data['hotel_code']);
                
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $condition)) ){
                    $this->result['msg']        = "酒店编码已经存在！";
                    return $this->result;
                }
            }
            
            //客户集团编码唯一
            if( !empty($data['group_code']) ){
                
                $condition = array('group_code'=>$data['group_code']);
                
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $condition))){
                    $this->result['msg']        = "客户集团编码已经存在！";
                    return $this->result;
                }
            }
            
            //客户酒店编码唯一
            if( !empty($data['customer_code']) ){
                
                $condition = array('customer_code'=>$data['customer_code']);
                
                if( !$this->rowExists('HotelInfo', array_merge($check_condition, $condition))){
                    $this->result['msg']        = "客户酒店编码已经存在！";
                    return $this->result;
                }
            }
            
            //添加商户信息
            $insert_id = $model->add($data);
            
            
            //添加商户类型
            $type_list = explode(',', I('post.hotel_type'));
            $type_data = array();
            foreach($type_list as $v){
                $tmp = array('hotel_id'=>$insert_id, 'type_id'=>$v);
                array_push($type_data, $tmp);
            }
            $type_result = D('HotelType')->addAll($type_data);
            
            
            //添加商圈
            $trade_list = explode(',', I('post.trade_id'));
            $trade_data = array();
            foreach($trade_list as $v){
                $tmp = array('hotel_id'=>$insert_id, 'trade_id'=>$v);
                array_push($trade_data, $tmp);
            }
            $trade_result = D('BusinessDistrict')->addAll($trade_data);
            
            
            //成功
            if( $insert_id && $type_result && $trade_result ){
                $this->result['status']     = 1;
                $this->result['msg']        = $insert_id;
                
                $model->commit();
            }else{
                $this->result['msg']        = $model->getLastSql();
                
                $model->rollback();
            }
        }else{
            $this->result['msg']            = $model->getError();
        }
        
        return $this->result;
    }
}