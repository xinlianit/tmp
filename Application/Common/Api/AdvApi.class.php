<?php

/**
 * FileApi.class.php - 广告处理类
 * @package Common\Api
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月3日 上午11:35
 * @version V1.0.0
 */

namespace Common\Api;

class AdvApi {

    /**
     * 获取广告列表
     * @param array $param          过滤条件
     * @param int   $page_index     当前页码数（0 查询所有）
     * @param int   $page_size      返回条数
     */
    public function getAdvertList($param=array(),$page_index=null,$page_size=20){
        //过滤条件
        $where['data_status'] = array('neq',99);        
        $_map = where_format($param, $where);
        
        //当前页码
        if(is_null($page_size)){
            $page_index = I('get.p',1);
        }
        
        $model = D('AdvertInfo');
        if($page_index){
            $list = $model->where($_map)->page($page_index,$page_size)->select();
        }else{
            $list = $model->where($_map)->select();
        }
    
        return $list;
    }
    
    /**
     * 获取指定条件的广告数据
     * @param type $param
     */
    public function getAdvertCount($param=array()){
        //过滤条件
        $where['data_status'] = array('neq',99);        
        $_map = where_format($param, $where);
        return D('AdvertInfo')->where($_map)->count();
    }
    
    /**
     * 发布广告
     * @param array $data 广告数据
     * @return boolean
     */
    public function addAdvertInfo($data){
        
        $model  = D('AdvertInfo');
        //开启事务
        $model->startTrans();
        //广告主表添加
        $rs1 = $model->add($data);
        if(!$rs1){
            $model->rollback();
            return false;
        }        
        //更新广告主的广告数
        $rs2 = D('AdvertisersInfo')->setAdvertNumInc($data['advertiser_id']);
        if(!$rs2){
            $model->rollback();
            return false;
        }
        
        $model->commit();
        return true;
    }
    
    /**
     * 编辑广告
     * @param array $data 广告数据
     * @return boolean
     */
    public function editAdvertInfo($id,$data){
        
        $model  = D('AdvertInfo');       
        //广告主表修改
        $rs = $model->editInfo($id,$data);
        if($rs === false){
            return false;
        }
        return true;
    }

    /**
     * 删除广告
     * @param type $id
     * @return boolean
     */
    public function delAdvertInfo($id){
        $model  = D('AdvertInfo');
        
        //广告信息
        $info = $model->getInfo($id);
        if(!$info || $info['data_status'] == 1){
            return false;
        }  
        
        //开启事务
        $model->startTrans();
        //广告主表添加
        $rs1 = $model->delInfo($id);
        if(!$rs1){
            $model->rollback();
            return false;
        }        
        
        
        //更新广告主的广告数
        $rs2 = D('AdvertisersInfo')->setAdvertNumDec($info['advertiser_id']);
        if(!$rs2){
            $model->rollback();
            return false;
        }
        
        //发布关系表状态修改
        $_map['advert_id'] = $id;      
        $_data['data_status'] = 99;    
        $rs3 = D('AdvertRelease')->where($_map)->save($_data);
        if($rs3 === false){                     
            $model->rollback();
            return false;
        }
        
        //更新广告发布关系状态        
        $model->commit();
        return true;
    }
    
    /**
     * 发布广告
     * @param int $adv_ids 广告ID(一维数组)
     * @param array $data 发布数据（二维数组）
     * @param int $release_source 发布来源 1: 平台发布, 2: 酒店发布
     * @return boolean
     */
    public function publishAdverts($adv_ids,$data,$release_source=1){
        //参数校验
        if(empty($adv_ids) || empty($data)){
            return false;
        }
        
        //广告发布信息表模型
        $model_release = D('AdvertRelease');
        $model_release->startTrans();
        
        //遍历发布广告
        foreach ($data as $val) {
            $_data['hotel_id']  = $val['hotel_id'];          
            $_data['release_source'] = $release_source;
            foreach ($adv_ids as $adv_id) {
                //当前广告详情
                $adv_info = D('AdvertInfo')->getInfo($adv_id);      
                $val['begin_time'] = $val['begin_time']?$val['begin_time']:$adv_info['begin_time'];//开始时间
                $val['end_time'] = $val['end_time']?$val['end_time']:$adv_info['end_time'];//结束时间                
                $_data['begin_time'] = ($val['begin_time']<$adv_info['begin_time'])?$adv_info['begin_time']:$val['begin_time'];//发布开始时间
                $_data['end_time'] = ($val['end_time']>$adv_info['end_time'])?$adv_info['end_time']:$val['end_time'];//发布结束时间                
                $_data['advert_id']  = $adv_id;
                //1.设置并且获取默认排序
                $_data['data_sort'] = $this->_setAndReturnNewSort($adv_id, intval($val['hotel_id']));
                if(!$_data['data_sort']){
                    $model_release->rollback();
                    return false;
                }
                //2.发布广告
                $rs_publish = $model_release->addRelease($_data);
                if(!$rs_publish){                     
                   $model_release->rollback();
                    return false;
                }
                //3.更新展示商户数
                $rs_upnum = D('AdvertInfo')->setHotelNumInc($adv_id);
                if(!$rs_upnum){
                    $model_release->rollback();
                    return false;
                }                
            }
            
        }
        
        $model_release->commit();
        return true;
    }
    
    /**
     * 删除酒店与广告的发布关系
     * @param type $id
     * @return boolean
     */
    public function delPublishRelease($id){
        //关系详情
        $_map['id'] = $id;
        $release_info = D('AdvertRelease')->where($_map)->find();
        if(!$release_info){
            return false;
        }
        
        M()->startTrans();
        //1.删除关系
        $rs_del = D('AdvertRelease')->delRelease($id);
        if($rs_del === false){
            M()->rollback();
            $this->ajaxReturnErr();
        }
        
        //2.更新展示商户数
        if($rs_del>0){
            $rs_upnum = D('AdvertInfo')->setHotelNumDec($release_info['advert_id']);
            if(!$rs_upnum){
                M()->rollback();
                return false;
            }  
        }
        
        M()->commit();
        return true;
    }
    
    /**
     * 广告下架（停止/失效）
     */
    public function stopAdverts($adv_ids){
        //参数校验
        if(empty($adv_ids)){
            return false;
        }
        
        //广告发布信息表模型
        $model_release = D('AdvertRelease');
        //广告主表模型
        $model_advert = D('AdvertInfo');
        
        $model_release->startTrans();        
        //广告主表状态修改
        $_map['id'] = array('in',$adv_ids);  
        $_map['data_status'] = array('neq',99);   
        $_data['data_status'] = 2;
        $_data['hotel_num'] = 0;
        $_data['update_time'] = time();        
        $rs1 = $model_advert->where($_map)->save($_data);
        unset($_map);
        if($rs1 === false){                     
            $model_release->rollback();
            return false;
        }
        
        //发布关系表状态修改
        $_map['advert_id'] = array('in',$adv_ids);   
        $rs2 = $model_release->where($_map)->delete();
        if($rs2 === false){                     
            $model_release->rollback();
            return false;
        }
        
        $model_release->commit();
        return true;
    }

        /**
     * 获取发布广告的排序(必须用于事务中)
     * @param int $adv_id 广告ID
     * @param int $hotel_id 酒店ID
     * @return int 新的排序
     */
    private function _setAndReturnNewSort($adv_id,$hotel_id){
        //获取广告内容
        $adv_info = D('AdvertInfo')->getInfo($adv_id);
        if(!$adv_info){
            return false;
        }
        
        $model_release = D('AdvertRelease');
        //位置权重
        $weight = $adv_info['weight']?$adv_info['weight']:1;
        //当前酒店最大排序
        $max_sort = $model_release->getMaxSort($hotel_id);
        //权重大于当前最大排序(不用更新其它发布广告排序)
        if($weight > $max_sort){
            $_new_sort = $max_sort+1;
        }else{
            $_new_sort = $weight;
            //更新本广告 本酒店下的所有大于等于此的排序
            $rs_updata_sort = $model_release->updateSort($hotel_id,$_new_sort);
            if(!$rs_updata_sort){
                return false;
            }
        }
        
        return $_new_sort;
    }
}