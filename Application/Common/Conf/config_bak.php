<?php
return array(
    /* 数据库设置 */
    'DB_TYPE'               =>  'mysql',     // 数据库类型
    //'DB_HOST'               =>  '192.168.1.180', // 服务器地址
    //'DB_HOST'               =>  '192.168.1.251',
    //'DB_HOST'               =>  '192.168.1.252', // 服务器地址
    'DB_HOST'               =>  '192.168.1.252,192.168.1.251', // 服务器地址
    'DB_NAME'               =>  'pad_shop',          // 数据库名
    'DB_USER'               =>  'phper',      // 用户名
    'DB_PWD'                =>  'izzpsVLeH5xCvRvJ',          // 密码
    'DB_PORT'               =>  '3306',        // 端口
    'DB_PREFIX'             =>  'pad_',    // 数据库表前缀
    'DB_PARAMS'             =>  array(), // 数据库连接参数    
    'DB_DEBUG'  	    =>  TRUE, // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  false,        // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',      // 数据库编码默认采用utf8
    'DB_DEPLOY_TYPE'        =>  1, // 数据库部署方式:0 集中式(单一服务器),1 分布式(主从服务器)
    'DB_RW_SEPARATE'        =>  true,       // 数据库读写是否分离 主从式有效
    'DB_MASTER_NUM'         =>  1, // 读写分离后 主服务器数量
    'DB_SLAVE_NO'           =>  '', // 指定从服务器序号
    
    'MODULE_ALLOW_LIST'    =>    array('Home','Admin','Api','Cli'),
    'DEFAULT_MODULE'       =>    'Home',
    
    'URL_MODEL'             =>  1,       // URL访问模式,可选参数0、1、2、3,代表以下四种模式：
    
    'APP_SUB_DOMAIN_DEPLOY'   => true, // 开启子域名或者IP配置
    'APP_SUB_DOMAIN_RULES'    =>    array( 
        /* 域名部署配置 
        *格式1: '子域名或泛域名或IP'=> '模块名[/控制器名]'; 
        *格式2: '子域名或泛域名或IP'=> array('模块名[/控制器名]','var1=a&var2=b&var3=*'); 
        */ 
        'www.l_hotel.my'=>'Admin',
        'api.demo.com'=>'Api',
    
    'SIGNKEY'               =>  '123123',//APP 公钥

    ),

    
    //缓存配置
    'DATA_CACHE_PREFIX' => 'Redis_',//缓存前缀
    'DATA_CACHE_TYPE'=>'Redis',//默认动态缓存为Redis
    'DATA_CACHE_TIME'       => 24*60*60,      // 数据缓存有效期 0表示永久缓存
    
    //Redis 配置
    'REDIS_RW_SEPARATE' => false, //Redis读写分离 true 开启
    'REDIS_HOST'=>'192.168.1.252', //redis服务器ip，多台用逗号隔开；读写分离开启时，第一台负责写，其它[随机]负责读；
    'REDIS_PORT'=>'6379',//端口号
    'REDIS_TIMEOUT'=>'300',//超时时间
    
    
    'SHOW_PAGE_TRACE' => true,//显示页面调试信息
    
    //资源服务器
    'FASTDFS_SERVER' => array(
        array(
            'host' => '192.168.1.252',
            'port' => '22122',
        ),
    ),

);