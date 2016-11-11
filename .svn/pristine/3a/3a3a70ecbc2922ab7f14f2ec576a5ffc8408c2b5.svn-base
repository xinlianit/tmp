$(document).ready(function() {
	var loginname = $.cookie('loginname');
	var password = $.cookie('password');
	if (typeof(loginname) != "undefined" && typeof(password) != "undefined") {
		$("#loginname").val(loginname);
		$("#password").val(password);
		$("#saveid").attr("checked", true);
		$("#code").focus();
	}
	
	//更换验证码
	$(document).on("click","[event-click='changeCode']",function(){
		var code_url = $("[tag-id='img-code']").attr('url');
		$("[tag-id='img-code']").attr('src',code_url + "?math=" + Math.random());
	});
});

//服务器校验
function severCheck(){
	if(check()){
		var url 		= $("#loginForm").attr('action');
		var loginname 	= $("#loginname").val();
		var password 	= $("#password").val();
		var code		= $("#code").val();
		
		$.ajax({
			type: "POST",
			url: url,
	    	data: {
	    		loginname:loginname,
	    		password:password,
	    		code:code
	    	},
			dataType:'json',
			cache: false,
			success: function(result){
				if( !result ){
					$("#loginbox").tips({
						side : 1,
						msg : '服务器内部发生错误，请稍后重试！',
						bg : 'red',
						time : 5
					});
					
					return false;
				}
				
				if( parseInt(result.status) != 1 ){
					switch( result.flag ){
						case 'loginname':
							$("#loginname").tips({
								side : 1,
								msg : result.msg,
								bg : '#FF5080',
								time : 3
							});
							$("#loginname").focus();
							break;
						case 'password':
							$("#password").tips({
								side : 1,
								msg : result.msg,
								bg : '#FF5080',
								time : 3
							});
							$("#password").focus();
							break;
						case 'code':
							$("#code").tips({
								side : 1,
								msg : result.msg,
								bg : '#FF5080',
								time : 3
							});
							$("#code").focus();
							break;
					}
				}else{
					saveCookie();
					window.location.reload();
				}
				
				login_status(true);
				
			},
			error:function(){
				$("#loginbox").tips({
					side : 1,
					msg : '服务器内部发生错误，请稍后重试！',
					bg : 'red',
					time : 5
				});
				
				login_status(true);
				
				return false;
			}
		});
		
		var code_url = $("[tag-id='img-code']").attr('url');
		$("[tag-id='img-code']").attr('src',code_url + "?math=" + Math.random());
	}
}


//监听回车事件
$(document).keyup(function(event) {
	if (event.keyCode == 13) {
		$("#to-recover").trigger("click");
	}
});

//客户端校验
function check() {

	if ($("#loginname").val() == "") {

		$("#loginname").tips({
			side : 2,
			msg : '管理员账号不能为空',
			bg : '#AE81FF',
			time : 3
		});

		$("#loginname").focus();
		return false;
	} else {
		$("#loginname").val(jQuery.trim($('#loginname').val()));
	}

	if ($("#password").val() == "") {

		$("#password").tips({
			side : 2,
			msg : '密码不能为空',
			bg : '#AE81FF',
			time : 3
		});

		$("#password").focus();
		return false;
	}
	if ($("#code").val() == "") {

		$("#code").tips({
			side : 1,
			msg : '验证码不能为空',
			bg : '#AE81FF',
			time : 3
		});

		$("#code").focus();
		return false;
	}

	login_status(false);
	return true;
}

//保存登陆信息
function saveCookie() {
	if ($("#saveid").attr("checked")) {
		$.cookie('loginname', $("#loginname").val(), {
			expires : 7
		});
		$.cookie('password', $("#password").val(), {
			expires : 7
		});
	}else{
		$.cookie('loginname', '', {
			expires : -1
		});
		$.cookie('password', '', {
			expires : -1
		});
		$("#loginname").val('');
		$("#password").val('');
	}
}

//重置表单
function reset() {
	$("#loginname").val('');
	$("#password").val('');
	$("#code").val('');
}

function login_status(status){
	if( status == true ){
		$("#to-recover").removeClass('login-in');
		$("#to-recover").text("立即登录");
		$("#to-recover").attr('onclick',"severCheck();");
	}else{
		$("#to-recover").addClass('login-in');
		$("#to-recover").text("正在登录 , 请稍后 ...");
		$("#to-recover").removeAttr('onclick');
	}
}


