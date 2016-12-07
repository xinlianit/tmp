define(function(require, exports ,module){
	$.extend({
		/**
		 * 常用公共库
		 */
		common: {
			
				/**
				 * 初始换插件
				 * @param string param.city_url		城市获取地址
				 */
				initialize: function(param){
					var param 			= $.common.typeCheck(param, 'undefined', {});
					
					//加载删除事件
					$.common.deleteEvent();
					
					//加载启用停用事件
					$.common.onOffEvent();
					
					//子级全选
					$.common.childCheck();
					
					//单选切换
					$.component.tabOptions();
					
				},
                                
                                /**
                                 * 获取酒店列表 组件（单选）
                                 * @param {type} open_seach_btn
                                 * @param {type} callback
                                 * @returns {undefined}
                                 */
                                get_search_hotel:function(open_seach_btn,callback){
                                    //搜索获取酒店列表
                                    function search_hotel(){
                                        var _this = $(this);
                                        var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
                                        //酒店名称
                                        var hotel_name = $.common.typeCheck($(document).find('[tag-id="hotel_name"]').val(), 'undefined', false);

                                        $.common.ajaxFormSubmit({
                                                type: 'POST',
                                                url: url,
                                                data: {hotel_name:hotel_name},
                                                success:function(result){
                                                    var hote_list = '';
                                                    if( result.status === 1 ){                                                                
                                                            $.each(result.data, function(i, item){
                                                                    hote_list += '<tr>' +
                                                                                '<td class="center">' +
                                                                                        '<input tag-id="hotel_id" title="'+item.hotel_name+'" name="id" type="radio" value="'+item.id+'" />' +
                                                                                '</td>' +
                                                                                '<td>'+item.hotel_name+'</td>' +
                                                                                '<td>'+item.hotel_type+'</td>' +
                                                                                '</tr>';
                                                            });

                                                            if( hote_list === '' ){
                                                                    hote_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                            }
                                                    }else{
                                                        hote_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                    }
                                                    //搜索结果赋值
                                                    $(document).find('[tag-id="shop-result"]').html( hote_list );
                                                    //关闭加载框
                                                    $.common.closeTips('loading-in');
                                                }
                                        });
                                    };
                                    //数据回调
                                    $(document).on('click', '[event-name='+open_seach_btn+']', function(){
                                            //打开窗口
                                            $.common.openWindow({
                                                    id: 'seach-hotel-box',
                                                    height: 500,
                                                    width: 700,
                                                    title: '商户搜索',
                                                    confirm_function: function(){
                                                            var _checed 	= $(document).find('[tag-id="hotel_id"]:checked');
                                                            var _title      	= _checed.attr('title');
                                                            var _id 		= _checed.val();                                                            
                                                            $( this ).dialog( "close" );
                                                            callback({id:_id,title:_title});
                                                    }
                                            });
                                            $(document).on('click', '[event-name="seach-hotel"]', search_hotel);
                                    });
                                },
                                
                                /**
                                 * 获取酒店列表 组件（多选）
                                 * @param {type} open_seach_btn
                                 * @param {type} callback
                                 * @returns {undefined}
                                 */
                                get_search_hotels:function(open_seach_btn,callback){
                                    //搜索获取酒店列表
                                    function search_hotel(){
                                        var _this = $(this);
                                        var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
                                        //酒店名称
                                        var hotel_name = $.common.typeCheck($(document).find('[tag-id="hotel_name"]').val(), 'undefined', false);

                                        $.common.ajaxFormSubmit({
                                                type: 'POST',
                                                url: url,
                                                data: {hotel_name:hotel_name},
                                                success:function(result){
                                                    var hote_list = '';
                                                    if( result.status === 1 ){                                                                
                                                            $.each(result.data, function(i, item){
                                                                    hote_list += '<tr>' +
                                                                                '<td class="center">' +
                                                                                        '<input tag-id="hotel_id" title="'+item.hotel_name+'" name="id" type="checkbox" value="'+item.id+'" />' +
                                                                                '</td>' +
                                                                                '<td>'+item.hotel_name+'</td>' +
                                                                                '<td>'+item.hotel_type+'</td>' +
                                                                                '</tr>';
                                                            });
                                                            if( hote_list === '' ){
                                                                    hote_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                            }
                                                    }else{
                                                        hote_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                    }
                                                    //搜索结果赋值
                                                    $(document).find('[tag-id="shop-result"]').html( hote_list );
                                                    //关闭加载框
                                                    $.common.closeTips('loading-in');
                                                }
                                        });
                                    };
                                    //数据回调
                                    $(document).on('click', '[event-name='+open_seach_btn+']', function(){
                                            //打开窗口
                                            $.common.openWindow({
                                                    id: 'seach-hotel-box',
                                                    height: 500,
                                                    width: 700,
                                                    title: '商户搜索',
                                                    confirm_function: function(){
                                                        var chk_value = [];
                                                        $("input[tag-id=hotel_id]:checked").each(function () {
                                                            var _checed = $(this);
                                                            var _this_val = {id:_checed.val(),title:_checed.attr('title')};
                                                            chk_value.push(_this_val);
                                                        });                                                                                                      
                                                        $( this ).dialog( "close" );                                                        
                                                        callback(chk_value);
                                                    }
                                            });
                                            $(document).on('click', '[event-name="seach-hotel"]', search_hotel);
                                    });
                                },
                                
                                
                                //移除类型(选中项)
                                remove_choose:function(tagid){
                                        $('body').off('click', '[event-name="removeType"]');//清楚绑定事件
                                        $('body').on('click', '[event-name="removeType"]', function () {
                                        //要删除的标签值
                                        var tag_val = $(this).attr('id');
                                        //console.log(tagid);
                                        //移除标签值
                                        var type = $(this).parents('form').eq(0).find('input[tag-id='+tagid+']');
                                        var type_val = type.val().split(',');
                                        var new_val = $.common.removeArrayItem(type_val, tag_val);
                                        //隐藏域重新赋值
                                        type.val(new_val);                                        
                                        //移除标签名称
                                        $(this).parent('[tag-id="label"]').parent('span').remove();
                                    });
                                },
                                
                                /**
                                 * 选择商品-单个
                                 * @param {type} event_name
                                 * @param {type} callback
                                 * @returns {undefined}
                                 */
                                get_search_goods_single:function(event_name,callback,param){
                                    //选择类型
                                    $(document).on('click', '[event-name="'+event_name+'"]', function () {
                                        //清空搜索结果
                                        $(document).find('[tag-id="goods-result"]').html('');   
                                        //初始化分类数据  tag-id="search-goods-cates"
                                        var get_cate_url = $.common.typeCheck(param.cate_url, 'undefined', '/Public/getCateList');
                                        $.ajax({
                                            type: "POST",
                                            url: get_cate_url,
                                            success: function (res) {
                                                var _cate_html = '<option value="0" selected="selected">全部分类</option>';
                                                if(res.status === 1){                                                    
                                                    $.each(res.data, function (i, n) {                        
                                                        _cate_html += '<option value="' + n.id + '">' + n.category_name + '</option>';
                                                    });                                                    
                                                }
                                                $('[tag-id="search-goods-cates"]').html(_cate_html);
                                            }
                                        });
                                        function search_goods(){
                                            var _this = $(this);
                                            var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
                                            //商品名称
                                            var goods_name = $.common.typeCheck($(document).find('[tag-id="goods_name" ]').val(), 'undefined', false);
                                            var goods_cate = $.common.typeCheck($('[name=cate_id]').val(), 'undefined', 0);
                                            $.common.ajaxFormSubmit({
                                                    type: 'POST',
                                                    url: url,
                                                    data: {goods_name:goods_name,cate_id:goods_cate},
                                                    success:function(result){                                                            
                                                            var goods_list = '';
                                                             if( result.status === 1 ){
                                                                var tagid = $.common.typeCheck(param.tagid, 'undefined', false);  
                                                                var tag_val = [];
                                                                if(tagid){
                                                                    var tag = $('input[tag-id='+tagid+']');
                                                                    tag_val = tag.val().split(',');
                                                                 } 
                                                                 $.each(result.data, function(i, item){ 
                                                                    var checked = '';
                                                                    if(tagid){
                                                                        var is_has = $.common.inArray(item.id, tag_val);                                              
                                                                        if(is_has === true){
                                                                            checked = 'checked="checked"';
                                                                        }
                                                                    }
                                                                    goods_list += '<tr>' +
                                                                                        '<td class="center">' +
                                                                                        '<input '+checked+' tag-id="goods_id" title="'+item.goods_name+'" name="goods_id" type="radio" value="'+item.id+'" />' +
                                                                                        '</td>' +
                                                                                        '<td>'+item.goods_name+'</td>' +
                                                                                        '<td>'+item.goods_cate+'</td>' +
                                                                                  '</tr>';
                                                                });
                                                            }
                                                            if( goods_list === '' ){
                                                                    goods_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                            }
                                                            //搜索结果赋值
                                                            $(document).find('[tag-id="goods-result"]').html(goods_list );

                                                            //关闭加载框
                                                            $.common.closeTips('loading-in');
                                                    }
                                            });
                                            
                                        }
                                        //绑定选择
                                        $(document).off('click', '[event-name="search-goods"]');//清楚绑定事件
                                        $(document).on('click', '[event-name="search-goods"]', search_goods);
                                        //显示类型框
                                        $.common.openWindow({
                                            id: 'choose-goods-box',
                                            title: '选择商品',
                                            height: 450,
                                            width: 600,
                                            confirm_function: function () {
                                                var _checed 		= $(document).find('[tag-id="goods_id"]:checked');
                                                var _title      	= _checed.attr('title');
                                                var _id 		= _checed.val();                                                            
                                                $( this ).dialog( "close" );
                                                callback({id:_id,title:_title});
                                            },
                                        });
                                    });
                                },
                                
                                /**
                                 * 选择商品-多个
                                 * @param {type} event_name
                                 * @param {type} callback
                                 * @returns {undefined}
                                 */
                                get_search_goods:function(event_name,callback,param){
                                    //选择类型
                                    $(document).on('click', '[event-name="'+event_name+'"]', function () {
                                        //清空搜索结果
                                        $(document).find('[tag-id="goods-result"]').html('');   
                                        //初始化分类数据  tag-id="search-goods-cates"
                                        var get_cate_url = $.common.typeCheck(param.cate_url, 'undefined', '/Public/getCateList');
                                        $.ajax({
                                            type: "POST",
                                            url: get_cate_url,
                                            success: function (res) {
                                                var _cate_html = '<option value="0" selected="selected">全部分类</option>';
                                                if(res.status === 1){                                                    
                                                    $.each(res.data, function (i, n) {                        
                                                        _cate_html += '<option value="' + n.id + '">' + n.category_name + '</option>';
                                                    });                                                    
                                                }
                                                $('[tag-id="search-goods-cates"]').html(_cate_html);
                                            }
                                        });
                                        
                                        function search_goods(){                                            
                                            var _this = $(this);
                                            var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
                                            //商品名称
                                            var goods_name = $.common.typeCheck($(document).find('[tag-id="goods_name"]').val(), 'undefined', false);
                                            var goods_cate = $.common.typeCheck($('[name=cate_id]').val(), 'undefined', 0);
                                            $.common.ajaxFormSubmit({
                                                    type: 'POST',
                                                    url: url,
                                                    data: {goods_name:goods_name,cate_id:goods_cate},
                                                    success:function(result){
                                                            var goods_list = '';
                                                            var tagid = $.common.typeCheck(param.tagid, 'undefined', false);  
                                                            var tag_val = [];
                                                            if(tagid){
                                                                var tag = $('input[tag-id='+tagid+']');
                                                                tag_val = tag.val().split(',');
                                                             }        
                                                            $.each(result.data, function(i, item){
                                                                var checked = '';
                                                                if(tagid){
                                                                    var is_has = $.common.inArray(item.id, tag_val);                                              
                                                                    if(is_has === true){
                                                                        checked = 'checked="checked"';
                                                                    }
                                                                }
                                                                goods_list += '<tr>' +
                                                                                    '<td class="center">' +
                                                                                    '<input '+checked+' tag-id="goods_id" title="'+item.goods_name+'" name="goods_id" type="checkbox" value="'+item.id+'" />' +
                                                                                    '</td>' +
                                                                                    '<td>'+item.goods_name+'</td>' +
                                                                                    '<td>'+item.goods_cate+'</td>' +
                                                                              '</tr>';
                                                            });

                                                            if( goods_list === '' ){
                                                                    goods_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                                                            }

                                                            //搜索结果赋值
                                                            $(document).find('[tag-id="goods-result"]').html(goods_list);

                                                            //关闭加载框
                                                            $.common.closeTips('loading-in');
                                                    }
                                            });
                                        }
                                        //绑定选择
                                        $(document).off('click', '[event-name="search-goods"]');//清楚绑定事件
                                        $(document).on('click', '[event-name="search-goods"]', search_goods);                                        

                                        //显示类型框
                                        $.common.openWindow({
                                            id: 'choose-goods-box',
                                            title: '选择商品',
                                            height: 450,
                                            width: 600,
                                            confirm_function: function () {
                                                var chk_value = [];
                                                $("input[tag-id=goods_id]:checked").each(function () {
                                                    var _checed = $(this);
                                                    var _this_val = {id:_checed.val(),title:_checed.attr('title')};
                                                    chk_value.push(_this_val);
                                                });                                                                                                      
                                                $(this).dialog( "close" );                                                        
                                                callback(chk_value);
                                            }
                                        });
                                    });
                                },
                                
                                //搜索酒店
                                /**
                                 * 上传插件
                                 * @param object webupload		上传插件对象
                                 * @param string input_name		隐藏域名称
                                 * @param int num				上传组件ID
                                 * @param extensions_val		允许上传的文件后缀
                                 * @param json init_params
                                 * @param string init_params.upload_url			上传路径
                                 * @param string init_params.preview_url		上传地址
                                 * @param boolean multiple_val					是否支持多图上传 	
                                 */
                                webupload_initialize:function(webupload,input_name,num,extensions_val,init_params={}){
                                    //视频上传
                                    //$('input[name='+input_name+']').val('');
                                    //初始化上传
                                    webupload.initialize({
                                            upload_url: $.common.typeCheck(init_params.upload_url, 'undefined', '/Public/doUpload'),
                                            preview_url: $.common.typeCheck(init_params.preview_url, 'undefined', 'http://www.baidu.com/pre'),
                                            multiple_val: $.common.typeCheck(init_params.multiple_val, 'undefined', false),
                                            extensions_val:extensions_val,
                                            md5_input:input_name,
                                            uploader_box:'uploader'+num,
                                            filePicker:'filePicker'+num,
                                            fileNumLimit: $.common.typeCheck(init_params.fileNumLimit, 'undefined', 10000)
                                    });
                                },
                                
                                //删除统一方法（单一删除，批量删除）
                                form_del:function(validator_param){
                                    //删除
                                    $('[event-name="del-event"]').on('click', function () {
                                        var id      = $(this).attr('event-id');    
                                        var msg     = $(this).attr('msg');
                                        var title   = $(this).attr('title');
                                        var url     = $(this).attr('url');
                                        var del_id  ='';
                                        //要验证的
                                        var attr_key = $.common.typeCheck(validator_param.attr_key , 'undefined' , false);
                                        var attr_val = $.common.typeCheck(validator_param.attr_val , 'undefined' , '');
                                        var attr_msg = $.common.typeCheck(validator_param.attr_msg , 'undefined' , '');
                                        var _box = $("div[dialog-id=del-box]");//删除的弹框
                                        
                                        var goon = true;
                                        if(id === 'checkbox'){                                            
                                            //要删除的ID          
                                            $("input[name=item_id]:checked").each(function () {
                                                if(attr_key){
                                                    var key_val = $.common.typeCheck($(this).attr(attr_key) , 'undefined' , false);
                                                    if(key_val !== false && key_val != attr_val){
                                                        $.common.openTips({message: attr_msg},'error');                                                        
                                                        goon = false;
                                                    }
                                                }
                                                del_id = del_id+ ',' + $(this).val();
                                            });
                                            
                                            if(goon == false){
                                                return false;
                                            }
                                            if (del_id.substr(0,1) === ','){
                                                del_id=del_id.substr(1);
                                            } 
                                            
                                        }else{
                                            if(attr_key){
                                                var key_val = $.common.typeCheck($(this).attr(attr_key) , 'undefined' , false);
                                                
                                                if(key_val !== false && key_val != attr_val){
                                                    $.common.openTips({message: attr_msg},'error');
                                                    return false;
                                                }
                                            }
                                            del_id = id;
                                        }            
                                        _box.find("#dialog-msg").html(msg);//删除提示内容

                                        //打开窗口
                                        $.common.openWindow({
                                            id: 'del-box',
                                            height: 300,
                                            width: 600,
                                            title: title,
                                            confirm_function: function () {
                                                $.common.ajaxFormSubmit({
                                                    id: 'del-form',
                                                    url:url,
                                                    data:{id:del_id}
                                                });
                                            }
                                        });
                                    });
                                },
				
				/**
				 * 动态加载CSS文件
				 * @param string css_file_name		文件名称（不含后缀）
				 */
				loadCss: function(css_file_name){
					if( $.common.typeCheck(css_file_name, 'undefined', false) ){
						var css_file = static_base + '/admin/view/css/' + css_file_name;
						$('#route').append('<link rel="stylesheet" href="'+css_file+'.css" />');
					}
				},
				
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
				formValidator: function(params, submit_params){
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
					$.common.formValidator(_valitor_params, _submit_params);
					
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
				 * @param object submit_params.data				提交数据
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
					
					//合并提交数据
					if( $.common.typeCheck(submit_params.data, 'undefined', false) && typeof(submit_params.data) == 'object'){
						data = Object.assign(data, submit_params.data);
					}
					
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
							
							msg = msg + ' <span tag-id="timeout">3 </span>秒钟后自动关闭提示...';
							
                                                        msg = msg + '<br>' + msg_info;
							
							
							//提示框
							$.common.openTips({
								'icon': 'icon-remove',
								'message': msg
							},'error',true);
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
				 * @param string type					提示类型：error:错误、warning:警告
				 * @param boolean autoClose				是否自动关闭；默认：true
				 * @param int timeout					自动关闭时间；默认：3 秒
				 */
				openTips: function(params, type, autoClose, timeout){
                                        var timeout	 = $.common.typeCheck(timeout, 'undefined', 3);
					
					var params 			= $.common.typeCheck(params, 'undefined', {});
					
					var className 		= $.common.typeCheck(params.className, 'undefined', 'loading-in');
					
					var message 		= $.common.typeCheck(params.message, 'undefined', '操作成功！<span tag-id="timeout">'+timeout+' </span>秒后自动刷新或跳转...');
					
					var icon 			= $.common.typeCheck(params.icon, 'undefined', 'icon-spinner icon-spin');
					
					//关闭加载框
					$.common.closeTips(className);
					
					if( $.common.typeCheck(type, 'undefined', false) ){
						switch( type ){
							//错误
							case 'error':
								className = 'error';
								icon = 'icon-remove';
								break;
							//警告
							case 'warning':
								className = 'warning';
								icon = 'icon-warning-sign';
								break;
						}
					}
					
					//提示
					bootbox.dialog({ 
						className: className,
						backdrop: $.common.typeCheck(params.backdrop, 'undefined', true),
						message: '<div class="text-center" style="font-size:14px;"><i class="'+icon+'"></i> '+message+'</div>' 
					});
					
					//自动关闭
					
					if( $.common.typeCheck(autoClose, 'undefined', true) ){	
                                                var fail_timer = setInterval(function(){
                                                        if( timeout > 1 ){
                                                                timeout--;
                                                                $(document).find('[tag-id="timeout"]').html(timeout+" ");
                                                        }else if(timeout == 1){
                                                                clearInterval(fail_timer);
                                                                $.common.closeTips(className);
                                                        }
                                                },1000);
					}
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
				
				/**
				 * 城市地区插件
				 * @param string city_url		获取城市数据地址
				 */
				cityComponent: function(component_id){
					//获取省份列表
					var city_url = "/Public/getCity";
					
					//标签对象
					var _tag = $(document).find('#'+component_id);
					
					var province_name 	= $.common.typeCheck(_tag.attr('province-name'), 'undefined', 'province_id');
					var city_name 		= $.common.typeCheck(_tag.attr('city-name'), 'undefined', 'city_id');
					var region_name 	= $.common.typeCheck(_tag.attr('region-name'), 'undefined', 'region_id');
					
					var default_province	= $.common.typeCheck(_tag.attr('default-province'), 'undefined', 0);
					var default_city		= $.common.typeCheck(_tag.attr('default-city'), 'undefined', 0);
					var default_region		= $.common.typeCheck(_tag.attr('default-region'), 'undefined', 0);
					
					var province_options 	= '';
					
					var city_options 		= '';
					
					var region_options 		= '';
					
					//请求参数
					var request_param = {};
					if(default_province != 0){
						request_param.province_id = default_province;
					}
					
					if(default_province != 0 && default_city != 0){
						request_param.city_id = default_city;
					}
					
					$.ajax({
						url: city_url,
						data: request_param,
						success: function(result){
							if( typeof(result) == 'object'){
								if(typeof(result.status != 'undefined') && result.status == 1){
									if(typeof(result.data == 'object')){
										
										var is_selected = '';
										$.each(result.data, function(i,item){
											if( default_province == item.id || default_city == item.id || default_region == item.id ){
												is_selected = ' selected="selected"';
											}else{
												is_selected = '';
											}
											
											switch(  parseInt(item.city_level) ){
												//省份
												case 1:
													province_options += '<option value="'+ item.id +'"'+is_selected+'>'+ item.city_name +'</option>';
													break;
												//城市
												case 2:
													city_options += '<option value="'+ item.id +'"'+is_selected+'>'+ item.city_name +'</option>';
													break;
												//县区
												case 3:
													region_options += '<option value="'+ item.id +'"'+is_selected+'>'+ item.city_name +'</option>';
													break;
											}
										});
									}
								}
							}
							
							var city_component = '<select name="'+province_name+'" event-name="getCityChild" tag-name="province" class="form-control province" style="margin-right:5px;">' +
													'<option value="0">--请选择--</option>' + province_options +
												 '</select>' +
												 '<select name="'+city_name+'" event-name="getCityChild" tag-name="city" class="form-control city" style="margin-right:5px;">' +
												 	'<option value="0">--请选择--</option>' + city_options +
												 '</select>' +
												 '<select name="'+region_name+'" event-name="getCityChild" tag-name="region" class="form-control area" style="margin-right:5px;">' +
												 	'<option value="0">--请选择--</option>' + region_options +
												 '</select>';
							_tag.html( city_component );
							
							if( region_options != '' ){
								$(document).find('._region').html( region_options );
							}else if( city_options != '' && region_options == '' ){
								$(document).find('._city').html( city_options );
							}
							
							
						},
						error: function(){
							console.error("城市信息获取地址错误！");
						}
					});
					
					//获取下级城市地区
					$(document).on('change', '[event-name="getCityChild"]', function(){
						var _this 			= $(this);
						var id 				= _this.val();
						var tag_name 		= _this.attr('tag-name');
						
						var defaule_option = '<option value="0">--请选择--</option>';
						
						var options = '';
						
						if( id == 0 ) return ;
						
						$.ajax({
							url: city_url,
							data: {parent_city_id: id},
							success: function(data){
                                                            
								if( typeof(data.status) != 'undefined' && data.status == 1 && typeof(data.data) == 'object' ){
									$.each(data.data, function(i,item){
										options += '<option value="'+ item.id +'">'+ item.city_name +'</option>';
									});
								}
								
								switch(tag_name){
									case 'province':
										_tag.find('[tag-name="city"]').html( options );
										_tag.find('[tag-name="region"]').html( defaule_option );
                                                                                //二级市 只有一个对象，此时无法处罚change事件,直接初始化下级 避免BUG
										if(data.data.length == 1){
                                                                                    _tag.find('[tag-name="city"]').change();
                                                                                }
                                                                                
										$(document).find('._city').html( options );
										break;
									case 'city':
                                                                            
										_tag.find('[tag-name="region"]').html( options );
										
										$(document).find('._region').html( options );
										break;
									case 'region':
										break;
								}
								
							}
						});
					});
				},
				
				/**
				 * 删除事件
				 */
				deleteEvent: function(){
					//删除
					$(document).on('click', '[event-name="delete"]', function(){
						var _this 		= $(this);
						//var flag 		= $.common.typeCheck(_this.attr('flag'), 'undefined', 'row');
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
									message: '请选择要删除的选项',
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
								
								if( msg_row == '' ) msg_row = '<h4>确定要删除吗？</h4><h4>删除后将不可恢复！</h4>';
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
							height: 300,
							width: 400,
							title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', '删除提示'),
							confirm_function: function(){
								
								$.common.ajaxFormSubmit({
									url: $.common.typeCheck(_this.attr('url'), 'undefined', ''),
									data:{ids:ids.toString()}
								});
							}
						});
					});
				},
				
				/**
				 * 启用停用事件
				 */
				onOffEvent: function(){
					//启用停用
					$(document).on('click', '[event-name="on-off"]', function(){
						var _this 		= $(this);
						var tag_id		= _this.attr('tag-id');
						var table_id 	= $.common.typeCheck(_this.attr('table-name'), 'undefined', false);
						var message		= $.common.typeCheck(_this.attr('message'), 'undefined', false);
						
						var ids = $.common.typeCheck(_this.attr('id-value'), 'undefined', []);
						
						if( table_id != false ){
							var cheked_ids = $(document).find('[table-id="'+ table_id +'"]').find('[tag-name="ids"]:checked');
							
							if(cheked_ids.length == 0){
								$.common.openTips({
									className: 'delete',
									icon: 'icon-warning-sign',
									message: '请选择要操作的记录',
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
								
							}
						
						
							var delete_tag = '<div dialog-id="delete" class="wating hide">' +
												'<div tag-id="row-info" class="message">' + msg_row + '</div>' +
											'</div>';
							
							$(document).find('body').find('[dialog-id="delete"]').remove();
							$(document).find('body').append( delete_tag );
							
							//打开窗口
							$.common.openWindow({
								id: 'delete',
								height: 300,
								width: 400,
								title: $.common.typeCheck(_this.attr('dialog-title'), 'undefined', '停用'),
								confirm_function: function(){
									
									$.common.ajaxFormSubmit({
										url: $.common.typeCheck(_this.attr('url'), 'undefined', ''),
										data:{flag:tag_id, ids:ids.toString()}
									});
								}
							});
						}else{
							$.common.ajaxFormSubmit({
								url: $.common.typeCheck(_this.attr('url'), 'undefined', ''),
								data:{flag:tag_id, ids:ids.toString()}
							});
						}
					});
				},
				
				/**
				 * url 参数转 json对象
				 * @param string params_str		url格式参数字符串
				 * @return json
				 */
				urlParamsToJson: function(params_str){
					var key_val = [];
					var data_str = '{';
					if( $.common.typeCheck(params_str, 'undefined', false) ){
						key_val = params_str.split('&');
					}
					
					$.each(key_val,function(i,item){
						var tmp = item.split('=');
						if(i > 0){
							data_str += ',';
						}
						data_str += '"' +tmp[0] +　'":"'+tmp[1]+'"';
					});
					
					data_str += '}';
					
					return JSON.parse(data_str);
				},
				
				/**
				 * 渲染数据表单
				 * @param string params.form_id		表单ID
				 * @param string params.data		表单数据
				 */
				renderData: function(params){
					if( !$.common.typeCheck(params.form_id, 'undefined', false) || typeof(params.data) != 'object' ){
						return false;
					}
					var _form = $(document).find('[form-id="'+params.form_id+'"]');					
					$.each(params.data, function(i, item){
						var input_item 		= _form.find('input[name="'+i+'"]');
						var checkbox_item 	= _form.find('input[name="'+i+'[]"]');
                                                
                                                _form.find('select[name="'+i+'"]').val(item);//select 赋值 
                                                _form.find('textarea[name="'+i+'"]').val(item);//文本框
						
						switch( input_item.attr('type') ){	
                                                        
							case 'radio'://单选                                            
                                                            $.each(input_item, function(){                                                                    
                                                                if($(this).val() == item ){
                                                                    input_item.prop({checked:false});
                                                                    $(this).prop({checked:true});
                                                                }
                                                            });
								
                                                            break;							
							case 'checkbox'://多选 要修改
								$.each(checkbox_item, function(c_i, c_item){
									if( c_item.attr('name') == (i+'[]') && c_item.val() == item ){
										c_item.attr('checked','checked');
									}
								});
								break;
							//文件
							case 'file':
								break;
							//输入框
							default:
								if( input_item.attr('name') == i ){
									input_item.val( item );
								}
								break;
						}
					});
					
				},
				
				/**
				 * 获取并渲染数据
				 * @param string params.event_object		事件对象
				 * @param string params.form_id				表单ID
				 * @param function params.success			成功回调函数	
				 */
				getInfoRender: function(params){
					//时间对象
					var _this = $.common.typeCheck(params.event_object, 'undefined', {});
					
					//请求数据
					var request_data = {};
					//请求地址
					var get_info_url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
					//请求参数
					var data = $.common.typeCheck(_this.attr('params'), 'undefined', false);
					if( data !== false ){
						data = $.common.urlParamsToJson( data );
						
						request_data = Object.assign(request_data, data);
					}
					
					if( get_info_url ){
						$.common.ajaxFormSubmit({
							url: get_info_url,
							data: request_data,
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
									form_id: $.common.typeCheck(params.form_id, 'undefined', ''),
									data: result.data
								});
								
								//回调外界函数
								if( $.common.typeCheck(params.success, 'undefined', false) ){
									params.success(result.data);
								}
								
								//关闭加载
								$.common.closeTips('loading-in');
							},
						});
					}
				},
				
				/**
				 * 获取参数
				 * @param object params.event_object		事件对象
				 * @return json
				 */
				getParams: function(params){
					var _this = $.common.typeCheck(params.event_object, 'undefined', false);
					
					var params		= {};
					
					if( _this == false ){
						return params;
					}
					
					if( $.common.typeCheck(_this.attr('params'), 'undefined', false) ){
						var params = $.common.urlParamsToJson( _this.attr('params') );
						
						params = Object.assign(params, params);
					}
					
					return params;
				},
				
				/**
				 * 格式化数字
				 * @param int number		数字
				 * @param int length		数字长度
				 * @return string
				 */
				intFormat: function(number, length){
					 return (Array(length).join(0) + number).slice(-length);
				},
				
				/**
				 * 子级全选
				 */
				childCheck: function(){
					$(document).on('click', '[event-name="child-check"]', function(){
						var _this = $(this);
						var _item = _this.parents('[tag-name="level-1"]').eq(0);
						var _item_index = _item.attr('tag-index');
						
						//选中二级菜单
						var _item_level_2 = $(document).find('[tag-index="level-2-'+_item_index+'"]');
						$.each(_item_level_2, function(){
							if( _this.is(':checked') ){
								$(this).find('[tag-name="ids"]').prop("checked", true);
							}else{
								$(this).find('[tag-name="ids"]').prop("checked", false);
							}
							
						})
					})
				}
				
				//成员方法...
				
			},
			
                /**
                 * 组件
                 */
                component: {
                        /**
                         * 联动层级组件
                         * @param string params.component_id			组件ID
                         * @param boolean params.showFirst				是否显示第一个层级
                         */
                        level: function(params){
                                var params = $.common.typeCheck(params, 'undefined', {});
                                if( !$.common.typeCheck(params.component_id, 'undefined', false) ){
                                        return false;
                                }

                                var _component = $(document).find('[component-id="'+params.component_id+'"]');

                                //显示第一层
                                if( $.common.typeCheck(params.showFirst, 'undefined', true) ){
                                        _component.find('[event-name="show-child"]').first().attr('flag', '+');
                                        $.each(_component.find('[tag-index="level-2-1"]'), function(i,item){
                                                $(this).removeClass('hide');
                                        })
                                }

                                //点击一级
                                _component.on('click', '[event-name="show-child"]', function(){
                                        var _this = $(this);
                                        var _item = _this.parents('[tag-name="level-1"]').eq(0);
                                        var _item_index = _item.attr('tag-index');

                                        //隐藏所有二级菜单
                                        $.each(_component.find('[tag-name="level-2"]'), function(){
                                                $(this).addClass('hide');
                                        });

                                        //显示本级的二级菜单
                                        var _item_level_2 = _component.find('[tag-index="level-2-'+_item_index+'"]');
                                        $.each(_item_level_2, function(){

                                                $(this).removeClass('hide');
                                        })
                                });
                        },
                        
                        /**
                         * 单选框切换
                         */
                        tabOptions: function(params){
                        	$(document).on('click', '[event-name="tabOptions"]', function(){
                        		var _this = $(this);
                        		var tag_item = _this.parents('[component-id="options"]').first().find('[tag-name="options-item"]');
                        		$.each(tag_item, function(i,item){
                        			var _item = $(item);
                        			if(_item.attr('tag-id') == 'options-'+_this.val()){
                        				_item.removeClass('hide');
                        			}else{
                        				_item.addClass('hide');
                        			}
                        		});
                        		
                        	});
                        },
                },
                
                
	});
});



