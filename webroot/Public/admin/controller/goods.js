/**
 * 广告管理
 */
seajs.use(['webupload', 'module/goods'], function (webupload, goods) {
    $(function () {
        //通用删除
        $.common.form_del({attr_key:'status',attr_val:'2',attr_msg:'上架中的商品无法删除'});        
        
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
        });

        //====================================================================================================
        //=======商品分类管理
        //====================================================================================================
        //添加分类
        $('[event-name="add-cate"]').on('click', function () {
            //打开窗口
            $.common.openWindow({
                id: 'add-cate-box',
                height: 350,
                width: 600,
                title: '新增分类信息',
                confirm_function: function () {
                    goods.addCate('add-cate-form');
                },
            });
        });

        //编辑分类
        $('[event-name="edit-cate"]').on('click', function () {
            var id  = $(this).attr('event-id');
            var info_url = $(this).attr('info-url');
            $.ajax({
                type: "POST",
                url: info_url,
                data: {id:id},
                success: function (result) {
                    //获取数据失败
                    if(result.status === 0){
                            $.common.openTips({message: result.msg},'error');
                            return false;
                    }
                    //渲染数据
                    $.common.renderData({
                            form_id: 'edit-cate-form',
                            data: result.data
                    });                    
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-cate-box',
                height: 450,
                width: 700,
                title: '编辑商品分类',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-cate-form',
                        data:{id:id}
                    });
                },
            });
        });
        //====================================================================================================
        //=======商品管理
        //====================================================================================================
        //添加商品
        $('[event-name="add-goods"]').on('click', function () {
            $('div[dialog-id=add-goods-box] input[name=goods_pic_md5]').val('');
            //打开窗口
            $.common.openWindow({
                id: 'add-goods-box',
                height: 650,
                width: 600,
                title: '新增商品信息',
                confirm_function: function () {
                    goods.addGoods('add-goods-form');
                },
            });
            
            $.common.webupload_initialize(webupload,'goods_pic_md5',1,'jpg,jpeg,png');
        });
        
        //编辑商品
        $('[event-name="edit-goods"]').on('click', function () {
            var id  = $(this).attr('event-id');
            var info_url = $(this).attr('info-url');
            var status = $(this).attr('status');
            //上架商品不可删除
            if(status === '1'){
                $.common.openTips({message: '上架中的商品无法编辑，请先下架商品再编辑！'},'error');
                return false;
            }
            $('div[dialog-id=edit-goods-box] input[name=goods_pic_md5]').val('');
            $.ajax({
                type: "POST",
                url: info_url,
                data: {id:id},
                success: function (result) {
                    //获取数据失败
                    if(result.status === 0){
                            $.common.openTips({message: result.msg},'error');
                            return false;
                    }
                    //渲染数据
                    $.common.renderData({
                            form_id: 'edit-goods-form',
                            data: result.data
                    });
                    $("#has_img_goods").attr('src',result.data.goods_pic);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-goods-box',
                height: 450,
                width: 700,
                title: '编辑商品',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-goods-form',
                        data:{id:id}
                    });
                }
            });
            $('div[dialog-id=edit-goods-box] input[name=goods_pic_md52]').val('');
            $.common.webupload_initialize(webupload,'goods_pic_md52',2,'jpg,jpeg,png');
        });
        
        //上架
        $('[event-name="shelf-up"]').on('click',function(){
            
            var id      = $(this).attr('event-id');          
            var _box = $("div[dialog-id=shelf-up-box]");//上架弹框
            var shelf_id = '';
            var goods_name = '';
            var goon = true;
            //广告ID
            $('.select_item').html('');
            if(id === 'checkbox'){  
                $("input[name=item_id]:checked").each(function () {                    
                    shelf_id = shelf_id + ',' + $(this).val();
                    goods_name = goods_name + ',' + $(this).attr('item_name');
                    
                    var key_val = $.common.typeCheck($(this).attr('status') , 'undefined' , false);
                    if(key_val !== false && key_val !== '2'){
                        goon = false;
                    }
                });

                if (shelf_id.substr(0,1) === ','){
                    shelf_id=shelf_id.substr(1);
                } 
                if (goods_name.substr(0,1) === ','){
                    goods_name=goods_name.substr(1);
                } 

            }else{                
                shelf_id = id;
                goods_name = $(this).attr('item_name'); 
                //获取当前已经选择的酒店
                $.ajax({
                    type: "POST",
                    url: "/Shop/getHotelListWithGoodsId",
                    data:{id:shelf_id},
                    success: function (res) {
                        if(res.status != 1){
                            return false;
                        }
                        $.each(res.data,function(i,n){
                            var _html = '<li hotel_id="'+n.hotel_id+'"><div class="close">x</div><div class="text">'+n.hotel_name+'</div></li>';
                            $(_html).appendTo('.select_item');                            
                        });
                    }
                });
            }           
            
            if(goon === false){
                $.common.openTips({message:'只有下架状态商品可上架操作!'},'error'); 
                return false;
            }
            
            _box.find("#up-goods-name").html(goods_name);//删除提示内容
            if(shelf_id.length === 0){
                $.common.openTips({message: '请选择要上架的商品！'},'error');
                return false;
            }
            
            $.ajax({
                type: "POST",
                url: "/Shop/getHotelListWithLetter",
                success: function (res) {
                    if(res.status != 1){
                        return false;
                    }
                    $.each(res.data,function(i,n){
                        var _html = '<li>'+
                                    '<a style="cursor: pointer" class="show_hotel icon-plus-sign" herf="javascript:void(0)"></a>&nbsp;'+ i +
                                    '<ul class="item hide">';
                            
                        $.each(n,function(ii,nn){
                            _html += '<li item_id="'+nn.id+'">'+nn.hotel_name+'</li>';
                        });
                                    
                            _html+='</ul></li>';
                        $(_html).appendTo('.hotel_list');
                    });
                }
            });
            
            //打开窗口
            $.common.openWindow({
                id: 'shelf-up-box',
                height: 500,
                width: 600,
                title: '商品上架',
                confirm_function: function () {
                    //获取选中酒店ID
                    var _item = $('.select_item li');//所有选中酒店
                    var _select_hotel_id = '';
                    _item.each(function(){
                        _select_hotel_id = _select_hotel_id + ',' + $(this).attr('hotel_id');
                    });
                    
                    if (_select_hotel_id.substr(0,1) === ','){
                        _select_hotel_id=_select_hotel_id.substr(1);
                    } 
            
                    $.common.ajaxFormSubmit({
                        id: 'shelf-up-form',
                        data:{id:shelf_id,hotel_id:_select_hotel_id}
                    });
                }
            });
        });
        
        //下架
        $('[event-name="shelf-down"]').on('click',function(){
            
            var id      = $(this).attr('event-id'); 
            var goods_id = '';
            var goon = true;
            //广告ID
            
            if(id === 'checkbox'){  
                $("input[name=item_id]:checked").each(function () {                    
                    goods_id = goods_id + ',' + $(this).val();
                    
                    var key_val = $.common.typeCheck($(this).attr('status') , 'undefined' , false);
                    if(key_val !== false && key_val !== '1'){
                        goon = false;
                    }
                });
                //处理前面那个 ","
                if (goods_id.substr(0,1) === ','){
                    goods_id=goods_id.substr(1);
                }              

            }else{                
                goods_id = id;
                
                var key_val = $.common.typeCheck($(this).attr('status') , 'undefined' , false);                                                
                if(key_val !== false && key_val !== '1'){
                    goon = false;
                }
            }           
            
            if(goon === false){
                $.common.openTips({message:'只有上架状态商品才可下架操作!'},'error'); 
                return false;
            }
            
            if(goods_id.length === 0){
                $.common.openTips({message: '请选择要下架的商品！'},'error');
                return false;
            }
            
            $.common.ajaxFormSubmit({
                    type: 'POST',
                    url: '/Goods/downGoods',
                    data: {ids:goods_id},
                    success:function(res){
                        //关闭加载框
                        if(res.status === 1){
                            $.common.closeTips('loading-in');
                            $.common.openTips({message:'产品下架成功!'}); 
                            setTimeout(function(){window.location.reload();},3000);
                        }else{
                            $.common.openTips({message:'产品下架失败!'},'error'); 
                            return false;
                        }                        
                    }
            });
       
            
        });
        
        //选中
        $('.hotel_list').on('click','.item li',function(){
            if($(this).is('.active')){
                $(this).removeClass('active');
            }else{
                $(this).addClass('active');
            }
        });
        //酒店展开
        $('.hotel_list').on('click','.show_hotel',function(){
            var _this = $(this);
            if(_this.is('.icon-plus-sign')){//当前隐藏子级                
                _this.next('ul').removeClass('hide');
                _this.removeClass('icon-plus-sign').addClass('icon-minus-sign');
            }else{
                _this.next('ul').addClass('hide');
                _this.removeClass('icon-minus-sign').addClass('icon-plus-sign');
            }
        });
        //删除选中酒店
        $('.select_item').on('click','.close',function(){
            var _this = $(this);
            _this.parent().remove();
        });
        //选择商户 
        $('.btn-add').on('click',function(){
            var _this = $(this);
            var _item = $('ul.item .active');//所有选中酒店
            _item.each(function(){
                var _hotel_id = $(this).attr('item_id');
                if($("li[hotel_id="+_hotel_id+"]").length === 0){
                    var _hotel_name = $(this).html();
                    var _html = '<li hotel_id="'+_hotel_id+'"><div class="close">x</div><div class="text">'+_hotel_name+'</div></li>';
                    $(_html).appendTo('.select_item');
                }
            });
        });
        
        //打开搜索界面
        $.common.get_search_hotel('open-seach-hotel',dohoteldata);
        
        //处理选择的酒店数据-发布时用
        function dohoteldata(hotel_data){          
            if($("li[hotel_id="+hotel_data.id+"]").length !== 0){
                return false;
            }
            var _html = '<li hotel_id="'+hotel_data.id+'"><div class="close">x</div><div class="text">'+hotel_data.title+'</div></li>';
            $(_html).appendTo('.select_item');
        }
        
        //添加促销信息
        $('[event-name="add-sales"]').on('click', function () {
            //ID隐藏ID域
            var tagid = 'goods_id_add';
            //删除选中标签项
            $.common.remove_choose(tagid);   
            //清空隐藏值及已选中值
            $('input[name=goods_id]').val('');
            $('[tag-id="checked-goods"]').html('');
            //打开窗口
            $.common.openWindow({
                id: 'add-sales-box',
                height: 350,
                width: 600,
                title: '新增促销信息',
                confirm_function: function () {
                    goods.addSales('add-sales-form');
                }
            });
            
            //选择商品-促销管理            
            $.common.get_search_goods('choose-goods-add',function(res){
                var chk_val = [];
                var tag = $('input[tag-id='+tagid+']');
                var tag_val = tag.val().split(',');
                $.each(res,function(i,n){
                    var tag_val = n.id;                
                    var is_has = $.common.inArray(tag_val, tag_val);
                    if(is_has === false){
                        var _html = '<span><span class="label" tag-id="label">'+n.title+'<i id="'+n.id+'" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span></span>';
                        $(_html).appendTo('[tag-id=checked-goods]');
                        chk_val.push(n.id);
                    }
                });
                var _new_val = chk_val.concat(tag_val);
                for (var i = 0; i < _new_val.length; i++){
                    if (_new_val[i] === "" || typeof (_new_val[i]) === "undefined"){
                        _new_val.splice(i, 1);
                        i = i - 1;
                    }
                }
                tag.val(_new_val);
                
            },{tagid:tagid});  
        });
                
        //编辑促销信息
        $('[event-name=edit-sales]').on('click', function () {
            //通用商品选择后的标签删除
            var tagid = 'goods_id_edit';
            $.common.remove_choose(tagid);      
            var _this = $(this);
            var _info_url = $.common.typeCheck(_this.attr('info-url'), 'undefined', false);//获取详情URL
            var _url = $.common.typeCheck(_this.attr('url'), 'undefined', false);//编辑提交URL
            var _this_id = _this.attr('event-id');
            var _form = $(document).find('[form-id="edit-sales-form"]');  
       
            $.ajax({
                type: "POST",
                url: _info_url,
                data: "id=" + _this_id,
                success: function (res) {                    //内容获取失败
                    if(res.status != 1){
                        $.common.openTips({message: '内容拉取失败！'},'error');
                        return false;
                    }                    
                    //渲染数据
                    $.common.renderData({
                            form_id: 'edit-sales-form',
                            data: res.data
                    });
                    
                    //内容拉取成功
                    _form.find('[name=goods_id]').val(res.data.goods_ids);
                    var checked_name = '';
                    $.each(res.data.goods_list, function (i, n) {                        
                        checked_name += '<span><span class="label" tag-id="label">' + n.goods_name + ' <i id="' + n.id + '" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span></span>';
                    });

                    //标签加入标签区域
                    $("div[dialog-id=edit-sales-box]").find('[tag-id="checked-goods"]').html(checked_name);
                    
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-sales-box',
                height: 450,
                width: 700,
                title: '编辑促销信息',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-sales-form',
                        url:_url,
                        data:{id:_this_id}
                    });
                },
            });
            
            $.common.get_search_goods('choose-goods-edit',function(res){
                var chk_val = [];
                var type = $('input[tag-id='+tagid+']');
                var type_val = type.val().split(',');
                $.each(res,function(i,n){
                    var tag_val = n.id;                
                    var is_has = $.common.inArray(tag_val, type_val);
                    if(is_has === false){
                        var _html = '<span><span class="label" tag-id="label">'+n.title+'<i id="'+n.id+'" class="icon-remove" style="cursor:pointer;" title="点击移除" event-name="removeType"></i></span><span class="separate"></span></span>';
                        $(_html).appendTo('[tag-id=checked-goods]');
                        chk_val.push(n.id);
                    }
                });
                var _new_val = chk_val.concat(type_val);
                for (var i = 0; i < _new_val.length; i++){
                    if (_new_val[i] === "" || typeof (_new_val[i]) === "undefined"){
                        _new_val.splice(i, 1);
                        i = i - 1;
                    }
                }
                type.val(_new_val);
            },{tagid:tagid});
            
        });
        
        //======================================================================
        //======商品配对
        //======================================================================
        //显示及隐藏商品
        $('.showgoods').on('click',function(){
            var _this = $(this);
            var _hotel_id = $(this).attr('hotel_id');
            
            if(_this.is('.icon-plus-sign')){//当前隐藏子级                
                _this.parent().parent().parent().find('.tr_hotel_'+_hotel_id).removeClass('hide');
                _this.removeClass('icon-plus-sign').addClass('icon-minus-sign');
            }else{
                _this.parent().parent().parent().find('.tr_hotel_'+_hotel_id).addClass('hide');
                _this.removeClass('icon-minus-sign').addClass('icon-plus-sign');
            }
        });
        //添加配对
        $('[event-name=add-match]').on('click',function(){
            
            //打开窗口
            $.common.openWindow({
                id: 'add-match-box',
                height: 300,
                width: 700,
                title: '添加配对信息',
                confirm_function: function () {
                    goods.addMatch('add-match-form');
                },
            });
            //选择商品-匹配
            $.common.get_search_goods_single('open-seach-goods',function(goods_data){        
                $('[dialog-id=add-match-box]').find('input[name=goods_id]').val(goods_data.id);
                $('[dialog-id=add-match-box]').find('input[name=goods_name]').val(goods_data.title);
            },{tagid:'goods_id_edit'});   
        });
        //批量添加配对
        $('[event-name=add-matchs]').on('click',function(){
            $('div[dialog-id=add-matchs-box] input[name=templet_md5]').val('');
            //打开窗口
            $.common.openWindow({
                id: 'add-matchs-box',
                height: 400,
                width: 700,
                title: '批量添加配对',
                confirm_function: function () {
                    goods.addMatchs('add-matchs-form');
                }
            });
            $.common.webupload_initialize(webupload,'templet_md5',1,'xls,xlsx');
        });
        
        //打开搜索界面
        $.common.get_search_hotel('open-seach-hotel2',dohoteldata2);
        
        //处理选择的酒店数据
        function dohoteldata2(hotel_data){          
            $('[dialog-id=add-match-box]').find('input[name=hotel_id]').val(hotel_data.id);
            $('[dialog-id=add-match-box]').find('input[name=hotel_name]').val(hotel_data.title);
        }
        
         
        
        //编辑商品配对信息
        $('[event-name=edit-match]').on('click', function () {
            var _this = $(this);
            var _info_url = $.common.typeCheck(_this.attr('info-url'), 'undefined', false);//获取详情URL
            var _url = $.common.typeCheck(_this.attr('url'), 'undefined', false);//编辑提交URL
            var _this_id = _this.attr('event-id');
        
            $.ajax({
                type: "POST",
                url: _info_url,
                data: "id=" + _this_id,
                success: function (res) {
                    //内容获取失败
                    if(res.status != 1){
                        $.common.openTips({message: '内容拉取失败！'},'error');
                        return false;
                    }                    
                    //渲染数据
                    $.common.renderData({
                        form_id: 'edit-match-form',
                        data: res.data
                    });                    
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-match-box',
                height: 300,
                width: 700,
                title: '编辑配对信息',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-match-form',
                        url:_url,
                        data:{id:_this_id}
                    });
                },
            });       
            
            //选择商品-匹配
            $.common.get_search_goods_single('open-seach-goods',function(goods_data){        
                $('[dialog-id=add-match-box]').find('input[name=goods_id]').val(goods_data.id);
                $('[dialog-id=add-match-box]').find('input[name=goods_name]').val(goods_data.title);
            },{tagid:'goods_id_edit'});   
        });
        
        //
        $('input.hotel_checkbox').on('click',function(){
            var _this = $(this);
            var hotel_id = _this.attr('hotel_id');
            if(_this.is(':checked')){
                $('tr.tr_hotel_' + hotel_id).find('input[type=checkbox]').prop({checked:true});
            }else{
                $('tr.tr_hotel_' + hotel_id).find('input[type=checkbox]').prop({checked:false});
            }
        });
        
        
    });
});