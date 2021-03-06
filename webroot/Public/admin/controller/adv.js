/**
 * 广告管理
 */
seajs.use(['webupload', 'module/adv'], function (webupload, adv) {
    $(function () {
        //页面搜索
        $('#search-button').on('click', function () {
            var search_key = $("#search-key").val();
            var search_url = $(this).attr('surl') + "?search_key=" + search_key;
            window.location.href = search_url;
        });
        //列表搜索--新
        $('#search-list-btn').on('click', function () {
            var _form = $(this).parents().find('[form-id=search-list]');
            _form.submit();
        })
        
        //搜索展开隐藏
        $('#show_more_search').on('click',function(){
            var _this = $(this);
            var _hotel_id = _this.attr('hotel_id')
            if($(this).is('.icon-plus-sign')){//当前隐藏子级
                _this.parent().parent().next().removeClass('hide'); 
                _this.removeClass('icon-plus-sign').addClass('icon-minus-sign');
            }else{
                _this.parent().parent().next().addClass('hide');
                _this.removeClass('icon-minus-sign').addClass('icon-plus-sign');
            }
        });
                
        

        //====================================================================================================
        //=======广告主管理
        //====================================================================================================
        //添加广告主
        $('[event-name="add-advmain"]').on('click', function () {
            $('input[name=category]').val('');//清空已选择行业
            //打开窗口
            $.common.openWindow({
                id: 'add-advmain-box',
                height: 450,
                width: 700,
                title: '新增广告主信息',
                confirm_function: function () {
                    //表单验证参数
                    var validator_params = {
                        //验证字段
                        fields: {
                            //详细配置
                            advert_name: {
                                rule: 'required',
                                msg: {
                                    required: "输入广告主名称！",
                                },
                            },
                        }
                    };

                    //提交表单
                    $.common.formSubmit('add-advmain-form', validator_params);

                },

            });
        });

        //编辑广告主
        $('[event-name="edit-advmain"]').on('click', function () {
            var id = $(this).attr('event-id');
            $.ajax({
                type: "POST",
                url: "/Adv/getAdverInfo",
                async: false,
                data: "id=" + id,
                success: function (rs_info) {
                    //console.log(rs_info.info.type_class);
                    $("div[dialog-id=edit-advmain-box] input[name=advert_name]").val(rs_info.data.info.advert_name);
                    $("div[dialog-id=edit-advmain-box] input[name=company_name]").val(rs_info.data.info.company_name);
                    $("div[dialog-id=edit-advmain-box] input[name=contacts]").val(rs_info.data.info.contacts);
                    $("div[dialog-id=edit-advmain-box] input[name=contact_way]").val(rs_info.data.info.contact_way);
                    $("div[dialog-id=edit-advmain-box] input[name=category]").val(rs_info.data.info.industry_desc);
                    $("div[dialog-id=edit-advmain-box] input[name=id]").val(id);

                    var checked_name = '';
                    $.each(rs_info.data.info.industry_list, function (i, n) {
                        checked_name += '<span class="label" tag-id="label">' + n.category_name + ' <i id="' + n.id + '" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span>';
                    });

                    //标签加入标签区域
                    $("div[dialog-id=edit-advmain-box]").find('[tag-id="checked-type"]').html(checked_name);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-advmain-box',
                height: 450,
                width: 700,
                title: '编辑商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-advmain-form'
                    });
                },
            });
        });

        //删除广告主-单个
        $('[event-name="del-advmain"]').on('click', function () {
            //要删除的ID
            var id = $(this).attr('event-id');

            $("div[dialog-id=del-advmain-box] input[name=id]").val(id);
            //打开窗口
            $.common.openWindow({
                id: 'del-advmain-box',
                height: 300,
                width: 600,
                title: '删除单条广告主',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-advmain-form'});
                }
            });
        });

        //删除服务-多个
        $('[event-name="dels-advmain"]').on('click', function () {
            //要删除的ID        
            var chk_value = [];
            $("input[name=item_id]:checked").each(function () {
                chk_value.push($(this).val());
            });
            $("div[dialog-id=dels-advmain-box] input[name=id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-advmain-box',
                height: 300,
                width: 600,
                title: '批量删除广告主',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-advmain-form'});
                },
            });
        });

        //选择类型
        $(document).on('click', '[event-name="add-type"]', function () {
            var _this = $(this);
            var _this_form = _this.parents('form').eq(0);

            //获取已选中标签值
            var checked_val = _this.parents('form').eq(0).find('input[name="category"]').val();
            var checked_val_arr = $.common.stringToArray(checked_val, ',');

            //判断是否已请求获取数据
            if (!$.common.typeCheck(_this.attr('status'), 'undefined', false)) {
                //未请求
                $.common.ajaxFormSubmit({
                    type: 'GET',
                    url: _this.attr('url'),
                    success: function (result) {
                        //返回错误
                        if (result.status != 1) {
                            $.common.openTips({
                                icon: 'icon-remove',
                                className: 'error',
                                message: result.msg
                            });
                            return false;
                        }
                        //数据绑定
                        var category_items = '<dl class="big-item">';
                        var type_items = '';
                        $.each(result.data, function (i, item) {

                            //选中属性
                            var checked = '';
                            if ($.common.inArray(item.id, checked_val_arr)) {
                                checked = 'checked="checked"';
                            }

                            type_items = '<dd class="small-item">' +
                                    '<div class="checkbox">' +
                                    '<label>' +
                                    '<input ' + checked + ' name="form-field-checkbox" tag-name="type-item" type="checkbox" class="ace" title="' + item.category_name + '" value="' + item.id + '">' +
                                    '<span class="lbl"> ' + item.category_name + '</span>' +
                                    '</label>' +
                                    '</div>' +
                                    '</dd>';
                            category_items += type_items;

                        });

                        category_items += '</dl>';

                        $(document).find('[tag-id="type-items"]').html(category_items);
                    },
                });

                //标识已请求
                _this.attr('status', 'ok');

                //关闭提示框
                $.common.closeTips();
            } else {
                //已请求过

                //获取选项列表
                $(document).find('[tag-id="type-items"]').find('[tag-name="type-item"]:checked').each(function () {
                    //过滤掉已移除的选项，设为不选中
                    if (!$.common.inArray($(this).val(), checked_val_arr)) {
                        $(this).removeAttr('checked');
                    }
                });

            }

            //显示类型框
            $.common.openWindow({
                id: 'type',
                title: '选择行业',
                height: 450,
                width: 700,
                confirm_function: function () {
                    //获取已选值
                    var checked_val = [];
                    var checked_name = '';
                    $(document).find('[tag-id="type-items"]').find('input:checked').each(function () {
                        checked_val.push($(this).val());

                        checked_name += '<span class="label" tag-id="label">' + $(this).attr('title') + ' <i id="' + $(this).val() + '" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span>';
                    });

                    //标签加入标签区域
                    _this_form.find('[tag-id="checked-type"]').html(checked_name);
                    //选中的值加入隐藏域
                    _this_form.find('input[name="category"]').val(checked_val);
                    //关闭当前弹框
                    $(this).dialog("close");
                },
            });


        });

        //移除类型
        $(document).on('click', '[event-name="removeType"]', function () {
            //要删除的标签值
            var tag_val = $(this).attr('id');

            //移除标签值
            var type = $(this).parents('form').eq(0).find('input[name="category"]');
            var type_val = type.val().split(',');
            var new_val = $.common.removeArrayItem(type_val, tag_val);

            //隐藏域重新赋值
            type.val(new_val);

            //移除标签名称
            $(this).parent('[tag-id="label"]').remove();
        });

        //========================================================================================
        //==广告管理
        //========================================================================================

        //添加广告
        $(document).on('click', '[event-name="add-adv"]', function () {
            $("input[name$='_md5']").val('');
            var _this = $(this);
            var _form = $(document).find('[form-id="add-adv-form"]');  

            //打开窗口
            $.common.openWindow({
                id: 'add-adv-box',
                title: '添加广告',
                height: 500,
                width: 700,
                reset: true,
                enable_next: true, //启用下一步
                next_class: 'custom-next',
                next_function: function () {
                    //商户名称必须填写
                    if (_form.find('input[name="advert_name"]').val() == '') {
                        $.common.openTips({
                            className: 'error',
                            icon: 'icon-info-sign',
                            message: "请输入广告名称",
                        });

                        //光标定位
                        _form.find('input[name="advert_name"]').focus();

                        setTimeout(function () {
                            $.common.closeTips('error');
                        }, 3000);
                        return false;
                    }
                    $("div[dialog-id=add-adv-box] input[type=radio][name=material_type]").get(0).checked=true;             

                    //显示第二步
                    $(document).find('[tag-id="setup-1"]').addClass('hide2');
                    $(document).find('[tag-id="setup-2"]').removeClass('hide2');

                    //隐藏下一步按钮
                    $(document).find('.custom-next').addClass('hide2');

                    //显示上一步 和 确认按钮
                    $(document).find('.custom-back').removeClass('hide2');
                    $(document).find('.custom-confirm').removeClass('hide2');
                    
                    //图片上传
                    $.common.webupload_initialize(webupload,'advpic_md5',1,'jpg,jpeg,png');
                    $.common.webupload_initialize(webupload,'advvideo_md5',20,'3gp,mp4');
                    $.common.webupload_initialize(webupload,'advvideopic_md5',3,'jpg,jpeg,png');
                    
                },
                enable_back: true, //启用上一步
                back_class: 'custom-back hide2',
                back_function: function () {
                    //显示第一步
                    $(document).find('[tag-id="setup-1"]').removeClass('hide2');
                    $(document).find('[tag-id="setup-2"]').addClass('hide2');

                    //隐藏确认 和 上一步按钮
                    $(document).find('.custom-confirm').addClass('hide2');
                    $(document).find('.custom-back').addClass('hide2');

                    //显示下一步
                    $(document).find('.custom-next').removeClass('hide2');
                },
                confirm_class: 'custom-confirm hide2',
                confirm_title: '确认添加',
                confirm_function: function () {
                    //添加编辑商户
                    adv.addAdvert('add-adv-form', 'add');
                }
            });
        });
        
        //广告主搜索
        $(document).on('click', '[event-name="open-seach-adver"]', function(){
                //打开窗口
                $.common.openWindow({
                        id: 'seach-adver-box',
                        height: 500,
                        width: 700,
                        title: '商户搜索',
                        confirm_function: function(){
                                var adver_checed 		= $(document).find('[tag-id="adver_id"]:checked');
                                var adver_name 			= adver_checed.attr('title');
                                var adver_id 			= adver_checed.val();

                                var _form = $(document).find('[form-id="add-adv-form"]');
                                _form.find('[name="adver_id"]').val(adver_id);
                                _form.find('[name="adver_name"]').val(adver_name);

                                //关闭当前弹框
                                $( this ).dialog( "close" );
                        }
                });
        });
        
        //搜索广告主
        $(document).on('click', '[event-name="seach-adver"]', function () {
            var _this = $(this);
            var url = $.common.typeCheck(_this.attr('url'), 'undefined', false);

            //广告主名称
            var adver_name = $.common.typeCheck($(document).find('[tag-id="adver_name" ]').val(), 'undefined', '');
            
            $.common.ajaxFormSubmit({
                type: 'POST',
                url: url,
                data: {adver_name: adver_name},
                success: function (result) {
                    if (typeof (result.data) == 'object') {
                        var adver_list = '';
                        $.each(result.data, function (i, item) {
                            adver_list += '<tr>' +
                                    '<td class="center">' +
                                    '<input tag-id="adver_id" title="' + item.advert_name + '" name="id" type="radio" value="' + item.id + '" />' +
                                    '</td>' +
                                    '<td>' + item.advert_name + '</td>' +
                                    '<td>' + item.industry_desc + '</td>' +
                                    '</tr>';
                        });

                        if (adver_list == '') {
                            adver_list = '<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>';
                        }

                        //搜索结果赋值
                        $(document).find('[tag-id="adver-result"]').html(adver_list);

                        //关闭加载框
                        $.common.closeTips('loading-in');
                    }
                }
            });
        });
        
        //广告 与 视频 切换  height1
        $(document).on('click', 'input[type=radio][name=material_type]',function(){
            var type_val = $(this).val();            
            $('.material_type').find('div[material_type]').addClass('hide2');
            $('.material_type').find('div[material_type='+type_val+']').removeClass('hide2');
        });
        
        //广告编辑
        $(document).on('click', '[event-name="edit-adv"]', function () {
            $("input[name$='_md5']").val('');//清空所有上传 结果值，避免添加与修改相互影响
            var _this = $(this);
            if(_this.attr('status') != '2'){
                $.common.openTips({message: '发布中的广告不允许编辑'},'error');
                return false;
            }
            var _info_url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
            var _this_id = _this.attr('event-id');
            var _form = $(document).find('[form-id="edit-adv-form"]');  
       
            var _res_info = '';
            
            $.ajax({
                url: _info_url,
                async: false,
                data: {id:_this_id},
                success:function(result){
                    //获取数据失败
                    if( result.status == 0 ){
                            $.common.openTips({message: result.msg},'error');
                            return false;
                    }
                    //渲染数据
                    $.common.renderData({
                            form_id: 'edit-adv-form',
                            data: result.data
                    });
                    _res_info = result.data;
                    //关闭加载
                    $.common.closeTips('loading-in');
                }
            });            

                    
            //打开窗口
            $.common.openWindow({
                id: 'edit-adv-box',
                title: '编辑广告',
                height: 500,
                width: 700,
                reset: true,
                enable_next: true, //启用下一步
                next_class: 'custom-next',
                next_function: function () {
                    //商户名称必须填写
                    if (_form.find('input[name="advert_name"]').val() == '') {
                        $.common.openTips({
                            className: 'error',
                            icon: 'icon-info-sign',
                            message: "请输入广告名称",
                        });

                        //光标定位
                        _form.find('input[name="advert_name"]').focus();

                        setTimeout(function () {
                            $.common.closeTips('error');
                        }, 3000);
                        return false;
                    }
                    //根据类型选择显示层
                    var _material_type_val = $("div[dialog-id=edit-adv-box] input[type=radio][name=material_type]:checked").val();
                    $('div[dialog-id="edit-adv-box"] div[material_type]').addClass('hide2');
                    $('div[dialog-id="edit-adv-box"] div[material_type]:eq('+(_material_type_val-1)+')').removeClass('hide2');
            

                    //显示第二步
                    $(document).find('[tag-id="setup-1"]').addClass('hide2');
                    $(document).find('[tag-id="setup-2"]').removeClass('hide2');

                    //隐藏下一步按钮
                    $(document).find('.custom-next').addClass('hide2');

                    //显示上一步 和 确认按钮
                    $(document).find('.custom-back').removeClass('hide2');
                    $(document).find('.custom-confirm').removeClass('hide2');
                    
                    
                    
                },
                enable_back: true, //启用上一步
                back_class: 'custom-back hide2',
                back_function: function () {
                    //显示第一步
                    $(document).find('[tag-id="setup-1"]').removeClass('hide2');
                    $(document).find('[tag-id="setup-2"]').addClass('hide2');

                    //隐藏确认 和 上一步按钮
                    $(document).find('.custom-confirm').addClass('hide2');
                    $(document).find('.custom-back').addClass('hide2');

                    //显示下一步
                    $(document).find('.custom-next').removeClass('hide2');
                },
                confirm_class: 'custom-confirm hide2',
                confirm_title: '确认添加',
                confirm_function: function () {
                    //添加编辑商户
                    adv.addAdvert('edit-adv-form');
                }
            });
            
            if(_res_info.material_type == 1){
                var viewfile = [{src:_res_info.source_src,md5val:_res_info.source_md5}];
                $.common.webupload_initialize(webupload,'advpic_md5',4,'jpg,jpeg,png',{viewfile:viewfile});

                $.common.webupload_initialize(webupload,'advvideo_md5',5,'3gp,mp4');
                $.common.webupload_initialize(webupload,'advvideopic_md5',6,'jpg,jpeg,png');
            }else{
                var viewfile1 = [{src:_res_info.source_src,md5val:_res_info.source_md5,mtype:'video'}];
                var viewfile2 = [{src:_res_info.thum_src,md5val:_res_info.thum_md5}];
                $.common.webupload_initialize(webupload,'advpic_md5',4,'jpg,jpeg,png');
                $.common.webupload_initialize(webupload,'advvideo_md5',5,'3gp,mp4',{viewfile:viewfile1});
                $.common.webupload_initialize(webupload,'advvideopic_md5',6,'jpg,jpeg,png',{viewfile:viewfile2});
            }
        });
        
        //删除广告-单个
        $('[event-name="del-adv"]').on('click', function () {
            //要删除的ID
            var id = $(this).attr('event-id');
            var status = $(this).attr('status');
            if(status === '1'){
                $.common.openTips({className: 'error',icon: 'icon-info-sign',message:"发丰中的广告不能删除"});
                return false;
            }

            $("div[dialog-id=del-adv-box] input[name=id]").val(id);
            //打开窗口
            $.common.openWindow({
                id: 'del-adv-box',
                height: 300,
                width: 600,
                title: '删除发布广告',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-adv-form'});
                },
            });
        });

        //删除广告-多个
        $('[event-name="dels-adv"]').on('click', function () {
            //要删除的ID            
            var chk_value = [],publish_name='';
            $("input[name=item_id]:checked").each(function () {
                chk_value.push($(this).val());
                if($(this).attr('publish_num')>0){
                    publish_name += $(this).attr('item_name')+' '
                }
            });
            //发布中的广告不能删除
            if (publish_name !== '') {$.common.openTips({className: 'error',icon: 'icon-info-sign',message: '['+publish_name+']'+"发布中的广告不能删除",});  
                setTimeout(function () { $.common.closeTips('error'); }, 3000);
                return false;
            }
            $("div[dialog-id=dels-adv-box] input[name=id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-adv-box',
                height: 300,
                width: 600,
                title: '批量删除广告',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-adv-form'});
                },
            });
        });
        
        //发布广告
        $('[event-name="publish-advs"]').on('click',function(){     
            var chk_value = [],chk_name = '',publish_name='';
            $("input[name=item_id]:checked").each(function () {
                if($(this).attr('publish_num')>0){
                    publish_name += $(this).attr('item_name')+' '
                }
                chk_value.push($(this).val());
                chk_name += $(this).attr('item_name')+'、'
            });
            //已经发布过的广告不能批量编辑
            if (publish_name !== '') {$.common.openTips({className: 'error',icon: 'icon-info-sign',message: '['+publish_name+']'+"已经发布过的广告不能批量编辑",});  
                setTimeout(function () { $.common.closeTips('error'); }, 3000);
                return false;
            }
            
            //必须选择广告
            if (chk_name === '') {$.common.openTips({className: 'error',icon: 'icon-info-sign',message: "请选择广告",});  
                setTimeout(function () { $.common.closeTips('error'); }, 3000);
                return false;
            }
                    
            $('#check_advname').html(chk_name);
            var _form = $("form[form-id='publish-adv-form']");
            _form.find('input[name=id]').val(chk_value);
            $.common.openWindow({
                id: 'publish-adv-box',
                height: 500,
                width: 700,
                title: '发布广告',
                confirm_function: function () {
                    var _data_hotel_id = [],_data_hotel_stime=[],_data_hotel_etime=[];
                    $('tr[id^=hotel_tr_]').each(function(){
                        var _this = $(this);                       
                        _data_hotel_id.push(_this.find('input:eq(0)').val() );
                        _data_hotel_stime.push(_this.find('input:eq(1)').val() );
                        _data_hotel_etime.push(_this.find('input:eq(2)').val() );
                    });
                 
                    $.common.ajaxFormSubmit({id: 'publish-adv-form',data:{hotel_id:_data_hotel_id,stime:_data_hotel_stime,etime:_data_hotel_etime}});
                },
            });
            
        });
          
        //发布广告-单个
        $('[event-name="publish-adv"]').on('click',function(){     
            var _this = $(this);
            var _info_url = $.common.typeCheck(_this.attr('url'), 'undefined', false);
            var _this_id = _this.attr('event-id');
            var _form = $(document).find('[form-id="publish-adv-form"]');  
            _form.find('input[name=id]').val(_this_id);
     
            $('#check_advname').html($('input[name=item_id][value='+_this_id+']').attr('item_name'));
            $.common.ajaxFormSubmit({
                url: _info_url,
                data: {adv_id:_this_id},
                success:function(result){
                        //获取数据失败
                        if( result.status == 0 ){
                                $.common.openTips({message: result.msg},'error');
                                return false;
                        }
                        //渲染数据 result.data
                        $('tr[id^=hotel_tr_]').remove();
                        $.each(result.data.plist,function(i,n){
                            drawhoteldata(n);
                        });
                        //关闭加载
                        $.common.closeTips('loading-in');
                }
            });  
            
            
            $.common.openWindow({
                id: 'publish-adv-box',
                height: 500,
                width: 700,
                title: '发布广告',
                confirm_function: function () {
                    var _add_data_hotel_id = [],_add_data_hotel_stime=[],_add_data_hotel_etime=[];
                    var _edit_id = [],_edit_data_hotel_stime=[],_edit_data_hotel_etime=[];
                    $('tr.add_tr[id^=hotel_tr_]').each(function(){
                        var _this = $(this);                       
                        _add_data_hotel_id.push(_this.find('input:eq(0)').val() );
                        _add_data_hotel_stime.push(_this.find('input:eq(1)').val() );
                        _add_data_hotel_etime.push(_this.find('input:eq(2)').val() );
                    });
                    $('tr.edit_tr[id^=hotel_tr_]').each(function(){
                        var _this = $(this);                       
                        _edit_id.push(_this.find('input:eq(0)').val() );
                        _edit_data_hotel_stime.push(_this.find('input:eq(1)').val() );
                        _edit_data_hotel_etime.push(_this.find('input:eq(2)').val() );
                    });
                 
                    $.common.ajaxFormSubmit({id: 'publish-adv-form',data:{hotel_id:_add_data_hotel_id,stime:_add_data_hotel_stime,etime:_add_data_hotel_etime,r_id:_edit_id,edit_stime:_edit_data_hotel_stime,edit_etime:_edit_data_hotel_etime}});
                },
            });
            
        });
        
        //打开搜索界面
        $.common.get_search_hotels('open-seach-hotel',dohoteldata);
        
        //处理选择的酒店数据-发布时用
        function dohoteldata(hotel_data){
            var html = '';
            $.each(hotel_data,function(i,n){
                if($('#hotel_tr_'+n.id).length !== 0){
                    html += '';
                }else{
                    html +=  '<tr class="add_tr" id="hotel_tr_'+n.id+'" hotel_id="'+n.id+'">'+
                        '<td>'+n.title+'</td>'+
                        '<td>'+
                        '<div class="input-group">'+
                        '<span class="input-group-addon">'+
                        '<i class="icon-calendar bigger-110"></i>'+
                        '</span> '+
                        '<input type="hidden" name="hotel_id"  value="'+n.id+'" /><input class="form-control date-picker" type="text" name="date-picker" value="" />'+                        
                        '</div>'+
                        '</td>'+
                        '<td>'+
                        '<div class="input-group">'+
                        '<span class="input-group-addon">'+
                        '<i class="icon-calendar bigger-110"></i>'+
                        '</span> '+
                        '<input class="form-control date-picker" type="text" name="date-picker"  value="" />'+                        
                        '</div>'+
                        '</td>'+
                        '<td>'+
                        '<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">'+
                        '<a class="red" event-name="publish-del-hotel"   href="javascript:void(0);" title="删除">'+
                        '<i class="icon-trash bigger-130"></i>'+
                        '</a>'+
                        '</div>'+
                        '</td>'+
                        '</tr> ';
                }     
            });                
            $(html).appendTo('#hotel_data');            
        }
        
        //处理选择的酒店数据-编辑时用
        function drawhoteldata(hotel_data){
            if($('#hotel_tr_'+hotel_data.hotel_id).length !== 0){
                return false;
            }
            var html =  '<tr class="edit_tr" id="hotel_tr_'+hotel_data.hotel_id+'" hotel_id="'+hotel_data.hotel_id+'">'+
                        '<td>'+hotel_data.hotel_name+'</td>'+
                        '<td>'+
                        '<div class="input-group">'+
                        '<span class="input-group-addon">'+
                        '<i class="icon-calendar bigger-110"></i>'+
                        '</span> '+
                        '<input type="hidden" name="rele_id"  value="'+hotel_data.id+'" /><input class="form-control date-picker" type="text" name="date-picker" id="id-date-picker-1" value="'+hotel_data.begin_time+'" />'+                        
                        '</div>'+
                        '</td>'+
                        '<td>'+
                        '<div class="input-group">'+
                        '<span class="input-group-addon">'+
                        '<i class="icon-calendar bigger-110"></i>'+
                        '</span> '+
                        '<input class="form-control date-picker" type="text" name="date-picker" id="id-date-picker-1" value="'+hotel_data.end_time+'" />'+                        
                        '</div>'+
                        '</td>'+
                        '<td>'+
                        '<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">'+
                        '<a class="red" event-name="publish-del-hotel-ajax"  event-id="'+hotel_data.id+'" href="javascript:void(0);" title="删除">'+
                        '<i class="icon-trash bigger-130"></i>'+
                        '</a>'+
                        '</div>'+
                        '</td>'+
                        '</tr> ';
                
            $(html).appendTo('#hotel_data');            
        }
        
        //删除发布酒店
        $('body').on('click','a[event-name="publish-del-hotel"]',function(){
            $(this).parent().parent().parent().remove();
        });

        //删除发布酒店
        $('body').on('click','a[event-name="publish-del-hotel-ajax"]',function(){
            var _this = $(this);
            var _this_id = _this.attr('event-id');
            $.common.ajaxFormSubmit({
                url: '/Adv/delRelease',
                data: {id:_this_id},
                success:function(result){
                        //获取数据失败
                        if( result.status == 0 ){
                                $.common.openTips({message: result.msg},'error');
                                return false;
                        }
                        _this.parent().parent().parent().remove();
                        //关闭加载
                        $.common.closeTips('loading-in');
                }
            }); 
        });
        
        //停止广告-多个
        $('[event-name="stops-adv"]').on('click', function () {
            var _this = $(this);
            //要删除的ID            
            var chk_value = [];
            $("input[name=item_id]:checked").each(function () {
                chk_value.push($(this).val());
            });
            //没有选择广告
            if(chk_value.length == 0){
                $.common.openTips({className: 'error',icon: 'icon-info-sign',message: "请选择要下架的广告"});
                return false;
            }
            $("div[dialog-id=stops-adv-box] input[name=id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'stops-adv-box',
                height: 300,
                width: 600,
                title: _this.attr('event-title'),
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'stops-adv-form'});
                },
            });
        });
        
        //查看广告详情
        $('a[event-name="info-adv"]').on('click',function(){
            var _url = $(this).attr('url');
            window.location.href = _url;
        });
        
        //广告位置维护-展开隐藏
        $('.spread').on('click',function(){
            var _this = $(this);
            var _hotel_id = _this.attr('hotel_id')
            if($(this).is('.icon-plus-sign')){//当前隐藏子级
                $('.tr_hotel_'+_hotel_id).removeClass('hide'); 
                _this.removeClass('icon-plus-sign').addClass('icon-minus-sign');
            }else{
                $('.tr_hotel_'+_hotel_id).addClass('hide');
                _this.removeClass('icon-minus-sign').addClass('icon-plus-sign');
            }
        });
        
        //广告位置调整
        $('.btn-up').on('click',function(){
            var _this = $(this);
            var _id = _this.attr('r_id');
            var _url = _this.attr('url');
            $.ajax({
                type: "POST",
                url: _url,
                async: false,
                data: {id: _id,type:'up'},
                success: function (result) {
                    if(result.status === 0){
                        //处理位置失败，前端不做调整
                    }else{
                        //前端对应调整位置
                        var _tr = _this.parent().parent();
                        if(_tr.prev().is('.tr_hotel_'+_this.attr('h_id'))){
                            _tr.prev().before(_tr);
                        }
                    }
                }
            });
            
        });
        $('.btn-down').on('click',function(){
            var _this = $(this);
            var _id = _this.attr('r_id');
            var _url = _this.attr('url');
            $.ajax({
                type: "POST",
                url: _url,
                async: false,
                data: {id: _id,type:'down'},
                success: function (result) {
                    if(result.status === 0){
                        //处理位置失败，前端不做调整
                    }else{
                        //前端对应调整位置
                        var _tr = _this.parent().parent();
                        if(_tr.next().is('.tr_hotel_'+_this.attr('h_id'))){
                            _tr.next().after(_tr);
                        }
                    }
                }
            });
            
        });
    });
});