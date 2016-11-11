<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用入口文件

// 检测PHP环境
if(version_compare(PHP_VERSION,'5.3.0','<'))  die('require PHP > 5.3.0 !');

/**
 * @todo 部署环境	develop--开发环境   product--运营环境
 */
define('APP_STATUS', isset($_SERVER['ENVIRON']) ? $_SERVER['ENVIRON'] : 'develop');

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG', (APP_STATUS == 'develop')  ?true : false);

// 定义应用目录
define('APP_PATH','../Application/');

// 定义第三方应用库
define('APP_LIBRARY', APP_PATH.'Common/Lib/');


// 引入ThinkPHP入口文件
require '../Core/ThinkPHP.php';

// 亲^_^ 后面不需要任何代码了 就是如此简单