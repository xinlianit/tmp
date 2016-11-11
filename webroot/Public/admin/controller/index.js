/**
 * 商户信息维护
 */

seajs.use('',function(){
	$(function(){
		//查看详情
		$('[event-name="viewInfo"]').on('click' , function(){
			//打开窗口
			$.common.openWindow({
				id: 'view',
				height: 300,
				width: 600,
				title: '详情',
			});
		});
		
		//添加
		$('[event-name="addInfo"]').on('click' , function(){
			//打开窗口
			$.common.openWindow({
				id: 'add',
				height: 300,
				width: 600,
				title: '添加',
				confirm_function: function(){
					
					
					
					//表单验证参数
					var validator_params = {
							//验证字段
							fields:{
								//详细配置
								account: {
									rule:'required',
									msg:{
										required: "请输入用户名！",
									},
								},
								//简洁配置
								pwd: 'required',
							}
							
					};
					
					//表单提交参数
					var submit_params = {
							url:'http://www.baidu.com',
					};
					
					//提交表单
					$.common.formSubmit('add', validator_params, submit_params);
				},
			});
		});
		
		//编辑
		$('[event-name="editInfo"]').on('click' , function(){
			//打开窗口
			$.common.openWindow({
				id: 'edit',
				height: 300,
				width: 600,
				title: '编辑',
			});
		});
		
		//删除
		$('[event-name="deleteRow"]').on('click' , function(){
			//打开窗口
			$.common.openWindow({
				id: 'delete',
				height: 300,
				width: 600,
				title: '删除',
			});
		});
		
		//批量删除
		$('[event-name="deleteRows"]').on('click' , function(){
			//打开窗口
			$.common.openWindow({
				id: 'deletes',
				height: 300,
				width: 600,
				title: '批量删除',
			});
		});
	})
});
