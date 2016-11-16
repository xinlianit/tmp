/**
 * 商户信息维护
 */
define(function(require, exports, module){
	return {
		/**
		 * 添加商户
		 * @param string form_id		表单ID
		 */
		addShop: function(form_id){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						hotel_name: {
							rule: 'required',
							msg: {
								required: '请输入商户名称！',
							}
						},
//						hotel_type: {
//							rule: 'required',
//							msg: {
//								required: '请选择商户类型',
//							}
//						},
					}
					
			};
			
			//提交表单
			$.common.formSubmit(form_id, validator_params);
		},
		
	}
});