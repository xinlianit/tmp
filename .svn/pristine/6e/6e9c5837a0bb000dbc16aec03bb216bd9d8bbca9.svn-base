<?php

namespace Admin\Controller;

use Admin\Controller\CommonController;

class TestController extends CommonController {

    public function __construct() {
        parent::__construct();
        header("Content-type:text/html;charset=utf-8");
    }

    public function testRedis() {

        S('name', 111);
        dump(S('name'));
    }

    public function testDfs() {
        //\Think\Log::write('测试日志信息，Dfs开始','INFO');
        logs('测试日志信息，Dfs开始');
        logs('测试日志信息，Dfs结束' . json_encode(array('1', '3')));
        $filename = '1.png';
        $rs = D('File', 'Api')->uploadFile($filename);
        dump($rs);

        $rs2 = D('File', 'Api')->makeThumb($filename, $rs['filename'], 50, 50);
        dump($rs2);

        $rs31 = D('File', 'Api')->fileExists($rs['groupname'], $rs['filename']);
        dump($rs31);
        $rs32 = D('File', 'Api')->fileExists($rs2['groupname'], $rs2['filename']);
        dump($rs32);

        $rs41 = D('File', 'Api')->deleteFile($rs['groupname'], $rs['filename']);
        dump($rs41);
        $rs42 = D('File', 'Api')->deleteFile($rs2['groupname'], $rs2['filename']);
        dump($rs42);

        $rs51 = D('File', 'Api')->fileExists($rs['groupname'], $rs['filename']);
        dump($rs51);
        $rs52 = D('File', 'Api')->fileExists($rs2['groupname'], $rs2['filename']);
        dump($rs52);
        //\Think\Log::write('测试日志信息，Dfs结束','MY');
        logs('测试日志信息，Dfs结束');
    }

    public function testcurl() {
        import('Curl.Curl', APP_LIBRARY);
        $uploadFile = 'http://www.baidu.com';
        $rs = \Common\Lib\Curl\MyCurl::send($uploadFile, array(), 'get');
        dump($rs);
    }

    public function testcache() {
        $id = 1;
        $key = 'DATA::GOOGS::ID::' . $id;
        //S($key,null);
        $rs = D('Goods', 'Cache')->getGoodsInfo($id);
        dump($rs);
    }

    public function phpinfo() {
        phpinfo();
    }

    public function testmysql() {
        $model_release = D('AdvertRelease');
        $model_release->startTrans();
        if (true) {
            $model_release->commit();
            return false;
        }
        $model_release->rollback();
    }

    public function test() {
        //dump(md5_file('3.mp4'));
        dump(md5_file('http://test.res.pad-phone.com/group1/M00/00/05/wKgB_Fg-ewWAFvkQAAHBubGGpfE147.jpg'));
exit;
        $this->display('Public/test');
    }

    public function doUpload() {
        $md5val = I('post.md5val'); //文件的md5值(分片时为总文件的md5)
        //获取文件 后缀，
        $fext = end(explode('.', $_FILES['file']['name']));
        $chunks = I('post.chunks') ? I('post.chunks') : 0; //分片总数
        $chunk = I('post.chunk') ? I('post.chunk') : 0; //当前分片数

        $file_name = $_FILES['file']['tmp_name'];
        $file_size = $_FILES['file']['size'];
        $file_type = $_FILES['file']['type'];

        dump(md5_file($_FILES['file']['tmp_name']));
        echo "Upload: " . $_FILES["file"]["name"] . "<br />";
            echo "Type: " . $_FILES["file"]["type"] . "<br />";
            echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
            echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";
        
        $rs = D('File', 'Api')->doUpload($file_name, $file_size, $file_type, I('post.type'), $md5val, $fext, $chunks, $chunk);

        $this->ajaxReturn($rs);
    }

    public function testUp() {
        
        if ($_FILES["file"]["error"] > 0) {
            echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
        } else {
            echo "Upload: " . $_FILES["file"]["name"] . "<br />";
            echo "Type: " . $_FILES["file"]["type"] . "<br />";
            echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
            echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

            if (file_exists("upload/" . $_FILES["file"]["name"])) {
                echo $_FILES["file"]["name"] . " already exists. ";
            } else {
                if (is_uploaded_file($_FILES['file']['tmp_name'])) {
                    $stored_path =  '/upload/' . basename($_FILES['file']['name']);

                    if (move_uploaded_file($_FILES['file']['tmp_name'], $stored_path)) {
                        echo "Stored in: " . $stored_path;
                    } else {
                        echo 'Stored failed:file save error';
                    }
                } else {
                    echo 'Stored failed:no post ';
                }
            }
        }
        exit;
        $this->ajaxReturnSuccess(I('post.'));
    }

}
