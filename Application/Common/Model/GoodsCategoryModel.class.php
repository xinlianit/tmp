<?php

/**
 * GoodsCategoryModel.class.php - 商品分类模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-23 10:40 Zhaoxizhan(441534536@qq.com)
 */
namespace Common\Model;
use Think\Model;

class GoodsCategoryModel extends Model {
    
    /**
     * 编辑商品分类
     * @param int $id   ID
     * @param arr $data 编辑数据
     * @return boolean
     */
    public function editCate($id,$data){
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
    public function delCate($id){
        $_map['id'] = $id;
        $data['data_status'] = 99;
        
        $rs = $this->where($_map)->save($data);
        if($rs === false){
            return false;
        }
        return true;
    }
    
    /**
     * 商品分类内容
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
     * 获取分类列表
     * @param type $data_status
     * @return type
     */
    public function getList($data_status = 1){
        $_map['data_status'] = $data_status;
        return $this->where($_map)->order('data_sort asc,id')->select();
    }
}
