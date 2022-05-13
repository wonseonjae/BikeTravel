<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
</head>
<body>
<ul class="navbar-nav ml-auto">
      <% if(session.getAttribute("user") == null){%>
   <li class="nav-item"><a class="nav-link" href="/LoginPage">로그인</a></li>
      <%}%>

   <!--<form  required oninput="Show()">-->
      <% if(session.getAttribute("user") != null){%>
   <li class="nav-item"><a class="nav-link" href="/myPage">마이페이지</a></li>
   <li class="nav-item"><a class="nav-link" href="/logOut">로그아웃</a></li>
   <li class="nav-item"><a class="nav-link" href="/admin">관리자 페이지</a></li>
      <%}%>

</ul>
<ul>
   <li><a href="/intro/courseList">코스 조회</a></li>
   <li><a href="/board/boardList">후기게시판</a></li>
</ul>

<form>

</form>

</body>
</html>