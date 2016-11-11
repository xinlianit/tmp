<?php

/**
 * @description of Base.class.php	分布式文件服务器操作类
 * @package Core\Components\File;
 * @link http://www.mashangchi.cn/
 * @author MSC PHP DEV TEAM Liangzy(szjava@126.com)
 * @createtime 2016年3月28日 下午6:17:27
 */
namespace Common\Lib\FastDFS\Client\Driver;


abstract class Base {

    /**
     * FastDFS数据包大小
     */
    const PROTO_PKG_LEN_SIZE = 8;
     
     /**
     * FastDFS头部大小
     */
    const HEADER_LENGTH      = 10;
     
     /**
     * FastDFS IP地址长度
     */
    const IP_ADDRESS_SIZE       = 16;
    const FILE_EXT_NAME_MAX_LEN = 6;
    const GROUP_NAME_MAX_LEN    = 16;
    const OVERWRITE_METADATA    = 1;
    const MERGE_METADATA        = 2;
     // 连接超时时间
    const CONNECT_TIME_OUT      = 5;
    const FILE_PREFIX_MAX_LEN   = 16;
     //传输超时时间
    const TRANSFER_TIME_OUT     = 5;


    /**
     * 命令码
     */
    // const PROTO_CMD_ACTIVE_TEST = 111;
    // const PROTO_CMD_RESP = 100;
    // const PROTO_CMD_UPLOAD_SLAVE_FILE = 21;
    // const PROTO_CMD_DELETE_FILE = 12;
    // const PROTO_CMD_GET_METADATA = 15;
    // const PROTO_CMD_SET_METADATA = 13;

    // //传输超时时间
    // const QUERY_STORE_WITHOUT_GROUP_ONE = 101;
    // const QUERY_STORE_WITH_GROUP_ONE    = 104;
    
    const TRACKER_PROTO_CMD_STORAGE_JOIN = 81;

    const PROTO_CMD_QUIT = 82;

    //storage heart beat
    const TRACKER_PROTO_CMD_STORAGE_BEAT = 83;

    //report disk usage
    const TRACKER_PROTO_CMD_STORAGE_REPORT_DISK_USAGE = 84;

    //repl new storage servers
    const TRACKER_PROTO_CMD_STORAGE_REPLICA_CHG = 85;

    //src storage require sync
    const TRACKER_PROTO_CMD_STORAGE_SYNC_SRC_REQ = 86;

    //dest storage require sync
    const TRACKER_PROTO_CMD_STORAGE_SYNC_DEST_REQ = 87;

    //sync done notify
    const TRACKER_PROTO_CMD_STORAGE_SYNC_NOTIFY = 88;

    //report src last synced time as dest server
    const TRACKER_PROTO_CMD_STORAGE_SYNC_REPORT = 89;

    //dest storage query sync src storage server
    const TRACKER_PROTO_CMD_STORAGE_SYNC_DEST_QUERY = 79;

    //storage server report it
    const TRACKER_PROTO_CMD_STORAGE_REPORT_IP_CHANGED = 78;

    //storage server request storage server's ip changed
    const TRACKER_PROTO_CMD_STORAGE_CHANGELOG_REQ = 77;

    //report specified storage server status's changelog
    const TRACKER_PROTO_CMD_STORAGE_REPORT_STATUS = 76;

    //storage server request parameters
    const TRACKER_PROTO_CMD_STORAGE_PARAMETER_REQ = 75;

    //storage report trunk free space
    const TRACKER_PROTO_CMD_STORAGE_REPORT_TRUNK_FREE = 74;

    //storage report current trunk file id
    const TRACKER_PROTO_CMD_STORAGE_REPORT_TRUNK_FID = 73;

    //storage get current trunk file id
    const TRACKER_PROTO_CMD_STORAGE_FETCH_TRUNK_FID = 72;

    //get storage status from tracker
    const TRACKER_PROTO_CMD_STORAGE_GET_STATUS = 71;

    //get storage server id from tracker
    const TRACKER_PROTO_CMD_STORAGE_GET_SERVER_ID = 70;

    //get all storage ids from tracker

    const TRACKER_PROTO_CMD_STORAGE_FETCH_STORAGE_IDS = 69;

    //start of tracker get system data files
    const TRACKER_PROTO_CMD_TRACKER_GET_SYS_FILES_START = 61;

    //end of tracker get system data files
    const TRACKER_PROTO_CMD_TRACKER_GET_SYS_FILES_END = 62;

    //tracker get a system data file
    const TRACKER_PROTO_CMD_TRACKER_GET_ONE_SYS_FILE = 63;

    //tracker get status of other tracker
    const TRACKER_PROTO_CMD_TRACKER_GET_STATUS = 64;

    //tracker ping leader
    const TRACKER_PROTO_CMD_TRACKER_PING_LEADER = 65;

    //notify next leader to other trackers
    const TRACKER_PROTO_CMD_TRACKER_NOTIFY_NEXT_LEADER = 66;

    //commit next leader to other trackers

    const TRACKER_PROTO_CMD_TRACKER_COMMIT_NEXT_LEADER = 67;

    const TRACKER_PROTO_CMD_SERVER_LIST_ONE_GROUP = 90;

    const TRACKER_PROTO_CMD_SERVER_LIST_ALL_GROUPS = 91;

    const TRACKER_PROTO_CMD_SERVER_LIST_STORAGE = 92;

    const TRACKER_PROTO_CMD_SERVER_DELETE_STORAGE = 93;

    const TRACKER_PROTO_CMD_SERVER_SET_TRUNK_SERVER = 94;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_STORE_WITHOUT_GROUP_ONE = 101;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_FETCH_ONE = 102;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_UPDATE = 103;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_STORE_WITH_GROUP_ONE = 104;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_FETCH_ALL = 105;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_STORE_WITHOUT_GROUP_ALL = 106;

    const TRACKER_PROTO_CMD_SERVICE_QUERY_STORE_WITH_GROUP_ALL = 107;

    const TRACKER_PROTO_CMD_RESP = 100;

    //active test, tracker and storage both support since V1.28
    const FDFS_PROTO_CMD_ACTIVE_TEST = 111;

    const STORAGE_PROTO_CMD_REPORT_SERVER_ID = 9;

    const STORAGE_PROTO_CMD_UPLOAD_FILE = 11;

    const STORAGE_PROTO_CMD_DELETE_FILE = 12;

    const STORAGE_PROTO_CMD_SET_METADATA = 13;

    const STORAGE_PROTO_CMD_DOWNLOAD_FILE = 14;

    const STORAGE_PROTO_CMD_GET_METADATA = 15;

    const STORAGE_PROTO_CMD_SYNC_CREATE_FILE = 16;

    const STORAGE_PROTO_CMD_SYNC_DELETE_FILE = 17;

    const STORAGE_PROTO_CMD_SYNC_UPDATE_FILE = 18;

    const STORAGE_PROTO_CMD_SYNC_CREATE_LINK = 19;

    const STORAGE_PROTO_CMD_CREATE_LINK = 20;

    const STORAGE_PROTO_CMD_UPLOAD_SLAVE_FILE = 21;

    const STORAGE_PROTO_CMD_QUERY_FILE_INFO = 22;

    //create appender file
    const STORAGE_PROTO_CMD_UPLOAD_APPENDER_FILE = 23;

    //append file
    const STORAGE_PROTO_CMD_APPEND_FILE = 24;

    const STORAGE_PROTO_CMD_SYNC_APPEND_FILE = 25;

    //fetch binlog of one store path
    const STORAGE_PROTO_CMD_FETCH_ONE_PATH_BINLOG = 26;

    const STORAGE_PROTO_CMD_RESP = self::TRACKER_PROTO_CMD_RESP;
    const STORAGE_PROTO_CMD_UPLOAD_MASTER_FILE = self::STORAGE_PROTO_CMD_UPLOAD_FILE;

    //since V3.00, storage to trunk server
    const STORAGE_PROTO_CMD_TRUNK_ALLOC_SPACE = 27;

    //since V3.00, storage to trunk server
    const STORAGE_PROTO_CMD_TRUNK_ALLOC_CONFIRM = 28;

    //since V3.00, storage to trunk server
    const STORAGE_PROTO_CMD_TRUNK_FREE_SPACE = 29;

    //since V3.00, trunk storage to storage
    const STORAGE_PROTO_CMD_TRUNK_SYNC_BINLOG = 30;

    //since V3.07, tracker to storage
    const STORAGE_PROTO_CMD_TRUNK_GET_BINLOG_SIZE = 31;

    //since V3.07, tracker to storage
    const STORAGE_PROTO_CMD_TRUNK_DELETE_BINLOG_MARKS = 32;

    //since V3.07, trunk storage to storage
    const STORAGE_PROTO_CMD_TRUNK_TRUNCATE_BINLOG_FILE = 33;

    //since V3.08
    const STORAGE_PROTO_CMD_MODIFY_FILE = 34;

    //since V3.08
    const STORAGE_PROTO_CMD_SYNC_MODIFY_FILE = 35;

    //since V3.08
    const STORAGE_PROTO_CMD_TRUNCATE_FILE = 36;

    //since V3.08
    const STORAGE_PROTO_CMD_SYNC_TRUNCATE_FILE = 37;

    //for overwrite all old metadata
    const STORAGE_SET_METADATA_FLAG_OVERWRITE     = 'O';
    const STORAGE_SET_METADATA_FLAG_OVERWRITE_STR = "O";
    //for replace, insert when the meta item not exist, otherwise update it
    const STORAGE_SET_METADATA_FLAG_MERGE         = 'M';
    const STORAGE_SET_METADATA_FLAG_MERGE_STR     = "M";

    const PROTO_CMD_SIZE = 1;

    // const FDFS_PROTO_IP_PORT_SIZE = (self::IP_ADDRESS_SIZE + 6);

    // const TRACKER_QUERY_STORAGE_FETCH_BODY_LEN = (self::GROUP_NAME_MAX_LEN \
    //                         + self::IP_ADDRESS_SIZE - 1 + self::PROTO_PKG_LEN_SIZE);
    // const TRACKER_QUERY_STORAGE_STORE_BODY_LEN = (self::GROUP_NAME_MAX_LEN \
    //                         + self::IP_ADDRESS_SIZE - 1 + self::PROTO_PKG_LEN_SIZE + 1);

    // const STORAGE_TRUNK_ALLOC_CONFIRM_REQ_BODY_LEN = (self::GROUP_NAME_MAX_LEN \
    //                         + sizeof(FDFSTrunkInfoBuff));

    //socket套接字
    protected $_sock;

    //连接主机地址
    protected $_host;

    //连接端口
    protected $_port;

    //错误代码
    protected $_errno;

    //错误信息
    protected $_errstr;

    // public function __construct($host, $port)
    // {

    //     $this->_host = $host;
    //     $this->_port = $port;
    //     $this->_sock = $this->_connect();
    // }

    // private function _connect()
    // {

    //     $sock = @fsockopen(
    //         $this->_host,
    //         $this->_port,
    //         $this->_errno, 
    //         $this->_errstr,
    //         self::CONNECT_TIME_OUT
    //     );

    //     if ( !is_resource($sock) )
    //         throw new Exception($this->_errstr, $this->_errno);

    //     return $sock;

    // }

    protected function send($data, $length = 0)
    {

        if (!$length) $length = strlen($data);

        // print_r($this->_sock);exit;
        if ( feof($this->_sock) 
            || fwrite( $this->_sock, $data, $length ) !== $length ) {

            $this->_error = 'connection unexpectedly closed (timed out?)';
            $this->_errno = 0;
            throw new Exception($this->_errstr, $this->_errno);
        }

        return TRUE;
    }

    protected function read($length)
    {

        if ( feof($this->_sock) ) {

            $this->_error = 'connection unexpectedly closed (timed out?)';
            $this->_errno = 0;
            throw new Exception($this->_errstr, $this->_errno);
        }

        $data = stream_get_contents($this->_sock, $length);

        assert( $length === strlen($data) );

        return $data;

    }

    final static function padding($str, $len) {

        $str_len = strlen($str);

        return $str_len > $len
            ? substr($str, 0, $len)
            : $str . pack('x'. ($len - $str_len));
    }

    final static function packHeader($command, $length = 0) {

        return self::packU64($length) . pack('Cx', $command);

    }

    final static function packMetaData($data) {
           
        $list = array();
        foreach($data as $key => $val) {
            $list[] = $key . "\x02" . $val;
        };

        return implode("\x01", $list);
    }

    final static function parseMetaData($data) {

        $arr    = explode("\x01", $data);
        $result = array();

        foreach($arr as $val) {
            list($k, $v) = explode("\x02", $val);
            $result[$k] = $v;
        }

        return $result;

    }    

    final static function parseHeader($str) {

        assert(strlen($str) === self::HEADER_LENGTH);


        $result = unpack('C10', $str);

        $length  = self::unpackU64(substr($str, 0, 8));
        $command = $result[9];
        $status  = $result[10];

        return array(
            'length'  => $length,
            'command' => $command,
            'status'  => $status
        );

    }

    /**
     * From: sphinxapi.php
     */
    final static function unpackU64($v) {
        list ( $hi, $lo ) = array_values ( unpack ( "N*N*", $v ) );

        if ( PHP_INT_SIZE>=8 )
        {
            if ( $hi<0 ) $hi += (1<<32); // because php 5.2.2 to 5.2.5 is totally fucked up again
            if ( $lo<0 ) $lo += (1<<32);

            // x64, int
            if ( $hi<=2147483647 )
                return ($hi<<32) + $lo;

            // x64, bcmath
            if ( function_exists("bcmul") )
                return bcadd ( $lo, bcmul ( $hi, "4294967296" ) );

            // x64, no-bcmath
            $C = 100000;
            $h = ((int)($hi / $C) << 32) + (int)($lo / $C);
            $l = (($hi % $C) << 32) + ($lo % $C);
            if ( $l>$C )
            {
                $h += (int)($l / $C);
                $l  = $l % $C;
            }

            if ( $h==0 )
                return $l;
            return sprintf ( "%d%05d", $h, $l );
        }

        // x32, int
        if ( $hi==0 )
        {
            if ( $lo>0 )
                return $lo;
            return sprintf ( "%u", $lo );
        }

        $hi = sprintf ( "%u", $hi );
        $lo = sprintf ( "%u", $lo );

        // x32, bcmath
        if ( function_exists("bcmul") )
            return bcadd ( $lo, bcmul ( $hi, "4294967296" ) );
        
        // x32, no-bcmath
        $hi = (float)$hi;
        $lo = (float)$lo;
        
        $q = floor($hi/10000000.0);
        $r = $hi - $q*10000000.0;
        $m = $lo + $r*4967296.0;
        $mq = floor($m/10000000.0);
        $l = $m - $mq*10000000.0;
        $h = $q*4294967296.0 + $r*429.0 + $mq;

        $h = sprintf ( "%.0f", $h );
        $l = sprintf ( "%07.0f", $l );
        if ( $h=="0" )
            return sprintf( "%.0f", (float)$l );
        return $h . $l;
    }

    /**
     * From: sphinxapi.php
     */
    final static function packU64 ($v) {

       
        assert ( is_numeric($v) );
        
        // x64
        if ( PHP_INT_SIZE>=8 )
        {
            assert ( $v>=0 );
            
            // x64, int
            if ( is_int($v) )
                return pack ( "NN", $v>>32, $v&0xFFFFFFFF );
                              
            // x64, bcmath
            if ( function_exists("bcmul") )
            {
                $h = bcdiv ( $v, 4294967296, 0 );
                $l = bcmod ( $v, 4294967296 );
                return pack ( "NN", $h, $l );
            }
            
            // x64, no-bcmath
            $p = max ( 0, strlen($v) - 13 );
            $lo = (int)substr ( $v, $p );
            $hi = (int)substr ( $v, 0, $p );
        
            $m = $lo + $hi*1316134912;
            $l = $m % 4294967296;
            $h = $hi*2328 + (int)($m/4294967296);

            return pack ( "NN", $h, $l );
        }

        // x32, int
        if ( is_int($v) )
            return pack ( "NN", 0, $v );
        
        // x32, bcmath
        if ( function_exists("bcmul") )
        {
            $h = bcdiv ( $v, "4294967296", 0 );
            $l = bcmod ( $v, "4294967296" );
            return pack ( "NN", (float)$h, (float)$l ); // conversion to float is intentional; int would lose 31st bit
        }

        // x32, no-bcmath
        $p = max(0, strlen($v) - 13);
        $lo = (float)substr($v, $p);
        $hi = (float)substr($v, 0, $p);
        
        $m = $lo + $hi*1316134912.0;
        $q = floor($m / 4294967296.0);
        $l = $m - ($q * 4294967296.0);
        $h = $hi*2328.0 + $q;

        return pack ( "NN", $h, $l );
    }

    public function __destruct() {

        if(is_resource($this->_sock))
            fclose($this->_sock);
    }
}

/**
 * 异常处理类
 */
class Exception extends \Exception
{

    /**
     * 构造器
     *
     * @param string = 
     */
    public function __construct($message = '', $code = 0) {}
}