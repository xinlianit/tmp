<?php

/**
 * @description of Tracker.class.php	分布式文件服务器操作类
 * @package Core\Components\File;
 * @link http://www.mashangchi.cn/
 * @author MSC PHP DEV TEAM Liangzy(szjava@126.com)
 * @createtime 2016年3月28日 下午6:17:27
 */

namespace Common\Lib\FastDFS\Client\Driver;



class Tracker extends Base
{

    public function __construct($host, $port, $timeout) {
        $this->host    = $host;
        $this->port    = $port;
        $this->timeout = $timeout;

        $this->_sock = @fsockopen("tcp://$host", $port, $errno, $errstr, $timeout);
        if (!$this->_sock) {
            throw new \Exception($errstr, -2);
        }
    }

}