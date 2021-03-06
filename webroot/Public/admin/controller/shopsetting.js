/**
 * 商户界面设置
 */
seajs.use(['module/shopsetting','controller/shop','webupload'],function(shopsetting,shop,webupload){
	
	//模块初始换
	shopsetting.initiailize();
	
	//新增编辑服务指南
	$(document).on('click', '[event-name="addEditSerGuide"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
                _form.find('[name=pic_md5]').val('');
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
		
		//上传组件
		$.common.webupload_initialize(webupload,'pic_md5',1,'jpeg,png,jpg',{
			multiple_val: true,
		});
	});
	
	//获取服务指南详情
	$(document).on('click', '[event-name="viewServer"]', function(){
		var _this 		= $(this);
		var url			= $.common.typeCheck(_this.attr('url'), 'undefined', '');
		$('.view-pic').html('');
		//获取详情
		$.common.ajaxFormSubmit({
			url: url,
			data: $.common.getParams({event_object: _this}),
			success: function(result){
				//绑定数据
				var view = $(document).find('[tag-id="floor-view"]');
				//酒店名称
				view.find('[tag-id="hotel-name"]').html( result.data.hotel_name );
				
				if(result.status === 1){
                                    var _html = '';
                                    $.each(result.data.list,function(i,n){
                                        _html += '<li><img src="'+n.pic_path+'" /></li>';
                                    });
                                    console.log(_html);
                                    $(_html).appendTo('.view-pic');
                                }else{
                                    $.common.openTips({className: 'error',icon: 'icon-info-sign',message: "请输入广告名称"});
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
			log_path = _option.attr('icon-path');
		}
		
		_form.find('[tag-id="icon_log"]').attr('src', log_path);
	});
	
	/************************************ 客房服务 ************************************/
	//添加编辑客房服务
	$(document).on('click', '[event-name="addEditRoomServer"]', function(){
		
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				//console.log(result);
				
				//二级服务
				var tow_item = '';
				if( typeof(result.service_two) == 'object' && result.service_two.length > 0 ){
					//已选二级服务
					var checked_two_ids = [];
					if(result.two_service_ids != null){
						checked_two_ids = result.two_service_ids.split(',');
					}
					
					$.each(result.service_two, function(i, item){
						if( i > 0 ){
							tow_item += '<span class="separate-3"></span>';
						} 
						
						if( $.common.inArray(item.id, checked_two_ids) ){
							checked = ' checked="checked"';
						}else{
							checked = '';
						}
						
						tow_item += '<label>' +
										'<input name="two_service_ids[]"'+checked+' value="'+item.id+'" type="checkbox" class="ace">' +
										'<span class="lbl"> '+item.server_name+'</span>' +
									'</label>';
					});
				}
				$(document).find('[tag-id="tow-server"]').html(tow_item);
				
				//自定义服务
				if( result.server_type == 2){
					_form.find('[component-id="options"] [tag-id="options-1"]').eq(0).addClass('hide');
					_form.find('[component-id="options"] [tag-id="options-2"]').eq(0).removeClass('hide');
					if( result.icon_path ){
						_form.find('[tag-id="icon_log"]').attr('src', result.icon_path);
					}
					_form.find('select[name="service_id"]').val(0);
					//自定义服务ID
					_form.find('input[name="custom_service_id"]').val(result.service_id);
				}else{
					_form.find('[component-id="options"] [tag-id="options-1"]').eq(0).removeClass('hide');
					_form.find('[component-id="options"] [tag-id="options-2"]').eq(0).addClass('hide');
					_form.find('input[name="service_name"]').val('');
					_form.find('select[name="icon_id"]').val(0);
				}
				
				//详情类型
				if( result.service_detail_type == 1 ){
					_form.find('[component-id="options"] [tag-id="options-1"]').eq(1).removeClass('hide');
					_form.find('[component-id="options"] [tag-id="options-2"]').eq(1).addClass('hide');
					
				}else{
					_form.find('[component-id="options"] [tag-id="options-1"]').eq(1).addClass('hide');
					_form.find('[component-id="options"] [tag-id="options-2"]').eq(1).removeClass('hide');
					_form.find('textarea[name="service_content"]').val('');
				}
				
			}
		});
		
		//还原表单第一步
		$(document).find('[tag-id="setup-1"]').removeClass('hide');
		$(document).find('[tag-id="options-1"]').removeClass('hide');
		$(document).find('[tag-id="options-2"]').addClass('hide');
		$(document).find('[tag-id="setup-2"]').addClass('hide');
		$(document).find('[tag-id="setup-2-1"]').addClass('hide');
		$(document).find('[tag-id="tow-server"]').html('');
		
		//打开窗口
		$.common.openWindow({
			id:'addEdit',
			title:$.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			height:500,
			width:700,
			reset: true,
			enable_next:true,	//启用下一步
			next_class: 'custom-next',
			next_function:function(){
				
				//服务类型;1：推荐服务、2：自定义服务
				var server_type = _form.find('[tag-name="server-type"]:checked');
				
				//已选推荐服务
				var system_server	= _form.find('select[name="service_id"] option:selected');
				
				//显示第二步
				$(document).find('[tag-id="setup-1"]').addClass('hide');
				$(document).find('[tag-id="setup-2"]').removeClass('hide');
				
				if(parseInt(system_server.attr('message-type')) == 2){
					$(document).find('[tag-id="setup-2-'+server_type.val()+'"]').removeClass('hide');
				}
				
				//隐藏下一步按钮
				$(document).find('.custom-next').addClass('hide');
				
				//显示上一步 和 确认按钮
				$(document).find('.custom-back').removeClass('hide');
				$(document).find('.custom-confirm').removeClass('hide');
			},
			enable_back: true,	//启用上一步
			back_class: 'custom-back hide',
			back_function: function(){
				//显示第一步
				$(document).find('[tag-id="setup-1"]').removeClass('hide');
				$(document).find('[tag-id="setup-2"]').addClass('hide');
				$(document).find('[tag-id="setup-2-1"]').addClass('hide');
				
				//隐藏确认 和 上一步按钮
				$(document).find('.custom-confirm').addClass('hide');
				$(document).find('.custom-back').addClass('hide');
				
				//显示下一步
				$(document).find('.custom-next').removeClass('hide');
			},
			confirm_class: 'custom-confirm hide',
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				//添加编辑商户
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				shopsetting.saveRoomServer('addEdit', flag);
			}
		});
		
	});
	
	//服务详情类型
	$(document).on('click', '[event-name="tabOptions"]', function(){
		$.common.webupload_initialize(webupload,'pic_md5',1,'jpeg,png,jpg');
	});
	
	//获取二级服务
	$(document).on('change', '[event-name="getChildServer"]', function(){
		var _this 			= $(this);
		var url 			= $.common.typeCheck(_this.attr('url'), 'undefined', '');
		var target_id 		= $.common.typeCheck(_this.attr('target-id'), 'undefined', '');
		
		var target_tag		= $(document).find('[tag-id="'+target_id+'"]');
		
		if( _this.val() == 0 ){
			target_tag.html('');
			return;
		}
		
		$.common.ajaxFormSubmit({
			url: url,
			data: {id:_this.val()},
			success: function(result){
				$.common.closeTips();
				
				if( parseInt(result.status) == 0 ){
					$.common.openTips({
						message: '获取数据失败！',
					}, 'error');
				}
				
				//数据不为空
				var tow_item = '';
				if( typeof(result.data) == 'object' && result.data.length > 0){
					$.each(result.data, function(i, item){
						
						if( i > 0 ){
							tow_item += '<span class="separate-3"></span>';
						} 
						
						tow_item += '<label>' +
										'<input name="two_service_ids[]" value="'+item.id+'" type="checkbox" class="ace">' +
										'<span class="lbl"> '+item.server_name+'</span>' +
									'</label>';
						
					});
				}
				
				target_tag.html(tow_item);
			}
		});
	});
	
	/************************************** 问卷 *******************************/
	
	//新增编辑服务意见
	$(document).on('click', '[event-name="addEditQuest"]', function(){
		var _this = $(this);
		
		var _form = $(document).find('[form-id="addEdit"]');
		
		var item_body = _form.find('[tag-id="item-body"]');
		
		//还原初始化
		_form.find('input[name="hotel_id"]').val(0);
		_form.find('input[name="hotel_name"]').val('');
		item_body.html('<div class="init">请添加问卷题目</div>');

		//获取详情
		$.common.getInfoRender({
			event_object: _this,
			form_id: 'addEdit',
			success: function(result){
				//console.log(result);
				
				var item_list = '';
				
				if( typeof(result.items) != 'object' || result.items.length == 0){
					item_body.html('<div class="init">请添加问卷题目</div>');
					return ;
				}
				
				$.each(result.items, function(i, item){
					switch( parseInt(item.subject_type) ){
						//单选题
						case 1:
							item_list += '<div class="item-option" tag-name="item-option">' +
										'<label for="form-field-8">单选题 &nbsp;</label>' +
										'<input name="subject_id" type="hidden" value="'+ item.id +'" />' +
										'<input name="subject_type" type="hidden" value="1" />' +
										'<textarea class="form-control title" name="title" placeholder="请输入标题">'+ item.title +'</textarea>' +
										
										'<div class="col-sm-9 floor-info" style="margin-top:10px;">' +
										'<div tag-id="dev-list">';
							
							//选项
							if( typeof(item.options) == 'object' && item.options.length > 0){
								item_list += '<div class="row-td td-tit"><span>选项</span></div> ' +
											'<div class="row-td" style="width:60%;">' +
												'<div class="col-sm-9">' +
													'<input name="option_id" type="hidden" value="'+item.options[0].id+'" />' +
													'<input type="text" name="option_name" placeholder="输入选项" class="col-xs-10 col-sm-3" value="'+item.options[0].option_name+'" >' +
												'</div>' +
											'</div>';
							}
											
											
											
							item_list += '<div class="item-list">' +
												'<ul tag-id="floor-item">';
												
												if( typeof(item.options) == 'object' && item.options.length > 1 ){
													$.each(item.options, function(o_i, o_item){
														if(o_i > 0){
															item_list += '<li><div class="row-td td-tit"><span>选项</span></div> <div class="row-td" style="width:60%;"><div class="col-sm-9"><input name="option_id" type="hidden" value="'+o_item.id+'"><input type="text" name="option_name" placeholder="输入选项" value="'+o_item.option_name+'" class="col-xs-10 col-sm-3"></div></div> <a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a></li>';
														}
													});
												}
												
							item_list += '</ul>' +
											'</div>' +
										'</div>';
							
								
							
											 
												
							 item_list += '<a event-name="addItmeOption" href="javascript:void(0);" class="add-floor-btn">' +
												'<i class="icon-plus-sign"></i> 添加选项' +
											'</a>' +
										'</div>' +
										'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>'+
									'</div>';
							break;
						//多选题
						case 2:
							item_list += '<div class="item-option" tag-name="item-option">' +
										'<label for="form-field-8">多选题 &nbsp;</label>' +
										'<input name="subject_id" type="hidden" value="'+ item.id +'" />' +
										'<input name="subject_type" type="hidden" value="1" />' +
										'<textarea class="form-control title" name="title" placeholder="请输入标题">'+ item.title +'</textarea>' +
										
										'<div class="col-sm-9 floor-info" style="margin-top:10px;">' +
										'<div tag-id="dev-list">';
							
							//选项
							if( typeof(item.options) == 'object' && item.options.length > 0){
								item_list += '<div class="row-td td-tit"><span>选项</span></div> ' +
											'<div class="row-td" style="width:60%;">' +
												'<div class="col-sm-9">' +
													'<input name="option_id" type="hidden" value="'+item.options[0].id+'" />' +
													'<input type="text" name="option_name" placeholder="输入选项" class="col-xs-10 col-sm-3" value="'+item.options[0].option_name+'" >' +
												'</div>' +
											'</div>';
							}
											
											
											
							item_list += '<div class="item-list">' +
												'<ul tag-id="floor-item">';
												
												if( typeof(item.options) == 'object' && item.options.length > 1 ){
													$.each(item.options, function(o_i, o_item){
														if(o_i > 0){
															item_list += '<li><div class="row-td td-tit"><span>选项</span></div> <div class="row-td" style="width:60%;"><div class="col-sm-9"><input name="option_id" type="hidden" value="'+o_item.id+'"><input type="text" name="option_name" placeholder="输入选项" value="'+o_item.option_name+'" class="col-xs-10 col-sm-3"></div></div> <a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a></li>';
														}
													});
												}
												
							item_list += '</ul>' +
											'</div>' +
										'</div>';
							
								
							
											 
												
							 item_list += '<a event-name="addItmeOption" href="javascript:void(0);" class="add-floor-btn">' +
												'<i class="icon-plus-sign"></i> 添加选项' +
											'</a>' +
										'</div>' +
										'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>'+
									'</div>';
							break;
						//填空题
						case 3:
							item_list += '<div class="item-option" tag-name="item-option">' +
										'<label for="form-field-8">填空题 &nbsp;</label>' +
										'<input name="subject_id" type="hidden" value="'+ item.id +'" />' +
										'<input name="subject_type" type="hidden" value="3" />' +
										'<textarea class="form-control title" name="title" placeholder="请输入标题">'+ item.title +'</textarea>' +
										'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
									'</div>';
							break;
					}
				});
				
				item_body.html( item_list );
				
			}
			
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'addEdit',
			height: 700,
			width: 720,
			title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
			confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
			confirm_function: function(){
				
				var items = [];
				var item_list = _form.find('[tag-id="item-body"] [tag-name="item-option"]');
				if( item_list.length > 0 ){
					$.each(item_list, function(i, item){
						var _item = $(item);
						
						//题目
						var tmp = {
								//题目ID
								subject_id: _item.find('input[name="subject_id"]').val(),
								//题型
								subject_type: _item.find('input[name="subject_type"]').val(),
								//标题
								title: _item.find('textarea[name="title"]').val(),
								//选项
								options: [],
						};
						
						var options_item = _item.find('input[name="option_name"]');
						var options_id = _item.find('input[name="option_id"]');
						
						if(options_item.length > 0 ){
							$.each(options_item, function(o_i, o_item){
								
								var o_tmp = {
										option_id: options_id.eq(o_i).val(),
										option_name: $(o_item).val()
								};
								
								tmp.options.push( o_tmp );
							});
						}
						
						items.push(tmp);
					});
				}
				
				//问卷没有任何题目
				if(items.length == 0){
					$.common.openTips({
						message: '请添加问卷题目！',
					}, 'warning');
					
					return false;
				}
				
				//console.log(items);return;
				
				var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
				shopsetting.saveQuest('addEdit', flag, items);
			}
		});
		
	});
	
	//添加题目
	$(document).on('click', '[event-name="add-quest-item"]', function(){
		var _this = $(this);
		var _form = $(document).find('[form-id="addEdit"]');
		var flag = _this.attr('flag');
		
		var item = '';
		
		switch( parseInt(flag) ){
			//单选题
			case 1:
				item = '<div class="item-option" tag-name="item-option">' +
							'<label for="form-field-8">单选题 &nbsp;</label>' +
							'<input name="subject_id" type="hidden" value="0" />' +
							'<input name="subject_type" type="hidden" value="1" />' +
							'<textarea class="form-control title" name="title" placeholder="请输入标题"></textarea>' +
							
							'<div class="col-sm-9 floor-info" style="margin-top:10px;">' +
								'<div tag-id="dev-list">' +
									'<div class="row-td td-tit"><span>选项</span></div> ' +
									'<div class="row-td" style="width:60%;">' +
										'<div class="col-sm-9">' +
											'<input name="option_id" type="hidden" value="0" />' +
											'<input type="text" name="option_name" placeholder="输入选项" class="col-xs-10 col-sm-3" >' +
										'</div>' +
									'</div>' +
									'<div class="item-list">' +
										'<ul tag-id="floor-item">' +
											
										'</ul>' +
									'</div>' +
								'</div>' +
								'<a event-name="addItmeOption" href="javascript:void(0);" class="add-floor-btn">' +
									'<i class="icon-plus-sign"></i> 添加选项' +
								'</a>' +
							'</div>' +
							'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>'+
						'</div>';
				break;
			//多选题
			case 2:
				item = '<div class="item-option" tag-name="item-option">' +
							'<label for="form-field-8">多选题 &nbsp;</label>' +
							'<input name="subject_id" type="hidden" value="0" />' +
							'<input name="subject_type" type="hidden" value="2" />' +
							'<textarea class="form-control title" name="title" placeholder="请输入标题"></textarea>' +
							
							'<div class="col-sm-9 floor-info" style="margin-top:10px;">' +
								'<div tag-id="dev-list">' +
									'<div class="row-td td-tit"><span>选项</span></div> ' +
									'<div class="row-td" style="width:60%;">' +
										'<div class="col-sm-9">' +
											'<input name="option_id" type="hidden" value="0" />' +
											'<input type="text" name="option_name" placeholder="输入选项" class="col-xs-10 col-sm-3" >' +
										'</div>' +
									'</div>' +
									'<div class="item-list">' +
										'<ul tag-id="floor-item">' +
											
										'</ul>' +
									'</div>' +
								'</div>' +
								'<a event-name="addItmeOption" href="javascript:void(0);" class="add-floor-btn">' +
									'<i class="icon-plus-sign"></i> 添加选项' +
								'</a>' +
							'</div>' +
							'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>'+
						'</div>';
				break;
			//填空题
			case 3:
				item = '<div class="item-option" tag-name="item-option">' +
							'<label for="form-field-8">填空题 &nbsp;</label>' +
							'<input name="subject_id" type="hidden" value="0" />' +
							'<input name="subject_type" type="hidden" value="3" />' +
							'<textarea class="form-control title" name="title" placeholder="请输入标题"></textarea>' +
							'<a href="javascript:void(0);" style="margin-left:10px;" event-name="removeQuestItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
						'</div>';
				break;
		}
		
		//追加题目
		var body_text = _form.find('[tag-id="item-body"]').text().trim();
		
		if( body_text == "请添加问卷题目" ){
			_form.find('[tag-id="item-body"]').html('');
		}
		_form.find('[tag-id="item-body"]').append(item);
		
		return false;
	});
	
	//添加题目选项；
	$(document).on('click', '[event-name="addItmeOption"]', function(){
		
		var _this = $(this);
		
		var item = '<li>' +
						'<div class="row-td td-tit"><span>选项</span></div> ' +
						'<div class="row-td" style="width:60%;">' +
							'<div class="col-sm-9">' +
								'<input name="option_id" type="hidden" value="0" />' +
								'<input type="text" name="option_name" placeholder="输入选项" class="col-xs-10 col-sm-3">' +
							'</div>' +
						'</div> ' +
						'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
					'</li>';
		
		_this.parents('.floor-info').eq(0).find('[tag-id="floor-item"]').append( item );
		
	});
	
	//删除问卷题目
	$(document).on('click', '[event-name="removeQuestItem"]', function(){
		var _form = $(document).find('[form-id="addEdit"]');
		
		$(this).parent('[ tag-name="item-option"]').remove();
		
		var items = _form.find('[tag-id="item-body"]').html();
		if( items == '' ){
			_form.find('[tag-id="item-body"]').html('<div class="init">请添加问卷题目</div>');
		}
	});
	
	//获取问卷详情
	$(document).on('click', '[event-name="viewQuest"]', function(){
		var _this 		= $(this);
		var url			= $.common.typeCheck(_this.attr('url'), 'undefined', '');
		
		var _info		= $(document).find('[tag-id="quest-info"]');
		
		//获取详情
		$.common.ajaxFormSubmit({
			url: url,
			data: $.common.getParams({event_object: _this}),
			success: function(result){
				console.log(result);
				var _items	= _info.find('[tag-id="quest-item"]');
				var quest_info	= '';
				
				if( result.status == 1 && typeof(result.data) == 'object' ){
					if( typeof(result.data.items) == 'object' && result.data.items.length > 0 ){
						$.each(result.data.items, function(i, item){
							switch( parseInt(item.subject_type) ){
								//单选
								case 1:
									//选项内容
									var options	= '';
									
									if( typeof(item.options) == 'object' && item.options.length > 0 ){
										$.each(item.options, function(o_i, o_item){
											options += '<label>' +
															'<input disabled="disabled" name="" type="radio" class="ace">' +
															'<span class="lbl"> ' + o_item.option_name + '</span>' +
														'</label>' +
														'<span class="separate-3"></span>';
										});
									}
									
									
									//单选详情
									quest_info	+= '<li>' +
														'<label class="item-tit" for="form-field-8">'+ item.data_sort +'. ' + item.title + '</label>' +
														'<div>' + options + '</div>' +
													'</li>';
									break;
								//多选
								case 2:
									//选项内容
									var options	= '';
									
									if( typeof(item.options) == 'object' && item.options.length > 0 ){
										$.each(item.options, function(o_i, o_item){
											options += '<label>' +
															'<input disabled="disabled" name="" type="checkbox" class="ace">' +
															'<span class="lbl"> ' + o_item.option_name + '</span>' +
														'</label>' +
														'<span class="separate-3"></span>';
										});
									}
									
									
									//单选详情
									quest_info	+= '<li>' +
														'<label class="item-tit" for="form-field-8">'+ item.data_sort +'. ' + item.title + '</label>' +
														'<div>' + options + '</div>' +
													'</li>';
									break;
								//填空
								case 3:
									quest_info	+= '<li>' +
														'<div>' +
															'<label class="item-tit" for="form-field-8">'+ item.data_sort +'. ' + item.title + '</label>' +
															'<textarea disabled="disabled" class="form-control"></textarea>' +
														'</div>' +
													'</li>';
									break;
							}
						});
					}
				}else{
					quest_info = '<div class="init">问卷未添加答题</div>';
				}
				
				//载入问卷内容
				_items.html(quest_info);
				
				//关闭加载框
				$.common.closeTips();
			}
		});
		
		//打开窗口
		$.common.openWindow({
			id: 'viewQuest',
			height: 550,
			width: 750,
			title: '问卷详情',
			enable_confirm: false,
			cancel_title: '关闭',
		});
	});
});