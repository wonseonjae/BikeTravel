<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.util.UseSha256" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO uDTO = (UserDTO) session.getAttribute("user");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://github.com/MinJunjang1/my2022PRJ/blob/7adfa4c9dc7a20b427ada2a2ad3e15a328089c3a/src/main/webapp/WEB-INF/views/js/seouljs.js"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>마이페이지</title>

</head>
<body>
<form method="post" action="/admin/pwCheck">
    <div>
        <li>비밀번호를 입력해주세요</li>
    </div>
    <div>
        <input type="password" id="user_pw" name="user_pw">
        <input type="hidden" id="user_no" name="user_no" value="<%=uDTO.getUser_no()%>">
        <input type="submit" value="확인">
    </div>
</form>

</body>
</html>