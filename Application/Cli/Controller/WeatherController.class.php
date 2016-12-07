<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Cli\Controller;
use Think\Controller;

/**
 * +----------------------------------------------------------------------
 * | JuhePHP [ NO ZUO NO DIE ]
 * +----------------------------------------------------------------------
 * | 天气预报接口调用 － 聚合数据
 * | 在线接口文档：http://www.juhe.cn/docs/73
 * | Copyright (c) 2016-2017 http://rapi.pad-phone.com/ All rights reserved.
 * +----------------------------------------------------------------------
 * | Author: PAD PHP DEV TEAM HuangZH(47198839@qq.com)
 * +----------------------------------------------------------------------
 */
class WeatherController extends Controller {
    //获取聚合天气预报数据
    public function query(){
        $appkey = C('JUHE_APP_KEY');
        //************1.根据城市查询天气************
        $url = C("JUHE_URL");
        import('Weather.Weather', APP_LIBRARY, '.class.php');

        $_weather_city = M('hotel_info') -> field('a.id, b.city_code') -> alias('a')
                        -> join('__CITY_INFO__ b ON a.city_id = b.id')
                        -> where(['a.data_status' => 1, 'b.city_code' => ['exp', 'is not null']])
                        -> select();

        if(isset($_weather_city) && !empty($_weather_city)) {
            $city_codes = array_column($_weather_city, 'city_code');
            $_weather_city = M('weather_city');
            $weather_city = $_weather_city -> field('id, city_name') -> where(['id' => ['in', $city_codes]]) -> select();

            if(isset($weather_city) && !empty($weather_city)) {
                foreach ($weather_city as $item) {
                    $result = null;
                    $_city_code = null;
                    $_request_date = null;
                    $weather_data = null;

//                    $_weather_data = M('weather_info')->field('id')->where(['city_code' => $item['id'], 'req_date' => date('Y-m-d')])->find();
//
//                    if (!isset($_weather_data)) {
                        /*$params = array(
                            "cityname" => trim($item['city_name']),//要查询的城市，如：温州、上海、北京
                            "key" => $appkey,//应用APPKEY(应用详细页查询)
                            "dtype" => "json",//返回数据的格式,xml或json，默认json
                        );
                        $paramstring = http_build_query($params);
                        $content = juhecurl($url, $paramstring);

                        $result = json_decode($content, true);*/
                        $_weather = new \Weather($appkey);
                        $result = $_weather ->getWeather(trim($item['city_name']));

                        if ($result) {
                            if ($result['error_code'] == '0') {
                                if (isset($result['result']['data'])) {
                                    $_city_code = trim($result['result']['data']['realtime']['city_code']);
                                    $_request_date = trim($result['result']['data']['realtime']['date']);
                                    $weather_data = M('weather_info')->field('id')->where(['city_code' => $_city_code, 'req_date' => $_request_date])->find();

                                    $_data = [
                                        'city_code' => $_city_code,
                                        'weather_data' => base64_encode(json_encode($result['result']['data'])),
                                        'req_date' => $_request_date,
                                        'create_time' => time(),
                                        'update_time' => trim($result['result']['data']['realtime']['dataUptime']),
                                    ];

                                    if (empty($weather_data)) {
                                        $_rs = M('weather_info')->data($_data)->add();
                                    }else{
                                        $_rs = M('weather_info') -> where(['city_code' => $_city_code, 'req_date' => $_request_date]) -> save($_data);
                                    }

                                    if ($_rs) {
                                        logs("[Date=" . $_request_date . "] " . $result['reason'] . ":" . trim($result['result']['data']['realtime']['city_name']) . "(" . $_city_code . ")", 'INFO', 'Weather');
                                    } else {
                                        logs("[Date=" . $_request_date . "] " . $result['reason'] . ":" . trim($result['result']['data']['realtime']['city_name']) . "(" . $_city_code . ")", 'ERR', 'Weather');
                                    }
                                }
                            } else {
                                logs($result['error_code'] . ":" . $result['reason'], 'ERR', 'Weather');
                            }
                        } else {
                            logs("请求失败", 'ERR', 'Weather');
                        }
//                    }
                }
            }
        }
    }

    public function getWeatherInfo(){
        $_weather_city = M('hotel_info') -> field('city_id')
                         -> where(['data_status' => 1]) -> select();

        if(isset($_weather_city) && !empty($_weather_city)) {
            $city_ids = array_column($_weather_city, 'city_id');
            $_weather_city = M('city_info');
            $weather_city = $_weather_city->field('id, city_code, city_id')->where(['id' => ['in', $city_ids], 'city_level' => ['gt', 1]])->select();

            if (isset($weather_city) && !empty($weather_city)) {
                $_weather_info = M('weather_info');
                $_future_info = M('future_day');
                foreach ($weather_city as $item) {
                    $_info = $this -> getFutureWeather($item['city_id']);
                    $_url = "http://www.nmc.gov.cn/f/rest/real/%s?_=" . getMillisecond();
                    $url = sprintf($_url, $item['city_code']);

                    $data = file_get_contents($url);
                    $weather_data = json_decode($data, true);

                    if($weather_data){
                        if(isset($weather_data['publish_time'])){
                            $_date = explode(' ', $weather_data['publish_time']);
                            $local_date = trim($_date[0]);
                            $local_time = trim($_date[1]);
                        }else{
                            $local_date = date('Y-m-d');
                            $local_time = date('H:i');
                        }

                        $_data = [
                            'city_id' => $item['id'],
                            'req_date' => $local_date,
                            'req_time' => $local_time,
                            'week'      => date('w',strtotime($local_date)),
                            'temperature' => $weather_data['weather']['temperature'],
                            'weather_info' => $weather_data['weather']['info'],
                            'weather_img' => $weather_data['weather']['img'],
                            'create_time' => time(),
                            'update_time' => time(),
                        ];

                        $weather_info = $_weather_info -> field('id') -> where(['city_id' => $item['id'], 'req_date' => $local_date]) -> find();

                        if (!$weather_info) {
                            $_rs = $_weather_info->data($_data)->add();
                        }else{
                            unset($_data['create_time']);
                            if(9999 == intval(trim($weather_data['weather']['temperature'])))unset($_data['temperature']);
                            $_rs = $_weather_info -> where(['city_id' => $item['id'], 'req_date' => $local_date]) -> save($_data);
                        }
                        //echo $_weather_info -> getLastSql() . '<br />';

                        if ($_rs) {
                            logs("[Date=" . $local_date . "] " . $item['id'] . ":" . trim($weather_data['station']['city']) . "(" . $item['city_code'] . ")", 'INFO', 'Weather');

                            $_url = 'http://www.nmc.gov.cn/f/rest/tempchart/' . $item['city_code'];
                            $data = file_get_contents($_url);
                            $_weather_list = json_decode($data, true);

                            if($_weather_list){
                                $_local_date = str_replace('-', '', $local_date);
                                $_date = date('m/d',strtotime("$local_date +1 day"));
                                $_execute = false;
                                $_index = 0;
                                foreach ( $_weather_list as $weather ){
                                    if( $_execute && $_index > 0 && $_index < 7 ){
                                        $_icon_id = (9999 == $weather['dayImg'])?0:$weather['dayImg'];
                                        $future_day = $_future_info -> field('id') -> where(['weather_id' => $_rs, 'weather_date' => $_date]) -> find();
                                        if($future_day){
                                            $_data = [
                                                'weather_id' => $_rs,
                                                'week' => date('w',strtotime($_date)),
                                                'weather_date' => $_date,
                                                'icon_id'      => $_icon_id,
                                                'weather_info' => $_info[$_index-1][1]
                                            ];
                                            if( intval($weather['minTemp']) < 9999 and intval($weather['maxTemp']) < 9999 ){
                                                $_data['temperature'] =  $weather['maxTemp'] . '°-' . $weather['minTemp'] . '°';
                                            }
                                            $_future_info -> where(['id' => $future_day['id']]) -> save($_data);
                                        }else{
                                            $_data = [
                                                'weather_id' => $_rs,
                                                'week' => date('w',strtotime($_date)),
                                                'weather_date' => $_date,
                                                'icon_id'      => $_icon_id,
                                                'weather_info' => $_info[$_index-1][1]
                                            ];

                                            if( intval($weather['minTemp']) < 9999 and intval($weather['maxTemp']) < 9999 ){
                                                $_data['temperature'] =  $weather['maxTemp'] . '°-' . $weather['minTemp'] . '°';
                                            }

                                            $_future_info -> data($_data) -> add();
                                        }
                                        $_date = date('m/d',strtotime("$_date +1 day"));
                                        $_index = $_index + 1;
                                    }
                                    if($_local_date == $weather['realTime']){
                                        $_execute = true;
                                        $_index = $_index + 1;
                                        if( intval($weather['minTemp']) < 9999 and intval($weather['maxTemp']) < 9999 ){
                                            $_weather_info -> where(['city_id' => $item['id'], 'req_date' => $local_date]) -> save(['section_temp' => $weather['maxTemp'] . '°-' . $weather['minTemp'] . '°']);
                                        }
                                        //echo $_weather_info -> getLastSql() . '<br />';
                                    }
                                }
                            }
                        } else {
                            logs("[Date=" . $local_date . "] " . $item['id'] . ":" . trim($weather_data['station']['city']) . "(" . $item['city_code'] . ")", 'ERR', 'Weather');
                        }
                    }
                }
            }
        }
    }

    /**
     * @param Integer $city_code  中国天气网城市编码 http://www.weather.com.cn
     * @return array 未来5天天气数组数据
     */
    function getFutureWeather($city_code = null){
        if(!empty($city_code)) {
            $url = "http://www.weather.com.cn/weather/" . $city_code . ".shtml"; //http://www.weather.com.cn/weather/101280601.shtml
            $data = file_get_contents($url);

            import('phpQuery.phpQuery', APP_LIBRARY, '.php');

            $doc = \phpQuery::newDocumentHTML($data);
            \phpQuery::selectDocument($doc);

            //$_data = pq('p [class="op_weather4_twoicon_date"]');
            //echo $_data->text();

            $_data = pq('#7d')->children("ul");

            $weathers = $_data->find("li");
            $_result = [];
            $_index = 0;

            foreach ($weathers->elements as $item) {
                if($_index < 6) {
                    $_result[] = explode(',', json_decode(str_replace(['\n\n\n\n\n\n\n', '\n\n\n', '\n\n', '\n'], ',', json_encode(trim($item->nodeValue)))));
                }
                $_index = $_index + 1;
            }
            return $_result;
        }
    }
}
