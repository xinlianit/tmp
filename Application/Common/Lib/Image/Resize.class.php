<?php

/**
 * @description of Resize.class.php  图片处理类-生成缩略图片的类
 * @package pad-phone
 * @author  zhaoxizhan
 * @createtime 2016年11月4日 下午4:42:10
 */

namespace Common\Lib\Image;

class Resize {

    public $type; //图片类型
    public $width; //实际宽度
    public $height; //实际高度
    public $resize_width; //改变后的宽度
    public $resize_height; //改变后的高度
    public $cut; //是否裁图
    public $srcimg; //源图象  
    public $dstimg; //目标图象地址
    public $im; //临时创建的图象
    public $quality; //图片质量

    /**
     * 生成缩略图
     * @param type $img
     * @param type $wid
     * @param type $hei
     * @param type $c
     * @param type $dstpath
     * @param type $quality
     */
    function create($img, $wid, $hei, $c, $dstpath, $quality = 75) {
	$this->srcimg = $img;
	$this->resize_width = $wid;
	$this->resize_height = $hei;
	$this->cut = $c;
	$this->quality = $quality;
	$this->type = strtolower(substr(strrchr($this->srcimg, '.'), 1)); //图片的类型
	$this->initi_img(); //初始化图象
	//不支持的图片类型
	if(!$this->im){
	    return false;
	}
	$this->dst_img($dstpath); //目标图象地址
	//获取图像失败
	if(!imagesx($this->im) || !imagesy($this->im) ){
	    return false;
	}
	$this->width = imagesx($this->im);
	$this->height = imagesy($this->im);
	if($this->cut == 1){
	    $this->doimg(); //生成图象
	}else{
	   $this->newimg(); //生成图象 
	}	
	ImageDestroy($this->im);
	
	return true;
    }

    /**
     * 图片的相关处理
     */
    public function doimg(){
	$resize_ratio = ($this->resize_width) / ($this->resize_height); //改变后的图象的比例
	$ratio = ($this->width) / ($this->height); //实际图象的比例	
	//原图比新图小
	if( ($this->width <= $this->resize_width) && ($this->height <= $this->resize_height) ){	    
	    $dst_x = intval( ($this->resize_width - $this->width)/2 );//设定需要载入的图片在新图中的x坐标
	    $dst_y = intval( ($this->resize_height - $this->height)/2 );//设定需要载入的图片在新图中的y坐标	
	    $src_x = 0;//设定载入图片要载入的区域x坐标
	    $src_y = 0;//设定载入图片要载入的区域y坐标
	    $dst_w = $this->width;//设定载入的原图的宽度（在此设置缩放）
	    $dst_h = $this->height;//设定载入的原图的高度（在此设置缩放）
	    $src_w = $this->width;//：原图要载入的宽度
	    $src_h = $this->height;//原图要载入的高度
	}
	//原图x比新图x小
	elseif ( $this->width <= $this->resize_width ){	    
	    $dst_x = intval( ($this->resize_width - $this->width)/2 );//设定需要载入的图片在新图中的x坐标
	    $dst_y = 0;	//设定需要载入的图片在新图中的y坐标
	    $src_x = 0;//设定载入图片要载入的区域x坐标
	    $src_y = intval( ($this->height - $this->resize_height)/2 ); //设定载入图片要载入的区域x坐标	
	    
	    $dst_w = $this->width;//设定载入的原图的宽度（在此设置缩放）
	    $dst_h = $this->resize_height;//设定载入的原图的高度（在此设置缩放）
	    $src_w = $this->width;//：原图要载入的宽度
	    $src_h = $this->resize_height;//原图要载入的高度   
	}
	//原图y比新图y小
	elseif( $this->height <= $this->resize_height ){
	    $dst_x = 0;//设定需要载入的图片在新图中的x坐标
	    $dst_y = intval( ($this->resize_height - $this->height)/2 );	//设定需要载入的图片在新图中的y坐标
	    $src_x = intval( ($this->width - $this->resize_width)/2 );//设定载入图片要载入的区域x坐标
	    $src_y = 0; //设定载入图片要载入的区域x坐标	
	    
	    $dst_w = $this->resize_width;//设定载入的原图的宽度（在此设置缩放）
	    $dst_h = $this->height;//设定载入的原图的高度（在此设置缩放）
	    $src_w = $this->resize_width;//：原图要载入的宽度
	    $src_h = $this->height;//原图要载入的高度     
	}
	//原图比处理图相大
	else{
	    $dst_x = 0;//设定需要载入的图片在新图中的x坐标
	    $dst_y = 0;//设定需要载入的图片在新图中的y坐标
	    //高度优先
	    if ($ratio >= $resize_ratio) {
		$src_x = intval( ($this->width - $this->height * $resize_ratio)/2 );//设定载入图片要载入的区域x坐标
		$src_y = 0; //设定载入图片要载入的区域x坐标
		$src_w = $this->height * $resize_ratio;//：原图要载入的宽度
		$src_h = $this->height;//原图要载入的高度   
	    }
	    if ($ratio < $resize_ratio) {//宽度优先
		$src_x = 0;//设定载入图片要载入的区域x坐标
		$src_y = intval( ($this->height-$this->width/$resize_ratio)/2 ); //设定载入图片要载入的区域x坐标
		$src_w = $this->width;//：原图要载入的宽度
		$src_h = $this->width / $resize_ratio;//原图要载入的高度   
	    }
	    $dst_w = $this->resize_width;//设定载入的原图的宽度（在此设置缩放）
	    $dst_h = $this->resize_height;//设定载入的原图的高度（在此设置缩放）	     
	}
	$newimg = imagecreatetruecolor($this->resize_width, $this->resize_height);
	$backcolor = imagecolorallocate($newimg, 255, 255, 255);
	imagefill($newimg, 0, 0, $backcolor);
	imagecopyresampled($newimg, $this->im, $dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h);
	imagejpeg($newimg, $this->dstimg, $this->quality);	
    }
    /**
     * 生成图象-只做缩放
     */
    function newimg() {
	$resize_ratio = ($this->resize_width) / ($this->resize_height); //改变后的图象的比例
	$ratio = ($this->width) / ($this->height); //实际图象的比例
	if ($ratio >= $resize_ratio) {
	    $newimg = imagecreatetruecolor($this->resize_width, ($this->resize_width) / $ratio);
	    imagecopyresampled($newimg, $this->im, 0, 0, 0, 0, $this->resize_width, ($this->resize_width) / $ratio, $this->width, $this->height);
	    imagejpeg($newimg, $this->dstimg, $this->quality);
	}
	if ($ratio < $resize_ratio) {
	    $newimg = imagecreatetruecolor(($this->resize_height) * $ratio, $this->resize_height);
	    imagecopyresampled($newimg, $this->im, 0, 0, 0, 0, ($this->resize_height) * $ratio, $this->resize_height, $this->width, $this->height);
	    imagejpeg($newimg, $this->dstimg, $this->quality);
	}
    }

    /**
     * 初始化图象
     */
    function initi_img() {
	switch ($this->type) {
	    case 'jpg':
	    case 'jpeg':
		$this->im = imagecreatefromjpeg($this->srcimg);
		break;
	    case 'gif':
		$this->im = imagecreatefromgif($this->srcimg);
		break;
	    case 'png':
		$this->im = imagecreatefrompng($this->srcimg);
		break;
	    case 'wbm':
		$this->im = imagecreatefromwbmp($this->srcimg);
		break;
	    case 'bmp';
		$this->im = $this->ImageCreateFromBMP($this->srcimg);
		break;
	}
    }

    /**
     * 图象目标地址
     * @param string $dstpath 目标图像地址
     */
    function dst_img($dstpath) {
	$this->dstimg = $dstpath;
    }

    /**
     * 自定义函数处理bmp图片
     * @param type $filename 源图片地址
     * @return type
     */
    function ImageCreateFromBMP($filename) { 
	if (!$f1 = fopen($filename, "rb"))
	    return FALSE;
	$FILE = unpack("vfile_type/Vfile_size/Vreserved/Vbitmap_offset", fread($f1, 14));
	if ($FILE['file_type'] != 19778)
	    returnFALSE;
	$BMP = unpack('Vheader_size/Vwidth/Vheight/vplanes/vbits_per_pixel' .
		'/Vcompression/Vsize_bitmap/Vhoriz_resolution' .
		'/Vvert_resolution/Vcolors_used/Vcolors_important', fread($f1, 40));
	$BMP['colors'] = pow(2, $BMP['bits_per_pixel']);
	if ($BMP['size_bitmap'] == 0)
	    $BMP['size_bitmap'] = $FILE['file_size'] - $FILE['bitmap_offset'];
	$BMP['bytes_per_pixel'] = $BMP['bits_per_pixel'] / 8;
	$BMP['bytes_per_pixel2'] = ceil($BMP['bytes_per_pixel']);
	$BMP['decal'] = ($BMP['width'] * $BMP['bytes_per_pixel'] / 4);
	$BMP['decal']-=floor($BMP['width'] * $BMP['bytes_per_pixel'] / 4);
	$BMP['decal'] = 4 - (4 * $BMP['decal']);
	if ($BMP['decal'] == 4)
	    $BMP['decal'] = 0;
	$PALETTE = array();
	if ($BMP['colors'] < 16777216) {
	    $PALETTE = unpack('V' . $BMP['colors'], fread($f1, $BMP['colors'] * 4));
	}
	$IMG = fread($f1, $BMP['size_bitmap']);
	$VIDE = chr(0);
	$res = imagecreatetruecolor($BMP['width'], $BMP['height']);
	$P = 0;
	$Y = $BMP['height'] - 1;
	while ($Y >= 0) {
	    $X = 0;
	    while ($X < $BMP['width']) {
		if ($BMP['bits_per_pixel'] == 24)
		    $COLOR = unpack("V", substr($IMG, $P, 3) . $VIDE);
		elseif ($BMP['bits_per_pixel'] == 16) {
		    $COLOR = unpack("n", substr($IMG, $P, 2));
		    $COLOR[1] = $PALETTE[$COLOR[1] + 1];
		} elseif ($BMP['bits_per_pixel'] == 8) {
		    $COLOR = unpack("n", $VIDE . substr($IMG, $P, 1));
		    $COLOR[1] = $PALETTE[$COLOR[1] + 1];
		} elseif ($BMP['bits_per_pixel'] == 4) {
		    $COLOR = unpack("n", $VIDE . substr($IMG, floor($P), 1));
		    if (($P * 2) % 2 == 0)
			$COLOR[1] = ($COLOR[1] >> 4);
		    
			else$COLOR[1] = ($COLOR[1] & 0x0F);
		    $COLOR[1] = $PALETTE[$COLOR[1] + 1];
		}
		elseif ($BMP['bits_per_pixel'] == 1) {
		    $COLOR = unpack("n", $VIDE . substr($IMG, floor($P), 1));
		    if (($P * 8) % 8 == 0)
			$COLOR[1] = $COLOR[1] >> 7;
		    elseif (($P * 8) % 8 == 1)
			$COLOR[1] = ($COLOR[1] & 0x40) >> 6;
		    elseif (($P * 8) % 8 == 2)
			$COLOR[1] = ($COLOR[1] & 0x20) >> 5;
		    elseif (($P * 8) % 8 == 3)
			$COLOR[1] = ($COLOR[1] & 0x10) >> 4;
		    elseif (($P * 8) % 8 == 4)
			$COLOR[1] = ($COLOR[1] & 0x8) >> 3;
		    elseif (($P * 8) % 8 == 5)
			$COLOR[1] = ($COLOR[1] & 0x4) >> 2;
		    elseif (($P * 8) % 8 == 6)
			$COLOR[1] = ($COLOR[1] & 0x2) >> 1;
		    elseif (($P * 8) % 8 == 7)
			$COLOR[1] = ($COLOR[1] & 0x1);
		    $COLOR[1] = $PALETTE[$COLOR[1] + 1];
		} else
		    returnFALSE;
		imagesetpixel($res, $X, $Y, $COLOR[1]);
		$X++;
		$P+=$BMP['bytes_per_pixel'];
	    }
	    $Y--;
	    $P+=$BMP['decal'];
	}
	fclose($f1);
	return$res;
    }

}
