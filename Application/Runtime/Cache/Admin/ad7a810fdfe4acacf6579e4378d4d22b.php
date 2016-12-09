<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>控制台 - 乐锋派后台管理系统</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<link href="/Public/plugins/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="/Public/plugins/assets/css/font-awesome.min.css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="/Public/plugins/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
		<!-- page specific plugin styles -->
		
		<!-- ace styles -->
		<link rel="stylesheet" href="/Public/plugins/assets/css/ace.min.css" />
		<link rel="stylesheet" href="/Public/plugins/assets/css/jquery-ui-1.10.3.full.min.css" />
		<link rel="stylesheet" href="/Public/plugins/nice-validator-1.0.7/jquery.validator.css" />
		<link rel="stylesheet" href="/Public/plugins/dropzone/css/dropzone.min.css" />
		<link rel="stylesheet" href="/Public/plugins/dropzone/css/basic.min.css" />
		<link rel="stylesheet" href="/Public/static/css/common.css" />
		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="/Public/plugins/assets/css/ace-ie.min.css" />
		<![endif]-->
		<!-- inline styles related to this page -->
		<!-- ace settings handler -->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="/Public/plugins/assets/js/html5shiv.js"></script>
		<script src="/Public/plugins/assets/js/respond.min.js"></script>
		<![endif]-->
		
		
		
	</head>
	<body>
		<div class="navbar navbar-default" id="navbar">
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){}
	</script>
	
	<div class="navbar-container" id="navbar-container">
		<div class="navbar-header pull-left log">
			<a href="<?php echo U('Index/index');?>" class="navbar-brand">
				<small>
					<i class="icon-leaf"></i>
					乐锋派后台管理系统
				</small>
			</a><!-- /.brand -->
		</div><!-- /.navbar-header -->
	
		<div class="navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav top-nav">
				<li class="nav-tit">
					<span><?php echo ($loginInfo['admin_name']); ?>，欢迎您</span>
				</li>
				<li class="nav-item">
					<a href="<?php echo U('Index/resetPwd');?>"><i class="icon icon-lock"></i>修改密码</a>
				</li>
				<li class="nav-item">
					<a href="<?php echo U('Public/logout');?>"><i class="icon icon-off"></i>退出系统</a>
				</li>
				
			</ul><!-- /.ace-nav -->
			<div class="sys-datetime">系统时间：<span id="now-datetime"><?php echo date('Y.m.d H:i:s');?></span>
			</div>
		</div><!-- /.navbar-header -->
	</div><!-- /.container -->
</div>
		<div class="main-container" id="main-container">
			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
	<span class="menu-text"></span>
</a>
<div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>

	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span>

			<span class="btn btn-info"></span>

			<span class="btn btn-warning"></span>

			<span class="btn btn-danger"></span>
		</div>
	</div><!-- #sidebar-shortcuts -->

	<ul class="nav nav-list">
		<li class="active">
			<a href="javascript:void(0);">
				<i class="icon-dashboard"></i>
				<span class="menu-text"> 菜单导航 </span>
			</a>
		</li>
		
		<?php if(!empty($menu)): if(is_array($menu)): $i = 0; $__LIST__ = $menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$big_item): $mod = ($i % 2 );++$i;?><li <?php if(in_array($big_item['id'],$path_id)): ?>class="open"<?php endif; ?>>
					<a href="<?php if(isset($big_item['url'])): echo ($big_item['url']); else: ?>javascript:void(0);<?php endif; ?>" class="dropdown-toggle">
						<i class="<?php echo ($big_item['icon_name']); ?>"></i>
						<span class="menu-text"> <?php echo ($big_item['title']); ?></span>
						<?php if(!empty($big_item["list"])): ?><b class="arrow icon-angle-down"></b>
							</a>
						    <ul class="submenu" <?php if(in_array($big_item['id'],$path_id)): ?>style="display: block;"<?php endif; ?>>
							    <?php if(is_array($big_item["list"])): $i = 0; $__LIST__ = $big_item["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$small_item): $mod = ($i % 2 );++$i;?><li <?php if(in_array($small_item['id'],$path_id)): ?>class="open"<?php endif; ?>>
										<a href="<?php if(isset($small_item['url'])): echo ($small_item['url']); else: ?>javascript:void(0);<?php endif; ?>" class="dropdown-toggle">
											<i class="<?php echo ($small_item['icon_name']); ?>"></i>
											<?php echo ($small_item['title']); ?>
										<?php if(!empty($small_item["list"])): ?><b class="arrow icon-angle-down"></b>
											</a>
											<ul class="submenu" <?php if(in_array($small_item['id'],$path_id)): ?>style="display: block;"<?php endif; ?>>
												<?php if(is_array($small_item["list"])): $i = 0; $__LIST__ = $small_item["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><li <?php if(in_array($item['id'],$path_id)): ?>class="active"<?php endif; ?>>
														<a href="<?php if(isset($item['url'])): echo ($item['url']); else: ?>javascript:void(0);<?php endif; ?>">
															<i class="<?php echo ($item['icon_name']); ?>"></i>
															<?php echo ($item['title']); ?>
														</a>
													</li><?php endforeach; endif; else: echo "" ;endif; ?>
											</ul>
										<?php else: ?>
											</a><?php endif; ?>
									</li><?php endforeach; endif; else: echo "" ;endif; ?>
						    </ul>
						<?php else: ?>
						 	</a><?php endif; ?>
						
					
				</li><?php endforeach; endif; else: echo "" ;endif; endif; ?>
	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
	</div>

	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
	</script>
</div>
				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
	<script type="text/javascript">
		try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
	</script>

	<ul class="breadcrumb">
			<li>
				<i class="icon-home home-icon"></i>
				<a href="<?php echo U('Index/index');?>">首页</a>
			</li>
		<?php if(is_array($path)): $i = 0; $__LIST__ = $path;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><li class="active"><span style="display:inline-block;margin:0px 6px 0px 1px;"><?php echo ($item['name']); ?></span> </li><?php endforeach; endif; else: echo "" ;endif; ?>
		
		
	</ul><!-- .breadcrumb -->
</div>
					<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <div class="main-content0">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->
                        <div class="row">
                            <div class="col-xs-12">

                                <div class="table-responsive">                                    
                                    <div class="table-search">
                                        <form class="form-horizontal" role="form" form-id="search-list" action='<?php echo U("Goods/goodsList");?>' method="get">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label no-padding-right search-label">商品名称：</label>
                                                <div class="col-sm-2 seach-input-col">
                                                    <input type="text" name="goods_name" placeholder="支持模糊查询" value="<?php echo ($goods_name); ?>" class="input-sm seach-input">
                                                </div>
                                                
                                                <label class="col-sm-3 control-label no-padding-right search-label">商品分类：</label>
                                                <div class="col-sm-2" style="width: 100px;">
                                                    <select  name="cate_id">
                                                        <option value="0" <?php if($data_status == 0 ): ?>selected="selected"<?php endif; ?>>全部</option>
                                                        <?php if(is_array($cate)): $i = 0; $__LIST__ = $cate;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><option value="<?php echo ($list["id"]); ?>" <?php if($list["id"] == $cate_id ): ?>selected="selected"<?php endif; ?>><?php echo ($list["category_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                                                    </select>
                                                </div>
                                                
                                                <label class="col-sm-3 control-label no-padding-right search-label">商品状态：</label>
                                                <div class="col-sm-2" style="width: 100px;">
                                                    <select  name="data_status">
                                                        <option value="0" <?php if($data_status == 0 ): ?>selected="selected"<?php endif; ?>>全部</option>
                                                        <option value="1" <?php if($data_status == 1 ): ?>selected="selected"<?php endif; ?>>生效中</option>
                                                        <option value="2" <?php if($data_status == 2 ): ?>selected="selected"<?php endif; ?>>已失效</option>
                                                    </select>
                                                </div>

                                                <span class="input-group-btn search-btn">
                                                    <button type="button" class="btn btn-purple btn-sm" id="search-list-btn">
                                                        查询
                                                        <i class="icon-search icon-on-right bigger-110"></i>
                                                    </button>
                                                </span>
                                            </div>
                                            
                                        </form>
                                    </div>
                                    <div class="table-search">
                                        <div class="form-group">
                                            <span class="input-group-btn search-btn">
                                                <button event-name="add-goods" type="button" class="btn btn-sm btn-success">新增商品</button>
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="shelf-up" event-id="checkbox" type="button" class="btn btn-sm btn-success">上架</button>
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="shelf-down" event-id="checkbox" type="button" class="btn btn-sm btn-success">下架</button>
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="del-event"  event-id="checkbox" type="button" class="btn btn-sm btn-default"  url="<?php echo U('Goods/delGoods');?>" msg='' title="批量删除商品">
                                                    删除<i class="icon-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                    <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="center">
                                                    <label>
                                                        <input type="checkbox" class="ace" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </th>
                                                <th class="center">ID</th>
                                                <th class="center">商品名称</th>
                                                <th class="center">商品描述</th>
                                                <th class="center">商品售价/元</th>
                                                <th class="center">商品库存</th>
                                                <th class="center">商品状态</th>
                                                <th class="center">上架商户数量</th>
                                                <th class="center">更新时间</th>
                                                <th class="hidden-480 center">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php if(empty($page["list"])): ?><tr>
		<td colspan="100" style="text-align:center;">暂无数据！</td>
	</tr><?php endif; ?>
                                        <?php if(is_array($page["list"])): $i = 0; $__LIST__ = $page["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
                                                <td colspan="10"><?php echo ($vo["cate_name"]); ?></td>
                                            </tr>
                                            <?php if(is_array($vo["list"])): $i = 0; $__LIST__ = $vo["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><tr>
                                                <td class="center">
                                                    <label>
                                                        <input type="checkbox" name="item_id" item_name="<?php echo ($list["goods_name"]); ?>" status="<?php echo ($list["data_status"]); ?>" value="<?php echo ($list["id"]); ?>" class="ace" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>
                                                
                                                <td><?php echo ($list["id"]); ?></td>
                                                <td><?php echo (_default($list["goods_name"])); ?></td>
                                                <td><?php echo (_default($list["goods_desc"])); ?></td>
                                                <td><?php echo (money_num_format($list["goods_price"])); ?></td>
                                                <td><?php echo ($list["goods_stock"]); ?></td>
                                                <td>
                                                    <?php switch($list["data_status"]): case "1": ?>上架<?php break;?>
                                                        <?php case "2": ?><span class="red">下架</span><?php break; endswitch;?>
                                                </td>
                                                <td><?php echo ($list["up_count"]); ?></td>
                                                <td><?php echo (date('Y-m-d H:i:s',$list["update_time"])); ?></td>
                                                <td>
                                                    <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">    
                                                        <?php switch($list["data_status"]): case "1": ?><a class="green" event-name="shelf-down" status="<?php echo ($list["data_status"]); ?>"  event-id="<?php echo ($list["id"]); ?>" href="javascript:void(0);" title="下架   ">下架</a><?php break;?>
                                                            <?php case "2": ?><a class="green" event-name="shelf-up"   event-id="<?php echo ($list["id"]); ?>" href="javascript:void(0);" title="上架   ">上架</a><?php break; endswitch;?>        
                                                        <a class="green" event-name="edit-goods" event-id="<?php echo ($list["id"]); ?>" status="<?php echo ($list["data_status"]); ?>" info-url="<?php echo U('Goods/getGoodsInfo');?>" href="javascript:void(0);" title="编辑">
                                                            <i class="icon-pencil bigger-130"></i>
                                                        </a>
                                                        <a class="red" event-name="del-event"  event-id="<?php echo ($list["id"]); ?>" status="<?php echo ($list["data_status"]); ?>" url="<?php echo U('Goods/delGoods');?>" msg='' href="javascript:void(0);" title="删除商品">
                                                            <i class="icon-trash bigger-130"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr><?php endforeach; endif; else: echo "" ;endif; endforeach; endif; else: echo "" ;endif; ?>

                                        </tbody>
                                    </table>
                                    <?php if(($page["totalCount"]) > "0"): ?><div class="table-footer">
		<div class="col-sm-6">
			<div class="dataTables_info" id="sample-table-2_info">共 <?php echo ($page["totalCount"]); ?>  条记录 <span class="separate-2"></span><?php echo ($page["numPerPage"]); ?> / <?php echo ($page["all_page"]); ?> 页</div>
		</div>
		<div class="col-sm-6">
			<div class="dataTables_paginate paging_bootstrap page">
				
				<?php echo ($page["pagehtml"]); ?>
				
			</div>
		</div>
	</div><?php endif; ?>








                                </div>
                            </div>
                        </div>

                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div><!-- /.main-content -->

    </div><!-- /.main-container-inner -->

</div><!-- /.main-container -->


<!-- 添加面板 -->
<div dialog-id="add-goods-box" class="hide">

    <form class="form-horizontal" role="form" form-id="add-goods-form" action="<?php echo U('Goods/addGoods');?>" method="post">
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">商品名称：<span class="red">*</span></label>
            <div class="col-sm-9">
                <input type="text" name="goods_name" placeholder="输入商品名称" class="col-xs-10 col-sm-5">
            </div>
        </div>
        <div class="space-4"></div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">商品描述：<span class="red">*</span></label>

            <div class="col-sm-9">
                <textarea class="col-xs-10" rows="3" name="goods_desc"></textarea>
            </div>
        </div>
        <div class="space-4"></div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">商品分类：<span class="red">*</span></label>
            <div class="col-sm-9">
                <select class="col-xs-10 col-sm-5"  name="cate_id">
                    <option value="0">请选择</option>
                    <?php if(is_array($cate)): $i = 0; $__LIST__ = $cate;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><option value="<?php echo ($list["id"]); ?>"><?php echo ($list["category_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                </select>
            </div>
        </div>
        <div class="space-4"></div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">商品售价：<span class="red">*</span></label>
            <div class="col-sm-9">
                <input type="text" name="goods_price" placeholder="输入商品售价" class="col-xs-10 col-sm-5">
            </div>
        </div>
        <div class="space-4"></div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">商品原价：</label>
            <div class="col-sm-9">
                <input type="text" name="original_cost" placeholder="输入商品原价" class="col-xs-10 col-sm-5">
            </div>
        </div>
        <div class="space-4"></div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right"><span class="red">*</span></label>

            <div class="col-sm-9">
                <input type="hidden" name="goods_pic_md5">
                <link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />

<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader1" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker1"></div>
                    <p>或将文件/图片拖到这里</p>
                </div>
            </div>
            <div class="statusBar" style="display:none;">
                <div class="progress">
                    <span class="text">0%</span>
                    <span class="percentage"></span>
                </div><div class="info"></div>
                <div class="btns">
                    <div id="filegoon" class="filegoon hide"></div><div class="uploadBtn">开始上传</div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/jquery.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/upload.js"></script>
            </div>
        </div>
        <div class="space-4"></div>
        
    </form>
</div>

<!-- 下架面板 -->
<div dialog-id="shelf-down-box" class="hide">
    <h3>确定要下架这些商品吗！</h3>
</div>

<!-- 删除面板 -->
<div dialog-id="del-box" class="hide">
    <h3>确定要删除吗？删除后不可恢复！</h3>
    <p id="dialog-msg"></p>
    <form class="form-horizontal" role="form" form-id="del-form" method="post">   
    </form>
</div>

<!-- 上架面板 -->
<div dialog-id="shelf-up-box" class="hide">

    <form class="form-horizontal" role="form" form-id="shelf-up-form" action="<?php echo U('Goods/upGoods');?>" method="post">
        <div class="form-group">
            <label class="col-sm-11  text-left">上架商品：<span id="up-goods-name"></span></label>
        </div>
        <div class="space-4"></div>        
        <div class="form-group">
            <div class="col-sm-12">
                <div class="col-sm-5 hotel_list_box">
                    <h5>上架商户：</h5>
                    <ul class="hotel_list"></ul>
                </div>
                <div class="col-sm-2">
                    <button type="button" class="btn-add btn btn-sm btn-success" style="margin-top: 100px;">
                            添加
                            <i class="icon-arrow-right icon-on-right bigger-110"></i>
                    </button>
                    <button type="button" event-name="open-seach-hotel" class="btn-search btn btn-sm btn-success" style="margin-top: 100px; padding:4px 4px;">
                            商户搜索
                    </button>
                </div>
                <div class="col-sm-5 hotel_list_box">
                    <h5>已选择酒店：</h5>
                    <ul class="select_item"></ul>
                </div>
            </div>
        </div>
        <div class="space-4"></div>
        
    </form>
</div>

<!-- 商家搜索面板 -->
<!-- 搜索商户 -->
<div dialog-id="seach-hotel-box" class="hide">	
        <div class="form-group">
                <div class="seach-item" style="width:78%;margin-top:15px;">
                        <label class="col-sm-3 control-label no-padding-right search-label sea-label" style="height:30px;line-height:30px;width:25%!important;" for="form-field-1">酒店名称：</label>
                        <input type="text"  tag-id="hotel_name" name="hotel_name" placeholder="支持模糊查询" class="input-sm seach-input value" style="width:70%!important;">
                </div>
                <span class="input-group-btn search-btn" style="display:inline-block;">
                        <button  event-name="seach-hotel" url="<?php echo U('Inner/seach');?>" class="btn btn-purple btn-sm">
                                搜索
                                <i class="icon-search icon-on-right bigger-110"></i>
                        </button>
                </span>
        </div>
        <div class="form-group">
                <table class="table table-striped table-bordered table-hover">
                        <thead>
                                <tr class="tr-center">
                                        <th colspan="2">商户名称</th>
                                        <th>商户类型</th>
                                </tr>
                        </thead>

                        <tbody tag-id="shop-result">
                                        <tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>
                        </tbody>
                </table>
        </div>
</div>


				</div><!-- /.main-content -->
				<!-- include setting path  -->
			</div><!-- /.main-container-inner -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->
		<!-- basic scripts -->
		
		<script src="/Public/static/js/jquery-1.10.2.min.js"></script>
		
		<script type="text/javascript">
			if("ontouchend" in document) 
				document.write("<script src='/Public/plugins/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		
		<script src="/Public/plugins/assets/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<!--[if lte IE 8]>
		  <script src="/Public/plugins/assets/js/excanvas.min.js"></script>
		<![endif]-->
		
		
		<script type="text/javascript">
			var static_base 	= '/Public';
			var static_domain 	= '<?php echo C("FASTDFS_URL");?>';
			var getTrad_url		= '<?php echo U("Inner/getTrad");?>';
		</script>
		<script src="/Public/static/js/sea.js"></script>
		<script src="/Public/plugins/assets/js/jquery-ui-1.10.3.full.min.js"></script>
		<script src="/Public/plugins/assets/js/ace.min.js"></script>
		<script src="/Public/plugins/assets/js/bootbox.min.js"></script>
		<script src="/Public/plugins/nice-validator-1.0.7/jquery.validator.min.js?local=zh-CN"></script>
		<script src="/Public/admin/config/main.js"></script>
		
		<script type="text/javascript">
		    var init = [
		    	'static/js/common',
		    	'module/layout'
		    ];
		    
			seajs.use( init ,function(common,layout){
				//初始换
				$.common.initialize({
					city_url: '<?php echo U("Public/getCity");?>',
				});
				
				//系统时间
				layout.getSystemTime();
				
				//当前路由
				var route_name = '<?php echo (CONTROLLER_NAME); ?>';
				
				//加载事件库
				layout.autoLoadEvents();
				
				//自动加载js路由
				layout.autoLoadRoute(route_name);
			});
		</script>
		<div id="route"></div>
</body>
</html>