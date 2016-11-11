<?php
/**
 * CommonLogic.class.php - 公共逻辑
 * @package Logic
 * @subpackage null
 * @link http://www.pad-phone.com
 * @author 派锋科技 PHP DEV TEAM JiRY(390066398@qq.com)
 * @copyright 2016-10-31 14:40
 */
namespace Admin\Logic;

class CommonLogic {
    /**
     * 管理员登陆信息
     * @var array
     */
    protected static $loginInfo = array();
    
    /**
     * 默认返回
     * @var array
     */
    public $result = array('status' => 0);
    
    public function __construct(){
        $storage_type       = C('LOGIN_STORAGE_TYPE');
        $session_key        = C('AUTH_CONFIG.AUTH_SESSION_KEY');
        
        switch( $storage_type ){
            case 'session':
                self::$loginInfo = session($session_key);
                break;
            case 'redis':
                break;
            case 'memcache':
                break;
        }
    }
    
    /**
     * 获取管理员登陆信息
     */
    public function getLoginInfo(){
        return self::$loginInfo;
    }
    
    /**
     * 存储登陆数据
     * @param array $data       管理员数据
     */
    public function storageLoginData($data){
        $auth_key           = C('AUTH_CONFIG.AUTH_KEY');
        $storage_type       = C('LOGIN_STORAGE_TYPE');
        $session_key        = C('AUTH_CONFIG.AUTH_SESSION_KEY');
    
        switch( $storage_type ){
            case 'session':
                //登陆成功session写入登陆token
                session($auth_key , $data['id']);
                session($session_key , $data);
                break;
            case 'redis':
                break;
            case 'memcache':
                break;
        }
    }
    
    /**
     * 删除登陆数据
     */
    public function deleteLoginData(){
        $auth_key           = C('AUTH_CONFIG.AUTH_KEY');
        $storage_type       = C('LOGIN_STORAGE_TYPE');
        $session_key        = C('AUTH_CONFIG.AUTH_SESSION_KEY');
    
        switch( $storage_type ){
            case 'session':
                session($auth_key , null);
                session($session_key , null);
                break;
            case 'redis':
                break;
            case 'memcache':
                break;
        }
    }
    
    /**
     * 获取模型对象
     * @param string $modelName         模型名称
     * @return boolean|object
     */
    private function getModel($modelName){
        if( !$modelName ) return false;
        
        return D($modelName) ? D($modelName) : M($modelName);
    }
    
    /**
     * 获取字段
     * @param string $modelName     表模型名
     * @param string $field         字段名称
     * @param array $condition      查询条件
     * @return string
     */
    public function getField($modelName, $field, $condition=array()){
        $model = self::getModel($modelName);
        $model = $model->where($condition);
        return $model->getField($field);
    }
    
    /**
     * 获取单条数据
     * @param string $modelName     表模型名
     * @param array $condition      查询条件
     * @param array $field          获取字段
     * @return array|boolean|null
     */
    public function getRow($modelName, $condition=array(), $field=array()){
        $model = self::getModel($modelName);
        
        if( is_array($field) && !empty($field) )
            $model = $model->field($field);
        
        if( is_array($condition) && !empty($condition) )
            $model = $model->where($condition);
        
        return $model->find();
    }
    
    /**
     * 获取多条数据
     * @param string $modelName     表模型名称
     * @param array $condition      查询条件
     * @param array $field          获取字段
     * @param array $sort           排序规则
     * @param int $limit            获取行数
     * @return array
     */
    public function getRows($modelName, $condition=array(), $field=array(), $sort=array(), $limit=0){
        $model = self::getModel($modelName);
        
        if( is_array($field) && !empty($field) )
            $model = $model->field($field);
        
        if( is_array($condition) && !empty($condition) )
            $model = $model->where($condition);
        
        if( is_array($sort) && !empty($sort) )
            $model = $model->order($sort);
        
        if( $limit > 0 )
            $model = $model->limit($limit);
        
        return $model->select();
    }
    
    /**
     * 数据分页
     * @author JiRY
     * @param array $modelParams    模型参数（name：模型名、field：字段列表、where：查询条件、order：排序）
     * @param int $pageIndex        当前页数
     * @param int $pageSize         每页条数
     * @param array $map            POST提交或其他查询条件
     * @return array                分页导航数据
     */
    public function page($modelParams, $pageIndex = 1, $pageSize = 0, $map = array()){
        if( !array_key_exists('name', $modelParams) || empty($modelParams['name']) )
            return false;
        
        $model  = D($modelParams['name']) ? D($modelParams['name']) : M($modelParams['name']);        
        
        $count      = $model->where($modelParams['where'])->count();
        
        if( $pageSize <= 0 ) $pageSize = C('PAGE_SIZE');
            
        //总页数
        $all_page   = ceil($count / $pageSize);
    
        // 实例化分页类 传入总记录数和每页显示的记录数
        $Page       = new \Think\Page( $count , $pageSize );
        
        //分页跳转的时候保证查询条件
        if( !empty($map) && is_array($map) ){
            foreach($map as $key=>$val) {
                $Page->parameter[$key]   =   urlencode($val);
            }
        }
    
        if( array_key_exists('field', $modelParams) && !empty($modelParams['field']) )
            $model = $model->field($modelParams['field']);
    
        if( array_key_exists('order', $modelParams) && !empty($modelParams['order']) )
            $model = $model->order($modelParams['order']);

    
        //记录
        $list = $model->where($modelParams['where'])->page($pageIndex.','.$pageSize)->select();

        // 分页显示输出
        $show       = $Page->show();

        return array(
            'all_page'      => $all_page,
            'totalCount'    => $count,
            'page'          => $pageSize,
            'list'          => $list,
            'numPerPage'    => $pageIndex,
            'pagehtml'      => $show
        );

    }
}