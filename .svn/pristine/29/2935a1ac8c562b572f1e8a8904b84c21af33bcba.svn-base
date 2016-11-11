<?php
/**
 * MiniBarController.class.php - 客房服务接口
 * @package RoomApi\Controller
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月11日  09:27
 * @version V1.0.0
 */
namespace RoomApi\Controller;

class MiniBarController extends CommonController {
    //获取迷你吧商品列表
    public function getGoodsList(){
        $hotel_id = trim($this->I['hotel_id']);         //酒店ID

        if( isset($hotel_id) && $hotel_id > 0 ) {
            $_goods_shelves = M("goods_shelves");
            $_map['a.hotel_id'] = $hotel_id;
            $_map['a.data_status'] = 1;
            $_map['a.up_shelves'] = ['lt', time()];
            $_map['a.down_shelves'] = ['gt', time()];
            $_map['d.match_code'] = ['exp', 'IS NOT NULL AND d.match_code <> \'\''];

            //获取已上架销售商品列表
            $goods_shelves = $_goods_shelves -> field(
                                                    'c.id as cate_id, 
                                             a.hotel_id, 
                                             c.category_name, 
                                             c.data_sort , 
                                             a.goods_id,
                                             b.cate_id,
                                             b.goods_name,
                                             b.goods_price,
                                             b.goods_stock,
                                             b.original_cost,
                                             b.goods_desc,
                                             d.match_code,
                                             b.goods_pic
                                             ') -> alias('a')
                                             -> join('__GOODS_INFO__ b ON a.goods_id = b.id')
                                             -> join('__GOODS_CATEGORY__ c ON b.cate_id = c.id')
                                             -> join('__GOODS_MATCH__ d ON d.goods_id = b.id')
                                             -> where($_map) -> order(['c.data_sort', 'c.id', 'a.goods_id']) -> select();

            if($goods_shelves){
                $_list = [];     //商品分类列表信息
                $local_cate_id = -1;  //当前分类ID
                $_index = 0;
                foreach ( $goods_shelves as $item ){
                    if( $local_cate_id != $item['cate_id'] ){
                        $_index  = array_push($_list, [                                  //增加分类头数据信息
                            'cate_id'   => $item['cate_id'],
                            'hotel_id'  => $item['hotel_id'],
                            'cate_name' => $item['category_name'],
                            'cate_sort' => $item['data_sort']
                        ]);
                        $local_cate_id = $item['cate_id'];
                    }

                    $_list[$_index-1]['goods_list'][] = [                      //增加商品信息
                        'cate_id'          => $item['cate_id'],
                        'goods_id'         => $item['goods_id'],
                        'goods_name'       => $item['goods_name'],
                        'goods_price'      => $item['goods_price'],
                        'goods_stock'      => $item['goods_stock'],
                        'original_cost'    => $item['original_cost'],
                        'goods_desc'       => $item['goods_desc'],
                        'match_code'       => $item['match_code'],
                        'goods_pic_thuml' => generateImageName($item['goods_pic']),
                        'goods_pic_max'   => generateImageName($item['goods_pic'])
                    ];
                }

                $this -> result = array_merge($this -> result, ['list' => $_list]) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['500000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }


    //生成迷你吧订单信息
    public function setOrderInfo(){
        $hotel_id = trim($this->I['hotel_id']);                     //酒店id
        $room_id = trim($this->I['room_id']);                       //房间id
        $device_id = trim($this->I['device_id']);                  //设备id
        $device_address = trim($this->I['device_address']);       //设备地址
        $only_code = trim($this->I['only_code']);                  //入住客人唯一识别码
        $payment = array_key_exists('payment', $this->I)?(!empty($this->I['payment'])?trim($this->I['payment']):3):3;           //支付方式 1:在线支付,2:货到付款,3:转房账(默认为3)
        $pay_status = array_key_exists('pay_status', $this->I)?(!empty($this->I['pay_status'])?trim($this->I['pay_status']):1):1;     //支付状态 1:未支付,2:已支付(默认为1)
        $goods_list = trim($this->I['goods_list']);     //购买商品列表


        if(isset($hotel_id) && !empty($hotel_id)                 //酒店ID、房间ID、设备ID、商品列表不能为空
            && isset($room_id) && !empty($room_id)
            && isset($device_id) && !empty($device_id)
            && isset($device_address) && !empty($device_address)
            && isset($only_code) && !empty($only_code)
            && isset($goods_list) && !empty($goods_list)
            && count($goods_list) > 0 ) {

            //生成订单号
            $order_no = '';
            //获取酒店名称
            $_map['id'] = $hotel_id;
            $_map['data_status'] = 1;
            $hotel_info = M('hotel_info') ->field('hotel_name') -> where($_map) -> find();

            //获取房间名称
            $_map['id'] = $room_id;
            $room_info = M('room_info') ->field('room_name') -> where($_map) -> find();

            if($hotel_info){
                if($room_info) {
                    //计算商品信息
                    if(!array_key_exists('goods_id', $goods_list)){
                        $this -> result = array_merge($this -> result, $this -> status['4']);
                    }else {
                        $_goods_ids = array_column($goods_list, 'goods_id');
                        if(count($_goods_ids)>0){
                            foreach ($goods_list as $item) {
                                $_new_goods_list[$item['goods_id']] = $item['goods_num'];
                            }

                            $_map['id'] = ['in', $_goods_ids];
                            $_goods_list = M('goods_info') -> field('goods_name, goods_price, category_name, goods_pic') -> alias('a')
                                                             -> join('__GOODS_CATEGORY__ b ON a.cate_id = b.id')
                                                             -> where($_map) -> select();
                            if($_goods_list){
                                unset($_data);
                                $_order_amount = 0;

                                foreach ( $_goods_list as $item ) {
                                    $_amount = $_new_goods_list[$item['goods_id']] * $item['goods_price'];     //获取当前商品订单额
                                    $_order_amount = intval($_order_amount) + intval($_amount);                    //累加订单商品金额

                                    array_push($_data, [
                                        'order_no' => $order_no,                                         //订单编号
                                        'goods_id' => $item['goods_id'],                               //商品ID,
                                        'goods_name' => $item['goods_name'],                          //商品名称
                                        'goods_cate' => $item['category_name'],                       //商品分类
                                        'goods_thum' => generateImageName($item['goods_pic']),        //商品缩略图
                                        'goods_price' => $item['goods_price'],                        //'商品单价 单位为分
                                        'goods_quantity' => $_new_goods_list[$item['goods_id']],      //'商品数量
                                    ]);
                                }
                                $_order_goods = M('order_goods');
                                $_order_goods -> startTrans();
                                $order_goods = $_order_goods -> addAll($_data);

                                if($order_goods){
                                    $_order_goods -> commit();
                                    $_order_info = M("order_info");
                                    unset($_data);

                                    $_data = [
                                        'order_no' => $order_no,            //订单编号
                                        'order_amount' => $_order_amount,       //订单金额 单位为分
                                        'sale_hotel' => $hotel_info['hotel_name'],          //销售商户
                                        'hotel_id' => $hotel_id,            //酒店ID
                                        'room_name' => $room_info['room_name'],   //销售房号
                                        'room_id' => $room_id,             //房间ID
                                        'device_id' => $device_id,           //设备ID
                                        'device_address' => $device_address,             //设备地址
                                        'only_code' => $only_code,           //入住客人唯一识别码
                                        'payment' => $payment,             //支付方式 1:在线支付,2:货到付款,3:转房账
                                        'pay_status' => $pay_status,          //支付状态 1:未支付,2:已支付
                                        'create_time' => time(),         //创建时间
                                        'update_time' => time(),         //最后更新时间
                                        'data_status' => 1,         //订单状态 1:待处理,2:配送中,3:订单取消,4:交易成功
                                    ];

                                    $_order_info -> startTrans();
                                    $order_info = $_order_info->data($_data)->add();
                                    if ($order_info) {
                                        $_order_info -> commit();
                                        $this->result['order_no'] = $order_no;
                                    } else {
                                        $_order_info -> rollback();
                                        $this->result = array_merge($this->result, $this->status['900001']);
                                    }
                                }else{
                                    $_order_goods -> rollback();
                                    $this->result = array_merge($this->result, $this->status['900004']);
                                }
                            }else{
                                $this->result = array_merge($this->result, $this->status['900003']);
                            }
                        }else{
                            $this->result = array_merge($this->result, $this->status['900002']);
                        }
                    }
                }else{
                    $this -> result = array_merge($this -> result, $this -> status['300002']);
                }
            }else{
                $this -> result = array_merge($this -> result, $this -> status['100014']);
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']);
        }

        $this->ajaxReturn($this->result);
    }


    //获取迷你吧订单列表
    public function getOrderList(){
        $hotel_id = trim($this->I['hotel_id']);         //酒店ID
        $room_id = trim($this->I['room_id']);         //房间ID

        if( isset($hotel_id) && $hotel_id > 0 ) {
            $_goods_shelves = M("goods_shelves");
            $_map['a.hotel_id'] = $hotel_id;
            $_map['a.data_status'] = 1;
            $_map['a.up_shelves'] = ['lt', time()];
            $_map['a.down_shelves'] = ['gt', time()];
            $_map['d.match_code'] = ['exp', 'IS NOT NULL AND d.match_code <> \'\''];

            //获取有效问卷主题列表
            $goods_shelves = $_goods_shelves -> field(
                'c.id as cate_id, 
                                             a.hotel_id, 
                                             c.category_name, 
                                             c.data_sort , 
                                             a.goods_id,
                                             b.goods_name,
                                             b.goods_price,
                                             b.goods_stock,
                                             b.original_cost,
                                             b.goods_desc,
                                             d.match_code,
                                             b.goods_pic
                                             ') -> alias('a')
                -> join('__GOODS_INFO__ b ON a.goods_id = b.id')
                -> join('__GOODS_CATEGORY__ c ON b.cate_id = c.id')
                -> join('__GOODS_MATCH__ d ON d.goods_id = b.id')
                -> where($_map) -> order(['c.data_sort', 'c.id', 'a.goods_id']) -> select();

            if($goods_shelves){
                $_list = [];     //商品分类列表信息
                $local_cate_id = -1;  //当前分类ID
                $_index = 0;
                foreach ( $goods_shelves as $item ){
                    if( $local_cate_id != $item['cate_id'] ){
                        $_index  = array_push($_list, [                                  //增加分类头数据信息
                            'cate_id'   => $item['cate_id'],
                            'hotel_id'  => $item['hotel_id'],
                            'cate_name' => $item['category_name'],
                            'cate_sort' => $item['data_sort']
                        ]);
                        $local_cate_id = $item['cate_id'];
                    }

                    $_list[$_index-1]['goods_list'][] = [                      //增加商品信息
                        'goods_id'         => $item['goods_id'],
                        'goods_name'       => $item['goods_name'],
                        'goods_price'      => $item['goods_price'],
                        'goods_stock'      => $item['goods_stock'],
                        'original_cost'    => $item['original_cost'],
                        'goods_desc'       => $item['goods_desc'],
                        'match_code'       => $item['match_code'],
                        'goods_pic_thuml' => generateImageName($item['goods_pic']),
                        'goods_pic_max'   => generateImageName($item['goods_pic'])
                    ];
                }

                $this -> result = array_merge($this -> result, ['list' => $_list]) ;
            }else{
                $this -> result = array_merge($this -> result, $this -> status['500000']) ;
            }
        }else{
            $this -> result = array_merge($this -> result, $this -> status['4']) ;
        }
        $this->ajaxReturn($this->result);
    }
}