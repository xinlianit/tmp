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
					<a href=""><i class="icon icon-lock"></i>修改密码</a>
				</li>
				<li class="nav-item">
					<a href="<?php echo U('Public/logout');?>"><i class="icon icon-off"></i>退出系统</a>
				</li>
				
				<li class="nav-item">
					<a href="<?php echo U('Index/tpl');?>">【模板插件库-开发使用】</a>
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
					<a href="<?php if(($big_item["type"]) == "3"): echo (get_url_by_node($big_item['id'])); else: ?>javascript:void(0);<?php endif; ?>" class="dropdown-toggle">
						<i class="<?php echo ($big_item['icon_name']); ?>"></i>
						<span class="menu-text"> <?php echo ($big_item['title']); ?></span>
						<?php if(!empty($big_item["list"])): ?><b class="arrow icon-angle-down"></b>
							</a>
						    <ul class="submenu" <?php if(in_array($big_item['id'],$path_id)): ?>style="display: block;"<?php endif; ?>>
							    <?php if(is_array($big_item["list"])): $i = 0; $__LIST__ = $big_item["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$small_item): $mod = ($i % 2 );++$i;?><li <?php if(in_array($small_item['id'],$path_id)): ?>class="open"<?php endif; ?>>
										<a href="<?php if(($small_item["type"]) == "3"): echo (get_url_by_node($small_item['id'])); else: ?>javascript:void(0);<?php endif; ?>" class="dropdown-toggle">
											<i class="<?php echo ($small_item['icon_name']); ?>"></i>
											<?php echo ($small_item['title']); ?>
										<?php if(!empty($small_item["list"])): ?><b class="arrow icon-angle-down"></b>
											</a>
											<ul class="submenu" <?php if(in_array($small_item['id'],$path_id)): ?>style="display: block;"<?php endif; ?>>
												<?php if(is_array($small_item["list"])): $i = 0; $__LIST__ = $small_item["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><li <?php if(in_array($item['id'],$path_id)): ?>class="active"<?php endif; ?>>
														<a href="<?php echo (get_url_by_node($item['id'])); ?>">
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
										<form name="" action="<?php echo U('Shop/floor');?>" method="get">
											<div class="form-group">
												<div class="seach-item">
													<label class="col-sm-3 control-label no-padding-right search-label sea-label" for="form-field-1">商户名称：</label>
													<input type="text" name="hotel_name" value="<?php echo I('get.hotel_name');?>" placeholder="支持模糊查询" class="input-sm seach-input value">
												</div>
												<span class="input-group-btn search-btn">
													<button type="submit" class="btn btn-purple btn-sm">
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
												<button event-name="addEditFloor" dialog-title="楼层信息新增" submit-title="添加" type="button" class="btn btn-sm btn-success">
													新增楼层信息
													<i class="icon-plus smaller-75"></i>
												</button>
												<div class="separate-2"><i class="separate-flag"></i></div>
												<button event-name="delete" table-name="list" url="<?php echo U('Shop/deleteFloor');?>" message="确认要删选中的  x 条楼层信息？|删除后信息不可恢复！" type="button" class="btn btn-sm btn-default">
													批量删除
													<i class="icon-remove"></i>
												</button>
											</span>
										</div>
									</div>
									<table table-id="list" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th class="center">
													<label>
														<input type="checkbox" class="ace" />
														<span class="lbl"></span>
													</label>
												</th>
												
												<th>商户ID</th>
												<th>商户名称</th>
												<th>楼层名称</th>
												<th>总楼层数</th>
												<th>总房间数</th>
												<th class="hidden-480">操作</th>
											</tr>
										</thead>

										<tbody>
										
											<?php if(empty($page["list"])): ?><tr>
		<td colspan="100" style="text-align:center;">暂无数据！</td>
	</tr><?php endif; ?>
											<?php if(is_array($page["list"])): $i = 0; $__LIST__ = $page["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><tr>
													<td class="center">
														<label>
															<input tag-name="ids" type="checkbox" value="<?php echo ($list["id"]); ?>" class="ace" />
															<span class="lbl"></span>
														</label>
													</td>
													
													<td><?php echo (sprintf("%05d",$list["id"])); ?></td>
													<td><?php echo (_default($list["hotel_name"])); ?></td>
													<td><?php echo (_default(get_fields_to_string("FloorInfo", "floor_name", array('hotel_id'=>$list["id"], 'data_status'=>array('neq',99))))); ?></td>
													<td><?php echo (_default(count(get_fields_to_array("FloorInfo", "id", array('hotel_id'=>$list["id"], 'data_status'=>array('neq',99)))))); ?></td>
													<td><?php echo (_default(array_sum(get_fields_to_array("FloorInfo", "room_number", array('hotel_id'=>$list["id"], 'data_status'=>array('neq',99)))))); ?></td>
													<td>
														<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
															<a class="blue" event-name="viewFloor" url="<?php echo U('Shop/floorInfo');?>" params="id=<?php echo ($list["id"]); ?>" href="javascript:void(0);" title="查看详情">
																<i class="icon-zoom-in bigger-130"></i>
															</a>
	
															<a class="green" event-name="addEditFloor" url="<?php echo U('Shop/floorInfo');?>" params="id=<?php echo ($list["id"]); ?>"  dialog-title="楼层信息编辑" submit-title="保存" flag="edit" href="javascript:void(0);" title="编辑">
																<i class="icon-pencil bigger-130"></i>
															</a>
	
															<a class="red" event-name="delete" id-value="<?php echo ($list["id"]); ?>" url="<?php echo U('Shop/deleteFloor');?>" message="确认要删除此楼层信息？|删除后信息不可恢复！" href="javascript:void(0);" title="删除">
																<i class="icon-trash bigger-130"></i>
															</a>
														</div>
													</td>
												</tr><?php endforeach; endif; else: echo "" ;endif; ?>
											
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


<!-- 添加编辑 -->
<div dialog-id="addEdit" class="hide">
	<form class="form-horizontal" role="form" form-id="addEdit" action="<?php echo U('Shop/addEditFloor');?>" method="post">
		<input name="id" type="hidden" value="0" />
		<div tag-id="setup-1">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 商户名称：<span class="must">*</span></label>
				<div class="col-sm-9">
					<input name="hotel_id" type="hidden" value="0" />
					<input type="text" name="hotel_name" disabled="disabled" placeholder="商户名称" class="col-xs-10 col-sm-9" >
					<a href="javascript:void(0);" event-name="openSeach"><i class="icon-search hotet-sea-btn"></i></a>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 楼层信息：<span class="must">*</span></label>
				<div class="col-sm-9 floor-info">
					<div tag-id="floor-list">
						<div class="row-td td-tit"><span>楼层名称</span></div>
						<div class="row-td">
							<div class="col-sm-9">
								<input type="text" name="floor_name[]" placeholder="输入楼层名称" value="" class="col-xs-10 col-sm-3" >
							</div>
						</div>
						<div class="row-td td-tit"><span>房间数量 </span></div>
						<div class="row-td" style="width:15%;">
							<div class="col-sm-9">
								<input type="text" name="room_number[]" placeholder="输入数量" value="" class="col-xs-10 col-sm-2" >
							</div>
						</div>
						<div class="row-td td-last"><span>间 </span></div>
						<div class="item-list">
							<ul tag-id="floor-item">
								
							</ul>
						</div>
					</div>
					<a event-name="addFloorItem" href="javascript:void(0);" class="add-floor-btn">
						<i class="icon-plus-sign"></i> 添加楼层
					</a>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 搜索商户 -->
<div dialog-id="seachShop" class="hide">
	<div tag-id="setup-1">
		<div class="form-group">
			<div class="seach-item" style="width:78%;margin-top:15px;">
				<label class="col-sm-3 control-label no-padding-right search-label sea-label" style="height:30px;line-height:30px;width:25%!important;" for="form-field-1">商户名称：</label>
				<input type="text" tag-id="hotel_name" name="hotel_name" placeholder="支持模糊查询" class="input-sm seach-input value" style="width:70%!important;">
			</div>
			<span class="input-group-btn search-btn" style="display:inline-block;">
				<button event-name="seachShop" url="<?php echo U('Shop/seach');?>" class="btn btn-purple btn-sm">
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
</div>

<!-- 查看面板 -->
<div dialog-id="viewFloor" tag-id="floor-view" class="hide">
	<div tag-id="setup-1">
		<div class="form-group floor-view">
			<div class="head-left">
				<span>商户名称：<span tag-id="hotel-name">-</span></span>
			</div>
			<div class="head-right">
				<span>商户ID：<span tag-id="hotel-code">0</span></span>
			</div>
		</div>
		<div class="form-group" style="padding-top:30px;">
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr class="tr-center">
						<th>楼层名称</th>
						<th>房间数</th>
					</tr>
				</thead>

				<tbody tag-id="view-list">
						<tr>
							<td colspan="2" style="text-align:center;">暂无楼层信息！</td>
						</tr>
				</tbody>
			</table>
		</div>
		<div class="form-group floor-view">
			<div class="head-right">
				<span>总计：<span tag-id="room-number">0</span> 间</span>
			</div>
		</div>
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