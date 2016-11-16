<?php
/**
 * FeedBackController.class.php - 客房服务APP接口意见反馈
 * @package RoomApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月10日  09:05
 * @version V1.0.0
 */
namespace RoomApi\Controller;

class FeedBackController extends CommonController {
    //获取单一问卷信息
    public function getOnceInfo(){
        $subject_id = trim($this->I['subject_id']);         //问卷ID

        if( isset($subject_id) && $subject_id > 0 ) {
            $_feedback_info = M("feedback_subject");
            $_map['subject_id'] = $subject_id;
            $_map['data_status'] = 1;

            //$_order['data_sort'] =

            $feedback_info = $_feedback_info -> field('id as subject_id, hotel_id, title as subject_title, subject_type, data_sort') -> where($_map) -> find();

            if($feedback_info){
                if(1 == $feedback_info['subject_type']){
                    $_map['subject_id'] = $feedback_info['subject_id'];
                    $option_list = M("feedback_option") -> field('id as option_id, option_name') -> where($_map) -> select();
                    $feedback_info['options'] = $option_list;
                    $this -> result = array_merge($this -> result, $feedback_info) ;
                }else{
                    $feedback_info['options'] = [];
                }
            }else{
                $this -> result = array_merge($this -> result, $this -> status['800000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取有效问卷标题列表
    public function getTitleList(){
        $hotel_id = trim($this->I['hotel_id']);         //问卷ID

        if( isset($hotel_id) && $hotel_id > 0 ) {
            $_feedback_info = M("feedback_subject");
            $_map['hotel_id'] = $hotel_id;
            $_map['data_status'] = 1;

            $_order['create_time'] = 'desc';

            $feedback_list = $_feedback_info -> field('id as subject_id, hotel_id, title as subject_title, subject_type, data_sort') -> where($_map) -> order($_order) -> select();

            if($feedback_list){
                $this -> result = array_merge($this -> result, ['list' => $feedback_list]) ;
            }else{
                $this -> result['list']  = [];
                $this -> result = array_merge($this -> result, $this -> status['800000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //获取有效问卷信息列表
    public function getValidList(){
        $hotel_id = trim($this->I['hotel_id']);         //问卷ID

        if( isset($hotel_id) && $hotel_id > 0 ) {
            $_feedback_info = M("feedback_subject");
            $_map['hotel_id'] = [['eq', $hotel_id], ['eq', 0], 'or'];
            $_map['data_status'] = 1;

            $_order['create_time'] = 'desc';

            //获取有效问卷主题列表
            $feedback_list = $_feedback_info -> field('id as subject_id, hotel_id, title as subject_title, subject_type, data_sort, null as options') -> where($_map) -> order($_order) -> select();

            if($feedback_list){
                //将问卷ID单独抽成数组，方便一次查询文件选项
                $subject_ids = array_column($feedback_list, 'subject_id');
                $_map['subject_id'] = ['in', $subject_ids];

                //查询问卷选项，如果不存在问卷ID(填空题),则无返回数据
                $option_list = M('feedback_option') -> field('id as option_id, subject_id, option_name') -> where($_map) -> select();

                //用问卷ID作为键值，生成新数组，并用空数组初始化
                $arrSubject = array_fill_keys($subject_ids, []);

                //将问卷ID与选项列表进行关联
                foreach ( $option_list as $item ){
                    array_push($arrSubject[$item['subject_id']], ['option_id' => $item['option_id'], 'option_name' => $item['option_name']]);
                }

                //通过问卷ID，将对应选项列表信息，关联到问卷列表上
                foreach ( $feedback_list as $key => $value ){
                    $feedback_list[$key]['options'] = $arrSubject[$value['subject_id']];
                }

                $this -> result = array_merge($this -> result, ['list' => $feedback_list]) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['800000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //提交问卷答案信息
    public function setAnswerInfo(){
        $answer_list = json_decode(html_entity_decode($this -> I['answer_list']), true);         //答案列表信息

        if(isset($answer_list) && !empty($answer_list)) {
            $_data = null;

            if(1 == count($answer_list)) $answer_list = $answer_list['answer_list'];
            foreach ( $answer_list as $item ){
                if(
                    6 == count($item)
                    && array_key_exists('hotel_id', $item)
                    && array_key_exists('room_id', $item)
                    && array_key_exists('only_code', $item)
                    && array_key_exists('subject_id', $item)
                    && array_key_exists('option_ids', $item)
                    && array_key_exists('answer_content', $item)){

                    if(strlen(($_opts = trim($item['option_ids'], ','))>0)){
                        if(false === strpos($_opts, ',')){
                            $_item_data['hotel_id'] = $item['hotel_id'];
                            $_item_data['room_id'] = $item['room_id'];
                            $_item_data['only_code'] = $item['only_code'];
                            $_item_data['subject_id'] = $item['subject_id'];
                            $_item_data['option_id'] = $item['option_ids'];
                            $_item_data['answer_content'] = $item['answer_content'];
                            $_item_data['create_time'] = time();
                        }else{
                            $_arr_opt = explode($item['option_ids']);
                            foreach ( $_arr_opt as $value) {
                                $_item_data['hotel_id'] = $item['hotel_id'];
                                $_item_data['room_id'] = $item['room_id'];
                                $_item_data['only_code'] = $item['only_code'];
                                $_item_data['subject_id'] = $item['subject_id'];
                                $_item_data['option_id'] = $value;
                                $_item_data['answer_content'] = $item['answer_content'];
                                $_item_data['create_time'] = time();
                                $_data[] = $_item_data;
                                //unset($_item_data);
                            }
                        }
                    }else{
                        $_item_data['hotel_id'] = $item['hotel_id'];
                        $_item_data['room_id'] = $item['room_id'];
                        $_item_data['only_code'] = $item['only_code'];
                        $_item_data['subject_id'] = $item['subject_id'];
                        $_item_data['option_id'] = 0;
                        $_item_data['answer_content'] = $item['answer_content'];
                        $_item_data['create_time'] = time();
                    }
                    $_data[] = $_item_data;
                    //unset($_item_data);
                }else{
                    unset($_data);
                    $_data = null;
                    $this -> result = array_merge($this -> result, $this -> status['5']) ;
                    break;
                }
            }

            if(!is_null($_data)){
                $_feedback_answer = M("feedback_answer");
                $feedback_answer = $_feedback_answer -> addAll($_data);
                if(!$feedback_answer){
                    $this -> result = array_merge($this -> result, $this -> status['6']) ;
                }
            }else{
                $this -> result = array_merge($this -> result, $this -> status['4']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }

        $this->ajaxReturn($this->result);
    }



}