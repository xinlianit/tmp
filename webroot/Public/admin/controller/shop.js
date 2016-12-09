/**
 * 商户信息维护
 */
seajs.use(['webupload', 'module/shop'],function(webupload, shop){
	
	//显示信息
	$(function(){
		
		//添加编辑商户
		$(document).on('click', '[event-name="addEdit"]', function(){
			var _this = $(this);
			
			var _form = $(document).find('[form-id="addEdit"]');
			
			//添加编辑商户
			var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
			
			//清除上一次数据
			_form.find('[tag-id="checked-type"]').html('请选择类型');
			_form.find('input[name="hotel_type"]').val('');
			
			//MP3、图片数据
			var audio_file 	= false;
			var pic_file	= false;
			
			//请求数据
			var request_data = {};
			
			//获取初始换数据
			var get_info_url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
			var data = $.common.typeCheck(_this.attr('params'), 'undefined', false);
			if( data !== false ){
				data = $.common.urlParamsToJson( data );
				
				request_data = Object.assign(request_data, data);
			}
			
			if(flag == 'edit'){
				//隐藏上传
				_form.find('[tag-id="cancel-upload"]').removeClass('hide');
				//显示预览图
				_form.find('[tag-id="view"]').removeClass('hide');
				//显示取消上传
				_form.find('[tag-id="upload"]').addClass('hide');
			}
			
			if( get_info_url ){
				$.common.ajaxFormSubmit({
					url: get_info_url,
					data: request_data,
					async: false,
					success:function(result){
						//获取数据失败
						if( result.status == 0 ){
							$.common.openTips({
								message: result.msg,
							},'error');
							
							return false;
						}
						
						//渲染数据
						$.common.renderData({
							form_id: 'addEdit',
							data: result.data
						});
						
						//酒店类型
						if( typeof(result.data.hotel_type_name) == 'object' && result.data.hotel_type_name.length > 0){
							var type_item = '';
							$.each(result.data.hotel_type_name, function(i, item){
								type_item +='<span><span class="label" tag-id="label">'+item+' <i id="'+result.data.hotel_type[i]+'" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span></span>';
							});
							
							_form.find('[tag-id="checked-type"]').html(type_item);
						}
						
						//开机语音
						if( result.data.audio_path ){
							audio_file 	= [{src:result.data.audio_path, md5val:result.data.audio_md5, mtype:'mp3'}];
						}
						
						if( result.data.pic_path ){
							pic_file	= [{src:result.data.pic_path, md5val:result.data.pic_md5}];
						}
						
						
						
						//预览图
						//_form.find('[tag-id="img"]').attr('src',result.data.res_path);
						
						//省市区
						var com = '<div id="city-component1" tag-id="city_1" url="'+getTrad_url+'" class="city-component" default-province="'+result.data.province_id+'" default-city="'+result.data.city_id+'" default-region="'+result.data.region_id+'"></div>';
						_form.find('[tag-id="city-com"]').html(com);
						
						//最新商圈
						var trand_options = '<option value="0">请选择</option>';
						if( typeof(result.data.trand) == 'object' && result.data.trand.length > 0){
							$.each(result.data.trand, function(i, item){
								if(item.id == result.data.trade_id){
									var selected='selected="selected"';
								}else{
									var selected='';
								}
								trand_options += '<option value="'+item.id+'" selected>'+item.area_name+'</option>';
							});
						}
						_form.find('select[name="trade_id"]').html(trand_options);
						
						//地区组件
						$.common.cityComponent('city-component1');
						
						//关闭加载
						$.common.closeTips('loading-in');
					},
				});
			}
			
			//还原表单第一步
			$(document).find('[tag-id="setup-1"]').removeClass('hide');
			$(document).find('[tag-id="setup-2"]').addClass('hide');
			
			//打开窗口
			$.common.openWindow({
				id:'addEdit',
				title:$.common.typeCheck(_this.attr('dialog-title'), 'undefined', ''),
				height:730,
				width:700,
				reset: true,
				enable_next:true,	//启用下一步
				next_class: 'custom-next',
				next_function:function(){
					//必填参数检测
					var form = $(document).find('[form-id="addEdit"]');
					
					//商户名称必须填写
					if( form.find('input[name="hotel_name"]').val() == '' ){
						$.common.openTips({
							className: 'error',
							icon: 'icon-info-sign',
							message: "请输入商户名称",
						});
						
						//光标定位
						form.find('input[name="hotel_name"]').focus();
						
						setTimeout(function(){
							$.common.closeTips('error');
						},3000);
						return false;
					}
					
					//商户类型必须选择
					if( form.find('input[name="hotel_type"]').val() == '' ){
						$.common.openTips({
							className: 'error',
							icon: 'icon-info-sign',
							message: "请选择商户类型",
						});
						
						setTimeout(function(){
							$.common.closeTips('error');
						},3000);
						return false;
					}
					
					
					//显示第二步
					$(document).find('[tag-id="setup-1"]').addClass('hide');
					$(document).find('[tag-id="setup-2"]').removeClass('hide');
					
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
					
					//隐藏确认 和 上一步按钮
					$(document).find('.custom-confirm').addClass('hide');
					$(document).find('.custom-back').addClass('hide');
					
					//显示下一步
					$(document).find('.custom-next').removeClass('hide');
				},
				confirm_class: 'custom-confirm hide',
				confirm_title: $.common.typeCheck(_this.attr('submit-title'), 'undefined', ''),
				confirm_function: function(){
					shop.saveShop('addEdit', flag);
				}
			});
			
			//上传组件
			$.common.webupload_initialize(webupload,'pic_md5',1,'jpeg,png,jpg', {
				viewfile: typeof(pic_file) == '' ? false : pic_file
			});
			
			$.common.webupload_initialize(webupload,'voice_md5',2,'mp3', {
				viewfile: typeof(audio_file) == '' ? false : audio_file
			});
			
			//地区组件
			$.common.cityComponent('city-component1');
		});
		
		//选择类型
		$(document).on('click','[event-name="add-type"]',function(){
			var _this = $(this);
			var _this_form = _this.parents('form').eq(0);
			
			//获取已选中标签值
			var checked_val = _this.parents('form').eq(0).find('input[name="hotel_type"]').val();
			var checked_val_arr = $.common.stringToArray(checked_val, ',');
			
			//判断是否已请求获取数据
			if( !$.common.typeCheck(_this.attr('status'), 'undefined', false) ){
				//未请求
				$.common.ajaxFormSubmit({
					type: 'GET',
					url: _this.attr('url'),
					success:function(result){
						//返回错误
						if(result.status != 1){
							$.common.openTips({
								icon: 'icon-remove',
								className: 'error',
								message: result.msg
							});
							return false;
						}
						
						//数据绑定
						var fun_items 			= '<dl class="big-item">'+
													'<dt class="big-tit">功能类型</dt>';
						var level_item 			= '<dl class="big-item">'+
													'<dt class="big-tit">星级类型</dt>';
						var constom_item 		= '<dl class="big-item">'+
													'<dt class="big-tit">自定义类型</dt>';
						
						var type_items = '';
						
						$.each(result.data, function(i,item){
							
							//选中属性
							var checked = '';
							if( $.common.inArray(item.id, checked_val_arr) ){
								checked = 'checked="checked"';
							}
							
							type_items = '<dd class="small-item">' +
											'<div class="checkbox">' +
												'<label>' +
													'<input '+checked+' name="form-field-checkbox" tag-name="type-item" type="checkbox" class="ace" title="'+item.type_name+'" value="'+item.id+'">' +
													'<span class="lbl"> '+item.type_name+'</span>' +
												'</label>' +
											'</div>' +
										 '</dd>';
							switch( parseInt(item.type_class) ){
								case 1:
									fun_items += type_items;
									break;
								case 2:
									level_item += type_items;
									break;
								case 3:
									constom_item += type_items;
									break;
							}
							
						});
						
						fun_items 		+= '</dl>';
						level_item 		+= '</dl>';
						constom_item 	+= '</dl>';
						
						$(document).find('[tag-id="type-items"]').html(fun_items+level_item+constom_item);
					},
				});
				
				//标识已请求
				_this.attr('status','ok');
				
				//关闭提示框
				$.common.closeTips();
			}else{
				//已请求过
				
				//获取选项列表
				$(document).find('[tag-id="type-items"]').find('[tag-name="type-item"]:checked').each(function(){
					//过滤掉已移除的选项，设为不选中
					if( !$.common.inArray($(this).val(), checked_val_arr) ){
						$(this).removeAttr('checked');
					}
				});
				
			}
			
			//显示类型框
			$.common.openWindow({
				id: 'type',
				title: '酒店类型',
				height:730,
				width:700,
				confirm_function: function(){
					//获取已选值
					var checked_val = [];
					var checked_name = '';
					$(document).find('[tag-id="type-items"]').find('input:checked').each(function(){
						checked_val.push($(this).val());
						
						checked_name += '<span><span class="label" tag-id="label">'+$(this).attr('title')+' <i id="'+$(this).val()+'" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span></span>';
					});
					
					//标签加入标签区域
					_this_form.find('[tag-id="checked-type"]').html(checked_name);
					//选中的值加入隐藏域
					_this_form.find('input[name="hotel_type"]').val(checked_val);
					//关闭当前弹框
					$( this ).dialog( "close" );
				},
			});
			
			
		});
		
		//移除酒店标签
		$(document).on('click','[event-name="removeType"]',function(){
			//要删除的标签值
			var tag_val = $(this).attr('id');
			
			//移除标签值
			var type = $(this).parents('form').eq(0).find('input[name="hotel_type"]');
			var type_val = type.val().split(',');
			var new_val = $.common.removeArrayItem(type_val, tag_val);
			
			//隐藏域重新赋值
			type.val(new_val);
			
			//移除标签名称
			$(this).parent('[tag-id="label"]').parent('span').remove();
		});
		
		//获取商圈
		$(document).on('change', '[tag-id="city_1"] .area', function(){
			var _this = $(this);
			
			var url = $(document).find('[tag-id="city_1"]').attr('url');
			
			//获取商圈
			$.common.ajaxFormSubmit({
				url: url,
				data: {id:_this.val()},
				success: function(result){
					var options = '<option value="0">请选择</option>';
					
					if(result.status == 1){
						
						if(typeof(result.data) == 'object' && result.data.length > 0){
							$.each(result.data, function(i, item){
								options += '<option value="'+item.id+'">'+item.area_name+'</option>';
							});
						}
					}
					
					$(document).find('[form-id="addEdit"] select[name="trade_id"]').html(options);
					
					$.common.closeTips();
				}
			});
		});
		
//		$(document).on('click', '[event-name="getCircle"]', function(){
//			var _this = $(this);
//			var target_obj = _this.parents('form').eq(0);
//			
//			//获取省份、城市、地区值
//			var province_id 	= target_obj.find('select[name="province_id"]').val();
//			var city_id 		= target_obj.find('select[name="city_id"]').val();
//			var region_id 		= target_obj.find('select[name="region_id"]').val();
//			
//			var data = {};
//			
//			if( parseInt(city_id) != 0 && parseInt(region_id) == 0 ){
//				data.parent_city_id	= province_id;
//			}else if( parseInt(region_id) != 0 ){
//				data.parent_city_id	= city_id;
//			}
//			
//			var options = '<option value="0">--请选择--</option>';
//			
//			$.ajax({
//				url: _this.attr('url'),
//				data: data,
//				success: function(result){
//					if( typeof(result.status) != 'undefined' && parseInt(result.status) == 1 && typeof(result.data) == 'object' )
//					{
//						$.each(result.data, function(i,item){
//							options += '<option value="' + item.id + '">' + item.city_name + '</option>';
//						});
//					}
//					
//					target_obj.find('[tag-name="circle"]').html( options );
//				}
//			});
//			
//		});
		
		//编辑上传图片
		$(document).on('click', '[event-name="edit-upload"]', function(){
			$(document).find('[tag-id="view"]').addClass('hide');
			$(document).find('[tag-id="upload"]').removeClass('hide');
			
			//上传组件
			$.common.webupload_initialize(webupload,'pic_md5',1,'jpeg,png,jpg');
			$.common.webupload_initialize(webupload,'voice_md5',2,'mp3');
		});
		
		//取消上传图片
		$(document).on('click', '[event-name="cancel-upload"]', function(){
			$(document).find('[tag-id="view"]').removeClass('hide');
			$(document).find('[tag-id="upload"]').addClass('hide');
		});
		
		
		//查看商户详情
		$(document).on('click', '[event-name="viewInfo"]', function(){
			
			var _this = $(this);
			
			var _dialog = $(document).find('[dialog-id="view"]');
			
			//酒店ID
			_dialog.find('[tag-id="hotel_id"]').html( $.common.intFormat(0, 5) );
			//商户名称
			_dialog.find('[tag-id="hotel_name"]').html('-');
			//商户类型
			_dialog.find('[tag-id="hotel_type"]').html('-');
			//商户地址
			_dialog.find('[tag-id="hotel_address"]').html('-');
			//所属商圈
			_dialog.find('[tag-id="hotel_trad"]').html('-');
			//联系人
			_dialog.find('[tag-id="hotel_contacts"]').html('-');
			//联系电话
			_dialog.find('[tag-id="hotel_phone"]').html('-');
			//广告位
			_dialog.find('[tag-id="adver_number"]').html('-');
			
			//获取详情
			$.common.getInfoRender({
				event_object: _this,
				form_id: 'addEdit',
				success: function(result){
					//图片
					_dialog.find('[tag-id="hotel_img"]').attr('src', result.res_path);
					//酒店ID
					_dialog.find('[tag-id="hotel_id"]').html( $.common.intFormat(result.id, 5) );
					//商户名称
					_dialog.find('[tag-id="hotel_name"]').html(result.hotel_name);
					//商户类型
					if( typeof(result.hotel_type_name) == 'object' && result.hotel_type_name.length > 0){
						_dialog.find('[tag-id="hotel_type"]').html(result.hotel_type_name.join('、'));
					}
					
					//商户地址
					if( result.city_all_name != '' || result.address != ''){
						_dialog.find('[tag-id="hotel_address"]').html(result.city_all_name+' '+result.address);
					}
					
					//所属商圈
					if( result.trade_name != '' && result.trade_name != null ){
						_dialog.find('[tag-id="hotel_trad"]').html(result.trade_name);
					}
					
					//联系人
					if( result.contacts != '' && result.contacts != null ){
						_dialog.find('[tag-id="hotel_contacts"]').html(result.contacts);
					}
					
					//联系电话
					if( result.contact_way != '' && result.contact_way != null ){
						_dialog.find('[tag-id="hotel_phone"]').html(result.contact_way);
					}
					
					//广告位
					if( result.adver_number != '' && result.adver_number != null ){
						_dialog.find('[tag-id="adver_number"]').html(result.adver_number);
					}
					
				}
			});
			
			//打开窗口
			$.common.openWindow({
				id: 'view',
				height: 540,
				width: 600,
				title: '商户详情',
				enable_confirm: false,
				cancel_title: '关闭',
			});
		});
		
		//添加编辑楼层
		$(document).on('click', '[event-name="addEditFloor"]', function(){
			var _this = $(this);
			
			var _form = $(document).find('[form-id="addEdit"]');

			//获取详情
			$.common.getInfoRender({
				event_object: _this,
				form_id: 'addEdit',
				success: function(result){
					_form.find('input[name="hotel_id"]').val(result.id);
					
					var floor_item = '';
					
					if( typeof(result.floor_list) == 'object' && result.floor_list.length > 0){
						
						floor_item += 	'<div class="row-td td-tit"><span>楼层名称</span></div> ' +
										'<div class="row-td">' +
											'<div class="col-sm-9">' +
												'<input type="text" name="floor_name[]" placeholder="输入楼层名称" value="'+result.floor_list[0].floor_name+'" class="col-xs-10 col-sm-3" >' +
											'</div>' +
										'</div> ' +
										'<div class="row-td td-tit"><span>房间数量 </span></div> ' +
										'<div class="row-td" style="width:15%;">' +
											'<div class="col-sm-9">' +
												'<input type="text" name="room_number[]" placeholder="输入数量" value="'+result.floor_list[0].room_number+'" class="col-xs-10 col-sm-2" >' +
											'</div>' +
										'</div> ' +
										'<div class="row-td td-last"><span>间 </span></div>' +
										'<div class="item-list">' +
											'<ul tag-id="floor-item">';
						
						$.each(result.floor_list, function(i,item){
							
							if( i > 0 ){ 
								floor_item += '<li>' +
													'<div class="row-td td-tit"><span>楼层名称</span></div> ' +
													'<div class="row-td">' +
														'<div class="col-sm-9">' +
															'<input type="text" name="floor_name[]" placeholder="输入楼层名称" value="'+item.floor_name+'" class="col-xs-10 col-sm-3" >' +
														'</div>' +
													'</div> ' +
													'<div class="row-td td-tit"><span>房间数量</span></div> ' +
													'<div class="row-td" style="width:15%;">' +
														'<div class="col-sm-9">' +
															'<input type="text" name="room_number[]" placeholder="输入数量" value="'+item.room_number+'" class="col-xs-10 col-sm-2" >' +
														'</div>' +
													'</div> ' +
													'<div class="row-td td-last"><span>间 </span></div>' +
													'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
												'</li>';
							}
						});
						
						floor_item	+= '</ul></div>';
					}
					
					//赋值
					if( floor_item != '' ){
						_form.find('[tag-id="floor-list"]').html(floor_item);
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
					
					var floor_name = _form.find('input[name="floor_name[]"]');
					var floor_room = _form.find('input[name="room_number[]"]');
					
					var floor_status = true;
					
					$.each(floor_name, function(i, item){
						var _item = $(this);
						
						if( _item.val() == '' || $(floor_room[i]).val() == '' ){
							$.common.openTips({
								message: '输入楼层名称和房间数量！',
							},'warning');
							
							floor_status = false;
						}
						
					});
					
					if( floor_status == false ) {
						return false;
					}
					
					var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
					shop.saveFloor('addEdit', flag);
				}
			});
		});
		
		//打开搜索楼层
		$(document).on('click', '[event-name="openSeach"]', function(){
			//打开窗口
			$.common.openWindow({
				id: 'seachShop',
				height: 500,
				width: 700,
				title: '商户搜索',
				confirm_function: function(){
					var hotel_checed 		= $(document).find('[tag-id="hote_id"]:checked');
					var hotel_name 			= hotel_checed.attr('title');
					var hotel_id 			= hotel_checed.val();
					var floor_list			= hotel_checed.attr('data-floor');
					
					var _form = $(document).find('[form-id="addEdit"]');
					_form.find('[name="hotel_id"]').val(hotel_id);
					_form.find('[name="hotel_name"]').val(hotel_name);
					
					//楼层列表
					var floor_select = $(document).find('[tag-id="floor-select"]');
					if( typeof(floor_select) != 'undefined' ){
						
						var options = '<option value="0">请选择</option>';
						
						if( $.common.typeCheck(floor_list, 'undefined', false) ){
							floor_list	= JSON.parse(floor_list);
							
							if( typeof(floor_list) == 'object' && floor_list.length > 0){
								$.each(floor_list, function(i,item){
									options += '<option value="'+item.id+'">'+item.floor_name+'</option>';
								});
							}
						}
						
						$(document).find('[tag-id="floor-select"]').html( options );
					}
					
					//关闭当前弹框
					$( this ).dialog( "close" );
				}
			});
		});
		
		//搜索楼层
		$(document).on('click', '[event-name="seachShop"]', function(){
			var _this = $(this);
			var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
			
			//楼层名称
			var hotel_name = $.common.typeCheck($(document).find('[tag-id="hotel_name" ]').val(), 'undefined', false);
			
			if( !hotel_name ){
				$.common.openTips({
					message: '请输入商户名称搜索'
				},'warning');
				
				return false;
			}
			
			$.common.ajaxFormSubmit({
				type: 'POST',
				url: url,
				data: {hotel_name:hotel_name},
				success:function(result){
					if( typeof(result.data) == 'object' ){
						var hote_list = '';
						$.each(result.data, function(i, item){
							hote_list += '<tr>' +
											'<td class="center">' +
												'<input tag-id="hote_id" title="'+item.hotel_name+'" name="id" type="radio" value="'+item.id+'" data-floor='+JSON.stringify(item.floor_list)+' />' +
											'</td>' +
											'<td>'+item.hotel_name+'</td>' +
											'<td>'+item.hotel_type+'</td>' +
										'</tr>';
						});
						
						if( hote_list == '' ){
							hote_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
						}
						
						//搜索结果赋值
						$(document).find('[tag-id="shop-result"]').html( hote_list );
						
						//关闭加载框
						$.common.closeTips('loading-in');
					}
				}
			});
		});
		
		//移除楼层信息
		$(document).on('click', '[event-name="removeFloorItem"]', function(){
			var _this = $(this);
			_this.parents('li').eq(0).remove();
		});
		
		//添加楼层信息；
		$(document).on('click', '[event-name="addFloorItem"]', function(){
			
			var _this = $(this);
			
			var item = '<li>' +
							'<div class="row-td td-tit"><span>楼层名称</span></div> ' +
							'<div class="row-td">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="floor_name[]" placeholder="输入楼层名称" class="col-xs-10 col-sm-3" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-tit"><span>房间数量</span></div> ' +
							'<div class="row-td" style="width:15%;">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="room_number[]" placeholder="输入数量" class="col-xs-10 col-sm-2" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-last"><span>间 </span></div>' +
							'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
						'</li>';
			
			_this.parents('.floor-info').eq(0).find('[tag-id="floor-item"]').append( item );
			
		});
		
		//查看楼层
		$(document).on('click', '[event-name="viewFloor"]', function(){
			var _this 		= $(this);
			var url			= $.common.typeCheck(_this.attr('url'), 'undefined', '');
			
			//获取详情
			$.common.ajaxFormSubmit({
				url: url,
				data: $.common.getParams({event_object: _this}),
				success: function(result){
					
					if( typeof(result) == 'object' && typeof(result.data) == 'object' ){
						//绑定数据
						var view = $(document).find('[tag-id="floor-view"]');
						
						//酒店名称
						view.find('[tag-id="hotel-name"]').html( result.data.hotel_name );
						//酒店编号
						view.find('[tag-id="hotel-code"]').html( $.common.intFormat(result.data.id, 5) );
						//总房间数
						view.find('[tag-id="room-number"]').html( result.data.total_room_number );
						//楼层列表
						var floor_list = '';
						
						if( typeof(result.data.floor_list) == 'object' && result.data.floor_list.length > 0){
							$.each(result.data.floor_list, function(i, item){
								floor_list += '<tr>' +
													'<td>'+item.floor_name+'</td>' +
													'<td>'+item.room_number+'</td>' +
											  '</tr>';
							});
						}
						
						if( floor_list != '' ){
							view.find('[tag-id="view-list"]').html( floor_list );
						}else{
							view.find('[tag-id="view-list"]').html( '<tr><td colspan="2" style="text-align:center;">暂无楼层信息！</td></tr>' );
						}
						
					}
					
					//关闭加载框
					$.common.closeTips();
				}
			});
			
			//打开窗口
			$.common.openWindow({
				id: 'viewFloor',
				height: 500,
				width: 700,
				title: '楼层信息详情',
				enable_confirm: false,
				cancel_title: '关闭',
			});
		});
		
		//新增编辑设备
		$(document).on('click', '[event-name="addEditDev"]', function(){
			var _this = $(this);
			
			var _form = $(document).find('[form-id="addEdit"]');

			//获取详情
			$.common.getInfoRender({
				event_object: _this,
				form_id: 'addEdit',
				success: function(result){
					
					//商户楼层
					if( typeof(result.floor_list) == 'object' && result.floor_list.length > 0 ){
						var floor_item = '<option value="0">请选择</option>';
						$.each(result.floor_list, function(i, item){
							var is_selected = '';
							
							if(item.id == result.floor_id){
								is_selected = ' selected="selected"';
							}
							floor_item += '<option value="'+item.id+'"'+is_selected+'>'+item.floor_name+'</option>';
						});
						
						$(document).find('[form-id="addEdit"] [tag-id="floor-select"]').html(floor_item);
					}
					
					//类型定位
					var room_type = $(document).find('[form-id="addEdit"] [tag-id="room_type"] option');
					if(room_type.length > 0){
						$.each(room_type, function(i, item){
							if( result.room_type == $(this).val() ){
								$(this).attr('selected','selected');
							}
						});
					}
					
					//设备信息列表
					var dev_item = '';
					
					if( typeof(result.device_list) == 'object' && result.device_list.length > 0){
						
						dev_item += 	'<div class="row-td td-tit"><span>设备地址</span></div> ' +
										'<div class="row-td">' +
											'<div class="col-sm-9">' +
												'<input name="device_id[]" type="hidden" value="'+result.device_list[0].id+'" /><input type="text" name="device_address[]" placeholder="输入设备地址" value="'+result.device_list[0].device_address+'" class="col-xs-10 col-sm-3" >' +
											'</div>' +
										'</div> ' +
										'<div class="row-td td-tit"><span>摆放位置 </span></div> ' +
										'<div class="row-td" style="width:19%;">' +
											'<div class="col-sm-9">' +
												'<input type="text" name="position[]" placeholder="摆放位置" value="'+result.device_list[0].position+'" class="col-xs-10 col-sm-2" >' +
											'</div>' +
										'</div> ' +
										'<div class="item-list">' +
											'<ul tag-id="floor-item">';
						
						$.each(result.device_list, function(i,item){
							
							if( i > 0 ){ 
								dev_item +=  '<li>' +
												'<div class="row-td td-tit"><span>设备地址</span></div> ' +
												'<div class="row-td">' +
													'<div class="col-sm-9">' +
														'<input name="device_id[]" type="hidden" value="'+item.id+'" /><input type="text" name="device_address[]" placeholder="输入设备地址" value="'+item.device_address+'" class="col-xs-10 col-sm-3" >' +
													'</div>' +
												'</div> ' +
												'<div class="row-td td-tit"><span>摆放位置</span></div> ' +
												'<div class="row-td" style="width:19%;">' +
													'<div class="col-sm-9">' +
														'<input type="text" name="position[]" placeholder="摆放位置" value="'+item.position+'" class="col-xs-10 col-sm-2" >' +
													'</div>' +
												'</div> ' +
												'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
											'</li>';
				
							}
						});
						
						dev_item	+= '</ul></div>';
					}
					
					//赋值
					if( floor_item != '' ){
						_form.find('[tag-id="dev-list"]').html(dev_item);
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
					
					var device_address 	= _form.find('input[name="device_address[]"]');
					var position 		= _form.find('input[name="position[]"]');
					
					var floor_status = true;
					
					$.each(device_address, function(i, item){
						var _item = $(this);
						
						if( _item.val() == '' || $(position[i]).val() == '' ){
							$.common.openTips({
								message: '请输入设备地址和摆放位置！',
							},'warning');
							
							floor_status = false;
						}
						
					});
					
					if( floor_status == false ) {
						return false;
					}
					
					var flag = $.common.typeCheck(_this.attr('flag'), 'undefined', 'add');
					shop.saveRoom('addEdit', flag);
				}
			});
		});
		
		//批量新增设备
		$(document).on('click', '[event-name="addDevices"]', function(){
			$.common.openTips({
				message: '暂不支持批量新增！'
			}, 'warning');
		});
		
		//添加设备信息项目；
		$(document).on('click', '[event-name="addDevItem"]', function(){
			
			var _this = $(this);
			
			var item = '<li>' +
							'<div class="row-td td-tit"><span>设备地址</span></div> ' +
							'<div class="row-td">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="device_address[]" placeholder="输入设备地址" class="col-xs-10 col-sm-3" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-tit"><span>摆放位置</span></div> ' +
							'<div class="row-td" style="width:19%;">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="position[]" placeholder="摆放位置" class="col-xs-10 col-sm-2" >' +
								'</div>' +
							'</div> ' +
							'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
						'</li>';
			
			_this.parents('.floor-info').eq(0).find('[tag-id="floor-item"]').append( item );
			
		});
		
	})
});
