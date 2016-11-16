<?php
/**
 * CityInfoModel.class.php - 城市逻辑处理
 * @link http://www.pad-phone.com
 * @copyright 2016-11-15 10:40 zhaoxz(441534536@qq.com)
 */

namespace Admin\Logic;
use Admin\Logic\CommonLogic;

class CityInfoLogic extends CommonLogic{
    
    /**
     * 获取全总地区
     * @param int $data_status 状态
     */
    public function getAreaAll($data_status=1){
        
        //获取所有地区
        $_map['data_status'] = $data_status;
        $area_list = M('CityInfo')->where($_map)->select();
        
        //按层级格式化
        foreach ($area_list as $val) {
            if ($val['city_level'] == 1) {
                $_area[$val['id']] = $val;
            }elseif ($val['city_level'] == 2) {                
                $_area[$val['parent_id']]['child'][$val['id']] = $val;
            }elseif ($val['city_level'] == 3) {
                $level_one_id = substr($val['parent_id'], 0,2).'0000';//
                $_area[$level_one_id]['child'][$val['parent_id']]['child'][$val['id']] = $val;
            }            
        }
        
        return $_area;
    }
    
    /**
     * 获取地区商圈列表
     * @param type $data_status
     * @return type
     */
    public function getAreaAllWithMart($data_status=1){
        //获取所有地区
        $_map['data_status'] = $data_status;
        $area_list = M('CityInfo')->where($_map)->select();
        
        //获取全部商圈
        $_map_mart['data_status'] = 1;
        $mart_list = M('TradingArea')->where($_map_mart)->select();
        foreach ($mart_list as $v) {
            $_mart_arr[$v['city_id']][] = $v;
        }
        
        //按层级格式化
        foreach ($area_list as &$val) {
            if ($val['city_level'] == 1) {
                $_area[$val['id']] = $val;
            }elseif ($val['city_level'] == 2) {                
                $_area[$val['parent_id']]['child'][$val['id']] = $val;
            }elseif ($val['city_level'] == 3) {
                $level_one_id = substr($val['parent_id'], 0,2).'0000';//                
                //拼加商圈信息
                if(isset($_mart_arr[$val['id']])){
                    $val['mart'] = $_mart_arr[$val['id']];
                }
                $_area[$level_one_id]['child'][$val['parent_id']]['child'][$val['id']] = $val;
            }            
        }
        return $_area;
    }
    
    /**
     * 获取城市详情（包含商圈）
     * @param type $id
     */
    public function getInfoWithMart($id){
        
        //地区详情
        $_map['id'] = $id;
        $city_info = M('CityInfo')->where($_map)->find();
        if(!$city_info){
            return false;
        }
        
        //获取全部商圈
        $_map_mart['city_id'] = $id;
        $_map_mart['data_status'] = 1;
        $mart_list = M('TradingArea')->where($_map_mart)->select();
        
        $city_info['mart'] = $mart_list;
        $city_info['level_'.$city_info['city_level'].'_id'] = $id;
      
        $_this_level = $city_info['city_level'];
        $_this_parent_id = $city_info['parent_id'];
        
        //遍历父级ID
        while ($_this_level > 1 ) {
            $_this_map['id'] = $_this_parent_id;
            $_this_info = M('CityInfo')->where($_this_map)->find();
            
            $_this_level = $_this_info['city_level'];
            $_this_parent_id = $_this_info['parent_id'];
            $city_info['level_'.$_this_level.'_id'] = $_this_info['id'];
        }
        
        return $city_info;
    }
}