/**
 * 广告管理
 */
seajs.use([], function () {
    $(function () {
        
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
        
        //查看订单详情
        $('a[event-name="view-orderinfo"]').on('click',function(){
            var _this = $(this);
            var url = _this.attr('info-url');
            var order_no = _this.attr('event-id');
            
            $.ajax({
                type: "POST",
                url: url,
                async: false,
                data: {order_no:order_no},
                success: function (res) {
                    if(res.status !== 1){
                        $.common.openTips({className: 'error', icon: 'icon-info-sign', message: "详情拉取失败"});
                        return false;
                    }
                    //订单数据
                    var order_info_html = '订单编号： '+res.data.order_no+'<br>'+
                                          '支付方式： '+res.data.payment+'<br>'+
                                          '支付状态： '+res.data.pay_status+'<br>'+
                                          '支付订单号： -<br>'+
                                          '订单金额： '+ res.data.order_amount/100 +'元';
                    $('#view_order_info').html(order_info_html);
                    
                    //日志
                    var log_html = '';
                    $.each(res.data.logs, function (i, n) {
                        log_html += n.create_time+ ' '+ n.order_msg + '<br>';
                    });
                    $('#view_logs').html(log_html);
                   
                   //销售信息
                   
                   var view_hotel_html = '销售商户： '+res.data.sale_hotel+'<br>'+
                                        '销售房号： '+res.data.room_name+'<br>'+
                                        '设备地址： '+res.data.device_info.device_address+'<br>';
                   $('#view_hotel').html(view_hotel_html);
                   
                   //商品
                   
                   var view_goods_html = '';                   
                   $.each(res.data.goods_list,function(i,n){
                       view_goods_html +=  '<div>'+
                                            '<div class="col-sm-2" style="padding:0">'+
                                            '    <img src="'+n.res_path+'" style="width: 40px">'+
                                            '</div>'+
                                            '<div class="col-sm-6">'+
                                            '    '+n.goods_name+'<br>'+
                                            '    '+n.goods_cate+
                                            '</div>'+
                                            '<div class="col-sm-4">'+
                                            '   单价:'+ n.goods_price/100 +'元<br>'+
                                            '    数量:'+n.goods_quantity+''+
                                            '</div>'+
                                        '</div><div class="space-4" style="border-bottom:1px solid #ccc"></div>';
                   });
                    $('#view_goods').html(view_goods_html);
                }
            });
            
            $.common.openWindow({
                id: 'order-info-box',
                height: 600,
                width: 700,
                title: '订单详情',
            });
            
        });
        
    });
});