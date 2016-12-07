<?php
/**
 * GoodsInfoLogic.class.php - 商品逻辑处理
 * @package Common\Case
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月24日 上午11:35
 * @version V1.0.0
 */

namespace Common\Logic;

class GoodsInfoLogic {
    
    /**
     * 判断指定分类下有无产品
     * @param int $cate_id 分类ID
     * @return boolean
     */
    public function isExistByCateId($cate_id){
        $rs = D('GoodsInfo')->getListByCateId($cate_id);
        if(!$rs){
            return false;
        }
        
        return true;
    }
    
    /**
     * 编辑商品
     * @param int $id   ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function editGoodsInfo($id,$data){
        $model_goods = D('GoodsInfo');
        //原商品信息
        $old_info = $model_goods->getInfo($id);
        
        //编辑商品
        $rs = $model_goods->editInfo($id,$data);
        if($rs === false){
            return false;
        }
        //更新商品缓存
        D('Goods','Cache')->getGoodsInfo($id,true,$data,$old_info);
        return true;
    }
    
    /**
     * 删除商品分类
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function delGoodsInfo($id){
        $rs = D('GoodsInfo')->delGoods($id);
        if($rs === false){
            return false;
        }
        
        //清商品缓存
        D('Goods','Cache')->getGoodsInfo($id,true);
        return true;
    }
    
    /**
     * 更新商品上架
     * @param int/array $ids 商品ID
     * @return boolean
     */
    public function upGoodsInfo($ids){
        if(is_array($ids)){
            $_map['id'] = array('in',$ids);
        }else{
            $_map['id'] = $ids;
        }
        
        $_data['update_time'] = time();//更新时间
        $_data['data_status'] = 1;//上架
        
        $rs = D('GoodsInfo')->where($_map)->save($_data);
        if($rs ===  false){
            return false;
        }
        return true;
    }
    
    /**
     * 更新商品下架
     * @param int/array $ids 商品ID
     * @return boolean
     */
    public function downGoodsInfo($ids){
        if(is_array($ids)){
            $_map['id'] = array('in',$ids);
        }else{
            $_map['id'] = $ids;
        }
        
        $_data['update_time'] = time();//更新时间
        $_data['data_status'] = 2;//上架
        
        $rs = D('GoodsInfo')->where($_map)->save($_data);
        if($rs ===  false){
            return false;
        }
        return true;
    }
    
}