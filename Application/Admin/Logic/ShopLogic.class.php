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
        $model = M('HotelInfo');
        
        
        $datas = $model->find();
        unset($datas['id']);
        $insert_id = M()->add($datas);
        
        dump($insert_id);
        
        
        
        
        if( @$data = $model->create() ){
            
            $datas = $model->find();
            unset($datas['id']);
            
            if(@$insert_id = $model->add($datas)){
                $this->result['status']     = 1;
                $this->result['msg']        = $insert_id;
            }else{
                $this->result['msg']        = $model->getLastSql();
            }
        }else{
            $this->result['msg']            = $model->getError();
        }
        
        return $this->result;
    }
}