<?php
return array(
	//'配置项'=>'配置值'
    'LAYOUT_ON'             =>  true, // 是否启用布局
    'LAYOUT_NAME'           =>  'layout', // 当前布局名称 默认为layout
    
    //登陆数据存储类型; session、redis、memcache
    'LOGIN_STORAGE_TYPE'        => 'session',
    
    //字段默认值
    'FIELD_DEFAULT_VALUE'       => '-',
    
    //每页显示行数
    'PAGE_SIZE'                 => 20,
    
    //权限验证配置
    'AUTH_CONFIG'=>array(
        'AUTH_ADMINISTRATOR'    => 'admin',                         //超级管理员
        'AUTH_KEY'              => 'login_token',                   //管理员登陆token
        'AUTH_SESSION_KEY'      => 'login_data',                    //管理员登陆信息存储Key
        'AUTH_ON'               => true,                            //认证开关
        'AUTH_TYPE'             => 1,                               // 认证方式，1为时时认证；2为登录认证。
        'AUTH_GROUP'            => 'pad_auth_group',                //用户组数据表名
        'AUTH_GROUP_ACCESS'     => 'pad_auth_group_access',         //用户组明细表
        'AUTH_RULE'             => 'pad_auth_rule',                 //权限规则表
        'AUTH_USER'             => 'pad_admin_info'                 //用户信息表
    ),
    
    //邮件服务配置
    'MAIL_SERVER'   => array(
        'CHARSET'           => 'UTF-8',                 //编码
        'PORT'              => 25,                      //端口
        'HOST'              => 'smtp.qq.com',           //主机
        'USER_NAME'         => '',      //用户名
        'PASSWORD'          => '',           //密码
        'NICK'              => '派锋科技-锋云时代',          //发送昵称
        'WORD_WRAP'         => 80,                      //自动换行
    ),
    
    /**
     * 搜索字段
     * @param string label          label标题
     * @param string name           input、select名称
     * @param string placeholder    input占位符
     * @param string type           form表单标签类型;input、select
     * @param string query_type     SQL查询类型；eq:=, like:like
     * @param string label_css      label 标签css样式
     * @param array defalut         默认值参数
     * @param string default.title  默认值标题
     * @param string|int default.value 默认值
     * @param array rule            逻辑处理规则
     * @param string rule.func      处理函数
     * @param array rule.params     处理函数参数
     */
    'SETCH_ITEM'        => array(
        //Admin 应用
        'ADMIN'     => array(
            //商户列表
            'SHOP_INDEX'    => array(
                array(
                    'label'         => '商户名称', 
                    'name'          => 'hotel_name', 
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input', 
                    'query_type'    => 'like',
                ),
            ),
            //楼层管理
            'SHOP_FLOOR'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
            ),
            //设备管理
            'SHOP_DEVICE'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'rule'          => array('func' => 'get_hotel_ids_by_name'),
                ),
                array(
                    'label'         => '设备地址',
                    'name'          => 'device_address',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'rule'          => array('func' => 'get_room_ids_by_address_version'),
                ),
                array(
                    'label'         => 'APP版本号',
                    'name'          => 'app_version',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'label_css'     => 'width:30%!important;',
                    'rule'          => array('func' => 'get_room_ids_by_address_version'),
                ),
                array(
                    'label'         => '房间类型',
                    'name'          => 'room_type',
                    'type'          => 'select',
                    'defalut'       => array('title' => '全部', 'value' => 0),
                    'options'       => 'get_field_status',
                    'params'        => array('ROOM_INFO', 'ROOM_TYPE'),
                    'item'          => array('title' => 'NAME', 'value' => 'VALUE'),
                    'query_type'    => 'eq',
                ),
            ),
            //酒店服务指南
            'SHOPSETTING_SERVICE'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'rule'          => array('func' => 'get_hotel_ids_by_name'),
                ),
            ),
            //WIFI服务
            'SHOPSETTING_WIFI'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'rule'          => array('func' => 'get_hotel_ids_by_name'),
                ),
            ),
            //服务电话
            'SHOPSETTING_TEL'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
            ),
            //客房服务
            'SHOPSETTING_ROOM'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
            ),
            //服务意见反馈
            'SHOPSETTING_QUEST'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'rule'          => array('func' => 'get_hotel_ids_by_name'),
                ),
            ),
            //权限节点
            'NODE_INDEX'    => array(
                array(
                    'label'         => '节点名称/规则',
                    'name'          => 'name',
                    'placeholder'   => '节点名称/节点规则',
                    'type'          => 'input',
                    'label_css'     => 'width:36%!important;',
                    'rule'          => array('func' => 'get_query_by_name'),
                ),
                array(
                    'label'         => '模块/控制器',
                    'name'          => 'pid',
                    'type'          => 'select',
                    'defalut'       => array('title' => '全部', 'value' => 0),
                    'options'       => 'get_module_controller_node',
                    'params'        => '',
                    'label_css'     => 'width:36%!important;',
                    'item'          => array('title' => 'name', 'value' => 'id'),
                ),
            ),
            //用户管理
            'NODE_USER'    => array(
                array(
                    'label'         => '所属组',
                    'name'          => 'group_id',
                    'type'          => 'select',
                    'defalut'       => array('title' => '全部', 'value' => 0),
                    'options'       => 'get_group',
                    'params'        => '',
                    'item'          => array('title' => 'title', 'value' => 'id'),
                    'rule'          => array('func' => 'get_admin_ids_by_group_id'),
                ),
                array(
                    'label'         => '账号',
                    'name'          => 'admin_account',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
                array(
                    'label'         => '姓名',
                    'name'          => 'admin_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
                array(
                    'label'         => '手机号',
                    'name'          => 'admin_mobile',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
            ),
            //组别管理
            'NODE_GROUP'    => array(
                array(
                    'label'         => '组别名称',
                    'name'          => 'title',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                ),
            ),
            //商户账号管理
            'NODE_MERCHANT'    => array(
                array(
                    'label'         => '商户名称',
                    'name'          => 'hotel_name',
                    'placeholder'   => '支持模糊查询',
                    'type'          => 'input',
                    'query_type'    => 'like',
                    'rule'          => array('func' => 'get_hotel_ids_by_name'),
                ),
            ),
        ),
    ),
    
    //表状态字段数据
    'STATUS_FIELD'              => array(
        //管理员
        'ADMIN_INFO'       =>array(
            //状态
            'DATA_STATUS'       => array(
                'VALUE_1'       => array('NAME'   =>'正常',     'VALUE' => 1),
                'VALUE_2'       => array('NAME'   =>'已停用',     'VALUE' => 2),
                'VALUE_99'       => array('NAME'   =>'删除',     'VALUE' => 99),
            ),
        ),
        //房间
        'ROOM_INFO'      => array(
            //房间类型
            'ROOM_TYPE'     => array(
                'VALUE_1'     => array('NAME'   =>'客房',     'VALUE' => 1),
                'VALUE_2'     => array('NAME'   =>'管家部',    'VALUE' => 2),
                'VALUE_3'     => array('NAME'   =>'前台',     'VALUE' => 3),
            ),     
        ),
        //WIFI服务
        'WIFI_SERVICE'      => array(
            //连接方式
            'LINK_METHOD'       => array(
                'VALUE_1'     => array('NAME'   =>'账号密码',     'VALUE' => 1),
                'VALUE_2'     => array('NAME'   =>'商户二维码',     'VALUE' => 2),
                'VALUE_3'     => array('NAME'   =>'短信认证',     'VALUE' => 3),
            ),
        ),
        //酒店员工
        'STAFF_INFO'        => array(
            //账号类型
            'ACCOUNT_TYPE'     => array(
                'VALUE_1'     => array('NAME'   =>'管家部服务员',     'VALUE' => 1),
                'VALUE_2'     => array('NAME'   =>'客房服务员',     'VALUE' => 2),
            ),
            //状态
            'DATA_STATUS'       => array(
                'VALUE_1'       => array('NAME'   =>'正常',     'VALUE' => 1),
                'VALUE_2'       => array('NAME'   =>'已停用',     'VALUE' => 2),
                'VALUE_99'       => array('NAME'   =>'删除',     'VALUE' => 99),
            ),
        ),
        //酒店详情
        'HOTEL_INFO'            => array(
            //接口类型
            'INTERFACE_TYPE'        => array(
                'VALUE_1'       => array('NAME'   =>'西软XMS',     'VALUE' => 1),
                'VALUE_2'       => array('NAME'   =>'西软X系列',     'VALUE' => 2),
                'VALUE_3'       => array('NAME'   =>'西软SMART系列',     'VALUE' => 3),
            ),
        ),
    ),
);