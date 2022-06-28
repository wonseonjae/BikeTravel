<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.CommentDTO" %>
<%@ page import="org.apache.catalina.User" %>
<%@ page import="kopo.poly.dto.NoticeDTO" %>
<%@ page import="java.util.Objects" %>
<%
	NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO");
	int res = (Integer) request.getAttribute("res");

//공지글 정보를 못불러왔다면, 객체 생성
	if (rDTO == null) {
		rDTO = new NoticeDTO();

	}
	int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
	if (session.getAttribute("user")==null) {
		edit = 3;
	} else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		String ss_user_name = uDTO.getUser_name();

//로그인 안했다면....
		if (uDTO == null) {
			edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
		} else if (Objects.equals(ss_user_name, rDTO.getAdminname())) {

			edit = 2;

		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>공지</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="/css/bootstrap.min.css"/>
	<script type="text/javascript">

		//삭제하기
		function goAdmin(){
			location.href="/admin"
		}
		function doDelete() {
			if ("<%=edit%>" == 2) {
				if (confirm("작성한 글을 삭제하시겠습니까?")) {
					location.href = "/noticeDelete?nSeq=<%=rDTO.getNotice_no()%>";

				}
			} else if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");

			} else {
				alert("본인이 작성한 글만 삭제 가능합니다.");
			}
		}
	</script>
	<style>
		body{
			padding-top: 80px;
		}
		.main{
			max-width: 1400px;
			height: 60%;
			padding-right:15px;
			padding-left:15px;
			margin-right:auto;
			margin-left:auto

		}
		.box{

		}

	</style>
</head>
<body>
<div class="main">
	<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		<a class="navbar-brand" href="#">공지</a>
		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<ul class="navbar-nav ms-auto">
				</ul>
			</form>
		</div>
	</nav>
	<div class="box" style="width: 100%; font-size: 24px">
			<%=rDTO.getTitle()%>
	</div>
	<hr>
		<div class="box" style="display:flex;width: 100%;color: #272a15">
			<p>작성자:<%=rDTO.getAdminname()%>&nbsp;&nbsp;|&nbsp;&nbsp;</p><p>작성일:<%=rDTO.getRegdate().substring(0,16)%></p>
		</div>
	<hr>
<div class="box" style="width: 100%; font-size:16px">
	<p><%=rDTO.getContents()%></p>
</div>
	<div style="font-size: 18px" class="box">
		<%if (edit==2){%>
		<a onclick="goAdmin()">[목록]</a>
		<a onclick="doDelete()">[삭제]</a>
		<%}%>
	</div>
</div>
<hr>
</body>
</html>