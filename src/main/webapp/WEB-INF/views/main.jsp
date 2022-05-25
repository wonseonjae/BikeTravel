<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
   <!-- Google fonts-->
   <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
   <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
   <!-- Core theme CSS (includes Bootstrap)-->
   <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
   <div class="container">
      <a class="navbar-brand" href="main"><img src="/image/bike.png" height="30" width="30">자전거여행</a>
      <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
         Menu
         <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
         <ul class="navbar-nav ms-auto">
            <% if(session.getAttribute("user") == null){%>
            <li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
            <%}%>
            <!--<form  required oninput="Show()">-->
            <% if(session.getAttribute("user") != null){%>
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">관리자 페이지</a></li>
            <%}%>
         </ul>
      </div>
   </div>
</nav>
<div>
   <ul>
      <li><a href="/course/index">코스 조회</a></li>
      <li><a href="/board/list">후기게시판</a></li>
      <li><a href="/weather/Form">기상조회</a></li>
      <li><a href="/club/clubIndex">동호회</a></li>
   </ul>
</div>



</body>
</html>