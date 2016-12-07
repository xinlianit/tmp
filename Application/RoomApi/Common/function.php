<?php

function generate_order_no($hotel_id = 0, $room_id = 0){
    mt_srand(make_seed($hotel_id));
    $_val = mt_rand(10001, 99999);

    if(($_hotel_id = $hotel_id % 10)<=0)$_hotel_id = mt_rand(1, 9);
    if(($_room_id = $room_id % 10)<=0)$_room_id = mt_rand(1, 9);

    return $_hotel_id . str_pad(($_room_id % 10), 2, mt_rand(1, 9), STR_PAD_LEFT) . str_shuffle(date('Ymd')) . $_val;
}

function getWeek($week_num){
    $weekarray=array("日","一","二","三","四","五","六");
    if(is_numeric($week_num) && $week_num>=0){
        return '星期' . $weekarray[$week_num];
    }
    return null;
}


/**
 * 得到图标访问路径
 * @param String $weather_info
 * @param int $type 0: 当天天气图标, 1: 未来天气图标
 * @return string
 */
function getWeatherIcon($weather_info, $type = 0){
    $result = $weather_info;
    if(isset($weather_info) && !empty($weather_info)){
        $icon_list = C('ICON_LIST');

        if(!$type){
            if(date('G')<=19){
                $result = 'http://'. $_SERVER['HTTP_HOST'] . '/' . sprintf($icon_list[0], $weather_info);
            }else{
                $result = 'http://'. $_SERVER['HTTP_HOST'] . '/' . sprintf($icon_list[1], $weather_info);
            }
        }else{
            $result = 'http://'. $_SERVER['HTTP_HOST'] . '/' . sprintf($icon_list[2], $weather_info);
        }
    }

    return $result;
}

/**
 * @param String $date  日期，例：'2016-11-23'
 * @return String 例：11月23日
 */
function getMoonAndDay($date){
    if(is_string($date) && false !== strpos($date, '-')){
        $_arr_date = explode('-', $date);
        if(3 == count($_arr_date)){
            return $_arr_date[1] . '月' . $_arr_date[2] . '号';
        }
    }
    return $date;
}