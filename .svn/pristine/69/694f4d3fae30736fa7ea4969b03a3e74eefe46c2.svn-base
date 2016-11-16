<?php

/**
 * TypeInfoModel.class.php - 商户类型标签信息模型
 * @link http://www.pad-phone.com
 * @copyright 2016-11-08 10:40 Zhaoxizhan(441534536@qq.com)
 */


namespace Common\Model;
use Think\Model;

class ResourceModel extends Model {
    protected $tableName = 'resource';
    
    /**
     * 获取类型详情-通过ID
     * @param type $id
     */
    public function getInfo($id){
        $_map['id'] = $id;
        return $this->where($_map)->find();
    }
    
    /**
     * 根据MD5 获取资源列表
     * @param string $md5val 资源的md5值
     * @param string $remark 资源的备注（大文件分片信息）
     * @return boolean
     */
    public function getResourceByMd5($md5val,$status=1,$remark=''){
        $_map['res_md5val'] = $md5val;
        $_map['data_status'] = $status;
        if(!empty($remark)){
            $_map['remark'] = $remark;
        }
        
        $info = $this->where($_map)->find();
        if(!$info){
            return false;
        }
        
        return $info;
    }
    
    /**
     * 获取制定文件的临时文件个数
     * @param string $md5val 资源的md5值
     * @param int $status 资源状态
     * @return int
     */
    public function getCountByMd5($md5val,$status=2){
        $_map['res_md5val'] = $md5val;
        $_map['data_status'] = $status;
        
        return $this->where($_map)->count();
    }
    
    /**
     * 删除资源表中的临时文件
     * @param type $md5val
     * @return boolean
     */
    public function delTmpRes($md5val){
        $_map['res_md5val'] = $md5val;
        $_map['data_status'] = 2;
        
        $rs = $this->where($_map)->delete();
        if($rs === false){
            return false;
        }
        return true;
    }
    
    /**
     * 资源使用数加1 
     * @todo 后期增加此功能
     * @param int $id 资源ID
     * @param int $int 使用次数
     * @return type
     */
    public function setIncUseTimes($id,$int = 1){
        $_map['id'] = $id;
        return $this->where($_map)->setInc('use_times',$int); //资源使用次数 +1
    }
    
    /**
     * 资源使用数减1
     * @todo 后期增加此功能
     * @param int $id 资源ID
     * @param int $int 使用次数
     * @return type
     */
    public function setDecUseTimes($id,$int = 1){
        $_map['id'] = $id;
        return $this->where($_map)->setDec('use_times',$int); //资源使用次数 -1
    }
}