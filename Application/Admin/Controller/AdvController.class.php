<?php

/**
 * AdvController.class.php - 广告管理
 * @package Controller
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 2016-11-16 10:40
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;

class AdvController extends CommonController {
    
    /**
     * 广告主管理
     */
    public function advMain(){
        //dump(self::$loginInfo['id']);
         //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //搜索条件
        $_map['data_status'] = 1;
        if(!empty($search_key)){
            $_map['advert_name'] = array('like','%'.$search_key.'%');
        }
        
        
        $page = D('Common' , 'Logic')->page(array('name'=>'AdvertisersInfo','where'=>$_map), I('get.p',1));
        
        //获取所有行业
        $cate_list = D('CategoryInfo')->getAllWithKey();
        
        foreach ($page['list'] as &$val) {
            //没有行业分类
            if(empty($val['industry_desc'])){
                continue;
            }
            //处理行业分类  
            $_cid_arr = explode(',', $val['industry_desc']);
            foreach ($_cid_arr as $v) {
                //行业存在
                if(isset($cate_list[$v])){
                    $val['industry_desc'] = str_replace($v, $cate_list[$v]['category_name'], $val['industry_desc']);
                }
            }
        }

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 搜索广告主列表 
     */
    public function seachAdver(){
        //dump(self::$loginInfo['id']);
         //搜索信息
        $search_key = I('post.adver_name','');        
        //搜索条件        
        if(!empty($search_key)){
            $_map['advert_name'] = array('like','%'.$search_key.'%');
        }        
        $_map['data_status'] = 1;
                
        $list = D('AdvertisersInfo')->where($_map)->select();
        
        //获取所有行业
        $cate_list = D('CategoryInfo')->getAllWithKey();
        
        foreach ($list as &$val) {
            //没有行业分类
            if(empty($val['industry_desc'])){
                continue;
            }
            //处理行业分类  
            $_cid_arr = explode(',', $val['industry_desc']);
            foreach ($_cid_arr as $v) {
                //行业存在
                if(isset($cate_list[$v])){
                    $val['industry_desc'] = str_replace($v, $cate_list[$v]['category_name'], $val['industry_desc']);
                }
            }
        }
        $data['data']=$list;
        $this->ajaxReturnSuccess($data);
    }
    
    /**
     * 获取广告主详情
     */
    public function getAdverInfo(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        //广告主ID
        $id = I('post.id');
        if(empty($id)){
            $this->ajaxReturnErr();
        }
        
        //详情
        $_map['id'] = $id;
        $rs_info = M('advertisers_info')->where($_map)->find();
        if(!$rs_info){
            $this->ajaxReturnErr();
        }
        
        //行业分类列表
        $rs_info['industry_list'] = array();
        //如果有行业分类 获取对应分类列表
        if(!empty($rs_info['industry_desc'])){
            $_map_cate['id'] = array('in',$rs_info['industry_desc']);//行业ID
            $cate_list = D('CategoryInfo')->where($_map_cate)->select();
            $rs_info['industry_list'] = $cate_list;
        }
        
        //industry_list
        $data['info'] = $rs_info;
        $this->ajaxReturnSuccess($data);
    }
 
    /**
     * 添加广告主
     */
    public function addAdver(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //参数校验
        if(empty(I('post.advert_name'))){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['advert_name']        = I('post.advert_name');      //广告主名        
        $data['company_name']       = I('post.company_name','');  //公司名
        $data['contact_way']        = I('post.contact_way','');   //联系方式
        $data['contacts']           = I('post.contacts','');      //联系人
        $data['data_status']        = 1;//状态信息,1:有效,2:无效,99:删除
        $data['industry_desc']      = I('post.category','');      //行业描述
        
        $_time = time();
        $data['create_time']      = $_time;      //创建时间
        $data['update_time']      = $_time;      //更新时间
        
        $data['admin_id']         = self::$loginInfo['id'];      //管理员ID
        
        $rs = M('AdvertisersInfo')->add($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
    
    /**
     * 编辑广告主
     */
    public function editAdver(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        $id = I('post.id');
        //参数校验
        if(empty(I('post.advert_name')) || !$id){
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $data['advert_name']        = I('post.advert_name');      //广告主名        
        $data['company_name']       = I('post.company_name','');  //公司名
        $data['contact_way']        = I('post.contact_way','');   //联系方式
        $data['contacts']           = I('post.contacts','');      //联系人
        $data['industry_desc']      = I('post.category','');      //行业描述
        $data['update_time']      = time();      //更新时间
        
        $data['admin_id']         = self::$loginInfo['id'];      //管理员ID
        
        $_map['id'] = $id;
        $rs = M('AdvertisersInfo')->where($_map)->save($data);
        if($rs){
            $this->ajaxReturnSuccess();
        }
        $this->ajaxReturnErr();
    }
     
    /**
     * 删除广告客户资料
     */
    public function delAdver(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
  
        $id = I('post.id'); //要编辑的类型ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //判断当前广告主是否有广告
        $_map_adv['advertiser_id'] = array('in',$id_arr);
        $_map_adv['data_status'] = array('neq',99);
        $is_exist = D('AdvertInfo')->where($_map_adv)->find();
        if($is_exist){
            $this->ajaxReturnErr('所删除的广告客户下还有广告，不能删除');
        }
        
        //过滤条件
        $_map['id'] = array('in',$id_arr);
        $_data['data_status'] = 99;
        //删除
        $rs = M('AdvertisersInfo')->where($_map)->save($_data);
        if($rs !== false){
            $this->ajaxReturnSuccess();
        }
                
        $this->ajaxReturnErr();
    }
    
    /**
     * 广告列表
     */
    public function advList(){
        
         //搜索信息
        $search['advert_name']  = I('get.advert_name','');
        $search['data_status']  = I('get.data_status',0);
        $search['begin_time']   = I('get.begin_time','');
        $search['end_time']     = I('get.end_time','');
        $search['hotel_id']     = I('get.hotel_id','all');
        $search['hotel_name']     = I('get.hotel_name','');
        $search['adver_name']     = I('get.adver_name','');
        
        $this->assign($search);
        
        //筛选条件
        $param=array();
        //广告名-模糊
        if($search['advert_name']){
            $param['like']['advert_name'] = $search['advert_name'];
        }
        //发布状态
        if($search['data_status']){
            $param['eq']['data_status'] = $search['data_status'];
        }        
        //发布时间开始
        if($search['begin_time']){
            $param['elt']['begin_time'] = strtotime($search['begin_time']);
        }
        //发布时间结束
        if($search['end_time']){
            $param['egt']['end_time'] = strtotime($search['end_time']);
        }
        
        //广告来源
        if($search['hotel_id'] != 'all'){
            if($search['hotel_id'] == 'hotel_id'){
                $param['egt']['hotel_id'] = 1;                
            }else{
                $param['eq']['hotel_id'] = 0;
            }            
        }
        
        //商户名
        if($search['hotel_name']){
            //1.查询到所有hotel_id
            $_map_hotel['hotel_name'] = array('like','%'.$search['hotel_name'].'%');
            $hotel_list = D('HotelInfo')->where($_map_hotel)->field('id')->select();
            //酒店列表
            foreach ($hotel_list as $val){
                $hotel_id[] = $val['id'];
            }
            //2.查询到hotel_id 下所有发布的广告
            if(!empty($hotel_id)){
                $_map_hotel_id['data_status'] = 1;
                $_map_hotel_id['hotel_id'] = array('in',$hotel_id);
                $advert_list = M('AdvertRelease')->where($_map_hotel_id)->field('advert_id')->select();
                //广告列表
                foreach ($advert_list as $val){
                    $advert_id[] = $val['advert_id'];
                }
            }
            //3.查询筛选出的广告ID下的符合条件的
            if(!empty($advert_id)){
                $param['in']['id'] = $advert_id;
            }else{
                $param['eq']['id'] = 0;
            }
        }
        
        //广告主名
        if($search['adver_name']){
            //1.查询到所有广告主ID
            $_map_adver['advert_name'] = array('like','%'.$search['adver_name'].'%');
            $adver_list = M('advertisers_info')->where($_map_adver)->field('id')->select();
            //酒店列表
            foreach ($adver_list as $val){
                $adver_id[] = $val['id'];
            }
            //2.查询到广告主ID下所有发布的广告
            if(!empty($advert_id)){
                $param['in']['advertiser_id'] = $adver_id;
            }else{
                $param['eq']['id'] = 0;
            }
        }
        
        
        $list = D('Adv','Api')->getAdvertList($param);
        $count = D('Adv','Api')->getAdvertCount($param);
    
        //读广告主信息
        foreach ($list as &$val) {
            $adver_info = D('AdvertisersInfo')->where('id='.$val['advertiser_id'])->find();
            $val['adver_name'] = $adver_info['advert_name'];
        }
        
        $page = show_page($count);
        $page['list'] = $list;

        $this->assign('page',$page);
        $this->display();
    }
    
    /**
     * 添加广告
     */
    public function addAdvert(){        
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //参数过滤
        if(!I('post.advert_name') || !I('post.adver_id') || !I('post.advert_position') || !I('post.date-range-picker') || !I('post.material_type') || !I('post.weight')){
            
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $_data['advert_name'] = I('post.advert_name');//广告名称
        $_data['hotel_id'] = 0;//发布来源,0:平台发布,其余对应酒店ID
        $_data['advertiser_id'] = I('post.adver_id');//广告主ID        
        $_data['advert_position'] = I('post.advert_position');//广告位置
        $_data['weight'] = I('post.weight');//位置权重
        $_data['material_type'] = I('post.material_type');//素材类型,1:图片,2:视频
       
        //投放时间处理开始===============================  
        //11/01/2016 - 11/30/2016
        $post_time = I('post.date-range-picker');
        $time_str_arr = explode(' - ', $post_time);
        if(!isset($time_str_arr[0]) || !isset($time_str_arr[1])){
            $this->ajaxReturnErr();
        }
        $_data['begin_time'] = strtotime($time_str_arr[0]);//投放开始时间
        $_data['end_time'] = strtotime($time_str_arr[1]);//投放结束时间
        if(!$_data['begin_time'] || !$_data['end_time']){
            $this->ajaxReturnErr();
        }
        $_data['release_time'] = date('Y.m.d',$_data['begin_time']).' - '.date('Y.m.d',$_data['end_time']);//投放时间,展示用
        //投放时间处理结束================================
        
        
        //素材来源md5
        $source_md5 = ($_data['material_type'] == 1)?I('post.advpic_md5'):I('post.advvideo_md5');
        if($source_md5){
            $res_info = D('Resource')->getResourceByMd5($source_md5);
            //没有找到对应资源
            if(!$res_info){
                $this->ajaxReturnErr();
            }
            $_data['source_id'] = $res_info['id'];//素材来源地址(主广告图/广告视频)
        }
        
        //缩略图处理
        if(I('post.advvideopic_md5') && $_data['material_type'] == 2){
            $res_info = D('Resource')->getResourceByMd5(I('post.advvideopic_md5'));
            //没有找到对应资源
            if(!$res_info){
                $this->ajaxReturnErr();
            }
            $_data['thum_id'] = $res_info['id'];//素材来源地址(主广告图/广告视频)
        } 
 
        $_time = time();
        $_data['create_time'] = $_time;//创建时间
        $_data['update_time'] = $_time;//更新时间
        $_data['data_status'] = 1;//状态信息,1:有效,2:无效,99:删除
        
        //发布广告
        $rs = D('Adv','Api')->addAdvertInfo($_data);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        
        $this->ajaxReturnSuccess();
    }
    
    /**
     * 获取发布的广告基础详情
     */
    public function getAdvertInfo(){
        $id = I('get.id');
        $_map['id'] = $id;
        $info = M('advert_info')->where($_map)->find();
        
        //获取资源地址
        $res_info = D('Resource')->getInfo($info['source_id']);        
        $info['source_src'] = C('FASTDFS_URL').$res_info['res_path'];
        $info['source_md5'] = $res_info['res_md5val'];
        
        $res2_info = D('Resource')->getInfo($info['thum_id']);   
        $info['thum_src'] = C('FASTDFS_URL').$res2_info['res_path'];
        $info['thum_md5'] = $res2_info['res_md5val'];
        
        $info['adver_id'] = $info['advertiser_id'];//广告主ID  
        //查询广告主的信息
        $_map_adver['id'] = $info['advertiser_id'];
        $adver_info = D('AdvertisersInfo')->where($_map_adver)->find();
        
        //用于前端 表单动态填充
        $info['adver_name'] = $adver_info['advert_name'];//广告主名        
        $info['date-range-picker'] = date('m/d/Y',$info['begin_time']).' - '.date('m/d/Y',$info['end_time']);//发布时间11/01/2016 - 11/30/2016
        
        $data['data'] = $info;
        $this->ajaxReturnSuccess($data);
    }
    
    /**
     * 编辑广告基础详情
     */
    public function editAdvert(){
 
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        
        //参数过滤
        if(!I('post.id') || !I('post.advert_name') || !I('post.adver_id') || !I('post.advert_position') || !I('post.date-range-picker') || !I('post.material_type') || !I('post.weight')){
            
            $this->ajaxReturnErr();
        }
        
        //数据组装
        $_data['advert_name'] = I('post.advert_name');//广告名称
        $_data['hotel_id'] = 0;//发布来源,0:平台发布,其余对应酒店ID
        $_data['advertiser_id'] = I('post.adver_id');//广告主ID        
        $_data['advert_position'] = I('post.advert_position');//广告位置
        $_data['weight'] = I('post.weight');//位置权重
        $_data['material_type'] = I('post.material_type');//素材类型,1:图片,2:视频
       
        //投放时间处理开始===============================  
        //11/01/2016 - 11/30/2016
        $post_time = I('post.date-range-picker');
        $time_str_arr = explode(' - ', $post_time);
        if(!isset($time_str_arr[0]) || !isset($time_str_arr[1])){
            $this->ajaxReturnErr();
        }
        $_data['begin_time'] = strtotime($time_str_arr[0]);//投放开始时间
        $_data['end_time'] = strtotime($time_str_arr[1]);//投放结束时间
        if(!$_data['begin_time'] || !$_data['end_time']){
            $this->ajaxReturnErr();
        }
        $_data['release_time'] = date('Y.m.d',$_data['begin_time']).' - '.date('Y.m.d',$_data['end_time']);//投放时间,展示用
        //投放时间处理结束================================
        
        
        //素材来源md5
        $source_md5 = ($_data['material_type'] == 1)?I('post.advpic_md5'):I('post.advvideo_md5');
        if($source_md5){
            $res_info = D('Resource')->getResourceByMd5($source_md5);
            //没有找到对应资源
            if(!$res_info){
                $this->ajaxReturnErr();
            }
            $_data['source_id'] = $res_info['id'];//素材来源地址(主广告图/广告视频)
        }
        
        //缩略图处理
        if(I('post.advvideopic_md5') && $_data['material_type'] == 2){
            $res_info = D('Resource')->getResourceByMd5(I('post.advvideopic_md5'));
            //没有找到对应资源
            if(!$res_info){
                $this->ajaxReturnErr();
            }
            $_data['thum_id'] = $res_info['id'];//素材来源地址(主广告图/广告视频)
        } 
 
        $_data['update_time'] = time();//更新时间
        //$_data['data_status'] = 1;//状态信息,1:有效,2:无效,99:删除
        
        //编辑广告
        $rs = D('Adv','Api')->editAdvertInfo(I('post.id'),$_data);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        
        $this->ajaxReturnSuccess();
    }
    
    /**
     * 删除广告基础详情
     */
    public function delAdvert(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.id'); //要编辑的类型ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        
        //循环删除
        foreach ($id_arr as $val) {
            $rs = D('Adv','Api')->delAdvertInfo($val);
            if($rs === false){
                $this->ajaxReturnErr();
            }
        }
        $this->ajaxReturnSuccess();        
    }
    
    /**
     * 发布广告(添加 编辑)
     */
    public function publishAdvert(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        } 
        
        
        $ids = I('post.id'); //广告ID    
        //参数有错误
        if(empty($ids)){
            $this->ajaxReturnErr();
        }
        //广告ID
        $adv_ids = explode(',', $ids);
        
        $_map['id'] = array('in',$adv_ids);
        $_data['update_time'] = time();
        $_data['data_status'] = 1;
        //广告主表上架
        $rs = D('AdvertInfo')->where($_map)->save($_data);
        if(!$rs){
            $this->ajaxReturnErr();
        }
        unset($_map,$_data);
        
        //添加
        $hotel_id = I('post.hotel_id');//酒店ID
        $stime = I('post.stime');//投放开始时间
        $etime = I('post.etime');//投放结束时间
        
        //添加
        if($hotel_id){
            //酒店ID
            foreach ($hotel_id as $key=>$val) {
                $_data['hotel_id'] = $val;
                $_data['begin_time'] = strtotime($stime[$key]);
                $_data['end_time'] = strtotime($etime[$key]);
                $publish_data[] = $_data;
            }
            //发布广告
            $rs_add = D('Adv','Api')->publishAdverts($adv_ids,$publish_data);

            if(!$rs_add){
                $this->ajaxReturnErr();
            }
        }
        
        //编辑时广告是唯一ID
        $r_id = I('post.r_id');//关系ID
        $edit_stime = I('post.edit_stime');//投放开始时间
        $edit_etime = I('post.edit_etime');//投放结束时间
       
        if($r_id){
            //编辑时$ids为唯一数字ID
            if(!is_numeric($ids)){
                $this->ajaxReturnErr();
            }
            //广告详情
            $adv_info = D('AdvertInfo')->getInfo($ids);    
            //酒店ID
            foreach ($r_id as $key=>$val) {
                $edit_map['id'] = $val;                            
                $edit_data['begin_time'] = (strtotime($edit_stime[$key])<$adv_info['begin_time'])?$adv_info['begin_time']:strtotime($edit_stime[$key]);//发布开始时间
                $edit_data['end_time'] = (strtotime($edit_etime[$key])>$adv_info['end_time'])?$adv_info['end_time']:strtotime($edit_etime[$key]);//发布结束时间   
                $edit_data['data_status'] = 1;
                //发布广告
                $rs_edit = D('AdvertRelease')->where($edit_map)->save($edit_data);
            }            

            if($rs_edit === false){
                $this->ajaxReturnErr();
            }
        }
        $this->ajaxReturnSuccess();
        
    }
    
    /**
     * 获取广告的发布酒店列表
     */
    public function getAdvertInfoWithPublish(){
        $advert_id = I('get.adv_id');
        //广告详情
        $_data['adv_info'] = D('AdvertInfo')->getInfo($advert_id);
        //发布详情
        $_data['plist'] = D('AdvertRelease')->getReleaseListByAdvId($advert_id);
        foreach ($_data['plist'] as &$val) {
            //获取酒店详情
            $hotel_info = D('Hotel','Cache')->getHotelInfo($val['hotel_id']);
            
            $val['hotel_name'] = $hotel_info['hotel_name'];
            $val['begin_time'] = date('m/d/Y',$val['begin_time']);
            $val['end_time'] = date('m/d/Y',$val['end_time']);
        }
        
        $this->ajaxReturnSuccess(array('data'=>$_data));
    }
    
    /**
     * 删除发布关系 
     */
    public function delRelease(){
        $id = I('get.id');
        if(!$id){
            $this->ajaxReturnErr();
        }
        
        $rs = D('Adv','Api')->delPublishRelease($id);
        if($rs === false){
            $this->ajaxReturnErr();
        }
        
        $this->ajaxReturnSuccess();
    }
    
    /**
     * 广告发布的酒店列表
     */
    public function publishList(){
        //广告ID
        $advert_id = I('get.id');
        //广告详情
        $_data['adv_info'] = D('AdvertInfo')->getInfo($advert_id);
        //发布详情
        $_data['plist'] = D('AdvertRelease')->getReleaseListByAdvId($advert_id);
        foreach ($_data['plist'] as &$val) {
            //获取酒店详情
            $hotel_info = D('Hotel','Cache')->getHotelInfo($val['hotel_id']);
            
            $val['hotel_name'] = $hotel_info['hotel_name'];
            $val['begin_time'] = date('m/d/Y',$val['begin_time']);
            $val['end_time'] = date('m/d/Y',$val['end_time']);
        }
        
        $this->assign($_data);
        $this->display();
    }
    
    /**
     * 停止广告
     */
    public function stopAdvert(){
         if(!IS_AJAX){
            $this->ajaxReturnErr();
        }        
        
        $id = I('post.id'); //要编辑的类型ID
        //参数校验
        if( !$id){
            $this->ajaxReturnErr();
        }
        $id_arr = explode(',', $id);
        //更新发布状态
        $rs = D('Adv','Api')->stopAdverts($id_arr);
        
        if($rs === false){
            $this->ajaxReturnErr();
        }
        $this->ajaxReturnSuccess();
    }
    
    /**
     * 查询广告详情
     */
    public function advertInfo(){
        
        $advert_id = I('get.id');
        //广告详情
        $_data['adv_info'] = D('AdvertInfo')->getInfo($advert_id);
        $adver_info = D('AdvertisersInfo')->where('id='.$_data['adv_info']['advertiser_id'])->find();
        $_data['adv_info']['adver_name'] = $adver_info['advert_name'];
            
        //发布详情
        $_data['plist'] = D('AdvertRelease')->getReleaseListByAdvId($advert_id);
        foreach ($_data['plist'] as &$val) {
            //获取酒店详情
            $hotel_info = D('Hotel','Cache')->getHotelInfo($val['hotel_id']);
            
            $val['hotel_name'] = $hotel_info['hotel_name'];
            $val['begin_time'] = date('m/d/Y',$val['begin_time']);
            $val['end_time'] = date('m/d/Y',$val['end_time']);
        }
        
        $this->assign($_data);
        
        $this->display();
    }
    
    /**
     * 广告运营数据
     * @todo 后期有了报表后再完善
     */
    public function getAdvCharts(){
        $data['list'] = array(
            array(1,'11-22',215),
            array(2,'11-23',456),
            array(3,'11-24',356),
            array(4,'11-25',369),
            array(5,'11-26',482),
            array(6,'11-27',256),
            array(7,'11-28',189),
            array(8,'11-29',417),
            array(9,'11-30',254),
            array(10,'12-01',110),
        );
        $data['max'] = 500;
        $data['min'] = 0;
        $data['data_type'] = '曝光量';
        
        $this->ajaxReturnSuccess(array('data'=>$data));
    }
    
    /**
     * 广告位置维护
     */
    public function position(){
        //搜索信息
        $search_key = I('get.search_key','');
        $this->assign('search_key', $search_key);
        
        //过滤条件
        if($search_key){
            $_map['hotel_name'] = array('like','%'.$search_key.'%');
        }
        $_map['data_status'] = 1;
        
        $list = D('HotelInfo')->where($_map)->select();
        $count = D('HotelInfo')->where($_map)->count();
    
        //读广告主信息
        foreach ($list as &$val) {
            //发布列表
            $list_release = D('AdvertRelease')->getReleaseListByHotelId($val['id']);
            foreach ($list_release as &$v){                
                $v['advert_info'] = D('Adv','Cache')->getAdvertInfo($v['advert_id']);
            }
            $val['list'] = $list_release;
        }
        
        $page = show_page($count);
        $page['list'] = $list;

        $this->assign('page',$page);
        
        $this->display();
    }
    
    /**
     * 位置更改
     */
    public function changeSort(){
        if(!IS_AJAX){
            $this->ajaxReturnErr();
        }
        $id = I('post.id');//发布关心ID
        $type = I('type');
        
        //参数过滤
        if(!$id || !$type){
            $this->ajaxReturnErr();
        }
        //内容获取失败
        $model = D('AdvertRelease');
        $r_info = $model->getInfo($id);//当前发布详情
        
        if(!$r_info){
            $this->ajaxReturnErr();
        }
        
        if($type === 'up'){
            if(($r_info['data_sort']-1) <1 ){
                //当前排序已经最靠前
                $this->ajaxReturnErr();
            }
            //获取当前排序的前一个 广告的发布ID            
            $_map['hotel_id'] = $r_info['hotel_id'];
            $_map['data_status'] = 1;
            $_map['data_sort'] = array('lt',$r_info['data_sort']);
            
            $rs_prev = $model->where($_map)->order('data_sort desc,id')->find();
            
            if(!$rs_prev){
                //当前排序已经最靠前
                $this->ajaxReturnErr();
            }
            
            //开启事务
            $model->startTrans();
            unset($_map);
            $_map['id'] = $id;
            $_data['data_sort'] = $rs_prev['data_sort'];
            $rs1 = $model->where($_map)->save($_data);
            if($rs1 === false){
                $model->rollback();
                $this->ajaxReturnErr();
            }
            
            unset($_map,$_data);
            $_map['id'] = $rs_prev['id'];
            $_data['data_sort'] = $r_info['data_sort'];
            $rs2 = $model->where($_map)->save($_data);
            if($rs2 === false){
                $model->rollback();
                $this->ajaxReturnErr();
            }
            $model->commit();
            $this->ajaxReturnSuccess();
        }elseif($type === 'down'){
            
            //获取当前排序的下一个 广告的发布ID            
            $_map['hotel_id'] = $r_info['hotel_id'];
            $_map['data_status'] = 1;
            $_map['data_sort'] = array('gt',$r_info['data_sort']);
            
            $rs_next = $model->where($_map)->order('data_sort asc,id')->find();
            if(!$rs_next){
                //当前排序已经最靠后
                $this->ajaxReturnErr();
            }
            
            //开启事务
            $model->startTrans();
            unset($_map);
            $_map['id'] = $id;
            $_data['data_sort'] = $rs_next['data_sort'];
            $rs1 = $model->where($_map)->save($_data);
            if($rs1 === false){
                $model->rollback();
                $this->ajaxReturnErr();
            }
            
            unset($_map,$_data);
            $_map['id'] = $rs_next['id'];
            $_data['data_sort'] = $r_info['data_sort'];
            $rs2 = $model->where($_map)->save($_data);
            if($rs2 === false){
                $model->rollback();
                $this->ajaxReturnErr();
            }
            $model->commit();
            $this->ajaxReturnSuccess();
        }
        
        $this->ajaxReturnErr();
        
    }
}