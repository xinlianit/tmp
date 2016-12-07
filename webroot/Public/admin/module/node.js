/**
 * 权限账号模型
 */
define(function(require, exports, module){
	return {
		/**
		 * 模块初始换
		 */
		initialize: function(){
			//使用shop.css
			$.common.loadCss('shop');
		},
		/**
		 * 添加编辑权限节点
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveNode: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						title: {
							rule: 'required',
							msg: {
								required: '请输入节点名称！',
							}
						},
						name: {
							rule: 'required',
							msg: {
								required: '请输入节点规则！',
							}
						},
						admin_name: {
							rule: 'required',
							msg: {
								required: '请输入姓名！',
							}
						},
						admin_mobile: {
							rule: 'required;mobile',
							msg: {
								required: '请输入手机号！',
								mobile: '手机号码格式不正确！',
							}
						},
						admin_email: {
							rule: 'required;email',
							msg: {
								required: '请输入管理员电子邮箱！',
								email: '电子邮箱格式不正确！',
							}
						},
						group_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请选择管理员组！',
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
		
		/**
		 * 添加编辑管理员账号
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveAdmin: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						admin_account: {
							rule: 'required',
							msg: {
								required: '请输入管理员账号！',
							}
						},
						admin_pass: {
							rule: 'required;length[6~16]',
							msg: {
								required: '请输入密码！',
								length: '请输入6-16位字符密码！',
							}
						},
						admin_name: {
							rule: 'required',
							msg: {
								required: '请输入姓名！',
							}
						},
						admin_mobile: {
							rule: 'required;mobile',
							msg: {
								required: '请输入手机号！',
								mobile: '手机号码格式不正确！',
							}
						},
						admin_email: {
							rule: 'required;email',
							msg: {
								required: '请输入管理员电子邮箱！',
								email: '电子邮箱格式不正确！',
							}
						},
						group_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请选择管理员组！',
							}
						},
					}
					
			};
			
			if(flag == 'edit'){
				delete validator_params.fields.admin_pass;
			}
			
			//提交参数
			var request_data = {
					data: {
						flag: $.common.typeCheck(flag, 'undefined', 'add')
					}
			};
			
			//提交表单
			$.common.formSubmit(form_id, validator_params, request_data);
		},
		
		/**
		 * 添加编辑组别
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveGroup: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						title: {
							rule: 'required',
							msg: {
								required: '请输入组别名称！',
							}
						},
						
					}
					
			};
			
			if(flag == 'edit'){
				delete validator_params.fields.admin_pass;
			}
			
			//提交参数
			var request_data = {
					data: {
						flag: $.common.typeCheck(flag, 'undefined', 'add')
					}
			};
			
			//提交表单
			$.common.formSubmit(form_id, validator_params, request_data);
		},
		
		/**
		 * 添加编辑商户账号
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveBusineAcc: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						hotel_id: {
							rule: 'integer[+]',
							msg: {
								integer: '请搜索并选择商户！',
							}
						},
						account_type: {
							rule: 'integer[+]',
							msg: {
								integer: '请选择账号类型！',
							}
						},
						staff_account: {
							rule: 'required',
							msg: {
								required: '请输入账号！',
							}
						},
						staff_pwd: {
							rule: 'required;length[6~16]',
							msg: {
								required: '请输入密码！',
								length: '密码由6~16位数字、字符和符号组成'
							}
						},
						
					}
					
			};
			
			if(flag == 'edit'){
				//delete validator_params.fields.staff_pwd;
			}
			
			//提交参数
			var request_data = {
					data: {
						flag: $.common.typeCheck(flag, 'undefined', 'add')
					}
			};
			
			//提交表单
			$.common.formSubmit(form_id, validator_params, request_data);
		},
	}
});