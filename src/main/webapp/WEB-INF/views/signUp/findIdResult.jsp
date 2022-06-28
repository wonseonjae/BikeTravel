<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
</head>
<body>
<div class="card o-hidden border-0 shadow-lg my-5">
    <div style="text-align: center" class="jumbotron">
        <h2> 아이디는 : <%= request.getAttribute("userid")%>입니다</h2><br/>
        <button class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" type="button"  onclick="location.href='/findPw'">비밀번호 찾기</button>
    </div>
</div>
</body>
</html>