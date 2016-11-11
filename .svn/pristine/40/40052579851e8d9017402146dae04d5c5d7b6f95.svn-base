<?php
/**
 * CommonLogic.class.php - 公共逻辑处理
 * @package RoomApi\Logic
 * @subpackage null
 * @link http://rapi.pad-phone.com/
 * @author MSC PHP DEV TEAM HuangZH(47198839@qq.com)
 * @copyright 派锋科技 2016年11月07日  14:49
 * @version V1.0.0
 */
namespace RoomApi\Logic;
class CommonLogic {

    /**
     * 数据结果集
     * @var array|null
     */
    protected $result = null;
    
    /**
     * 签名验证
     * @param string $sign          签名串
     * @return boole 
     */
    public function verifySign($sign = null) {
        //获取签名
        $serverSign = make_sign ();
        if ($serverSign != $sign) return false;
        return true;
    }
}