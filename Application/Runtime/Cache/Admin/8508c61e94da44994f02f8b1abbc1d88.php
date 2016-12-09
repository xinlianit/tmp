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
	<form name="" action="" method="get">
		<input name="p" type="hidden" value="1" />
		<div class="form-group">
			
			
			<?php if(!empty(C('SETCH_ITEM.ADMIN'))): if(!empty(C('SETCH_ITEM.ADMIN')[$seach])): $_result=C('SETCH_ITEM.ADMIN')[$seach];if(is_array($_result)): $i = 0; $__LIST__ = $_result;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$seach_item): $mod = ($i % 2 );++$i; switch($seach_item["type"]): case "input": ?><div class="seach-item">
									<label class="col-sm-3 control-label no-padding-right search-label sea-label" style="<?php echo ($seach_item["label_css"]); ?>"><?php echo ($seach_item["label"]); ?>：</label>
									<input type="text" name="<?php echo ($seach_item["name"]); ?>" value="<?php echo ($$seach_item["name"]); ?>" placeholder="<?php echo ($seach_item["placeholder"]); ?>" class="input-sm seach-input value">
								</div><?php break;?>
							
							<?php case "select": ?><div class="seach-item">
									<label class="col-sm-3 control-label no-padding-right search-label sea-label" style="<?php echo ($seach_item["label_css"]); ?>"><?php echo ($seach_item["label"]); ?>：</label>
									<select name="<?php echo ($seach_item["name"]); ?>" class="form-control value">
										<option value="<?php echo ($seach_item["defalut"]["value"]); ?>"><?php echo ($seach_item["defalut"]["title"]); ?></option>
										<?php $_result=call_user_func($seach_item['options'], $seach_item['params'][0], $seach_item['params'][1], $seach_item['params'][2]);if(is_array($_result)): $i = 0; $__LIST__ = $_result;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$options): $mod = ($i % 2 );++$i;?><option <?php if($options[$seach_item['item']['value']] == $$seach_item['name']): ?>selected="selected"<?php endif; ?> value="<?php echo ($options[$seach_item['item']['value']]); ?>"><?php echo ($options[$seach_item['item']['title']]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
									</select>
								</div><?php break; endswitch; endforeach; endif; else: echo "" ;endif; endif; endif; ?>
			
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
												<button event-name="addEditGroup" dialog-title="组别新增" submit-title="添加" type="button" class="btn btn-sm btn-success">
													新增组别
													<i class="icon-plus smaller-75"></i>
												</button>
												<div class="separate-2"><i class="separate-flag"></i></div>
												<button event-name="delete" table-name="list" url="<?php echo U('Node/deleteGroup');?>" message="确认要删选中的 x 条分组？|删除后信息不可恢复！" type="button" class="btn btn-sm btn-default">
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
												
												<th>ID</th>
												<th>组别名称</th>
												<th>成员</th>
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
															<input type="checkbox" tag-name="ids" value="<?php echo ($list["id"]); ?>" class="ace" />
															<span class="lbl"></span>
														</label>
													</td>
													
													
	
													<td><?php echo (sprintf("%02d",$list["id"])); ?></td>
													<td><?php echo (_default($list["title"])); ?></td>
													<td><?php echo (_default(get_fields_to_string("AdminInfo", "admin_account", array('id'=>array('in',get_fields_to_array("AuthGroupAccess", "uid", array('group_id'=>$list["id"]))), 'data_status'=>array('neq',99))))); ?></td>
													<td>
														<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
															<a class="blue" event-name="viewGroupInfo" url="<?php echo U('Node/groupInfo');?>" params="id=<?php echo ($list["id"]); ?>" dialog-title="查看权限" flag="view" href="javascript:void(0);" title="查看详情">
																<i class="icon-zoom-in bigger-130"></i>
															</a>
	
															<a class="green" event-name="addEditGroup" url="<?php echo U('Node/groupInfo');?>" params="id=<?php echo ($list["id"]); ?>" dialog-title="编辑权限" submit-title="保存" flag="edit" href="javascript:void(0);" title="编辑">
																<i class="icon-pencil bigger-130"></i>
															</a>
	
															<a class="red" event-name="delete" id-value="<?php echo ($list["id"]); ?>" url="<?php echo U('Node/deleteGroup');?>" message="确认要删除此分组？|删除后信息不可恢复！" href="javascript:void(0);" title="删除">
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
	<form class="form-horizontal" role="form" form-id="addEdit" action="<?php echo U('Node/addEditGroup');?>" method="post">
		<input name="id" type="hidden" value="0" />
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 组别名称：<span class="must">*</span></label>
				<div class="col-sm-9">
					<input type="text" name="title" placeholder="输入组别名称；如：广告管理员" class="col-xs-10 col-sm-7">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 管理模块：<span class="must">*</span></label>
				<div class="col-sm-9">
					<div tag-id="rules-item" class="group-access">
						<?php if(is_array($rule)): $i = 0; $__LIST__ = $rule;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$controller_list): $mod = ($i % 2 );++$i;?><dl tag-id="item" class="access-item <?php if($controller_list['name'] == 'Admin/Index'): ?>hide<?php endif; ?>">
								<dt>
									<label>
										<input event-name="checked-child" type="checkbox" name="rules[]" tag-name="ids" <?php if($controller_list['name'] == 'Admin/Index'): ?>checked="checked" flag="auto"<?php endif; ?> value="<?php echo ($controller_list["id"]); ?>" class="ace">
										<span class="lbl"> <?php echo ($controller_list["title"]); ?></span>
									</label>
								</dt>
								<?php if(is_array($controller_list["list"])): $i = 0; $__LIST__ = $controller_list["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$action_list): $mod = ($i % 2 );++$i;?><dd>
										<label>
											<input name="rules[]" <?php if(in_array($action_list['name'], array('Admin/Index/index','Admin/Index/resetPwd'))): ?>checked="checked" flag="auto"<?php endif; ?> type="checkbox" tag-name="ids" value="<?php echo ($action_list["id"]); ?>" class="ace">
											<span class="lbl"> <?php echo ($action_list["title"]); ?></span>
										</label>
									</dd><?php endforeach; endif; else: echo "" ;endif; ?>
							</dl>
							<div style="height:10px;clear:both;"></div><?php endforeach; endif; else: echo "" ;endif; ?>
					</div>
				</div>
			</div>
			
			
			
	</form>
</div>

<!-- 查看面板 -->
<div dialog-id="view" class="hide">
	<form class="form-horizontal" role="form" form-id="view" method="post">
		<input name="id" type="hidden" value="0" />
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 组别名称：<span class="must">*</span></label>
				<div class="col-sm-9">
					<input type="text" name="title" disabled="disabled" placeholder="输入组别名称；如：广告管理员" class="col-xs-10 col-sm-7">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1"> 管理模块：<span class="must">*</span></label>
				<div class="col-sm-9">
					<div tag-id="rules-item" class="group-access">
						<?php if(is_array($rule)): $i = 0; $__LIST__ = $rule;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$controller_list): $mod = ($i % 2 );++$i;?><dl tag-id="item" class="access-item <?php if($controller_list['name'] == 'Admin/Index'): ?>hide<?php endif; ?>">
								<dt>
									<label>
										<input event-name="checked-child" disabled="disabled" type="checkbox" name="rules[]" tag-name="ids" <?php if($controller_list['name'] == 'Admin/Index'): ?>checked="checked"<?php endif; ?> value="<?php echo ($controller_list["id"]); ?>" class="ace">
										<span class="lbl"> <?php echo ($controller_list["title"]); ?></span>
									</label>
								</dt>
								<?php if(is_array($controller_list["list"])): $i = 0; $__LIST__ = $controller_list["list"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$action_list): $mod = ($i % 2 );++$i;?><dd>
										<label>
											<input name="rules[]" disabled="disabled" <?php if($action_list['name'] == 'Admin/Index/index'): ?>checked="checked"<?php endif; ?> type="checkbox" tag-name="ids" value="<?php echo ($action_list["id"]); ?>" class="ace">
											<span class="lbl"> <?php echo ($action_list["title"]); ?></span>
										</label>
									</dd><?php endforeach; endif; else: echo "" ;endif; ?>
							</dl>
							<div style="height:10px;clear:both;"></div><?php endforeach; endif; else: echo "" ;endif; ?>
					</div>
				</div>
			</div>
			
			
			
	</form>
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