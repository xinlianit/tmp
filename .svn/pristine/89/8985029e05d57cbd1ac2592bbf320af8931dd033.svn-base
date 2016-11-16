/**
 * 商户信息维护
 */
seajs.use(['webupload', 'module/shop'],function(webupload, shop){
	
	//显示信息
	$(function(){
		
		//添加商户
		$(document).on('click', '[event-name="addInfo"]', function(){
			
			//还原表单第一步
			$(document).find('[tag-id="setup-1"]').removeClass('hide');
			$(document).find('[tag-id="setup-2"]').addClass('hide');
			
			//初始化上传
			webupload.initialize({
				upload_url: '',
				preview_url: ''
			});
			
			//打开窗口
			$.common.openWindow({
				id:'add',
				title:'新增商户',
				height:730,
				width:700,
				enable_next:true,	//启用下一步
				next_class: 'custom-next',
				next_function:function(){
					//必填参数检测
					var form = $(document).find('[form-id="add"]');
					
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
				confirm_title: '新增',
				confirm_function: function(){
					//添加商户
					shop.addShop('add');
				}
			});
		});
		
		//选择类型
		$(document).on('click','[event-name="add-type"]',function(){
			var _this = $(this);
			
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
						
						checked_name += '<span class="label" tag-id="label">'+$(this).attr('title')+' <i id="'+$(this).val()+'" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span>';
					});
					
					//标签加入标签区域
					$(document).find('[tag-id="checked-type"]').html(checked_name);
					//选中的值加入隐藏域
					$(document).find('[form-id="add"]').find('input[name="hotel_type"]').val(checked_val);
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
			$(this).parent('[tag-id="label"]').remove();
		});
		
		//获取商圈
		$(document).on('click', '[event-name="getCircle"]', function(){
			var _this = $(this);
			var target_obj = _this.parents('form').eq(0);
			
			//获取省份、城市、地区值
			var province_id 	= target_obj.find('select[name="province_id"]').val();
			var city_id 		= target_obj.find('select[name="city_id"]').val();
			var region_id 		= target_obj.find('select[name="region_id"]').val();
			
			var data = {};
			
			if( parseInt(city_id) != 0 && parseInt(region_id) == 0 ){
				data.parent_city_id	= province_id;
			}else if( parseInt(region_id) != 0 ){
				data.parent_city_id	= city_id;
			}
			
			var options = '<option value="0">--请选择--</option>';
			
			$.ajax({
				url: _this.attr('url'),
				data: data,
				success: function(result){
					if( typeof(result.status) != 'undefined' && parseInt(result.status) == 1 && typeof(result.data) == 'object' )
					{
						$.each(result.data, function(i,item){
							options += '<option value="' + item.id + '">' + item.city_name + '</option>';
						});
					}
					
					target_obj.find('[tag-name="circle"]').html( options );
				}
			});
			
		})
		
		//查看商户详情
		$(document).on('click', '[event-name="viewInfo"]', function(){
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
		
		//编辑商户
		$(document).on('click', '[event-name="editInfo"]', function(){
			//alert("编辑");
		});
		
		//添加楼层
		$(document).on('click', '[event-name="addFloor"]', function(){
			//打开窗口
			$.common.openWindow({
				id: 'addFloor',
				height: 500,
				width: 700,
				title: '楼层信息新增',
				confirm_title: '新增',
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
			});
		});
		
		//搜索楼层
		$(document).on('click', '[event-name="seachShop"]', function(){
			alert("搜索楼层");
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
									'<input type="text" name="hotel_name" placeholder="输入楼层名称" class="col-xs-10 col-sm-3" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-tit"><span>房间数量</span></div> ' +
							'<div class="row-td" style="width:15%;">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="hotel_name" placeholder="输入数量" class="col-xs-10 col-sm-2" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-last"><span>间 </span></div>' +
							'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
						'</li>';
			
			_this.parents('.floor-info').eq(0).find('[tag-id="floor-item"]').append( item );
			
		});
		
		//查看楼层
		$(document).on('click', '[event-name="viewFloor"]', function(){
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
		
		//新增设备
		$(document).on('click', '[event-name="addDevice"]', function(){
			//打开窗口
			$.common.openWindow({
				id: 'add',
				height: 500,
				width: 700,
				title: '设备新增',
				confirm_title: '新增',
			});
		});
		
		//添加设备信息项目；
		$(document).on('click', '[event-name="addDevItem"]', function(){
			
			var _this = $(this);
			
			var item = '<li>' +
							'<div class="row-td td-tit"><span>设备地址</span></div> ' +
							'<div class="row-td">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="hotel_name" placeholder="输入设备地址" class="col-xs-10 col-sm-3" >' +
								'</div>' +
							'</div> ' +
							'<div class="row-td td-tit"><span>摆放位置</span></div> ' +
							'<div class="row-td" style="width:19%;">' +
								'<div class="col-sm-9">' +
									'<input type="text" name="hotel_name" placeholder="摆放位置" class="col-xs-10 col-sm-2" >' +
								'</div>' +
							'</div> ' +
							'<a href="javascript:void(0);" event-name="removeFloorItem"><i class="icon-remove-circle" style="font-size:16px;"></i></a>' +
						'</li>';
			
			_this.parents('.floor-info').eq(0).find('[tag-id="floor-item"]').append( item );
			
		});
		
	})
});
