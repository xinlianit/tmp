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
    )
);