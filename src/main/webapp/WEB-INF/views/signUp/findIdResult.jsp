<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
</head>
<body>
<div class="card o-hidden border-0 shadow-lg my-5">

    <div class="jumbotron">
        <h2> 아이디는 : <%= request.getAttribute("userid")%>입니다</h2><br/>


        <button type="button" class="btn btn-primary" onclick="location.href='/LoginPage'">로그인페이지</button>
        <button type="button" class="btn btn-primary" onclick="location.href='/findIdPw'">비밀번호 찾기</button>


    </div>
</body>
</html>