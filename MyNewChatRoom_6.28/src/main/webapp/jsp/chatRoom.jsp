<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/6/28
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>聊天页面</title>
    <script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="../js/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="../js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <style>

        #Div1{
            width: 600px;
            height: 300px;
            margin-left: 500px;
            margin-top: 100px;
            position: absolute;
            background: url("../img/11.png");
            background-size: 300px;
        }

        #Div2{
            width: 200px;
            height: 495px;
            margin-top: 100px;
            margin-left: 300px;
            position: absolute;
            background-color: darkgray;
        }

        #Div3{
            width: 600px;
            height: 195px;
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

        #Div6{
            width: 300px;
            height: 200px;
            position: absolute;
            background-color: white;
        }

        body{
            background: url("../img/12.png");
            background-size: 500px;
        }
    </style>
</head>
<body>

<div id="Div6" style="OVERFLOW-y: scroll " >
    <h4>欢迎您，${username}</h4>
</div>

<div class="panel panel-default" id="Div4">
    <div class="panel-heading">
        <h3 class="panel-title">聊天框</h3>
    </div>
</div>
<div style="OVERFLOW-y: scroll " class="panel panel-default" id="Div1" >

</div>


<div class="panel panel-default" id="Div5">
    <div class="panel-heading">
        <h3 class="panel-title">当前在线</h3>
    </div>
</div>
<div style="OVERFLOW-y: scroll;"  class="panel panel-default" id="Div2">
    <ul id="ul1" class="list-unstyled">
        <c:forEach items="${userMap}" var="map">
            <c:choose>
                <c:when test="${username != map.key}">
                    <li id="${map.key}">
                        <div  class="media"  style="width: 150px">
                            <div class="media-left" >
                                <img src="../img/1.png" class="media-object" style="width:60px">
                            </div>
                            <div class="media-body">
                                <h4  style="color: forestgreen;
                                text-align: center;margin-top: 20px" class="media-heading">${map.key}</h4>
                            </div>
                        </div>
                    </li>
                </c:when>
            </c:choose>
        </c:forEach>
    </ul>
</div>

<div class="panel panel-default" id="Div3">
    <div class="panel-heading">
        <h3 class="panel-title">发送框</h3>
    </div>
    <form role="form">
        <div class="form-group">
            <textarea id="send" class="form-control" rows="7"></textarea>
        </div>
    </form>
    <button onclick="button()" style="margin-left:520px;margin-top: -50px; position: absolute "  type="button" class="btn btn-primary btn-sm active">发送</button>
</div>




</body>
<script type="text/javascript">
    var ws = new WebSocket("ws://47.94.242.95/websocket/${username}");
    $(function(){
        $("#send").keyup(function(evt){
            if(evt.which == 13){ //enter键发送消息
                var htm = $("#send").val();
                doSend(htm);
                document.getElementById("send").value = "";
            }
        });
        $("#send").html("")
    })

    function button(){
        var htm = $("#send").val();
        doSend(htm);
        document.getElementById("send").value = "";
    }

    ws.onopen = function(){
        ($("#Div6")[0]).innerHTML += "<h4>连接成功！</h4>";
    }

    // 从服务端接收到消息，将消息回显到聊天记录区
    ws.onmessage = function(evt){
        dealMessage(evt.data);
    }

    ws.onerror = function(){
        ($("#Div6")[0]).innerHTML += "<h4>连接失败！</h4>";
    }

    ws.onclose = function(){
        ($("#Div6")[0]).innerHTML += "<h4>连接关闭！</h4>";
    }

    // 注销登录
    function doClose(){
        ws.close();
    }

    // 发送消息
    function doSend(htm){
        ws.send(htm);
    }

    //处理消息
    function dealMessage(data) {
        var strings = data.split("_");
        if(strings[0] == "names"){
            var users = strings[1].split(",");
            ($("#Div6")[0]).innerHTML += "<h4>"+users+"</h4>";
            userUp(users[0]);
        }

        if(strings[0] == "content"){
            fromOther(strings[1]);
        }

        if(strings[0] == "quit"){
            $("#"+strings[1]).remove();
        }
    }

    function userUp(users) {
        ($("#ul1")[0]).innerHTML += "<li id=\""+users+"\"><div class=\"media\"  style=\"width: 150px\"> <div class=\"media-left\" > <img src=\"../img/1.png\" class=\"media-object\" style=\"width:60px\"> </div> <div class=\"media-body\"> <h4  style=\"color: forestgreen;text-align: center;margin-top: 20px\" class=\"media-heading\">"+users+"</h4> </div> </div></li>";
    }

    function fromOther(content) {
        var str = content.split(":");
        if(str[0] != "${username}") {
            ($("#Div1")[0]).innerHTML += "<div  class=\"media\"  style=\"width: 500px\"> <div class=\"media-left\" > <img src=\"../img/1.png\" class=\"media-object\" style=\"width:60px\"> </div> <div class=\"media-body\" style=\"background-color: white;\"><p>【" + str[0] + "】     " + new Date().toLocaleTimeString() + "</p> <p>" + str[1] + "</p> </div> </div>";
        }else{
            ($("#Div1")[0]).innerHTML += "<div  class=\"media\"  style=\" margin-left:80px;width: 500px\">  <div class=\"media-body\" style=\"background-color: white;\"><p>【本人】  " + new Date().toLocaleTimeString() + "</p> <p>" + str[1] + "</p> </div> <div class=\"media-right\" > <img src=\"../img/1.png\" class=\"media-object\" style=\"width:60px\"> </div> </div>";
        }
    }
</script>
</html>
