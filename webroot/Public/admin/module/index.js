/**
 * 首页模块
 */
define(function(require, exports, module){
	return {
		/**
		 * 模块初始化
		 */
		initiailize: function(){
			
		},
		
		/**
		 * 更新密码
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		savePwd: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						old_pwd: {
							rule: 'required',
							msg: {
								required: '请输入原始密码！',
							}
						},
						admin_pass: {
							rule: 'required;length[6~16]',
							msg: {
								required: '请输入新密码！',
								length: '密码由6~16位数字、字符和符号组成。',
							}
						},
						admin_pass_repeat: {
							rule: 'required',
							msg: {
								required: '请再次输入新密码！',
							}
						},
					}
					
			};
			
			//提交参数
			var request_data = {
					data: {
						flag: $.common.typeCheck(flag, 'undefined', 'add')
					}
			};
			
			//提交表单
			$.common.formSubmit(form_id, validator_params, request_data);
		},
		
	};
});