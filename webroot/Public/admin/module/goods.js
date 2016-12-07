/**
 * 广告信息维护
 */
define(function (require, exports, module) {
    return {
        /**
         * 添加广告
         * @param string form_id		表单ID
         */
        addCate: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    category_name: {
                        rule: 'required',
                        msg: {required: '请输入分类名！'}
                    },
                    data_sort: {
                        rule: 'range[1~12]',
                        msg: {range: '请选择分类'}
                    },
                }

            };

            //提交表单
            $.common.formSubmit(form_id, validator_params);
        },
        /**
         * 添加广告
         * @param string form_id		表单ID
         */
        addGoods: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    goods_name: {
                        rule: 'required',
                        msg: {required: '请输入商品名称！'}
                    },
                    cate_id: {
                        rule: 'range[1~100000000]',
                        msg: {range: '请选择分类'}
                    },
                    goods_price:{
                        rule:['required','range[0.01~100000000]'],
                        msg: {required: '请输入商22品价格',range:'价格必须为数字型'}
                    },
                    original_cost:{
                        rule:'range[0.01~100000000]',
                        msg: {range:'价格必须为数字型'}
                    },
                    goods_pic_md5:{
                        rule: 'required',
                        msg: {required: '请上传酒店图片！'}
                    }
                }

            };

            //提交表单
            $.common.formSubmit(form_id, validator_params);
        },
        
        /**
         * 添加促销信息
         * @param string form_id		表单ID
         */
        addSales: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    promotion_name: {
                        rule: 'required',
                        msg: {required: '请输入促销名称！'}
                    },
                    data_sort: {
                        rule: 'range[1~12]',
                        msg: {range: '请选择排序号'}
                    },
                    goods_id:{
                        rule:'required',
                        msg: {required: '请选择商品'}
                    }
                }

            };

            //提交表单
            $.common.formSubmit(form_id, validator_params);
        },
        
        /**
         * 添加促销信息
         * @param string form_id		表单ID
         */
        addMatch: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    hotel_id: {
                        rule: 'required',
                        msg: {required: '请选择商户！'}
                    },
                    goods_id: {
                        rule: 'required',
                        msg: {required: '请选择商品！'}
                    },
                    match_code:{
                        rule:'required',
                        msg: {required: '请输入配对号'}
                    }
                }

            };

            //提交表单
            $.common.formSubmit(form_id, validator_params);
        },
        /**
         * 添加促销信息
         * @param string form_id		表单ID
         */
        addMatchs: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    templet_md5:{
                        rule:'required',
                        msg: {required: '请上传批量数据'}
                    }
                }
            };
            //提交表单
            $.common.formSubmit(form_id, validator_params);
        }

    }
});