<?php
/**
 * @description of FastDFSClient.class.php	分布式文件服务器操作类
 * @package Core\Components\File;
 * @link http://www.mashangchi.cn/
 * @author MSC PHP DEV TEAM Liangzy(szjava@126.com)
 * @createtime 2016年3月28日 下午6:17:27
 */


namespace Common\Lib\FastDFS\Client;

class FastDFSClient
{

    public $config = array();

    /**
     *
     * @var Tracker
     */
    private $tracker = null;

    /**
     *
     * @var Storage
     */
    private $storage = null;

    private $error = array(
        'code' => 0,
        'msg' => '',
    );

    /**
     * 
     */
    public function __construct() {
        
    }

    /**
     * 获得一个tracker
     * 
     * @return \Tracker
     */
    public function connect_server($tracker_host, $tracker_port = 22122, $tracker_timeout = 10) {
        $this->server = array(
            'host'    => $tracker_host,
            'port'    => $tracker_port,
            'timeout' => $tracker_timeout,
        );
        $this->tracker = new Driver\Tracker($tracker_host, $tracker_port, $tracker_timeout);

        return $this->tracker;
    }

    /**
     * 获得一个tracker
     * 
     * @return \Tracker
     */
    public function tracker_get_connection() {
        $this->tracker = new Driver\Tracker($this->server['host'], $this->server['port']);

        return $this->tracker;
    }

    /**
     * 通过tracker获取一个stroage
     * 
     * @param string $groupName 文件组名，当为空时，组名由tracker决定
     * @param Tracker $tracker
     * @return Storage
     */
    public function tracker_query_storage_store($groupName, Driver\Tracker $tracker) {
        // $this->storage = new Storage($this, $groupName, $tracker);
        $this->storage = new Driver\Storage($groupName, $tracker);

        return $this->storage;
    }
    public function storage_file_exist($groupName, $remoteFilename,
            Driver\Tracker $tracker, Driver\Storage $storage) {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        return $this->storage->getFileInfo($groupName, $remoteFilename);
    }

    public function set_error_and_return($errno, $message, $flag = false) {
        $this->error['code'] = $errno;
        $this->error['msg']  = $message;

        return $flag;
    }

    public function get_last_error_no() {
        return $this->error['code'];
    }

    public function get_last_error_info() {
        return $this->error['msg'];
    }

    /**
     * 往storage中上传一个文件
     * 
     * @param string $localFile 你本地的文件路径
     * @param string $extName 文件的扩展名，当名优提供扩展名时，会自动取文件的扩展名
     * @param array $metas 文件的附加信息
     * @param string $groupName 所在的组名，可以为空，为空时，由tracker决定
     * @param Tracker $tracker
     * @param Storage $storage
     */
    public function storage_upload_by_filename($localFile, $extName = '', $metas = array(), $groupName = '', Driver\Tracker $tracker = null, Driver\Storage $storage = null) {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->uploadFile($localFile, $extName, $metas);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    public function storage_upload_by_filebuff($fileBuff, $extName = '', $metas = array(), $groupName = '', Driver\Tracker $tracker = null, Driver\Storage $storage = null) {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->uploadFileByBuff($fileBuff, $extName, $metas);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    public function storage_download_file_to_file($groupName, $remoteFileName, $localFileName, $offset=0,
            $length=0, Driver\Tracker $tracker = null, Driver\Storage $storage = null){
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->downloadFile($groupName, $remoteFileName, $localFileName, $offset, $length);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    public function storage_download_file_to_buff($groupName, $remoteFileName, $offset=0,
            $length=0, Driver\Tracker $tracker = null, Driver\Storage $storage = null){
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->downloadFileToBuff($groupName, $remoteFileName, $offset, $length);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    /**
     * 上传一个文件的附属文件，主要使用一个图片有缩略图的情况下
     * 
     * @param string $localFile 本地文件的路径，缩略图的文件路径
     * @param string $groupName 组名，最好和主文件在同一个组
     * @param string $masterFileName 主文件名
     * @param string $prefix 文件的前缀
     * @param string $extName 文件的后缀，可以为空，为空时，由tracker决定
     * @param array $meta 附件信息
     * @param Tracker $tracker
     * @param Storage $storage
     */
    public function storage_upload_slave_by_filename($localFile, $groupName, $masterFileName, $prefix = '', $extName = '', $meta = array(), Driver\Tracker $tracker = null, Driver\Storage $storage = null)
    {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);
        /*echo $localFile."<br/>".$groupName."<br/>".$masterFileName."<br/>".$prefix;
        exit;*/
        try {
            return $this->storage->uploadSlaveFile($localFile, $masterFileName, $prefix, $extName, $meta);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    /**
     * 
     */
    public function storage_upload_slave_by_filebuff($fileBuff, $groupName, $masterFileName, $prefix = '', $extName = '', $meta = array(), Driver\Tracker $tracker = null, Driver\Storage $storage = null)
    {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->uploadSlaveFileByBuff($fileBuff, $masterFileName, $prefix, $extName, $meta);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    public function storage_delete_file($groupName, $remoteFileName, $tracker, $storage)
    {
        $this->initTrackerAndStorage($tracker, $storage, $groupName);

        try {
            return $this->storage->deleteFile($groupName, $remoteFileName);
        } catch (\Exception $e) {
            return $this->set_error_and_return($e->getCode(), $e->getMessage());
        }
    }

    private function initTrackerAndStorage(Driver\Tracker $tracker = null, Driver\Storage $storage = null, $groupName = '') {
        $reNewStorage = false;
        if ($tracker && $tracker !== $this->tracker) {
            $this->tracker_get_connection();
        }
        if (($storage && $storage !== $this->storage) || $reNewStorage) {
            $this->tracker_query_storage_store($groupName, $this->tracker);
        }
    }
}