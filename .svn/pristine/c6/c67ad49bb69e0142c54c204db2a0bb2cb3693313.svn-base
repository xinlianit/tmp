<?php
/**
 * ServiceInfoLogic.class.php - 酒店服务逻辑处理
 * @package Common\Case
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月14日 上午11:35
 * @version V1.0.0
 */

namespace Common\Logic;

class ServiceInfoLogic {
    
    /**
     * 删除服务信息 - 通过一级服务ID，同时会删除二级服务信息
     * @param int $id 一级服务ID
     * @return boolean
     */
    public function delServiceById($id){        
        //删除一级分类
        $_map_one['id'] = $id;
        $_data_one['data_status'] = 99;
        $rs_one= D('ServiceInfo')->where($_map_one)->save($_data_one);

        //先删除二级分类
        //$_map_two['service_id'] = $id;        
        //$rs_two = M('ServiceTwo')->where($_map_two)->delete();   
        
        
        //删除二级服务
        if($rs_one === false){
            return false;
        }
        return true;
    }
    
}