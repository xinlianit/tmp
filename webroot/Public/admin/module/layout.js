/**
 * 后台布局
 */
define(function(require, exports, module){
	return {
		
		/**
		 * 获取系统时间
		 * */
		getSystemTime: function(){
			setInterval(function(){
				document.getElementById('now-datetime').innerHTML = $.common.getNowDateTime('.');
			},1000);
		},
		
		/**
		 * 加载事件库
		 */
		autoLoadEvents:function(){
			$(function(){
				//全选、反选
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
				});
			});
		},
		
		/**
		 * 路由自动加载
		 * @param string routeName		路由名称
		 * @return null
		 * */
		autoLoadRoute: function(routeName){
			
			//加载路由
			require('config/route');
			
			//routeName变量安全过滤
			var filter = /^[a-zA-Z0-9_]+$/;
			if( filter.test(routeName) ){
				var route_file_name = eval("_route." + routeName);
				
				if( typeof(route_file_name) == 'object'){
					
					if( typeof(route_file_name.js) != 'undefined' && route_file_name.js != '' ){
						//路由路径
						var js_route_path 	= static_base + '/admin/controller/' + route_file_name.js.toLowerCase() + '.js';
						//动态加载
						$('#route').html('<script src="'+js_route_path+'"></script>');
					}
					
					if( typeof(route_file_name.css) != 'undefined' && route_file_name.css != ''){
						var css_route_path 	= static_base + '/admin/view/css/' + route_file_name.css.toLowerCase() + '.css';
						$('#route').html('<link rel="stylesheet" href="'+css_route_path+'" />');
					}
					
				}
				
			}
		}
		
	};
});