<%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-05-31
  Time: 오후 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String roomname = (String) request.getAttribute("cName");
    String username = (String) request.getAttribute("uName");
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><%=roomname%></title>
    <link rel="stylesheet" href="/css/main.css" />
</head>
<body>

<div id="username-page">
    <div class="username-page-container">
        <h1 class="title"><%=roomname%></h1>
        <form id="usernameForm" name="usernameForm">
            <div class="form-group">
                <input type="text" id="name" placeholder="사용자 이름" autocomplete="off" class="form-control" value="<%=username%>" disabled/>
                <input type="text" id="roomname" placeholder="방 이름" autocomplete="off" class="form-control" value="<%=roomname%>" disabled/>
            </div>
            <div class="form-group">
                <button type="submit" class="accent username-submit">채팅 시작하기</button>
            </div>
        </form>
    </div>
</div>

<div id="chat-page" class="hidden">
    <div class="chat-container">
        <div class="chat-header">
            <h2><%=roomname%></h2>
        </div>
        <div class="connecting">
            연결중...
        </div>
        <ul id="messageArea">

        </ul>
        <form id="messageForm" name="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="보내실 메세지를 적어주세요" autocomplete="off" class="form-control"/>
                    <button type="submit" class="primary">보내기</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/js/main.js"></script>
</body>
</html>