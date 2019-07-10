<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/6/28
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>


    <script src="../js/jquery-3.2.1.min.js"></script>
    <link href="../js/bootstrap.min.css" rel="stylesheet">
    <link href="../js/font-awesome.min.css" rel="stylesheet">
    <script src="../js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/style.css">

    <style>
        body{
            background: url("/img/1.jpg");
            animation-name:myfirst;
            animation-duration:12s;
            /*变换时间*/
            animation-delay:2s;
            /*动画开始时间*/
            animation-iteration-count:infinite;
            /*下一周期循环播放*/
            animation-play-state:running;
            /*动画开始运行*/
        }
        @keyframes myfirst
        {
            0%   {background:url("/img/1.jpg");}
            34%  {background:url("/img/timg.jpg");}
            67%  {background:url("/img/2.png");}
            100% {background:url("/img/1.jpg");}
        }
        .form{background: rgba(255,255,255,0.2);width:400px;margin:120px auto;}
        /*阴影*/
        .fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}
        input[type="text"],input[type="password"]{padding-left:26px;}
    </style>

    <script  type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script  type="text/javascript">
        function doReg() {
            if($("#username").val().length == 0) {
                alert("用户名不能为空！");
                return;
            }
            if($("#password").val().length == 0){
                alert("密码不能为空！")
                return;
            }
            //获取用户输入的数据
            var u = $("#username").val();
            var p = $("#password").val();
            //处理请求的url
            var url = "/landingJump.action";
            //提交到服务器端的参数
            var data = "username=" + u + "&password=" + p;
            //dataType : 预期服务器返回的数据类型
            //发出请求，并获取响应结果
            $.ajax({
                "url" : url,
                "data" : data,
                "type" : "post",
                "dataType" : "json",
                "success" : function (json) {
                    // 由于服务端使用了Jackson
                    // 所以响应头中由Jackson自动设置了响应正文是json
                    // 所以dataType的值就是"json"
                    // 且当前成功时的处理函数的参数就是服务端响应的json对象
                    if(json.state == "1"){
                        window.location.href = "/successful.action?username="+u;
                    }else if(json.state == "-1"){
                        alert("用户名或密码不正确！");
                    }else if(json.state == "0"){
                        alert("用户不存在！")
                    } else{
                        alert("用户已登陆！")
                    }
                }
            });
        }

        function register() {
            window.location.href = "/jsp/register.jsp";
        }
    </script>

</head>
<body>
    <div class="container">
        <div class="form row">
            <div class="form-horizontal col-md-offset-3" id="login_form">
                <h3 class="form-title">聊天室登陆</h3>
                <div class="col-md-9">
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <input onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" class="form-control required" type="text" placeholder="只能使用英文字母和数字" id="username" name="username" autofocus="autofocus" maxlength="20"/>
                    </div>
                    <div class="form-group">
                        <i class="fa fa-lock fa-lg"></i>
                        <input class="form-control required" type="password" placeholder="Password" id="password" name="password" maxlength="8"/>
                    </div>
                    <div class="form-group col-md-offset-9">
                        <button type="button" class="btn btn-success pull-right" name="submit" onclick="register()">注册</button>
                        <button style="margin-right: 110px" type="submit" class="btn btn-success pull-right" name="submit" onclick="doReg()">登录</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
