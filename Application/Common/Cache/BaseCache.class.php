<?php
/**
 * BaseCache.class.php - 专门处理缓存类-基类 缓存键的定义
 * @package Common\Case
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年10月31日 上午11:35
 * @version V1.0.0
 */

namespace Common\Cache;

class BaseCache {
    
    //商品详情缓存键名前缀
    public static $KEY_GOODS_INFO = 'DATA::GOOGS::INFO::ID_';
    
    //系统图标详情
    public static $KEY_ICON_INFO  = 'DATA::ICON::INFO::ID_';

}