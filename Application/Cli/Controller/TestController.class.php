<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Cli\Controller;
use Think\Controller;

//http://www.nmc.gov.cn/f/rest/province   获取省份数据
//http://www.nmc.gov.cn/f/rest/province/ATW
//通过身份中url及参数，GET城市中数据
//http://www.nmc.gov.cn/f/rest/tempchart/59493  通过省份CODE获取当前省份天气数据
//http://www.nmc.gov.cn/f/rest/real/59493?_=1479718614084 当前城市实时天气预报数据
//http://image.nmc.cn/static/site/nmc/themes/basic/weather/color/day/small/9.png  图片地址
/**
 * Description of TestController
 *
 * @author Administrator
 */
class TestController extends Controller {
    public function index()
    {
        header("Content-Type: text/html; charset=utf-8");
        //http://www.weather.com.cn/weather1d/101280601.shtml
        $url = "http://cj.weather.com.cn/support/Detail.aspx?id=51837fba1b35fe0f8411b6df"; //http://www.weather.com.cn/weather/101280601.shtml
        $data = file_get_contents($url);

        import('phpQuery.phpQuery', APP_LIBRARY, '.php');

        $doc = \phpQuery::newDocumentHTML($data);
        \phpQuery::selectDocument($doc);

        //$_data = pq('p [class="op_weather4_twoicon_date"]');
        //echo $_data->text();

        //$_data = pq('#7d') -> children("ul");

        //$weathers = $_data -> find("li");

        //foreach ($weathers -> elements  as $item ){
        //    var_dump(explode(',', json_decode(str_replace(['\n\n\n\n\n\n\n', '\n\n\n', '\n\n', '\n'], ',', json_encode(trim($item -> nodeValue))))));
        //}

        $p = pq("div [class='entry-content']") -> find('p[style="text-align:left;"]');
        //file_put_contents('temp.html', $p);
        //var_dump($p -> elements);
        $i = 0 ;
        foreach ( $p -> elements as $item ) {
            if ($i > 0) {
                $_all_name = explode(',', str_replace('，', ',', $item->nodeValue));

                $_map['data_status'] = 1;
                $_map['city_name'] = ['like', trim($_all_name[1]) . '%区'];
                $city_list = M('city_info') -> field('id, city_id') -> where($_map) -> select();

                if($city_list){
                    if ($city_list && 1 == count($city_list)) {
                        foreach ($city_list as $city) {
                            if ($city['city_id'] > 0) {
                                continue;
                            } else {
                                $rs = M('city_info')->data(['city_id' => trim($_all_name[0])])->where(['id' => $city['id']])->save();
                                if ($rs) {
                                    file_put_contents('test_success.log', trim($_all_name[0]) . ' => ' . $city['id'] . '(' . trim($_all_name[1]) . ')' . PHP_EOL, FILE_APPEND);
                                } else {
                                    file_put_contents('test_error.log', trim($_all_name[0]) . ' => ' . $city['id'] . '(' . trim($_all_name[1]) . ')' . PHP_EOL, FILE_APPEND);
                                }
                            }
                        }
                    }else{
                        file_put_contents('test_ambiguous.log', trim($_all_name[0]) . ' => (' . trim($_all_name[1]) . ')' . PHP_EOL, FILE_APPEND);
                    }
                }
                //$_map['city_name'] = trim($_tmp[1]);
            }
            $i = $i + 1;
        }
         /*       $city_data = M('weather_city') -> field('id') -> where(['id' => trim($_tmp[0])]) -> find();
                var_dump($city_data);
                if(!isset($city_data)) {
                    M('weather_city')->data(['id' => trim($_tmp[0]), 'city_name' => trim($_tmp[1]), 'all_name' => $all_name]) -> add();
        /*$city_list = M('weather_city')->field('id, city_name, city_code')->where($_map)->select();
        if ($city_list && 1 == count($city_list)) {
            foreach ($city_list as $city) {
                if (strlen(trim($city['city_code'])) > 0) {
                    continue;
                } else {
                    $rs = M('city_info')->data(['city_code' => trim($_tmp[0])])->where(['id' => $city['id']])->save();
                    if ($rs) {
                        file_put_contents('success.log', trim($_tmp[0]) . ' => ' . $city['id'] . '(' . trim($_tmp[1]) . ')\n\r', FILE_APPEND);
                    } else {
                        file_put_contents('error.log', trim($_tmp[0]) . ' => ' . $city['id'] . '(' . trim($_tmp[1]) . ')\n\r', FILE_APPEND);
                    }
                }
            }
        } else {
            file_put_contents('notwritten.log', trim($_tmp[0]) . ' => ' . trim($_tmp[1]) . '\n\r', FILE_APPEND);
        }*/
        /*}else{
            if (strlen(trim($city_data['city_code'])) > 0) {
                $rs = M('city_info')->data(['city_code' => null])->where(['id' => $city_data['id']])->save();
            }
        }*/
        //}
        //$i = $i + 1;
    //}
        echo 'ok';
        //print_r($city_data);
    }

    //put your code here
    public function add(){
        print_r('sdfsdf');
    }

    public function collect_province(){
        header("Content-Type: text/html; charset=utf-8");
        //http://www.weather.com.cn/weather1d/101280601.shtml
        $url = "http://www.nmc.gov.cn/f/rest/province"; //http://www.weather.com.cn/weather/101280601.shtml
        $data = file_get_contents($url);

        $_data = json_decode($data, true);

        foreach ( $_data as $item ){
            $_map['city_name'] = trim($item['name']);
            $city_list = M('city_info')->field('id, city_name, city_code')->where($_map)->select();
            if ($city_list && 1 == count($city_list)) {
                foreach ($city_list as $city) {
                    if (strlen(trim($city['city_code'])) > 0) {
                        continue;
                    } else {
                        $rs = M('city_info')->data(['city_code' => trim($item['code']), 'city_url' => trim($item['url'])])->where(['id' => $city['id']])->save();
                        if ($rs) {
                            file_put_contents('success.log', trim($item['name']) . ' => ' . $city['id'] . '(' . trim($item['code']) . ")" . PHP_EOL, FILE_APPEND);
                        } else {
                            file_put_contents('error.log', trim($item['name']) . ' => ' . $city['id'] . '(' . trim($item['code']) . ")" . PHP_EOL, FILE_APPEND);
                        }
                    }
                }
            }
        }
        echo 'ok';
    }


    public function collect_city(){
        header("Content-Type: text/html; charset=utf-8");
        //http://www.weather.com.cn/weather1d/101280601.shtml

        $_map['city_level'] = 1;
        $_map['city_code'] = ['exp', 'is not null'];
        $province_list = M('city_info')->field('city_code')->where($_map)->select();
        $url = "http://www.nmc.gov.cn/f/rest/province/"; //http://www.weather.com.cn/weather/101280601.shtml

        if( $province_list ){
            foreach ( $province_list as $item ){
                $data = file_get_contents($url . $item['city_code']);
                $_data = json_decode($data, true);
                $_city_info = M('city_info');
                unset($_map['city_level'], $_map['city_code']);

                foreach ( $_data as $item ){
                    $_map['city_name'] = ['like', $item['city'] . '市%'];
                    $city_list = $_city_info -> field('id, city_name, city_code') -> where($_map)->select();

                    if ($city_list && 1 == count($city_list)) {
                        foreach ($city_list as $city) {
                            if (strlen(trim($city['city_code'])) > 0) {
                                continue;
                            } else {
                                $rs = M('city_info')->data(['city_code' => trim($item['code']), 'city_url' => trim($item['url'])])->where(['id' => $city['id']])->save();
                                if ($rs) {
                                    file_put_contents('success.log', trim($item['city']) . ' => ' . $city['id'] . '(' . trim($item['code']) . ')' . PHP_EOL, FILE_APPEND);
                                } else {
                                    file_put_contents('error.log', trim($item['city']) . ' => ' . $city['id'] . '(' . trim($item['code']) . ')' . PHP_EOL, FILE_APPEND);
                                }
                            }
                        }
                    }else{
                        file_put_contents('ambiguous.log', trim($item['city']) . ' => ' . trim($item['code']) . PHP_EOL, FILE_APPEND);
                    }
                }
            }
        }

        echo 'ok';
    }


    public function downIcon(){
        $_url = 'http://image.nmc.cn/static2/site/nmc/themes/basic/weather/white/night/%d.png';

        for( $i = 0; $i < 100; $i++ ){
            $real_url = sprintf($_url, $i);
            $new_file = getImage($real_url);
            file_put_contents('result.log', trim($real_url) . ' => ' . trim($new_file) . PHP_EOL, FILE_APPEND);
        }
    }
}
