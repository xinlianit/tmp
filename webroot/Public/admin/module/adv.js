/**
 * 广告信息维护
 */
define(function (require, exports, module) {
    return {
        /**
         * 添加广告
         * @param string form_id		表单ID
         * @param string flag			提交标识；add:添加、edit:编辑
         */
        addAdvert: function (form_id) {
            //表单验证参数
            var validator_params = {
                //验证字段
                fields: {
                    //详细配置
                    advert_type: {
                        rule: 'required',
                        msg: {
                            required: '请输入商户名称！',
                        }
                    },
                    adver_number: {
                        rule: 'range[0~6]',
                    },
                }

            };

            //提交表单
            $.common.formSubmit(form_id, validator_params);
        },

    }
});