/**
 * 系统基础信息维护
 */

seajs.use('', function () {
    $(function () {
        //=========================================================================
        //商户类型标签==============================================================
        //=========================================================================   
        //搜索
        $('#shoptype-search-button').on('click', function () {
            var search_key = $("#search-key").val();
            var search_url = $(this).attr('surl') + "?search_key=" + search_key;
            window.location.href = search_url
        })

        //添加商户类型
        $('[event-name="add-shop-type"]').on('click', function () {
            //打开窗口
            $.common.openWindow({
                id: 'add-shop-type-box',
                height: 320,
                width: 600,
                title: '新增商户类型',
                confirm_function: function () {
                    //表单验证参数
                    var validator_params = {
                        //验证字段
                        fields: {
                            //详细配置
                            type_name: {
                                rule: 'required',
                                msg: {
                                    required: "请输入类型名！",
                                },
                            },
                        }

                    };

                    //提交表单
                    $.common.formSubmit('add-shop-type-form', validator_params);

                },

            });
        });

        //删除商户类型-单个
        $('[event-name="del-shop-type"]').on('click', function () {
            //要删除的ID
            var type_id = $(this).attr('event-id');
            $("div[dialog-id=del-shop-type-box] input[name=type_id]").val(type_id);
            //打开窗口
            $.common.openWindow({
                id: 'del-shop-type-box',
                height: 300,
                width: 600,
                title: '删除商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-shop-type-form'});
                },
            });
        });

        //删除商户类型-多个
        $('[event-name="dels-shop-type"]').on('click', function () {
            //要删除的ID
            var type_id = $(this).attr('event-id');
            var chk_value = [];
            $("input[name=type_item]:checked").each(function () {
                chk_value.push($(this).val());
            });
            $("div[dialog-id=dels-shop-type-box] input[name=type_id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-shop-type-box',
                height: 300,
                width: 600,
                title: '批量删除商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-shop-type-form'});
                },
            });
        });

        //编辑商户类型
        $('[event-name="edit-shop-type"]').on('click', function () {
            var type_id = $(this).attr('event-id');
            $.ajax({
                type: "POST",
                url: "/Baseinfo/getTypeInfo",
                async: false,
                data: "id=" + type_id,
                success: function (rs_info) {
                    //console.log(rs_info.info.type_class);
                    $("#edit-shop-type-box input[name=type_name]").val(rs_info.info.type_name);
                    $("#edit-shop-type-box textarea[name=type_desc]").val(rs_info.info.type_desc);
                    $("#edit-shop-type-box select[name=type_class]").val(rs_info.info.type_class);
                    $("#edit-shop-type-box input[name=type_id]").val(type_id);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-shop-type-box',
                height: 300,
                width: 600,
                title: '编辑商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-shop-type-form'
                    });
                },
            });
        });


        //=========================================================================
        //行业分类标签==============================================================
        //=========================================================================   
        //搜索
        $('#trade-search-button').on('click', function () {
            var search_key = $("#search-key").val();
            var search_url = $(this).attr('surl') + "?search_key=" + search_key;
            window.location.href = search_url
        })

        //添加行业分类
        $('[event-name="add-trade"]').on('click', function () {
            //打开窗口
            $.common.openWindow({
                id: 'add-trade-box',
                height: 260,
                width: 600,
                title: '新增行业分类',
                confirm_function: function () {
                    //表单验证参数
                    var validator_params = {
                        //验证字段
                        fields: {
                            //详细配置
                            category_name: {
                                rule: 'required',
                                msg: {
                                    required: "请输入分类名！",
                                },
                            },
                        }

                    };

                    //提交表单
                    $.common.formSubmit('add-trade-form', validator_params);

                },

            });
        });

        //删除商户类型-单个
        $('[event-name="del-trade"]').on('click', function () {
            //要删除的ID
            var type_id = $(this).attr('event-id');

            $("div[dialog-id=del-trade-box] input[name=trade_id]").val(type_id);
            //打开窗口
            $.common.openWindow({
                id: 'del-trade-box',
                height: 300,
                width: 600,
                title: '删除行业分类',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-trade-form'});
                },
            });
        });

        $('[event-name="dels-trade"]').on('click', function () {
            //要删除的ID
            var type_id = $(this).attr('event-id');
            var chk_value = [];
            $("input[name=type_item]:checked").each(function () {
                chk_value.push($(this).val());
            });
            $("div[dialog-id=dels-trade-box] input[name=trade_id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-trade-box',
                height: 300,
                width: 600,
                title: '批量删除行业分类',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-trade-form'});
                },
            });
        });

        //编辑商户类型
        $('[event-name="edit-trade"]').on('click', function () {
            var trade_id = $(this).attr('event-id');
            $.ajax({
                type: "POST",
                url: "/Baseinfo/getTradeInfo",
                async: false,
                data: "id=" + trade_id,
                success: function (rs_info) {
                    $("#edit-trade-box input[name=category_name]").val(rs_info.info.category_name);
                    $("#edit-trade-box textarea[name=category_desc]").val(rs_info.info.category_desc);
                    $("#edit-trade-box input[name=trade_id]").val(trade_id);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-trade-box',
                height: 300,
                width: 600,
                title: '编辑商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-trade-form'
                    });
                },
            });
        });



        //=========================================================================
        //图标管理   ==============================================================
        //=========================================================================   
        //搜索
        $('#icon-search-button').on('click', function () {
            var search_key = $("#search-key").val();
            var search_url = $(this).attr('surl') + "?search_key=" + search_key;
            window.location.href = search_url
        })

        //添加图标
        $('[event-name="add-icon"]').on('click', function () {
            //打开窗口
            $.common.openWindow({
                id: 'add-icon-box',
                height: 350,
                width: 600,
                title: '新增图标',
                confirm_function: function () {
                    //表单验证参数
                    var validator_params = {
                        //验证字段
                        fields: {
                            //详细配置
                            category_name: {
                                rule: 'required',
                                msg: {
                                    required: "请输入图标名！",
                                },
                            },
                        }

                    };

                    //提交表单
                    $.common.formSubmit('add-icon-form', validator_params);

                },

            });
        });

        //删除图标-单个
        $('[event-name="del-icon"]').on('click', function () {
            //要删除的ID
            var icon_id = $(this).attr('event-id');

            $("div[dialog-id=del-icon-box] input[name=icon_id]").val(icon_id);
            //打开窗口
            $.common.openWindow({
                id: 'del-icon-box',
                height: 300,
                width: 600,
                title: '删除图标',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-icon-form'});
                },
            });
        });

        //删除图标-多个
        $('[event-name="dels-icon"]').on('click', function () {
            //要删除的ID
            var icon_id = $(this).attr('event-id');
            var chk_value = [];
            $("input[name=icon_item]:checked").each(function () {
                chk_value.push($(this).val());
            });
            $("div[dialog-id=dels-icon-box] input[name=icon_id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-icon-box',
                height: 300,
                width: 600,
                title: '批量删除图标',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-icon-form'});
                },
            });
        });

        //编辑商户类型
        $('[event-name="edit-icon"]').on('click', function () {
            var icon_id = $(this).attr('event-id');
            $.ajax({
                type: "POST",
                url: "/Baseinfo/getIconInfo",
                async: false,
                data: "id=" + icon_id,
                success: function (rs_info) {
                    $("#edit-icon-box input[name=icon_name]").val(rs_info.info.icon_name);
                    $("#edit-icon-box input[name=icon_path]").val(rs_info.info.icon_path);
                    $("#edit-icon-box textarea[name=icon_desc]").val(rs_info.info.icon_desc);
                    $("#edit-icon-box input[name=icon_id]").val(icon_id);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-icon-box',
                height: 300,
                width: 600,
                title: '编辑商户类型',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-icon-form'
                    });
                },
            });
        });
        
        
        //=========================================================================
        //客房服务管理==============================================================
        //=========================================================================   
        //搜索
        $('#service-search-button').on('click', function () {
            var search_key = $("#search-key").val();
            var search_url = $(this).attr('surl') + "?search_key=" + search_key;
            window.location.href = search_url
        });

        //添加客户服务
        $('[event-name="add-service"]').on('click', function () {
            //打开窗口
            $.common.openWindow({
                id: 'add-service-box',
                height: 350,
                width: 600,
                title: '新增服务',
                confirm_function: function () {
                    //表单验证参数
                    var validator_params = {
                        //验证字段
                        fields: {
                            //详细配置
                            service_name: {
                                rule: 'required',
                                msg: {
                                    required: "请输入服务名！",
                                },
                            },
                        }

                    };

                    //提交表单
                    $.common.formSubmit('add-service-form', validator_params);

                },

            });
        });

        //删除服务-单个
        $('[event-name="del-service"]').on('click', function () {
            //要删除的ID
            var service_id = $(this).attr('event-id');

            $("div[dialog-id=del-service-box] input[name=service_id]").val(service_id);
            //打开窗口
            $.common.openWindow({
                id: 'del-service-box',
                height: 300,
                width: 600,
                title: '删除单条服务',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'del-service-form'});
                },
            });
        });

        //删除服务-多个
        $('[event-name="dels-service"]').on('click', function () {
            //要删除的ID
            var service_id = $(this).attr('event-id');
            var chk_value = [];
            $("input[name=service_item]:checked").each(function () {
                chk_value.push($(this).val());
            });
            $("div[dialog-id=dels-service-box] input[name=service_id]").val(chk_value);
            //打开窗口
            $.common.openWindow({
                id: 'dels-service-box',
                height: 300,
                width: 600,
                title: '批量删除服务',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({id: 'dels-service-form'});
                },
            });
        });

        //编辑商户类型
        $('[event-name="edit-service"]').on('click', function () {
            var service_id = $(this).attr('event-id');
            $.ajax({
                type: "POST",
                url: "/Baseinfo/getRoomServiceInfo",
                async: false,
                data: "id=" + service_id,
                success: function (rs_info) {
                    $("div[dialog-id=edit-service-box] input[name=service_name]").val(rs_info.info.service_name);
                    $("div[dialog-id=edit-service-box] textarea[name=service_info]").val(rs_info.info.service_info);   
                    
                    $("div[dialog-id=edit-service-box] select[name=icon_id]").val(rs_info.info.icon_id);
                    $("div[dialog-id=edit-service-box] select[name=service_type]").val(rs_info.info.service_type);                    
                    $("div[dialog-id=edit-service-box] input[name=service_id]").val(service_id);
                }
            });

            //打开窗口
            $.common.openWindow({
                id: 'edit-service-box',
                height: 350,
                width: 600,
                title: '编辑服务',
                confirm_function: function () {
                    $.common.ajaxFormSubmit({
                        id: 'edit-service-form'
                    });
                },
            });
        });

    });
});