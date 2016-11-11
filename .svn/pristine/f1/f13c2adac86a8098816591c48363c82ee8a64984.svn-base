<?php
/**
 * BaseinfoController.class.php - 系统管理-基础信息管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 2016-11-08 10:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;

class BaseinfoController extends CommonController {
    /**
     * 商户类型列表
     */
    public function shopType(){
        //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件
        if(!empty($search_key)){
            $_map['type_name'] = array('like','%'.$search_key.'%');
        }else{
            $_map = '';
        }
        
        $page = D('Common' , 'Logic')->page(array('name'=>'TypeInfo','where'=>$_map), I('get.p',1));

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加商户类型（AJAX）
     */
    public function addType(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['type_name']      = I('post.type_name');      //类型名称        
        $data['type_class']     = I('post.type_class');     //类型分类
        $data['type_desc']      = I('post.type_desc','');   //类型描述
        
        //参数校验
        if(!$data['type_name'] || !$data['type_class']){
            $this->ajaxReturnErr();
        }
        
        $rs = D('TypeInfo')->add($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 修改商户类型（AJAX）
     */
    public function editType(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //要编辑的类型ID
        $id = I('post.type_id');
        //数据组装
        $data['type_name']      = I('post.type_name');      //类型名称        
        $data['type_class']     = I('post.type_class');     //类型分类
        $data['type_desc']      = I('post.type_desc','');   //类型描述
       
        //参数校验
        if(!$data['type_name'] || !$data['type_class'] || !$id){
            $this->ajaxReturnErr();
        }
        //过滤条件
        $_map['id'] = $id;
        
        $rs = D('TypeInfo')->where($_map)->save($data);
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 删除商家类型
     */
    public function delType(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.type_id'); //要编辑的类型ID

        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //过滤条件
        $_map['id'] = array('in',$id_arr);
        //删除
        $rs = D('TypeInfo')->where($_map)->delete();
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }

    /**
     * 获取商户类型详情
     */
    public function getTypeInfo(){
        
        //非法请求
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //类型ID
        $id = I('post.id');
        if(!$id){
            $this->ajaxReturnErr();
        }
        
        $rs = D('TypeInfo')->getInfo($id);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        $data['info'] = $rs;
        $this->ajaxReturnSuccess($data);
    }
    
    /**
     * 行业分类标签
     */
    public function tradeCate(){
        //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件
        if(!empty($search_key)){
            $_map['category_name'] = array('like','%'.$search_key.'%');
        }else{
            $_map = '';
        }
        
        $page = D('Common' , 'Logic')->page(array('name'=>'CategoryInfo','where'=>$_map), I('get.p',1));

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加行业分类（AJAX）
     */
    public function addTrade(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['category_name']      = I('post.category_name');      //类型名称        
        $data['category_desc']     = I('post.category_desc');     //类型分类
        
        //参数校验
        if(!$data['category_name'] ){
            $this->ajaxReturnErr();
        }
        
        $rs = D('CategoryInfo')->add($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 删除行业分类
     */
    public function delTrade(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.trade_id'); //要编辑的类型ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //过滤条件
        $_map['id'] = array('in',$id_arr);
        //删除
        $rs = D('CategoryInfo')->where($_map)->delete();
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 获取商户类型详情
     */
    public function getTradeInfo(){
        
        //非法请求
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //类型ID
        $id = I('post.id');
        if(!$id){
            $this->ajaxReturnErr();
        }
        
        $rs = D('CategoryInfo')->getInfo($id);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        $data['info'] = $rs;
        $this->ajaxReturnSuccess($data);
    }
    
    /**
     * 修改分类（AJAX）
     */
    public function editTrade(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //要编辑的类型ID
        $id = I('post.trade_id');
        //数据组装
        $data['category_name']      = I('post.category_name');      //分类名称    
        $data['category_desc']      = I('post.category_desc','');   //分类描述
       
        //参数校验
        if(!$data['category_name']  || !$id){
            $this->ajaxReturnErr();
        }
        //过滤条件
        $_map['id'] = $id;
        
        $rs = D('CategoryInfo')->where($_map)->save($data);
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 客户服务信息
     */
    public function iconList(){
        //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件
        if(!empty($search_key)){
            $_map['icon_name'] = array('like','%'.$search_key.'%');
        }else{
            $_map = '';
        }
        
        $page = D('Common' , 'Logic')->page(array('name'=>'ServiceIcon','where'=>$_map), I('get.p',1));

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加图标（AJAX）
     */
    public function addIcon(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['icon_name']     = I('post.icon_name');      //类型名称        
        $data['icon_path']     = I('post.icon_path');     //类型分类
        $data['icon_desc']     = I('post.icon_desc');     //类型分类
        
        //参数校验
        if(!$data['icon_name'] || !$data['icon_path']){
            $this->ajaxReturnErr();
        }
        
        $rs = D('ServiceIcon')->add($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 删除图标
     */
    public function delIcon(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.icon_id'); //要编辑的类型ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //过滤条件
        $_map['id'] = array('in',$id_arr);
        //删除
        $rs = D('ServiceIcon')->where($_map)->delete();
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 获取图标详情
     */
    public function getIconInfo(){
        
        //非法请求
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //类型ID
        $id = I('post.id');
        if(!$id){
            $this->ajaxReturnErr();
        }
        
        $rs = D('ServiceIcon')->getInfo($id);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        $data['info'] = $rs;
        $this->ajaxReturnSuccess($data);
    }
    
    /**
     * 修改图标（AJAX）
     */
    public function editIcon(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //要编辑的类型ID
        $id = I('post.icon_id');
        //数据组装
        
        $data['icon_name']     = I('post.icon_name');      //图标名        
        $data['icon_path']     = I('post.icon_path');     //图标路径
        $data['icon_desc']     = I('post.icon_desc');     //图标说明
       
        //参数校验
        if(!$data['icon_name']  || !$id || !$data['icon_path']){
            $this->ajaxReturnErr();
        }
        //过滤条件
        $_map['id'] = $id;
        //更新
        $rs = D('ServiceIcon')->where($_map)->save($data);

        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    
    /**
     * 客房服务信息
     */
    public function roomService(){
        //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件
        if(!empty($search_key)){
            $_map['service_name'] = array('like','%'.$search_key.'%');
        }else{
            $_map = '';
        }
        
        $page = D('Common' , 'Logic')->page(array('name'=>'ServiceInfo','where'=>$_map), I('get.p',1));

        $this->assign('page',$page);
        
        //获取图标列表 icon_list
        $icon_list = D('ServiceIcon')->select();
        $this->assign('icon_list',$icon_list);
        $this->display();
    }
    
    /**
     * 添加客房服务（AJAX）
     */
    public function addRoomService(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['icon_id']            = I('post.icon_id');          //图标ID        
        $data['service_type']       = I('post.service_type');     //服务类型(消息类型) 0:未知服务,1:发送请求,2:呼叫电话
        $data['service_name']       = I('post.service_name');     //服务名称
        $data['service_info']       = I('post.service_info');     //服务描述
        
        /**
         * 待删除
         */
        $data['service_code']       = '-';
        
        //参数校验
        if(!$data['icon_id'] || !$data['service_type'] || !$data['service_name']){
            $this->ajaxReturnErr();
        }
        
        $rs = D('ServiceInfo')->add($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 删除客房服务
     */
    public function delRoomService(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.service_id'); //要编辑的ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //过滤条件
        $_map['id'] = array('in',$id_arr);
        //删除
        $rs = D('ServiceInfo')->where($_map)->delete();
    
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 修改客房服务（AJAX）
     */
    public function editRoomService(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //要编辑的类型ID
        $id = I('post.service_id');
        //数据组装
        
        $data['icon_id']            = I('post.icon_id');          //图标ID        
        $data['service_type']       = I('post.service_type');     //服务类型(消息类型) 0:未知服务,1:发送请求,2:呼叫电话
        $data['service_name']       = I('post.service_name');     //服务名称
        $data['service_info']       = I('post.service_info');     //服务描述
              
        //参数校验
        if(!$data['icon_id'] || !$data['service_type'] || !$data['service_name'] || !$id){
            $this->ajaxReturnErr();
        }
        
        //过滤条件
        $_map['id'] = $id;
        //更新
        $rs = D('ServiceInfo')->where($_map)->save($data);

        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 获取客房服务详情
     */
    public function getRoomServiceInfo(){
        
        //非法请求
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //类型ID
        $id = I('post.id');
        if(!$id){
            $this->ajaxReturnErr();
        }
        
        $rs = D('ServiceInfo')->getInfo($id);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        $data['info'] = $rs;
        $this->ajaxReturnSuccess($data);
    }
    
    
    
    
    
    
}