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
										<form name="" action="<?php echo U('Shop/index');?>" method="get">
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
												<button event-name="addEdit" dialog-title="添加商户" submit-title="添加" type="button" class="btn btn-sm btn-success">
													新增商户
													<i class="icon-plus smaller-75"></i>
												</button>
												<div class="separate-2"><i class="separate-flag"></i></div>
												<button event-name="delete" table-name="list" url="<?php echo U('Shop/deleteShop');?>" message="确认要删选中的 x 条商户信息？|商户绑定的信息将会一同删除！" type="button" class="btn btn-sm btn-default">
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
												<th>商户类型</th>
												<th>商户地址和商圈</th>
												<th>联系人</th>
												<th>联系电话</th>
												<th>广告位数量</th>
												<th>创建时间</th>
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
													
													
	
													<td><?php echo (sprintf("%05d",$list["id"])); ?></td>
													<td><?php echo (_default($list["hotel_name"])); ?></td>
													<td><?php echo (_default(get_fields_to_string("TypeInfo", "type_name", array('id'=>array('in',get_fields_to_array("HotelType", "type_id", array('hotel_id'=>$list["id"]))))))); ?></td>
													<td>
														<?php if(($list["province_id"]) != "0"): echo (get_field("CityInfo","city_name",array('id'=>$list["province_id"]))); endif; ?>
														
														<?php if(($list["city_id"]) != "0"): echo (get_field("CityInfo","city_name",array('id'=>$list["city_id"]))); endif; ?>
														
														<?php if(($list["region_id"]) != "0"): echo (get_field("CityInfo","city_name",array('id'=>$list["region_id"]))); endif; ?>
														
														<?php echo ($list["address"]); ?>
														
														<?php if(empty($list['province_id']) && empty($list['city_id']) && empty($list['region_id']) && empty($list['province_id'])): echo C('FIELD_DEFAULT_VALUE'); endif; ?>
														 
													</td>
													<td><?php echo (_default($list["contacts"])); ?></td>
													<td><?php echo (_default($list["contact_way"])); ?></td>
													<td><?php echo (_default($list["adver_number"])); ?></td>
													<td><?php echo (date("Y-m-d H:i:s",$list["create_time"])); ?></td>
													<td>
														<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
															<a class="blue" event-name="viewInfo" url="<?php echo U('Shop/shopInfo');?>" params="id=<?php echo ($list["id"]); ?>" href="javascript:void(0);" title="查看详情">
																<i class="icon-zoom-in bigger-130"></i>
															</a>
	
															<a class="green" event-name="addEdit" url="<?php echo U('Shop/shopInfo');?>" params="id=<?php echo ($list["id"]); ?>"  dialog-title="编辑商户" submit-title="保存" flag="edit" href="javascript:void(0);" title="编辑">
																<i class="icon-pencil bigger-130"></i>
															</a>
	
															<a class="red" event-name="delete" id-value="<?php echo ($list["id"]); ?>" url="<?php echo U('Shop/deleteShop');?>" message="确认要删除此商户信息？|商户绑定的信息将会一同删除！" href="javascript:void(0);" title="删除">
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
	<form class="form-horizontal" role="form" form-id="addEdit" action="<?php echo U('Shop/addEdit');?>" method="post">
		<input name="id" type="hidden" value="0" />
		<div tag-id="setup-1">
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 商户名称：<span class="must">*</span></label>
		<div class="col-sm-9">
			<input type="text" name="hotel_name" placeholder="输入商户名称" class="col-xs-10 col-sm-8" >
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 商户类型：<span class="must">*</span></label>
		<div class="col-sm-9">
			<div class="shop-type" tag-id="checked-type">
				请选择类型
			</div>
			<button event-name="add-type" url="<?php echo U('Inner/hotelType');?>" type="button" class="btn btn-sm btn-success add-shop-type">
				添加类型
			</button>
			<input type="hidden" name="hotel_type">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 联系人：<span class="red">&nbsp;&nbsp;</span> </label>

		<div class="col-sm-9">
			<input type="text" name="contacts" id="form-field-2" placeholder="输入联系人" class="col-xs-10 col-sm-6">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 联系方式： <span class="red">&nbsp;&nbsp;</span></label>

		<div class="col-sm-9">
			<input type="text" name="contact_way" id="form-field-2" placeholder="输入联系方式" class="col-xs-10 col-sm-6">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 开机语音： <span class="red">&nbsp;&nbsp;</span></label>

		<div class="col-sm-9">
               <input type="hidden" name="voice_md5">
               
               <div tag-id="view" class="hide">
               		<div>
               			<img tag-id="img" style="border:1px solid #CCC;padding:3px;" src="<?php echo default_img();?>" width="130" />
               		</div>
               		<a tag-id="edit-upload" style="display:inline-block;line-height:35px;" href="javascript:void(0);" event-name="edit-upload">编辑图片</a>
               </div>
               
               <div tag-id="upload">
               		<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader2" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker2"></div>
                    <p>或将照片拖到这里</p>
                </div>
            </div>
            <div class="statusBar" style="display:none;">
                <div class="progress">
                    <span class="text">0%</span>
                    <span class="percentage"></span>
                </div><div class="info"></div>
                <div class="btns">
                    <div class="uploadBtn">开始上传</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/jquery.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/upload.js"></script>

               		
               		<a tag-id="cancel-upload" style="display:inline-block;line-height:35px;" class="hide" href="javascript:void(0);" event-name="cancel-upload">取消编辑</a>
               </div>
           </div>
	</div>
	
	<div class="form-group">
           <label class="col-sm-3 control-label no-padding-right"> 商户图片：<span class="red">&nbsp;&nbsp;</span></label>

           <div class="col-sm-9">
               <input type="hidden" name="pic_md5">
               
               <div tag-id="view" class="hide">
               		<div>
               			<img tag-id="img" style="border:1px solid #CCC;padding:3px;" src="<?php echo default_img();?>" width="130" />
               		</div>
               		<a tag-id="edit-upload" style="display:inline-block;line-height:35px;" href="javascript:void(0);" event-name="edit-upload">编辑图片</a>
               </div>
               
               <div tag-id="upload">
               		<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader1" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker1"></div>
                    <p>或将照片拖到这里</p>
                </div>
            </div>
            <div class="statusBar" style="display:none;">
                <div class="progress">
                    <span class="text">0%</span>
                    <span class="percentage"></span>
                </div><div class="info"></div>
                <div class="btns">
                    <div class="uploadBtn">开始上传</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/jquery.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="/Public/plugins/webuploader/image-upload/upload.js"></script>

               		
               		<a tag-id="cancel-upload" style="display:inline-block;line-height:35px;" class="hide" href="javascript:void(0);" event-name="cancel-upload">取消编辑</a>
               </div>
           </div>
       </div>
</div>
		<div tag-id="setup-2" class="hide">
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 商户地址：</label>
		<div class="col-sm-9">
			<span tag-id="city-com">
				<div id="city-component1" tag-id="city_1" url="<?php echo U('Inner/getTrad');?>" class="city-component" default-province="440000" default-city="440300" default-region="440304"></div>
			</span>
			<input type="text" name="address" placeholder="详细地址" class="col-xs-10 col-sm-12 address" >
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 商圈： </label>

		<div class="col-sm-9">
			<select name="trade_id" class="form-control area">
				<option value="0">请选择</option>
				<?php if(is_array($trand)): $i = 0; $__LIST__ = $trand;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$trand_list): $mod = ($i % 2 );++$i;?><option value="<?php echo ($trand_list["id"]); ?>"><?php echo ($trand_list["area_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
			</select>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 广告位和数量：</label>

		<div class="col-sm-9 adv">
			<div>*首页广告位 </div>
			<div style="text-align:right;padding-right:10px;width:10%;">数量</div>
			<div><input type="text" name="adver_number" placeholder="最大数量为 6" class="col-xs-10" style="float:none;width:100%;"></div>
		</div>
	</div>
	
	<div class="widget-box transparent hotel-intef">
		<div class="widget-header widget-header-flat">
			<h4 class="lighter">
				<i class="icon-signal"></i>
				接口信息
			</h4>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 酒店编码： </label>

		<div class="col-sm-9">
			<input type="text" name="customer_code" placeholder="酒店编码系统唯一不能重复；如：30001" class="col-xs-10 col-sm-10">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 集团编码： </label>

		<div class="col-sm-9">
			<input type="text" name="group_code" placeholder="集团编码系统唯一不能重复；如：20001" class="col-xs-10 col-sm-10">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 接口类型：<span class="must"></span></label>
		<div class="col-sm-4">
			<select tag-id="data-sort" name="interface_type" class="form-control">
				<option value="0">请选择</option>
				<?php $_result=get_field_status('HOTEL_INFO','INTERFACE_TYPE');if(is_array($_result)): $i = 0; $__LIST__ = $_result;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><option value="<?php echo ($list["VALUE"]); ?>"><?php echo ($list["NAME"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 接口地址： </label>

		<div class="col-sm-9">
			<input type="text" name="interface_url" placeholder="输入接口地址" class="col-xs-10 col-sm-10">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 接口参数： </label>

		<div class="col-sm-9 floor-info">
			<div tag-id="floor-list">
				<div class="row-td td-tit"><span>参数① </span></div>
				<div class="row-td" style="width:25%;">
					<div class="col-sm-9">
						<input type="text" name="para1" placeholder="如：nick=24K" value="" class="col-xs-10 col-sm-2" >
					</div>
				</div>
				<div class="separate-2"></div>
				<div class="row-td td-tit"><span>参数② </span></div>
				<div class="row-td" style="width:25%;">
					<div class="col-sm-9">
						<input type="text" name="para2" placeholder="如：nick=24K" value="" class="col-xs-10 col-sm-2" >
					</div>
				</div>
				<div class="item-list">
					<ul tag-id="floor-item">
						
					</ul>
				</div>
			</div>
			<div style="height:10px;"></div>
			<div tag-id="floor-list">
				<div class="row-td td-tit"><span>参数③ </span></div>
				<div class="row-td" style="width:25%;">
					<div class="col-sm-9">
						<input type="text" name="para3" placeholder="如：nick=24K" value="" class="col-xs-10 col-sm-2" >
					</div>
				</div>
				<div class="separate-2"></div>
				<div class="row-td td-tit"><span>参数④ </span></div>
				<div class="row-td" style="width:25%;">
					<div class="col-sm-9">
						<input type="text" name="para4" placeholder="如：nick=24K" value="" class="col-xs-10 col-sm-2" >
					</div>
				</div>
				<div class="item-list">
					<ul tag-id="floor-item">
						
					</ul>
				</div>
			</div>
		</div>
	</div>
	
</div>
	</form>
</div>

<!-- 查看面板 -->
<div dialog-id="view" class="hide">
	<div class="base-info">
		<h3>商户信息</h3>
		<div class="info-row">
			<div class="base-left">
				<span class="profile-picture">
					<img id="avatar" tag-id="hotel_img" class="editable img-responsive editable-click editable-empty" style="min-width:125px;" src="/Public/plugins/assets/avatars/profile-pic.jpg"></img>
				</span>
				<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right img-tit">
					<div class="inline position-relative">
						<span class="white">商户ID：<span tag-id="hotel_id">00000</span></span>
					</div>
				</div>
			</div>
			
			<div class="base-right">
				<ul>
					<li>商户名称：<span tag-id="hotel_name">-</span></li>
					<li>商户类型：<span tag-id="hotel_type">-</span></li>
					<li>商户地址：<span tag-id="hotel_address">-</span></li>
					<li>所属商圈：<span tag-id="hotel_trad">-</span></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="author-info">
		<div class="base-info">
			<h3>联系人信息</h3>
			<div class="info-row">
				<div class="base-right">
					<ul>
						<li>联系人：<span tag-id="hotel_contacts">-</span></li>
						<li>联系电话：<span tag-id="hotel_phone">-</span></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="base-info">
			<h3>商家广告位</h3>
			<div class="info-row">
				<div class="base-right">
					<ul class="adv-info">
						<li class="adv-title">
							<span class="adv-name">广告位名称</span>
							<span class="adv-num">广告位数量</span>
						</li>
						<li class="adv-item">
							<span class="adv-name">首页广告位</span>
							<span class="adv-num"><span tag-id="adver_number">0</span>个</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 选择类型 -->
<div dialog-id="type" class="hide">
	<div class="type-select" tag-id="type-items">
		
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