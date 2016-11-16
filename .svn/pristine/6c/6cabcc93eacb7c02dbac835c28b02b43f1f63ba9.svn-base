/**
 * 商户界面设置
 */
seajs.use(['module/shopsetting','controller/shop'],function(shopsetting,shop){
	
	//模块初始换
	shopsetting.initiailize();
	
	//新增编辑服务指南
	$(document).on('click', '[event-name="addEditSerGuide"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				
				//图片数量定位
				var pic_num = $(document).find('[tag-id="pic-num"] option');
				$.each(pic_num, function(i,item){
					if(result.pic_num == $(this).val()){
						$(this).attr('selected','selected');
					}
				});
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 500,
			width: 700,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				shopsetting.saveServer('addEdit', flag);
			}
		});
	});
	
	//获取服务指南详情
	$(document).on('click', '[event-name="viewServer"]', function(){
		var _this 		= $(this);
		var url			= $.common.typeCheck(_this.attr('url'), 'undefined', '');
		
		//获取详情
		$.common.ajaxFormSubmit({
			url: url,
			data: $.common.getParams({event_object: _this}),
			success: function(result){
				//绑定数据
				var view = $(document).find('[tag-id="floor-view"]');
				//酒店名称
				view.find('[tag-id="hotel-name"]').html( result.data.hotel_name );
				
				if( typeof(result) == 'object' && typeof(result.data) == 'object' ){
					
				}
				
				//关闭加载框
				$.common.closeTips();
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'viewServer',
			height: 550,
			width: 750,
			title: '服务指南详情',
			enable_confirm: false,
			cancel_title: '关闭',
		});
	});
	
	//新增编辑WIFI
	$(document).on('click', '[event-name="addEditWiFi"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				
				//连接类型定位
				var type = $(document).find('[tag-id="link-method"] option');
				$.each(type, function(i,item){
					if(result.link_method == $(this).val()){
						$(this).attr('selected','selected');
					}
				});
				
				//显示相应类型的输入信息
				switch( parseInt(result.link_method) ){
					//账号密码
					case 1:
						_form.find('[tag-id="account_type"]').removeClass('hide');
						_form.find('[tag-id="code_type"]').addClass('hide');
						_form.find('[tag-id="sns_type"]').removeClass('hide');
						break;
					//商户二维码
					case 2:
						_form.find('[tag-id="account_type"]').addClass('hide');
						_form.find('[tag-id="code_type"]').removeClass('hide');
						_form.find('[tag-id="sns_type"]').addClass('hide');
						break;
					//短信认证
					case 3:
						_form.find('[tag-id="account_type"]').addClass('hide');
						_form.find('[tag-id="code_type"]').addClass('hide');
						_form.find('[tag-id="sns_type"]').removeClass('hide');
						break;
				}
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 500,
			width: 700,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				shopsetting.saveServer('addEdit', flag);
			}
		});
	});
	
	//WIFI连接类型切换
	$(document).on('change', '[event-name="change-type"]', function(){
		var _this = $(this);
		var _form = _this.parents('form').eq(0);
		
		switch( parseInt(_this.val()) ){
			//账号密码
			case 1:
				_form.find('[tag-id="account_type"]').removeClass('hide');
				_form.find('[tag-id="code_type"]').addClass('hide');
				_form.find('[tag-id="sns_type"]').removeClass('hide');
				break;
			//商户二维码
			case 2:
				_form.find('[tag-id="account_type"]').addClass('hide');
				_form.find('[tag-id="code_type"]').removeClass('hide');
				_form.find('[tag-id="sns_type"]').addClass('hide');
				break;
			//短信认证
			case 3:
				_form.find('[tag-id="account_type"]').addClass('hide');
				_form.find('[tag-id="code_type"]').addClass('hide');
				_form.find('[tag-id="sns_type"]').removeClass('hide');
				break;
		}
	});
	
	//新增编辑服务电话
	$(document).on('click', '[event-name="addEditTel"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				
				//排列号定位
				var sort = _form.find('[tag-id="data-sort"] option');
				if( typeof(sort) != 'undefined' && sort.length > 0 ){
					$.each(sort, function(){
						if($(this).val() == result.data_sort){
							$(this).attr('selected','selected');
						}
					})
				} 
				
				//ICON定位
				var icon = _form.find('[tag-id="icon-id"] option');
				if( typeof(icon) != 'undefined' && icon.length > 0 ){
					$.each(icon, function(){
						if($(this).val() == result.icon_id){
							$(this).attr('selected','selected');
						}
					})
				} 
				
				_form.find('[tag-id="icon_log"]').attr('src', result.icon_path);
				
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 500,
			width: 700,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				shopsetting.saveTel('addEdit', flag);
			}
		});
	});
	
	//ICON图标切换
	$(document).on('change', '[tag-id="icon-id"]', function(){
		var _this = $(this);
		var _form = _this.parents('form').eq(0);
		var _option = _this.find('option:selected');
		
		var log_path = static_base + '/static/images/default_60_60.png';
		
		if( $.common.typeCheck(_option.attr('icon-path'), 'undefined', false) && _option.attr('icon-path') != ''){
			log_path = static_domain + _option.attr('icon-path');
		}
		
		_form.find('[tag-id="icon_log"]').attr('src', log_path);
	});
	
});