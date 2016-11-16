<?php 
/**
 * tableStatus.php - 数据库表字段状态值对应名称
 * @link http://www.mashangchi.cn/
 * @author MSC PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 易订云 2016年4月12日  16:27
 * @version V1.0.0
 */
return array(
    //用户叫服务列表 msc_member_service：service_type
    'MEMBER_SERVICE_TYPE'           => array('1'=>'加水','2'=>'加饭','3'=>'呼叫服务员','4'=>'买单'),
    //用户叫服务列表 msc_member_service：service_status
    'MEMBER_SERVICE_STATUS'         => array('1'=>'待处理','2'=>'已处理'),
    //桌台信息 msc_desk_info：desk_cate
    'DESK_INFO_TYPE'                => array('1'=>'包厢','2'=>'散座','3'=>'卡座'),
    //桌台信息 msc_desk_info：desk_status
    'DESK_INFO_STATUS'              => array('1'=>'空台','2'=>'占用','3'=>'使用中','4'=>'维修','5'=>'待落单'),
    'DESK_INFO_STATUS_ALIAS'        => array('1'=>'空','2'=>'占','3'=>'使','4'=>'维','5'=>'待'),
    //订单菜品信息 order_food_info：detail_type
    'ORDER_FOOD_INFO_TYPE'          => array('1'=>'菜品','2'=>'套餐','3'=>'套餐子菜品'),
    //订单菜品信息 order_food_info：detail_status；当前状态,1:待确认,2:已确认(已下厨),3:订单取消,99:删除
    'ORDER_FOOD_INFO_STATUS'        => array('1'=>'待确认','2'=>'已下厨','3'=>'已取消'),
    //订单菜品信息 order_food_info：up_type
    'ORDER_FOOD_INFO_UP'            => array('1'=>'叫停','2'=>'起菜'),
    //菜品详情  food_info：food_type
    'FOOD_INFO_TYPE'                => array('1'=>'菜品','2'=>'套餐'),
    //菜品详情
    'FOOD_INFO_STATUS'              => array('1'=>'有效','2'=>'无效','3'=>'已锁定','4'=>'已沽清'),
    //订单状态,1:待确认,2:已确认,3:金额待确认,4:金额已确认,5:已买单,6:已退单,7:已过期
    'ORDER_INFO_STATUS'             => array('1'=>'待确认','2'=>'已确认','3'=>'金额待确认','4'=>'金额已确认','5'=>'已买单','6'=>'已取消','7'=>'已过期'),
    //订单类型
    'ORDER_INFO_TYPE'               => array('1'=>'堂食点餐','2'=>'霸王餐','3'=>'限量套餐'),
    //员工职位
    'STAFF_INFO_WORKER'             => array('1'=>'服务员'),
    //员工状态
    'STAFF_INFO_STATUS'             => array('1'=>'正常' , '2'=>'停用'),
    //服务状态
    'SERVICE_STATUS'                => array('1'=>'未定义' , '2'=>'加水' , '3' => '加饭' , '4'=>'呼叫服务员'),
    
    //菜品详情
    'FOOD_INFO'                     => array(
        //菜品类型
        'FOOD_TYPE'         => array(
            //菜品
            'FOOD'          => array('VALUE' => 1 , 'NAME' => '菜品' , 'STATUS' => 1),
            //套餐
            'PACK'          => array('VALUE' => 2 , 'NAME' => '套餐' , 'STATUS' => 1),
        ),
        //是否显示
        'IS_DISPLAY'        => array(
            //不显示
            'HIDE'          => array('VALUE' => 0 , 'NAME' => '不显示' , 'STATUS' => 1),
            //显示
            'SHOW'          => array('VALUE' => 1 , 'NAME' => '显示' , 'STATUS' => 1),
        ),
        //菜品状态
        'FOOD_STATUS'       => array(
            //有效
            'EFFECTIVE'          => array('VALUE' => 1 , 'NAME' => '有效' , 'STATUS' => 1),
            //无效
            'INVALID'            => array('VALUE' => 2 , 'NAME' => '无效' , 'STATUS' => 1),
            //锁定
            'LOCK'               => array('VALUE' => 3 , 'NAME' => '已锁定' , 'STATUS' => 1),
            //解除锁定
            'UNLOCK'             => array('VALUE' => 1 , 'NAME' => '解除锁定' , 'STATUS' => 1),
            //沽清
            'IS_EMPTY'           => array('VALUE' => 4 , 'NAME' => '已沽清' , 'STATUS' => 1),
            //解除沽清
            'NOT_EMPTY'          => array('VALUE' => 1 , 'NAME' => '解除沽清' , 'STATUS' => 1),
            //删除
            'DELETE'             => array('VALUE' => 99 , 'NAME' => '删除' , 'STATUS' => 1),
        ),
    ),
    //用户叫服务
    'MEMBER_SERVICE'                => array(
        //服务类型
        'SERVICE_TYPE'         => array(
            //加水
            'ADD_WATER'         => array('VALUE' => 1 , 'NAME' => '加水' , 'STATUS' => 1),
            //加饭
            'ADD_MEAL'          => array('VALUE' => 2 , 'NAME' => '加饭' , 'STATUS' => 1),
            //呼叫服务员
            'CALL_WAITER'       => array('VALUE' => 3 , 'NAME' => '呼叫服务员' , 'STATUS' => 1),
            //买单
            'CHECKOUT'          => array('VALUE' => 4 , 'NAME' => '买单' , 'STATUS' => 1),
        ),
        //服务状态
        'SERVICE_STATUS'         => array(
            //待处理
            'NOT_HANDLE'        => array('VALUE' => 1 , 'NAME' => '待处理' , 'STATUS' => 1),
            //已处理
            'YES_HANDLE'        => array('VALUE' => 2 , 'NAME' => '已处理' , 'STATUS' => 1),
        ),
    ),
    //桌台信息
    'DESK_INFO'                 => array(
        //桌台分类
        'DESK_CATE'             => array(
            //包厢
            'BOX'         => array('VALUE' => 1 , 'NAME' => '包厢' , 'STATUS' => 1),
            //散座
            'SEATS'       => array('VALUE' => 2 , 'NAME' => '散座' , 'STATUS' => 1),
            //卡座
            'CASSETTE'    => array('VALUE' => 3 , 'NAME' => '卡座' , 'STATUS' => 1),
        ),
        //桌台状态
        'DESK_STATUS'             => array(
            //空台
            'EMPTY_DESK'         => array('VALUE' => 1 , 'NAME' => '空台' , 'STATUS' => 1),
            //占用
            'OCCUPY'             => array('VALUE' => 2 , 'NAME' => '占用' , 'STATUS' => 1),
            //使用中
            'USE_IN'             => array('VALUE' => 3 , 'NAME' => '使用中' , 'STATUS' => 1),
            //维修
            'REPAIR'             => array('VALUE' => 4 , 'NAME' => '维修' , 'STATUS' => 1),
            //待落单
            'STAY'               => array('VALUE' => 5 , 'NAME' => '待落单' , 'STATUS' => 1),
        ),
    ),
    //订单详情
    'ORDER_INFO'                  => array(
        //订单类型
        'ORDER_TYPE'            => array(
            //堂食点餐
            'STDC'              => array('VALUE' => 1 , 'NAME' => '堂食点餐' , 'STATUS' => 1),
            //霸王餐
            'BWC'               => array('VALUE' => 2 , 'NAME' => '霸王餐' , 'STATUS' => 1),
            //限量套餐
            'XLTC'              => array('VALUE' => 3 , 'NAME' => '限量套餐' , 'STATUS' => 1),
        ),
        //订单性质,0:正常订单,1:合并订单主订单,2:合并订单子订单,3:待安排
        'ORDER_NATURE'          => array(
            //正常订单
            'NORMAL'            => array('VALUE' => 0 , 'NAME' => '正常订单' , 'STATUS' => 1),
            //合并订单主订单
            'MAIN'              => array('VALUE' => 1 , 'NAME' => '合并订单主订单' , 'STATUS' => 1),
            //合并订单子订单
            'CHILD'             => array('VALUE' => 2 , 'NAME' => '合并订单子订单' , 'STATUS' => 1),
            //待安排
            'STAY'              => array('VALUE' => 3 , 'NAME' => '待安排' , 'STATUS' => 1),
        ),
        //限量套餐状态
        'XL_STATUS'             => array(
            //未验证
            'NOT_VERIFY'        => array('VALUE' => 1 , 'NAME' => '未验证' , 'STATUS' => 1),
            //已验证
            'IS_VERIFY'         => array('VALUE' => 2 , 'NAME' => '已验证' , 'STATUS' => 1),
            //已退单
            'CANCEL'            => array('VALUE' => 3 , 'NAME' => '已退单' , 'STATUS' => 1),
        ),
        //霸王餐状态
        'BWC_STATUS'             => array(
            //未验证
            'NOT_VERIFY'        => array('VALUE' => 1 , 'NAME' => '未验证' , 'STATUS' => 1),
            //已验证
            'IS_VERIFY'         => array('VALUE' => 2 , 'NAME' => '已验证' , 'STATUS' => 1),
        ),
        //订单状态,1:待确认,2:已确认,3:金额待确认,4:金额已确认,5:已买单,6:已退单,7:已过期
        'ORDER_STATUS'            => array(
            //待确认
            'NOT_CONFIRM'              => array('VALUE' => 1 , 'NAME' => '待确认' , 'STATUS' => 1),
            //已确认
            'IS_CONFIRM'               => array('VALUE' => 2 , 'NAME' => '已确认' , 'STATUS' => 1),
            //金额待确认
            'MONEY_NOT_CONFIRM'        => array('VALUE' => 3 , 'NAME' => '金额待确认' , 'STATUS' => 1),
            //金额已确认
            'MONEY_IS_CONFIRM'         => array('VALUE' => 4 , 'NAME' => '金额已确认' , 'STATUS' => 1),
            //已买单 
            'IS_CHECK'                 => array('VALUE' => 5 , 'NAME' => '已买单' , 'STATUS' => 1),
            //已退单（已取消）
            'IS_BACK'                  => array('VALUE' => 6 , 'NAME' => '已退单' , 'STATUS' => 1),
            //已过期
            'EXPIRE'                   => array('VALUE' => 7 , 'NAME' => '已过期' , 'STATUS' => 1),
        ),
    ),
    //订单菜品
    'ORDER_FOOD_INFO'           => array(
        //菜品类型
        'UP_TYPE'       => array(
            //叫停
            'STOP'          => array('VALUE' => 1 , 'NAME' => '叫停' , 'STATUS' => 1),
            //起菜
            'UP'            => array('VALUE' => 2 , 'NAME' => '起菜' , 'STATUS' => 1),
        ),
        //菜品类型
        'DETAIL_TYPE'       => array(
            //菜品
            'FOOD'          => array('VALUE' => 1 , 'NAME' => '菜品' , 'STATUS' => 1),
            //套餐
            'PACK'          => array('VALUE' => 2 , 'NAME' => '套餐' , 'STATUS' => 1),
            //套餐子菜品
            'PACK_CHILD'    => array('VALUE' => 3 , 'NAME' => '套餐子菜品' , 'STATUS' => 1),
        ),
        //菜品状态
        'DETAIL_STATUS'       => array(
            //待确认
            'NOT_CONFIRM'          => array('VALUE' => 1 , 'NAME' => '待确认' , 'STATUS' => 1),
            //已确认（已下厨）
            'IS_CONFIRM'           => array('VALUE' => 2 , 'NAME' => '已下厨' , 'STATUS' => 1),
            //已取消
            'CANCEL'               => array('VALUE' => 3 , 'NAME' => '已取消' , 'STATUS' => 1),
        ),
    ),
    //员工信息
    'STAFF_INFO'                => array(
        //工作状态
        'IS_WORKER'             => array(
            //下班
            'DOWN_WORKER'               => array('VALUE' => 0 , 'NAME' => '下班' , 'STATUS' => 1),
            //上班
            'UP_WORKER'                 => array('VALUE' => 1 , 'NAME' => '上班' , 'STATUS' => 1),
        ),
        //员工状态
        'STAFF_STATUS'             => array(
            //正常
            'NORMAL'                    => array('VALUE' => 1 , 'NAME' => '正常' , 'STATUS' => 1),
            //2:已停用
            'DISABLE'                   => array('VALUE' => 2 , 'NAME' => '已停用' , 'STATUS' => 1),
            //删除
            'DELETE'                    => array('VALUE' => 99 , 'NAME' => '删除' , 'STATUS' => 1),
        ),
    ),
    //霸王餐报名
    'BWC_ENROLL'                    => array(
        //中奖后状态,1:未消费,2:已消费
        'WINNER_STATUS'       => array(
            //未消费
            'NOT_USE'      => array('VALUE' => 1 , 'NAME' => '未消费' , 'STATUS' => 1),
            //已消费
            'IS_USE'       => array('VALUE' => 2 , 'NAME' => '已消费' , 'STATUS' => 1),
        ),
    ),
    //员工推荐
    'STAFF_RECOMMEND'           => array(
        //推荐状态
        'RECOMM_STATUS'     => array(
            //有效
            'YES'  => array('VALUE' => 1 , 'NAME' => '有效' , 'STATUS' => 1),
            //无效
            'NOT'  => array('VALUE' => 2 , 'NAME' => '无效' , 'STATUS' => 1),
        ),
    ),
    //店铺
    'SHOP_INFO'           => array(
        //店铺状态
        'SHOP_STATUS'     => array(
            //正常
            'NORMAL'    => array('VALUE' => 1 , 'NAME' => '正常' , 'STATUS' => 1),
            //已解约
            'EXPIRE'    => array('VALUE' => 2 , 'NAME' => '已解约' , 'STATUS' => 1),
            //已下架
            'OFFLINE'   => array('VALUE' => 3 , 'NAME' => '已下架' , 'STATUS' => 1),
            //已删除
            'DELETE'    => array('VALUE' => 99 , 'NAME' => '已删除' , 'STATUS' => 1),
        ),
    ),
);
?>