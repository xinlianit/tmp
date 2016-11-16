/**
 * 商户界面设置
 */
define(function(require, exports, module){
	return {
		/**
		 * 模块初始化
		 */
		initiailize: function(){
			//使用shop.css
			$.common.loadCss('shop');
			
			//使用层级插件
			$.component.level({
				component_id: 'hotel-tel'
			});
		},
		
		/**
		 * 添加编辑服务指南
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveServer: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						hotel_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请搜索并选择商户！',
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
		 * 添加编辑WIFI
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveServer: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						hotel_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请搜索并选择商户！',
							}
						},
						link_method: {
							rule: 'integer(+)',
							msg: {
								integer: '请选择WiFi连接方式！',
							}
						},
//						wifi_account: {
//							rule: 'required',
//							msg: {
//								required: '请输入WIFI账号！',
//							}
//						},
//						wifi_password: {
//							rule: 'required',
//							msg: {
//								required: '请输入WIFI密码！',
//							}
//						},
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
		 * 添加编辑服务电话
		 * @param string form_id		表单ID
		 * @param string flag			提交标识；add:添加、edit:编辑
		 */
		saveTel: function(form_id, flag){
			//表单验证参数
			var validator_params = {
					//验证字段
					fields:{
						//详细配置
						hotel_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请搜索并选择商户！',
							}
						},
						call_name: {
							rule: 'required',
							msg: {
								required: '请输入呼叫名称！',
							}
						},
						telephone: {
							rule: 'required',
							msg: {
								required: '请输入服务电话！',
							}
						},
						data_sort: {
							rule: 'integer(+)',
							msg: {
								integer: '请选择排列号！',
							}
						},
						icon_id: {
							rule: 'integer(+)',
							msg: {
								integer: '请选择icon图标！',
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