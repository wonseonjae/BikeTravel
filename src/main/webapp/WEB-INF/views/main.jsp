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
<img width="25" height="25" src="">
<%
   int midx = 0;

   if (session.getAttribute("user") != null) {

      midx = (int)session.getAttribute("midx");
   }
%>
<div>
   <%if (midx == 0) {%>
      <ul>
           <li><a href="signUp">회원가입</a></li>
           <li><a href="LoginPage">로그인</a></li>
      </ul>
   <%} else if (midx > 0) {%>
      <ul>
         <li><<a href="admin">관리자</a> </li>
         <li><a href="mypage">마이페이지</a></li>
         <li><a href="logout">로그아웃</a> </li>
      </ul>
   <%};%>
</div>
<p>안녕하세요 ${user.user_name}님</p>
<form>
   <input type="button" name="LogOut" value="로그아웃" onclick="location.href='/logOut'">
</form>

</body>
</html>