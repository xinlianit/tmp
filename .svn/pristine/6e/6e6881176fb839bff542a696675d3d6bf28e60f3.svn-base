<?php

/**
 * GoodsInfoModel.class.php - 商品模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-23 10:40 Zhaoxizhan(441534536@qq.com)
 */
namespace Common\Model;
use Think\Model;

class GoodsInfoModel extends Model {
    
    /**
     * 编辑商品
     * @param int $id   ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function editInfo($id,$data){
        $_map['id'] = $id;
        //广告主表添加
        $rs = $this->where($_map)->save($data);
        if($rs === false){
            return false;
        }
        return true;
    }
        
    /**
     * 删除商品分类
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function delGoods($id){
        $_map['id'] = $id;
        $data['data_status'] = 99;
        
        $rs = $this->where($_map)->save($data);
        if($rs === false){
            return false;
        }
        return true;
    }
    
    /**
     * 商品内容
     * @param int $id   广告ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function getInfo($id){
        $_map['id'] = $id;
        //广告主表添加
        $rs = $this->where($_map)->find();
        if($rs === false){
            return false;
        }
        return $rs;
    }
    
    /**
     * 获取制定分类的产品列表
     * @param type $cate_id
     * @return type
     */
    public function getListByCateId($cate_id){
        $_map['cate_id'] = $cate_id;
        $_map['data_status'] = array('neq',99);
        
        $list = $this->where($_map)->select();
        return $list;
    }
}
