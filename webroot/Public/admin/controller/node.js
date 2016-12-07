/**
 * 权限账号
 */
seajs.use(['module/node','controller/shop'], function(node,shop){
	//初始换模块
	node.initialize();
	/********************* 权限节点 ***********************/
	$(document).on('click', '[event-name="addNode"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		//还原初始
		_form.find('input[name="admin_account"]').removeAttr('disabled');
		_form.find('input[name="admin_pass"]').parents('.form-group').first().removeClass('hide');
		_form.find('select[name="group_id"]').parents('.form-group').first().removeClass('hide');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				console.log(result);
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 500,
			width: 700,
			reset: true,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				node.saveNode('addEdit', flag);
			}
		});
	});
	
	/********************* 用户管理 ***********************/
	//新增编辑服务指南
	$(document).on('click', '[event-name="addEditAdmin"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		//还原初始
		_form.find('input[name="admin_account"]').removeAttr('disabled');
		_form.find('input[name="admin_pass"]').parents('.form-group').first().removeClass('hide');
		_form.find('select[name="group_id"]').parents('.form-group').first().removeClass('hide');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				//账号不可编辑
				_form.find('input[name="admin_account"]').attr('disabled','disabled');
				//密码删除
				_form.find('input[name="admin_pass"]').parents('.form-group').first().addClass('hide');
				
				if( parseInt(result.is_super) == 1 ){
					//密码删除
					_form.find('select[name="group_id"]').parents('.form-group').first().addClass('hide');
				}
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 400,
			width: 600,
			reset: true,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				node.saveAdmin('addEdit', flag);
			}
		});
	});
	
	//初始化密码
	$(document).on('click', '[event-name="initPwd"]', function(){
		var _this 		= $(this);
		var table_id 	= $.common.typeCheck(_this.attr('table-name'), 'undefined', false);
		var _dialog		= $(document).find('[dialog-id="delete"]');
		var message		= $.common.typeCheck(_this.attr('message'), 'undefined', false);
		
		var ids = $.common.typeCheck(_this.attr('id-value'), 'undefined', []);
		
		if( table_id != false ){
			var cheked_ids = $(document).find('[table-id="'+ table_id +'"]').find('[tag-name="ids"]:checked');
			
			if(cheked_ids.length == 0){
				$.common.openTips({
					className: 'delete',
					icon: 'icon-warning-sign',
					message: '请选择要初始化密码的账号',
				});
				setTimeout(function(){
					$.common.closeTips('delete');
				},3000);
				return false;
			}else{
				$.each(cheked_ids, function(i, item){
					//console.log($(item).val());
					ids.push($(item).val());
				});
			}
		}
		
		if( message != false ){
			var msg_rows = message.split('|');
			if( typeof(msg_rows) == 'object' ){
				var first_row = msg_rows[0];
				var x = first_row.indexOf('x');
				if( x > -1 ){
					msg_rows[0] = first_row.replace("x", cheked_ids.length);
				}
				
				var msg_row = '';
				$.each(msg_rows, function(i, item){
					msg_row += '<h4>'+ item +'</h4>';
				});
				
				if( msg_row == '' ) msg_row = '<h4>确定要操作吗？</h4><h4>确认后将执行！</h4>';
			}
		}
		
		//删除面板
		var delete_tag = '<div dialog-id="delete" class="wating hide">' +
							'<div tag-id="row-info" class="message">' + msg_row + '</div>' +
						'</div>';
		
		$(document).find('body').find('[dialog-id="delete"]').remove();
		$(document).find('body').append( delete_tag );
		
		//打开窗口
		$.common.openWindow({
			id: 'delete',
			height: 350,
			width: 400,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', '初始化密码'),
			confirm_function: function(){
				
				$.common.ajaxFormSubmit({
					url: $.common.typeCheck(_this.attr('url'), 'undefined', ''),
					data:{ids:ids.toString()}
				});
			}
		});
	});
	
	/***************************** 组别管理 ***************************************/
	//新增编辑组别
	$(document).on('click', '[event-name="addEditGroup"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				var rules = _form.find('[tag-id="rules-item"] [tag-name="ids"]');
				$.each(rules, function(i, item){
					var _item = $(item);
					if( $.common.inArray(_item.val(), result.rules) ){
						_item.attr('checked', 'checked');
						//_item.prop('cheched', true);
					}else if(_item.attr('flag') != 'auto'){
						_item.removeAttr('checked');
					}
				});
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 750,
			width: 1000,
			reset: true,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				node.saveGroup('addEdit', flag);
			}
		});
	});
	
	//选择权限
	$(document).on('click', '[event-name="checked-child"]', function(){
		var _this = $(this);
		var item = _this.parents('[tag-id="item"]').first();
		var child = item.find('dd [tag-name="ids"]');
		
		$.each(child, function(i, item){
			if(_this.is(':checked')){
				$(this).prop('checked', true);
			}else{
				$(this).prop('checked', false);
			}
		});
		
		
	});
	
	//查看组别
	$(document).on('click', '[event-name="viewGroupInfo"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="view"]');
		
		var rules = _form.find('[tag-id="rules-item"] [tag-name="ids"]');
		
		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'view',
			success: function(result){
				
				$.each(rules, function(i, item){
					var _item = $(item);
					if( $.common.inArray(_item.val(), result.rules) ){
						_item.attr('checked', 'checked');
						//_item.prop('cheched', true);
					}else if(_item.attr('flag') != 'auto'){
						_item.removeAttr('checked');
					}
					
				});
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'view',
			height: 750,
			width: 1000,
			reset: true,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			enable_confirm: false,
		});
	});
	
	/***********************************商户账号管理************************************/
	//新增编辑商户账号
	$(document).on('click', '[event-name="addEditAcc"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		_form.find('[event-name="openSeach"]').removeClass('hide');
		_form.find('select[name="account_type"]').removeAttr('disabled');
		_form.find('input[name="staff_account"]').removeAttr('disabled');
		
		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				_form.find('[event-name="openSeach"]').addClass('hide');
				_form.find('select[name="account_type"]').attr('disabled','disabled');
				_form.find('input[name="staff_account"]').attr('disabled','disabled');
				
				_form.find('input[name="staff_pwd"]').val('******');
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 450,
			width: 700,
			reset: true,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				node.saveBusineAcc('addEdit', flag);
			}
		});
	});
	
});