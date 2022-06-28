<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String user_mail = uDTO.getUser_mailid() + "@" + uDTO.getUser_maildomain();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>마이페이지</title>

    <script>
        function chgName() {
            window.open('/admin/chgName','이름변경','width=800px,height=400px')
        }
        function deleteUser() {
            if (confirm('정말 탈퇴하시겠습니까?')===true){
                location.href="/deleteUser?user_no=<%=uDTO.getUser_no()%>"
            }
        }
    </script>
    <link rel="stylesheet" href="/css/bootstrap.min.css"/>
    <style type="text/css">
        body{
            padding-top: 240px;
        }
        .main{
            max-width: 1400px;
            height: 60%;
            padding-right:15px;
            padding-left:15px;
            margin-right:auto;
            margin-left:auto

        }
        .btn{
            border: #1b1c1d;
        }
    </style>

</head>
<body class="bg-light">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" onclick="window.open('/weather/Form','기상조회','width=500 height=500')">기상조히</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/board/list">후기게시판</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link disabled" onclick="window.open('/course/index','코스조회','width= height=800')">코스조회</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link disabled" href="/club/list">동호회</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav ms-auto">
                <% if(session.getAttribute("user") == null){%>
                <li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
                <%}%>
                <!--<form  required oninput="Show()">-->
                <% if(session.getAttribute("user") != null){%>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" onclick="window.open('/admin','관리자 페이지','width=1000 height=1200')">관리자 페이지</a></li>
                <%}%>
            </ul>
        </form>
    </div>
</nav>

<div class="main" style="margin: 0 auto;">
    <main>
        <div class="col-md-7 col-lg-8">
            <h2 class="mb-3">마이페이지</h2>
            <hr class="my-4">
            <div class="row g-3">
                <div class="col-sm-12">
                    <h4 class="mb-3">이름</h4><br>
                    <p><%=uDTO.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn" onclick="chgName()"><strong>변경</strong></a></p>
                </div>
            </div>
            <hr class="my-1">
            <div class="row g-3">
                <div class="col-sm-12">
                    <h4 class="mb-3">이메일</h4>
                    <p><%=uDTO.getUser_mailid()%>@<%=uDTO.getUser_maildomain()%></p>
                </div>
            </div>
            <hr class="my-1">
            <div class="row g-3">
                <div class="col-sm-12">
                    <h4 class="mb-3">아이디</h4>
                    <p><%=uDTO.getUser_id()%></p>
                </div>
            </div>
            <hr class="my-1">
            <div class="row g-3">
                <div class="col-sm-12">
                    <h4 class="mb-3">가입일</h4>
                    <p><%=uDTO.getRegdate().substring(0,10)%></p>
                </div>
            </div>
            <hr class="my-1">
            <div class="row g-3">
                <div class="col-sm-12">
                    <a onclick="window.open('/pwCheck','비밀번호 변경','width=600 height=400')">비밀번호 변경</a><a>&nbsp;&nbsp;||&nbsp;&nbsp;</a><a onclick="deleteUser()">회원탈퇴</a>
                </div>
            </div>
            <hr class="my-2">
        </div>
    </main>
</div>
</body>
</html>