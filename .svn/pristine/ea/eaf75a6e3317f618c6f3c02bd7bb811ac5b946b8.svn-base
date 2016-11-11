<?php

/**
 * File.class.php - 文件处理类
 * @package Common\Api
 * @subpackage
 * @link http://www.pad-phone.com/
 * @author PHP DEV TEAM Zhaoxizhan(441534536@qq.com)
 * @copyright 派锋科技 2016年11月3日 上午11:35
 * @version V1.0.0
 */


namespace Common\Api;

class FileApi{	
	
	//普通文件
	const FILE_TYPE_COMMON  		= 10;	
	//普通图片
	const IMAGE_TYPE_COMMON                 = 20;
        //普通视频
	const VIDEO_TYPE_COMMON                 = 30;
	
        //错误码
	private static $_errno = 0;	
        //错误描述
	private static $_errstr = '';
	
	/**
	 * 上传文件分组
	 */
	public static $file_type_groups = array(
            self::IMAGE_TYPE_COMMON     => 'group1', 
            self::FILE_TYPE_COMMON      => 'group1',
            self::VIDEO_TYPE_COMMON     => 'group1',
			
	);	
	
	/**
	 * 允许上传的文件扩展名
	 */
	private static $allow_extentions = array(
			'file' => array('doc', 'xls', 'docx','xlsx'),
			'image' => array('jpg', 'jpeg', 'png', 'gif'),
                        'video' => array('3gp', 'mp4'),
	);	
	
	/**
	 * 错误类型码
	 */
	const ERROR_REMOTE_FILE_NOT_EXISTS = 1001;
	const ERROR_LOCAL_FILE_NOT_EXISTS  = 1002;
	const ERROR_FILE_TYPE_NOT_ALLOW_UPLOAD = 1003;
	
	/**
	 * 文件上传
	 * @param  string $uploadFile 上传文件路径
	 * @param  int    $type 上传文件类型：10:普通文件 20:普通图片 30:普通视频
	 * @return array  $result 失败返回false，成功返回数组
         *          array(
         *              groupname => 组名
	 *              filename   => 文件名
	 *              fullname   => 文件全名，包含组名
         *          )       
	 */
	public static function uploadFile($uploadFile, $type = self::IMAGE_TYPE_COMMON) {
                //文件所属组名
		$group_name = self::$file_type_groups[$type];
                //是否删除临时文件
		$is_clean_file = false;
                //对网络文件的处理
		if (!file_exists($uploadFile)) {
			if (preg_match('/^https?:\/\//', $uploadFile)) {
                                //网络图片请求
                                
				$res = \Common\Lib\Curl\MyCurl::send($uploadFile,array(),'get');
				if ($res !== false) {
					$uploadFile = tempnam(RUNTIME_PATH . 'Temp', 'remote_');
					file_put_contents($uploadFile, $res);
					$is_clean_file = true;
				} else {
                                    //网络资源不存在
                                    return self::set_error_and_return(self::ERROR_REMOTE_FILE_NOT_EXISTS, 'remote file not exists');
				}
			} else {
                            //本地资源不存在
                            return self::set_error_and_return(self::ERROR_LOCAL_FILE_NOT_EXISTS, 'local file not exists');
			}
		}
                	
		/**
		 * 初始化文件
		 */
            
		$file = new \Common\Lib\FastDFS\FastDFS();
		$file->open($group_name);
		$result = $file->uploadFile($group_name, $uploadFile);
	
		if ($result === false){
			return self::set_error_and_return($file->get_last_error_no(), $file->get_last_error_info());
		}
		$fullname =  $result['groupname'] . '/' . $result['filename'];
		$result['fullname'] = $fullname;
	
		if ($is_clean_file) {
		    unlink($uploadFile);
		}
	
		return $result;
	}
	
	
	/**
	 * 生成缩略图入口 
	 * @param $string $uploadFile 要处理的原图片
	 * @param $string $master_filename 主文件名
	 * @param type $width
	 * @param type $height
	 * @param type $type
	 * @return array  $result 
	 *	    失败返回false，
	 *	    成功返回数组
	 *                group_name 组名
	 *                filename   文件名 M00/00/04/wKgC-1cMXfuAd9u8AACJg144DQE165_300x300.jpg
	 *                fullname   文件全名，包含组名
	 */
	public static function makeThumb($uploadFile,$master_filename,$width,$height, $type = self::IMAGE_TYPE_COMMON,$quality=75){
	    //参数验证
	    if(!$uploadFile || !intval($width) || !intval($height)){
		return false;
	    }
	    //文件所属组
	    $group_name = self::$file_type_groups[$type];
	    //
	    $is_clean_file = false;
	    if (!file_exists($uploadFile)) {
		    if (preg_match('/^https?:\/\//', $uploadFile)) {
			    $res = Common::sendHttp($uploadFile);
			    if ($res !== false) {
				    $uploadFile = tempnam(RUNTIME_PATH . 'Temp', 'remote_');
				    file_put_contents($uploadFile, $res['body']);
				    $is_clean_file = true;
				    $del_uploadFile = $uploadFile;
			    } else {
				    return self::set_error_and_return(self::ERROR_REMOTE_FILE_NOT_EXISTS, 'remote file not exists');
			    }
		    } else {
			    return self::set_error_and_return(self::ERROR_LOCAL_FILE_NOT_EXISTS, 'local file not exists');
		    }
	    }
	    
            $file_ext = self::getFileExt($uploadFile);
	    
	    if (!in_array($file_ext, self::$allow_extentions['image'])) {
		    return self::set_error_and_return(self::ERROR_FILE_TYPE_NOT_ALLOW_UPLOAD, '该文件类型不允许上传');
	    }    
            
	    //生成原始图片临时图 用于做缩略图
	    $_rand = time().rand();
	    $src_img = RUNTIME_PATH . 'Temp/' . $_rand . '.'.$file_ext;
	    $handle = fopen($uploadFile, "rb");
	    $contents = fread($handle, filesize ($uploadFile));
	    fclose($handle);
	    file_put_contents($src_img, $contents);	
	    
	    //在指定目录生成临时缩略图
	    $dst_img = RUNTIME_PATH . 'Temp/' . $_rand . '_thumb.'.$file_ext;
	    $resize_image = new \Common\Lib\Image\Resize();
	    $resize_image->create($src_img, $width, $height, 1, $dst_img,$quality);
	    
	    
	    $file = new \Common\Lib\FastDFS\FastDFS();
	    $file->open($group_name);	    
	    $result = $file->uploadSlaveFile($group_name, $dst_img,$master_filename,'_'.$width.'x'.$height, $file_ext);		
     
            //缩略图生成失败
	    if ($result === false){
                return self::set_error_and_return($file->get_last_error_no(), $file->get_last_error_info());
	    }		    
	    $result['fullname'] = $result['groupname'] . '/' . $result['filename'];//图片完整路径

	    if ($is_clean_file) {
		unlink($del_uploadFile);
	    }
	    unlink($src_img);
	    unlink($dst_img);
	    
	    return $result;
	}
        
        /**
         * 判断文件是否存在
         * @param string $groupname 分组名
         * @param string $filename  文件名
         * @return boolean
         */
        public static function fileExists($groupname, $filename){
            $file = new \Common\Lib\FastDFS\FastDFS();
	    return $file->fileExists($groupname,$filename);	
        }
        
        /**
         * 删除文件
         * @param string $groupname 分组名
         * @param string $filename  文件名
         * @return boolean
         */
        public static function deleteFile($groupname, $filename){
            $file = new \Common\Lib\FastDFS\FastDFS();
	    return $file->deleteFile($groupname,$filename);	
        }

        /**
	 * 设置错误信息
	 * @access  private
	 */
	private static function set_error_and_return($errno, $errmes, $return = false)
	{
		self::$_errno = $errno;
		self::$_errstr = $errmes;
	
		return $return;
	}
	
	/**
	 * 获取错误号
	 */
	public static function get_last_error_no()
	{
		return self::$_errno;
	}
	
	/**
	 * 获取错误信息
	 */
	public static function get_last_error_info()
	{
		return self::$_errstr;
	}
        
        /**
	 * 获取文件扩展名
	 */
	public static function getFileExt($filename)
	{
		/**
		 * 文件类型
		 */
		$finfo = finfo_open(FILEINFO_MIME_TYPE);                
		$mime_type = finfo_file($finfo, $filename);
		finfo_close($finfo);

		$mime_types = array(
				'text/plain' => 'txt',
				'text/html' => 'htm',
				'text/html' => 'html',
				'text/html' => 'php',
				'text/css' => 'css',
				'application/javascript' => 'js',
				'application/json' => 'json',
				'application/xml' => 'xml',
				'application/x-shockwave-flash' => 'swf',
				'video/x-flv' => 'flv',
	
				// images
				'image/png' => 'png',
				'image/jpeg' => 'jpe',
				'image/jpeg' => 'jpeg',
				'image/jpeg' => 'jpg',
				'image/gif' => 'gif',
				'image/bmp' => 'bmp',
				'image/vnd.microsoft.icon' => 'ico',
				'image/tiff' => 'tiff',
				'image/tiff' => 'tif',
				'image/svg+xml' => 'svg',
				'image/svg+xml' => 'svgz',
	
				// archives
				'application/zip' => 'zip',
				'application/x-rar-compressed' => 'rar',
				'application/x-msdownload' => 'exe',
				'application/x-msdownload' => 'msi',
				'application/vnd.ms-cab-compressed' => 'cab',
	
				// audio/video
				'audio/mpeg' => 'mp3',
				'video/quicktime' => 'qt',
				'video/quicktime' => 'mov',
	
				// adobe
				'application/pdf' => 'pdf',
				'image/vnd.adobe.photoshop' => 'psd',
				'application/postscript' => 'ai',
				'application/postscript' => 'eps',
				'application/postscript' => 'ps',
	
				// ms office
				'application/msword' => 'doc',
				'application/rtf' => 'rtf',
				'application/vnd.ms-excel' => 'xls',
				'application/vnd.ms-powerpoint' => 'ppt',
	
				// open office
				'application/vnd.oasis.opendocument.text' => 'odt',
				'application/vnd.oasis.opendocument.spreadsheet' => 'ods',
                    
                                //apk
                                'application/jar'=>'apk',
                                'application/java-archive'=>'apk'
		);
	
	
		if (isset($mime_types[$mime_type])) {
			$extention = $mime_types[$mime_type];
		} else {
			$extention = '';
		}
	
		return $extention;
	}
}