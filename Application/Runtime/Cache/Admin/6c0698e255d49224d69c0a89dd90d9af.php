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
                                        <form class="form-horizontal" role="form" form-id="search-list" action='<?php echo U("Adv/advList");?>' method="get">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label no-padding-right search-label">状态：</label>
                                                <div class="col-sm-2" style="width: 100px;">
                                                    <select  name="data_status">
                                                        <option value="0" <?php if($data_status == 0 ): ?>selected="selected"<?php endif; ?>>全部</option>
                                                        <option value="1" <?php if($data_status == 1 ): ?>selected="selected"<?php endif; ?>>生效中</option>
                                                        <option value="2" <?php if($data_status == 2 ): ?>selected="selected"<?php endif; ?>>已失效</option>
                                                    </select>
                                                </div>

                                                <label class="col-sm-3 control-label no-padding-right search-label">生效时间：</label>
                                                <div class="col-sm-2" style="width: 150px;">                                                
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="icon-calendar bigger-110"></i></span> 
                                                        <input class="form-control date-picker" name="begin_time"  value="<?php echo ($begin_time); ?>" type="text">
                                                    </div>
                                                </div>                                            
                                                <label class="col-sm-3 control-label no-padding-right search-label">至</label>
                                                <div class="col-sm-2" style="width: 150px;">                                                
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="icon-calendar bigger-110"></i></span> 
                                                        <input class="form-control date-picker" name="end_time"  value="<?php echo ($end_time); ?>" type="text">
                                                    </div>
                                                </div>

                                                <label class="col-sm-3 control-label no-padding-right search-label">来源：</label>
                                                <div class="col-sm-2" style="width: 100px;">
                                                    <select  name="hotel_id">
                                                        <option value="all" <?php if($hotel_id == 'all' ): ?>selected="selected"<?php endif; ?>>全部</option>
                                                        <option value="0" <?php if($hotel_id == '0' ): ?>selected="selected"<?php endif; ?>>平台</option>
                                                        <option value="hotel_id" <?php if($hotel_id == 'hotel_id' ): ?>selected="selected"<?php endif; ?>>商户</option>
                                                    </select>
                                                </div>

                                                <label class="col-sm-3 control-label no-padding-right search-label">广告名称：</label>
                                                <div class="col-sm-2 seach-input-col">
                                                    <input type="text" name="advert_name" placeholder="广告名称" value="<?php echo ($advert_name); ?>" class="input-sm seach-input">
                                                </div>
                                                <div class="col-sm-2" style='width:90px; line-height: 32px;'>
                                                    <span class="lbl"></span> <a style="cursor: pointer" id="show_more_search" class="<?php if($hotel_name == '' and $adver_name == '' ): ?>icon-plus-sign<?php else: ?>icon-minus-sign<?php endif; ?>" herf='javascript:void(0)'></a>更多条件
                                                </div>

                                                <span class="input-group-btn search-btn">
                                                    <button type="button" class="btn btn-purple btn-sm" id="search-list-btn">
                                                        查询
                                                        <i class="icon-search icon-on-right bigger-110"></i>
                                                    </button>
                                                </span>
                                            </div>
                                            <div class="form-group <?php if($hotel_name == '' and $adver_name == '' ): ?>hide<?php endif; ?>">
                                                <label class="col-sm-3 control-label no-padding-right search-label">展示商户名称：</label>
                                                <div class="col-sm-2 seach-input-col">
                                                    <input type="text"  name="hotel_name" placeholder="展示商户名称" value="<?php echo ($hotel_name); ?>" class="input-sm seach-input">
                                                </div>
                                                
                                                <label class="col-sm-3 control-label no-padding-right search-label">广告主名称：</label>
                                                <div class="col-sm-2 seach-input-col">
                                                    <input type="text" name="adver_name" placeholder="广告主名称" value="<?php echo ($adver_name); ?>" class="input-sm seach-input">
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="table-search">
                                        <div class="form-group">
                                            <span class="input-group-btn search-btn">
                                                <button event-name="add-adv" type="button" class="btn btn-sm btn-success">新增<i class="icon-plus smaller-75"></i></button>
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="publish-advs" url='<?php echo U("Adv/publishAdvert");?>' type="button" class="btn btn-sm btn-default">发布</button>   
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="stops-adv" type="button" class="btn btn-sm btn-default" event-title='下架广告'>停止</button>     
                                                <div class="separate-2"><i class="separate-flag"></i></div>
                                                <button event-name="dels-adv" type="button" class="btn btn-sm btn-default">删除<i class="icon-remove"></i></button>
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
                                                <th>广告ID</th>
                                                <th>广告名称</th>
                                                <th>广告状态</th>
                                                <th>广告来源</th>
                                                <th>广告主名称</th>
                                                <th>广告类别</th>
                                                <th>展示商户数量</th>
                                                <th>累计曝光数</th>
                                                <th>投放时间</th>
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
                                                        <input type="checkbox" name="item_id" value="<?php echo ($list["id"]); ?>" publish_num="<?php echo ($list["hotel_num"]); ?>" item_name ="<?php echo ($list["advert_name"]); ?>" class="ace" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>
                                                <td><?php echo ($list["id"]); ?></td>
                                                <td><?php echo ($list["advert_name"]); ?></td>
                                                <td>
                                                    <?php switch($list["data_status"]): case "1": ?>生效中<?php break;?>
                                                        <?php case "2": ?>已失效<?php break; endswitch;?>
                                                </td>
                                                <td>
                                                    <?php switch($list["hotel_id"]): case "0": ?>平台发布<?php break;?>
                                                        <?php default: ?>酒店发布<?php endswitch;?>
                                                </td>
                                                <td><?php echo (_default($list["adver_name"])); ?></td>
                                                <td>首页广告/
                                                <?php switch($list["material_type"]): case "1": ?>图片<?php break;?>
                                                        <?php case "2": ?>视频<?php break; endswitch;?>
                                                </td>
                                                <td><a href="<?php echo U('Adv/publishList',array('id'=>$list['id']));?>"><?php echo ($list["hotel_num"]); ?></a></td>
                                                <td><?php echo ($list["exposure_num"]); ?></td>
                                                <td><?php echo ($list["release_time"]); ?></td>
                                                <td>
                                                    <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                                        <a class="green" event-name="publish-adv" url="<?php echo U('Adv/getAdvertInfoWithPublish');?>"  event-id="<?php echo ($list["id"]); ?>" href="javascript:void(0);" title="发布">发布</a>
                                                        <a class="blue" event-name="info-adv"  url="<?php echo U('Adv/advertInfo',array('id'=>$list['id']));?>" href="javascript:void(0);" title="查看详情"><i class="icon-zoom-in bigger-130"></i></a>
                                                        <a class="green" event-name="edit-adv" url="<?php echo U('Adv/getAdvertInfo');?>" event-id="<?php echo ($list["id"]); ?>" status='<?php echo ($list["data_status"]); ?>' href="javascript:void(0);" title="编辑"><i class="icon-pencil bigger-130"></i></a>
                                                        <a class="red" event-name="del-adv"  event-id="<?php echo ($list["id"]); ?>"  status='<?php echo ($list["data_status"]); ?>' href="javascript:void(0);"  title="删除"><i class="icon-trash bigger-130"></i></a>
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

<!-- 添加面板 -->
<div dialog-id="add-adv-box" class="hide">
    <form class="form-horizontal" role="form" form-id="add-adv-form" action="<?php echo U('Adv/addAdvert');?>" method="post">
        <div tag-id="setup-1">
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >广告名称：<span class="must">*</span></label>
                <div class="col-sm-9">
                    <input type="text" name="advert_name" placeholder="输入广告名称" class="col-xs-10 col-sm-7">
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right"> 广告主选择：<span class="must">*</span></label>
                <div class="col-sm-9">
                        <input name="adver_id" type="hidden" value="0" />
                        <input type="text" name="adver_name" disabled="disabled" placeholder="广告主名称" class="col-xs-10 col-sm-9" >
                        <a href="javascript:void(0);" event-name="open-seach-adver"><i class="icon-search hotet-sea-btn"></i></a>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right"> 广告类别： </label>
                <div class="col-sm-9">
                    <select class="col-xs-10 col-sm-5"  name="advert_position">
                        <option value="1">首页广告</option>
                    </select>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >广告排列号：</label>
                <div class="col-sm-9">
                    <select class="col-xs-10 col-sm-3"  name="weight">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3" selected = "selected" >3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                    <p class="text-muted">&nbsp;&nbsp;数字0-8，数字越小广告位置越靠前</p>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >投放时间：<span class="must">*</span></label>
                <div class="col-sm-9">
                    <div class="input-group">
                            <span class="input-group-addon">
                                    <i class="icon-calendar bigger-110"></i>
                            </span> 
                        <input class="form-control" type="text" name="date-range-picker" id="id-date-range-picker-1" value="" />
                    </div>
                </div>
            </div>
            <div class="space-4"></div>
        </div>
        <div tag-id="setup-2">
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >素材类型：</label>
                <div class="col-sm-9">
                    <label class="radio-inline">
                        <input type="radio" name="material_type" checked="checked" value="1"> 图片
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="material_type"  value="2"> 视频
                    </label>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group material_type">
                <div  material_type="1" >
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >广告图：</label>
                        <div class="col-sm-9">
                            <input type="hidden" name="advpic_md5">
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

                        </div>
                    </div>                    
                </div>
                <div  material_type="2" class="hide">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >广告视频：</label>
                        <div class="col-sm-9">
                            <input type="hidden" name="advvideo_md5">
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

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >缩略图：</label>
                        <div class="col-sm-9">                            
                            <input type="hidden" name="advvideopic_md5">
                            <link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader3" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker3"></div>
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

                        </div>
                    </div>
                </div>
            </div>
            
            
        </div>
        
        
    </form>
</div>
<link rel="stylesheet" href="/Public/plugins/assets/css/chosen.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/datepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/bootstrap-timepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/daterangepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/colorpicker.css" />

<script type="text/javascript">
        window.jQuery || document.write("<script src='/Public/plugins/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>

<script src="/Public/plugins/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="/Public/plugins/assets/js/date-time/moment.min.js"></script>

<script src="/Public/plugins/assets/js/date-time/daterangepicker.min.js"></script>
<script type="text/javascript">
jQuery(function($) {           
        $('input[name=date-range-picker]').daterangepicker({autoclose:true}).prev().on(ace.click_event, function(){
                $(this).next().focus();
        });

        $('input[name=date-range-picker]').on('click',function(){
            $('.daterangepicker').css('zIndex','1100');
        });

});
</script>

<!-- 编辑面板 -->
<div dialog-id="edit-adv-box" class="hide">
    <form class="form-horizontal" role="form" form-id="edit-adv-form" action="<?php echo U('Adv/editAdvert');?>" method="post">
        <div tag-id="setup-1">
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >广告名称：</label>
                <div class="col-sm-9">
                    <input type="text" name="advert_name" class="col-xs-10 col-sm-7">
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right"> 广告主选择：<span class="must">*</span></label>
                <div class="col-sm-9">
                        <input name="adver_id" type="hidden" value="0" />
                        <input type="text" name="adver_name" disabled="disabled" placeholder="广告主名称" class="col-xs-10 col-sm-9" >
                        <a href="javascript:void(0);" event-name="open-seach-adver"><i class="icon-search hotet-sea-btn"></i></a>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right"> 广告类别： </label>
                <div class="col-sm-9">
                    <select class="col-xs-10 col-sm-5"  name="advert_position">
                        <option value="1">首页广告</option>
                    </select>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >广告排列号：</label>
                <div class="col-sm-9">
                    <select class="col-xs-10 col-sm-3"  name="weight">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                    <p class="text-muted">&nbsp;&nbsp;数字0-8，数字越小广告位置越靠前</p>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >投放时间：</label>
                <div class="col-sm-9">
                    <div class="input-group">
                            <span class="input-group-addon">
                                    <i class="icon-calendar bigger-110"></i>
                            </span> 
                        <input class="form-control" type="text" name="date-range-picker" id="id-date-range-picker-1" value="" />
                    </div>
                </div>
            </div>
            <div class="space-4"></div>
        </div>
        <div tag-id="setup-2">
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" >素材类型：</label>
                <div class="col-sm-9">
                    <label class="radio-inline">
                        <input type="radio" name="material_type" checked="checked" value="1"> 图片
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="material_type"  value="2"> 视频
                    </label>
                </div>
            </div>
            <div class="space-4"></div>
            
            <div class="form-group material_type">
                <div  material_type="1" >
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-4">已有广告图：</label>
                        <div class="col-sm-9">
                            <img id="has_img_advpic" src="" style="height: 40px">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >广告图：</label>
                        <div class="col-sm-9">
                            <input type="hidden" name="advpic_md5">
                            <link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader4" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker4"></div>
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

                        </div>
                    </div>                    
                </div>
                <div  material_type="2" class="hide">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-4">已有视频：</label>
                        <div class="col-sm-9">
                            <script src="/Public/static/js/html5media.min.js"></script>
                            <video id="has_img_advvideo" src="" width="352" height="264" controls autobuffer></video>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >广告视频：</label>
                        <div class="col-sm-9">
                            <input type="hidden" name="advvideo_md5">
                            <link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader5" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker5"></div>
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

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-4">已有缩略图：</label>
                        <div class="col-sm-9">
                            <img id="has_img_advvideopic" src="" style="height: 40px">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" >缩略图：</label>
                        <div class="col-sm-9">                            
                            <input type="hidden" name="advvideopic_md5">
                            <link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="/Public/plugins/webuploader/image-upload/style.css" />
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->

        <div id="uploader6" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker6"></div>
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

                        </div>
                    </div>
                </div>
            </div>
            
            
        </div>
        
        <input type="hidden" name="id" >
    </form>
</div>
<link rel="stylesheet" href="/Public/plugins/assets/css/chosen.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/datepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/bootstrap-timepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/daterangepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/colorpicker.css" />

<script type="text/javascript">
        window.jQuery || document.write("<script src='/Public/plugins/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>

<script src="/Public/plugins/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="/Public/plugins/assets/js/date-time/moment.min.js"></script>

<script src="/Public/plugins/assets/js/date-time/daterangepicker.min.js"></script>
<script type="text/javascript">
jQuery(function($) {           
        $('input[name=date-range-picker]').daterangepicker({autoclose:true}).prev().on(ace.click_event, function(){
                $(this).next().focus();
        });

        $('input[name=date-range-picker]').on('click',function(){
            $('.daterangepicker').css('zIndex','1100');
        });

});
</script>

<!-- 删除面板 -->
<div dialog-id="del-adv-box" class="hide">
    <h3>确定要删除吗？</h3>
    <p>删除后不可恢复！</p>
    <form class="form-horizontal" role="form" form-id="del-adv-form" action="<?php echo U('Adv/delAdvert');?>" method="post">

        <input type="hidden" name="id" >

        
    </form>
</div>

<!-- 删除面板多个 -->
<div dialog-id="dels-adv-box" class="hide">
    <h3>确定要批量删除吗？</h3>
    <p>删除后不可恢复！</p>
    <form class="form-horizontal" role="form" form-id="dels-adv-form" action="<?php echo U('Adv/delAdvert');?>" method="post">

        <input type="hidden" name="id" >

        
    </form>
</div>

<!-- 搜索面板 -->
<!-- 搜索商户 -->
<div dialog-id="seach-adver-box" class="hide">
	<div tag-id="setup-1">
		<div class="form-group">
			<div class="seach-item" style="width:78%;margin-top:15px;">
				<label class="col-sm-3 control-label no-padding-right search-label sea-label" style="height:30px;line-height:30px;width:25%!important;" for="form-field-1">广告主名称：</label>
				<input type="text" tag-id="adver_name" name="adver_name" placeholder="支持模糊查询" class="input-sm seach-input value" style="width:70%!important;">
			</div>
			<span class="input-group-btn search-btn" style="display:inline-block;">
				<button event-name="seach-adver" url="<?php echo U('Adv/seachAdver');?>" class="btn btn-purple btn-sm">
					搜索
					<i class="icon-search icon-on-right bigger-110"></i>
				</button>
			</span>
		</div>
		<div class="form-group">
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr class="tr-center">
						<th colspan="2">名称</th>
						<th>行业一描述</th>
					</tr>
				</thead>

				<tbody tag-id="adver-result">
						<tr><td colspan="3" style="text-align:center;">暂无搜索结果！</td></tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- 搜索面板 -->
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

<!-- 发布面板 -->
<div dialog-id="publish-adv-box" class="hide">
    <form class="form-horizontal" role="form" form-id="publish-adv-form" action="<?php echo U('Adv/publishAdvert');?>" method="post">
        <div class="form-group">
            <p>已选择广告： <i id="check_advname">sdf</i></p>
        </div>
        <div class="form-group">
            <span class="input-group-btn search-btn">
                <button event-name="open-seach-hotel" type="button" class="btn btn-sm btn-success"><i class="icon-plus smaller-75"></i>新增发布酒店</button>
        </div>
        <div class="form-group">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>                                           
                                            <th>酒店</th>
                                            <th>投放开始时间</th>
                                            <th>投放结束时间</th>
                                            <th class="hidden-480">操作</th>
                                        </tr>
                                    </thead>

                                    <tbody id="hotel_data">                                    
                                       
                                    </tbody>
                                </table>
        </div>
        <input name='id' type='hidden'>
    </form>
</div>    



<!-- 停止面板 -->
<div dialog-id="stops-adv-box" class="hide">
    <h3>确定要停止此广告吗？</h3>
    <form class="form-horizontal" role="form" form-id="stops-adv-form" action="<?php echo U('Adv/stopAdvert');?>" method="post">

        <input type="hidden" name="id" >

        
    </form>
</div>
<!-- 日历控件 -->
<link rel="stylesheet" href="/Public/plugins/assets/css/chosen.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/datepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/bootstrap-timepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/daterangepicker.css" />
<link rel="stylesheet" href="/Public/plugins/assets/css/colorpicker.css" />

<script type="text/javascript">
        window.jQuery || document.write("<script src='/Public/plugins/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>

<script src="/Public/plugins/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="/Public/plugins/assets/js/date-time/moment.min.js"></script>

<script src="/Public/plugins/assets/js/date-time/daterangepicker.min.js"></script>

<script type="text/javascript">
    
jQuery(function($) {                
        $("body").on('click','input.date-picker',function(){
            var _this_picker = $(this);
            _this_picker.datepicker({autoclose:true,showOn:'focus'}).focus();              
        });
});
</script>


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