<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/7/8
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>
        #Div1{
            width: 600px;
            height: 300px;
            margin-left: 500px;
            margin-top: 100px;
            position: absolute;
        }

        #Div2{
            width: 200px;
            height: 400px;
            margin-top: 100px;
            margin-left: 300px;
            position: absolute;
        }

        #Div3{
            width: 600px;
            height: 200px;
            margin-top: 400px;
            margin-left: 500px;
            position: absolute;
        }

        #Div4{
            width:600px ;
            margin-top:60px ;
            margin-left: 500px;
            position: absolute;
        }

        #Div5{
            width:200px ;
            margin-top: 60px;
            margin-left:300px;
            position: absolute;
        }
        #li1{

        }
    </style>

    <script>
        function x() {
            $("#li1").remove();
        }
    </script>
</head>
<body>

    <li>1</li>
    <li id = "li1">2</li>
    <li>3</li>
    <button onclick="x()" value="asd">asd</button>

<div class="panel panel-success" id="Div5">
    <div class="panel-heading">
        <h3 class="panel-title">当前在线</h3>
    </div>
</div>
<div class="panel panel-primary" id="Div4">
    <div class="panel-heading">
        <h3 class="panel-title">聊天框</h3>
    </div>
</div>
<div style="OVERFLOW-y: scroll;" class="panel panel-primary" id="Div1">
    <!-- 左对齐 -->
    <div  class="media"  style="width: 500px">
        <div class="media-left" >
            <img src="../img/1.png" class="media-object" style="width:60px">
        </div>
        <div class="media-body" style="background-color: dodgerblue;">
            <h4 class="media-heading">左对齐</h4>
            <p>这是一些示例文本...</p>
        </div>
    </div>

</div>

<div style="OVERFLOW-y: scroll;"  class="panel panel-danger" id="Div2">
    <div  class="media"  style="width: 150px">
        <div class="media-left" >
            <img src="../img/1.png" class="media-object" style="width:60px">
        </div>
        <div class="media-body">
            <h4  style="color: forestgreen;
            text-align: center;margin-top: 20px" class="media-heading">张三</h4>
        </div>
    </div>
    <hr>
</div>

<div class="panel panel-primary" id="Div3">
    <div class="panel-heading">
        <h3 class="panel-title">发送框</h3>
    </div>
    <form role="form">
        <div class="form-group">
            <textarea class="form-control" rows="7"></textarea>
        </div>
    </form>
</div>


</body>
</html>
