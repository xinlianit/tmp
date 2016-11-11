<?php
/**
 * Cache.class.php - 专门处理缓存类
 * @package Common\Cache
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年10月31日 上午11:35
 * @version V1.0.0
 */

namespace Common\Cache;

class RapiCache {
    private $_key = 'DATA::ROOM::API::INFO';
    /**
     * 用户信息
     * @access public
     * @param String $user_token  用户令牌
     * @param array/string $val 默认值
     * @return boolea/array
     */
    public function getStaffByToken($user_token, $val = null){
        if(isset($user_token) && !empty($user_token)) {
            $key = sprintf('%s::%s', $this->_key, $user_token);

            //读取当前缓存
            $info = S($key);
            if (isset($info) && !empty($info)) {
                return $info;
            }
        }
        
        return $val;
    }
}