define(function(require, exports ,module){
	$.extend({
		/**
		 * 常用公共库
		 */
		common: {
				/**
				 * 获取系统当前时间
				 * @author Create By JiRY
				 * @param string dateFlag		日期分隔符
				 * @param string timeFlag		时间分隔符
				 * @return string
				 * */
				getNowDateTime:function(dateFlag, timeFlag){
					dateFlag = dateFlag ? dateFlag : '-';
					timeFlag = timeFlag ?　timeFlag : ':';
				    var date = new Date();
				    var seperator1 = dateFlag;
				    var seperator2 = timeFlag;
				    var month = date.getMonth() + 1;
				    var strDate = date.getDate();
				    var hours = date.getHours();
				    var minu = date.getMinutes();
				    var seconds = date.getSeconds();
				    	
				    if (month >= 1 && month <= 9) {
				        month = "0" + month;
				    }
				    if (strDate >= 0 && strDate <= 9) {
				        strDate = "0" + strDate;
				    }
				    if( hours < 10 ){
				    	hours = '0' + hours;
				    }
				    if( minu < 10 ){
				    	minu = '0' + minu;
				    }
				    if( seconds < 10 ){
				    	seconds = '0' + seconds;
				    }
				    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
				            + " " + hours + seperator2 + minu
				            + seperator2 + seconds;
				    return currentdate;
				},
				
				/**
				 * 打开窗口
				 * @param string params.id					弹框ID
				 * @param boolean params.resizable			重置大小
				 * @param boolean params.modal				背景遮罩
				 * @param string params.title				弹框标题；html|text,为html时，需配合title_html使用
				 * @param boolean params.title_html			标题是否支持html
				 * @param boolean params.enable_confirm		是否启用确定按钮
				 * @param boolean params.enable_cancel		是否启用取消按钮
				 * @param string params.confirm_icon		确定按钮图标
				 * @param string params.confirm_class		确认按钮样式
				 * @param string params.confirm_title		确认按钮标题
				 * @param function params.confirm_function	确认按钮回调函数
				 * @param string params.cancel_icon			取消按钮图标
				 * @param string params.cancel_class		取消按钮样式
				 * @param string params.cancel_title		取消按钮标题
				 * @param function params.cancel_function	取消按钮回调函数
				 * @param boolean params.reset				取消时是否重置表单
				 * */
				openWindow: function(params){
					var params = $.common.typeCheck(params , 'undefined' , {});
					var btn = [];
					
					//上一步
					var back_icon 		= $.common.typeCheck(params.back_icon , 'undefined' , 'icon-arrow-left');
					var back_title 		= $.common.typeCheck(params.back_title , 'undefined' , '上一步');
					var back_class 		= $.common.typeCheck(params.back_class , 'undefined' , '');
					var back_function 	= $.common.typeCheck(params.back_function , 'undefined' , function(){
						$( this ).dialog( "close" );
					});
					
					//下一步
					var next_icon 		= $.common.typeCheck(params.next_icon , 'undefined' , 'icon-arrow-right');
					var next_title 		= $.common.typeCheck(params.next_title , 'undefined' , '下一步');
					var next_class 		= $.common.typeCheck(params.next_class , 'undefined' , '');
					var next_function 	= $.common.typeCheck(params.next_function , 'undefined' , function(){
						$( this ).dialog( "close" );
					});
					
					//确定
					var confirm_icon 		= $.common.typeCheck(params.confirm_icon , 'undefined' , 'icon-ok bigger-110');
					var confirm_title 		= $.common.typeCheck(params.confirm_title , 'undefined' , '确定');
					var confirm_class 		= $.common.typeCheck(params.confirm_class , 'undefined' , '');
					var confirm_function 	= $.common.typeCheck(params.confirm_function , 'undefined' , function(){
						$( this ).dialog( "close" );
					});
					
					//取消
					var cancel_icon 		= $.common.typeCheck(params.cancel_icon , 'undefined' , 'icon-remove bigger-110');
					var cancel_title 		= $.common.typeCheck(params.cancel_title , 'undefined' , '取消');
					var cancel_class 		= $.common.typeCheck(params.cancel_class , 'undefined' , '');
					var cancel_function 	= $.common.typeCheck(params.cancel_function , 'undefined' , function(){
						var reset = $.common.typeCheck(params.reset , 'undefined' , false);
						if( reset ){
							var forms = $(document).find('[dialog-id="'+params.id+'"] form');
							if(forms.length > 1){
								$.each(forms,function(i){
									forms[i].reset();
								});
							}else{
								$(document).find('[dialog-id="'+params.id+'"] form')[0].reset();
							}
						}
						$( this ).dialog( "close" );
					});
					
					//上一步按钮
					var enable_back 		= $.common.typeCheck(params.enable_back , 'undefined' , false);
					if( enable_back ){
						var back_btn = {
								"html": "<i class='"+back_icon+"'></i>&nbsp; "+back_title,
								"class" : "btn btn-purple btn-sm " + back_class,
								"click": back_function
						};
						btn.push(back_btn);
					}
					
					//下一步按钮
					var enable_next 		= $.common.typeCheck(params.enable_next , 'undefined' , false);
					if( enable_next ){
						var next_btn = {
								"html": "<i class='"+next_icon+"'></i>&nbsp; "+next_title,
								"class" : "btn btn-sm btn-success " + next_class,
								"click": next_function
						};
						btn.push(next_btn);
					}
					
					//确认按钮
					var enable_confirm 		= $.common.typeCheck(params.enable_confirm , 'undefined' , true);
					if( enable_confirm ){
						var confirm_btn = {
								"html": "<i class='"+confirm_icon+"'></i>&nbsp; "+confirm_title,
								"class" : "btn btn-danger btn-xs " + confirm_class,
								"click": confirm_function
						};
						btn.push(confirm_btn);
					}
					
					//取消按钮
					var enable_cancel = $.common.typeCheck(params.enable_cancel , 'undefined' , true);
					if( enable_cancel ){
						var cancel_btn = {
								"html": "<i class='"+cancel_icon+"'></i>&nbsp; "+cancel_title,
								"class" : "btn btn-xs " + cancel_class,
								"click": cancel_function
						};
						btn.push(cancel_btn);
					}
					
					
					//dialog 设置
					var dialog_id = $.common.typeCheck(params.id , 'undefined' , false);
					if( dialog_id ){
						
						var dialog_params = {
							resizable: $.common.typeCheck(params.resizable , 'undefined' , false),
							modal: $.common.typeCheck(params.modal , 'undefined' , true),
							title: $.common.typeCheck(params.title , 'undefined' , '温馨提示'),
							title_html: $.common.typeCheck(params.title_html , 'undefined' , true),
							buttons: btn
						};
						
						if( $.common.typeCheck(params.height , 'undefined' , null) !== null ){
							dialog_params.height = params.height;
						}
						
						if( $.common.typeCheck(params.width , 'undefined' , null) !== null ){
							dialog_params.width = params.width;
						}
						
						$(document).find( '[dialog-id="'+dialog_id+'"]' ).removeClass('hide').dialog(dialog_params);
					}
					
				},
				
				/**
				 * 表单验证
				 * @param string params.form_id				表单ID；form-id
				 * @param int params.debug					否启用调试模式
				 * @param int params.timely					是否启用实时验证
				 * @param string params.theme 				主题名字，用于设置一个表单验证的主题样式
				 * @param boolean params.stopOnError 		是否在验证出错时停止继续验证
				 * @param boolean params.focusInvalid  		是否自动让第一个出错的输入框获得的焦点
				 * @param boolean params.focusCleanup   	是否在输入框获得焦点的时候清除消息
				 * @param string params.ignore    			指定需要忽略验证的元素的jQuery选择器
				 * @param string params.display     		自定义消息中{0}的显示替换名称
				 * @param object params.rules      			自定义用于当前实例的规则，支持两种定义方式
				 * @param object params.messages       		自定义用于当前实例的规则消息
				 * @param object params.fields				待验证的字段集合，键为字段的name值或者"#"+字段id。有两种用法：
				 * @param function params.valid				验证通过回调函数
				 * @param object submit_params				表单提交参数
				 */
				_formValidator: function(params, submit_params){
					var params = $.common.typeCheck(params, 'undefined' , {});
					
					var validator_params = {
							debug: $.common.typeCheck(params.debug, 'undefined', 0),
							timely: $.common.typeCheck(params.timely, 'undefined', 1),
							theme: $.common.typeCheck(params.theme, 'undefined', 'default'),
							stopOnError: $.common.typeCheck(params.stopOnError, 'undefined', false), 
							focusInvalid: $.common.typeCheck(params.focusInvalid, 'undefined', true),
							focusCleanup: $.common.typeCheck(params.focusCleanup, 'undefined', false),
							ignore: $.common.typeCheck(params.ignore, 'undefined', ''), 
							display: $.common.typeCheck(params.display, 'undefined', ''), 
							rules: $.common.typeCheck(params.rules, 'undefined', {}), 
							messages: $.common.typeCheck(params.messages, 'undefined', {}), 
						    fields: $.common.typeCheck(params.fields, 'undefined', {}),
						    valid: function(form){
						        // 表单验证通过，提交表单
						        $.common.ajaxFormSubmit(submit_params);
						    }
					}
					
					$(document).find('[form-id="'+params.form_id+'"]').validator(validator_params);
				},
				
				/**
				 * 提交表单
				 * @param string form_id 				表单ID；form-id
				 * @param object valitor_params			表单验证参数
				 * @param object submit_params			表单提交参数
				 */
				formSubmit:function(form_id, valitor_params, submit_params){
					
					var _valitor_params = {
							form_id: form_id
					};
					
					if( typeof(valitor_params) == 'object' )
						_valitor_params = Object.assign(_valitor_params , valitor_params);
					
					var _submit_params = {
							id: form_id
					};
					
					if( typeof(submit_params) == 'object' )
						_submit_params = Object.assign(_submit_params , submit_params);
					
					//表单验证
					$.common._formValidator(_valitor_params, _submit_params);
					//表单提交
					$(document).find('[form-id="'+form_id+'"]').submit();
				},
				
				/**
				 * 表单ajax提交
				 * @param string submit_params.id				表单ID
				 * @param string submit_params.type				提交类型
				 * @param string submit_params.url				提交地址
				 * @param boolean submit_params.cache			ajax缓存
				 * @param int submit_params.timeout				超时时间；单位：毫秒：如 3秒 = 30000毫秒 
				 * @param boolean submit_params.async			异步提交
				 * @param string submit_params.contentType		提交内容类型
				 * @param string submit_params.dataType			预期返回数据格式
				 * @param function submit_params.beforeSend		提交前回调函数
				 * @param function submit_params.complete		提交完成回调函数
				 * @param function submit_params.success		提交成功回调函数
				 * @param function submit_params.error			提交出错回调函数
				 */
				ajaxFormSubmit: function(submit_params){
					//提交参数
					var submit_params = $.common.typeCheck(submit_params, 'undefined', {});
					
					//表单对象
					var form = $(document).find('[form-id="'+submit_params.id+'"]');
					
					//提交类型
					var type = $.common.typeCheck(form.attr('method') , 'undefined' , 'GET');

					//ajax参数
					var ajaxParam = {
							type: $.common.typeCheck(submit_params.type , 'undefined' , $.common.typeCheck(form.attr('method') , 'undefined' , 'GET')),
							url: $.common.typeCheck(submit_params.url , 'undefined' , $.common.typeCheck(form.attr('action') , 'undefined' , '')),
							cache: $.common.typeCheck(submit_params.cache , 'undefined' , true),
							timeout: $.common.typeCheck(submit_params.timeout , 'undefined' , 30000),
							async: $.common.typeCheck(submit_params.async , 'undefined' , true),
							dataType: $.common.typeCheck(submit_params.dataType , 'undefined' , 'JSON'),
							contentType: $.common.typeCheck(submit_params.contentType , 'undefined' , 'application/x-www-form-urlencoded'),
							beforeSend: $.common.typeCheck(submit_params.beforeSend , 'undefined' , function(XMLHttpRequest){
								$.common.beforeSend(XMLHttpRequest);
							}),
							complete: $.common.typeCheck(submit_params.complete, 'undefined', function(XMLHttpRequest, textStatus){
								$.common.complete(XMLHttpRequest, textStatus);
							}),
							success: $.common.typeCheck(submit_params.success , 'undefined' , function(data, textStatus){
								$.common.success(data, textStatus, form);
							}),
							error: $.common.typeCheck(submit_params.error , 'undefined', function(XMLHttpRequest, textStatus, errorThrown){
								$.common.error(XMLHttpRequest, textStatus, errorThrown);
							}),
							data: form.serializeArray()
						};
					
					//表单数据处理
					var data = {};
					$.each(ajaxParam.data,function(i,item){
						if(typeof(data[item.name]) == 'undefined'){
							data[item.name] = item.value;
							
						}else if(typeof(data[item.name]) == 'string'){
							
							var arr = new Array();
							arr.push(data[item.name]);
							arr.push(item.value);
							
							data[item.name] = arr;
						}else if(typeof(data[item.name]) == 'object'){
							data[item.name].push(item.value);
						}
					});
					
					//替换提交数据
					ajaxParam.data = data;
					
					//执行ajax提交
					$.ajax(ajaxParam);
					
					return false;
				},
				
				/**
				 * 数据类型检测
				 * @author JiRY
				 * @param all data   						数据源
				 * @param string|object|boolean type 		类型
				 * @param all default_value					默认值
				 * @return string|object|boolean
				 */
				typeCheck: function(data, type, default_value){
					return typeof(data) == type ? default_value : data;
				},
				
				/**
				 * 发送请求前
				 * @param object XMLHttpRequest  响应对象
				 */
				beforeSend: function(XMLHttpRequest){
					//提示框
					$.common.openTips({
						'message': "请稍后，数据正在处理中..."
					});
				},
				
				/**
				 * 请求完成时
				 * @param object XMLHttpRequest	响应对象
				 * @param string textStatus		响应状态
				 */
				complete: function(XMLHttpRequest, textStatus){
					//关闭加载框
					//$.common.closeTips();
				},
				
				/**
				 * 请求成功
				 * @param string|object|boolean data	服务器返回数据
				 * @param string testStatus				响应状态
				 */
				success: function(data, textStatus , form){
					if( typeof(data) == 'object' ){
						if( typeof(data.status) != 'undefined' && parseInt(data.status) == 1){
							
							var msg = "操作成功，";
							var msg_info = $.common.typeCheck(data.msg, 'undefined', '');
							msg = msg + msg_info + ' <span tag-id="timeout">3 </span>秒钟后自动刷新或跳转...';
							
							//提示框
							$.common.openTips({
								'icon': 'icon-ok bigger-110',
								'message': msg
							});
							
							//倒计时
							var timeout = 3;
							var success_timer = setInterval(function(){
								if( timeout > 1 ){
									timeout--;
									$(document).find('[tag-id="timeout"]').html(timeout+" ");
									
								}else if(timeout == 1){
									clearInterval(success_timer);
									$.common.closeTips();
								}
							},1000);
							
							
							//跳转或刷新
							if( typeof(form.attr('redirect')) != 'undefined' ){
								//3秒后关闭提示并重定向
								setTimeout(function(){
									//跳转
									window.location.href = form.attr('redirect');
								},3000);
							}else{
								//3秒钟后关闭提示，且刷新
								setTimeout(function(){
									//刷新
									window.location.reload();
								},3000);
							}
							
						}else{
							
							var msg = '操作失败，';
							
							var msg_info = $.common.typeCheck(data.msg, 'undefined', '');
							
							msg = msg + msg_info + ' <span tag-id="timeout">3 </span>秒钟后自动关闭提示...';
							
							//倒计时
							var timeout = 3;
							var fail_timer = setInterval(function(){
								if( timeout > 1 ){
									timeout--;
									$(document).find('[tag-id="timeout"]').html(timeout+" ");
								}else if(timeout == 1){
									clearInterval(fail_timer);
									$.common.closeTips();
								}
							},1000);
							
							//提示框
							$.common.openTips({
								'icon': 'icon-remove',
								'message': msg
							});
						}
					}else if( typeof(data) == 'string' ){
						
					}else if( typeof(data) == 'boolean' ){
						
					}
				},
				
				/**
				 * 请求失败
				 * @param object XMLHttpRequest		响应对象
				 * @param string textStatus			响应状态
				 * @param string errorThrown		错误信息
				 */
				error: function(XMLHttpRequest, textStatus, errorThrown){
					console.error(errorThrown);
					$.common.openTips({className:'error', icon:'icon-warning-sign', message:'服务器发生错误，请重试！ <span tag-id="timeout">5 </span>秒钟后自动关闭提示...'});
					
					//关闭加载框
					$.common.closeTips();
					//倒计时
					var timeout = 5;
					var error_timer = setInterval(function(){
						if( timeout > 1 ){
							timeout--;
							$(document).find('[tag-id="timeout"]').html(timeout+" ");
						}else if(timeout == 1){
							clearInterval(error_timer);
							$.common.closeTips('error');
						}
					},1000);
					
					setTimeout(function(){
						$.common.closeTips('error');
					},5000);
				},
				
				/**
				 * 打开提示弹框
				 * @param string params.className		提示框类名
				 * @param string param.message			提示内容
				 * @param boolean param.backdrop		是否遮罩
				 * @param string param.icon				提示图标
				 */
				openTips: function(params){
					
					var params 			= $.common.typeCheck(params, 'undefined', {});
					
					var className 		= $.common.typeCheck(params.className, 'undefined', 'loading-in');
					
					var message 		= $.common.typeCheck(params.message, 'undefined', '操作成功！<span tag-id="timeout">3 </span>秒后自动刷新或跳转...');
					
					var icon 			= $.common.typeCheck(params.icon, 'undefined', 'icon-spinner icon-spin');
					
					//关闭加载框
					$.common.closeTips(className);
					
					//提示
					bootbox.dialog({ 
						className: className,
						backdrop: $.common.typeCheck(params.backdrop, 'undefined', true),
						message: '<div class="text-center" style="font-size:14px;"><i class="'+icon+'"></i> '+message+'</div>' 
					});
				},
				
				/**
				 * 关闭提示框
				 * @params string className			提示框类名
				 */
				closeTips: function(className){
					
					var className = $.common.typeCheck(className, 'undefined', 'loading-in');
					
					//关闭加载框
					if($(document).find('.'+className).attr('class') != 'undefined'){
						$(document).find('.'+className).find('.bootbox-close-button').click();
					}
				},
				
				/**
				 * 删除数组指定元素
				 * @param array arr		数组
				 * @param value var		删除元素值
				 * @return array 		
				 */
				removeArrayItem: function(arr, val){
					for(var i=0; i<arr.length; i++) {
					    if(arr[i] == val) {
					      arr.splice(i, 1);
					      break;
					    }
					  }
					
					return arr;
				},
				
				/**
				 * 字符串转数组
				 * @param string string		字符串
				 * @param string flag		分隔符
				 * @return array
				 */
				stringToArray: function(string, flag){
					return string.split(flag);
				},
				
				/**
				 * 判断元素是否存在数组内
				 * @param string val		查找值
				 * @param array	array		查找数组
				 * @return boolean
				 */
				inArray: function(val, array){
					if( array.indexOf(val) != -1){
						return true;
					}
					return false;
				},
				
				//成员方法...
				
			}
	});
});



