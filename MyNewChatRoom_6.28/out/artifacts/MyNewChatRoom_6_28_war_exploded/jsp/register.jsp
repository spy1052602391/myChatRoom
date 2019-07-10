<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/7/3
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>


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
        .checkbox{padding-left:21px;}
    </style>

    <script  type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <script  type="text/javascript" >
        function checkUsername() {
            if($("#username").val().length == 0){
                $("#div1").html("用户名不能为空！");
                document.getElementById("bt1").disabled = true;
            }else{
                var u = $("#username").val();
                var url = "/registerCheck.action";
                var data = "username=" + u;
                $.ajax({
                    "url" : url,
                    "data" : data,
                    "type" : "post",
                    "dataType" : "json",
                    "success" : function (json) {
                        if(json.state == 0){
                            $("#div1").html("");
                            document.getElementById("bt1").disabled = false;
                        }else{
                            $("#div1").html("用户名已经存在！");
                            document.getElementById("bt1").disabled = true;
                        }
                    }
                });
            }

        }

        function checkPassword() {

            if($("#password").val().length == 0){
                $("#div2").html("密码不能为空！");
            }else{
                $("#div2").html("");
            }
        }

        function reNewPage() {
            if($("#username").val().length == 0 || $("#password").val().length == 0){
                alert("用户名或者密码不能为空！")
                window.reload();
            }else{
                alert("注册成功")
                var u = document.getElementById("username").value;
                var p = document.getElementById("password").value;
                window.location.href = "/registerUser.action?username="+u+"&password="+p;
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <div class="form row">
            <div class="form-horizontal col-md-offset-3" id="login_form">
                <h3 class="form-title">聊天室注册</h3>
                <div class="col-md-9">
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"
                               onblur="checkUsername()" placeholder="只能使用英文字母和数字" id="username" name="username"
                               autofocus="autofocus" maxlength="20"/>
                    </div>
                    <div id="div1" style="color: red"></div>
                    <div class="form-group">
                        <i class="fa fa-lock fa-lg"></i>
                        <input class="form-control required" type="password"  onblur="checkPassword()" placeholder="Password" id="password" name="password" maxlength="8"/>
                    </div>
                    <div id="div2" style="color: red"></div>
                    <div class="form-group col-md-offset-9">
                        <button id="bt1" disabled="true" class="btn btn-success pull-right" name="submit" onclick="reNewPage()" >确认注册</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
