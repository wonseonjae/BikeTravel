<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%
	UserDTO rDTO = (UserDTO) request.getAttribute("rDTO");
	List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("rList");
	int access = 0;
	if (session.getAttribute("user")==null) {
		access = 0;
	} else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		System.out.println(uDTO.getAuthority());
		if (uDTO.getAuthority().equals("ADMIN")) {
			access = 3;
		} else {
			access = 1;
		}
	}

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<BoardDTO>();

	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	<meta name="generator" content="Hugo 0.88.1">
	<title>회원조회</title>
	<!-- Bootstrap core CSS -->
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript">

		//상세보기 이동
		function doDetail(bNo) {
			location.href = "/userBoardDetail?bNo="+bNo;
		}

		function goList() {
			location.href = "/admin";
		}
		function userDelete() {
			if (confirm('<%=rDTO.getUser_name()%>회원을 삭제하시겠습니까?')){
				location.href = "/adminDeleteUser?bNo="+<%=String.valueOf(rDTO.getUser_no())%>;
			}else {
				location.reload()
			}


		}
		function doOnload(){
			if ("<%=access%>"=="1"){
				alert("관리자만 접근할수 있는 페이지 입니다");
				window.close();
			}
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<style>
		body{
			padding-top: 100px;
		}
		.bd-placeholder-img {
			font-size: 1.125rem;
			text-anchor: middle;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}

		@media (min-width: 768px) {
			.bd-placeholder-img-lg {
				font-size: 3.5rem;
			}
		}
		ul, li{
			list-style:none;
			text-align:center;
			padding:0;
			margin:0;
		}

		#mainWrapper{
			margin: 0 auto; /*가운데 정렬*/
		}

		#mainWrapper > ul > li:first-child {
			text-align: center;
			font-size:14pt;
			height:40px;
			vertical-align:middle;
			line-height:30px;
		}

		#ulTable {margin-top:10px;}


		#ulTable > li:first-child > ul > li {
			background-color:#c9c9c9;
			font-weight:bold;
			text-align:center;
		}

		#ulTable > li > ul {
			clear:both;
			padding:0px auto;
			position:relative;
			min-width:40px;
		}
		#ulTable > li > ul > li {
			float:left;
			font-size:10pt;
			border-bottom:1px solid silver;
			vertical-align:baseline;
		}

		#ulTable > li > ul > li:first-child           	{width:10%;} /*No 열 크기*/
		#ulTable > li > ul > li:first-child +li       	{width:30%;} /*제목 열 크기*/
		#ulTable > li > ul > li:first-child +li+li    	{width:25%;} /*코스명 열 크기*/
		#ulTable > li > ul > li:first-child +li+li+li 	{width:15%;} /*작성자 열 크기*/
		#ulTable > li > ul > li:first-child +li+li+li+li{width:20%;} /*작성일 열 크기*/

		.contain{
			width:1200px;
			padding-right:15px;
			padding-left:15px;
			margin-right:auto;
			margin-left:100px;
		}
	</style>


	<!-- Custom styles for this template -->
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="#">관리자페이지</a>
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
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">[목록]</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="Javascript:doDelete(<%=rDTO.getUser_no()%>)">[삭제]</a></li>
			</ul>
		</form>
	</div>
</nav>

<div class="contain">
	<main>
			<div class="col-md-7 col-lg-8">
				<h2 class="mb-3">회원조회</h2>
				<hr class="my-4">
					<div class="row g-3">
						<div class="col-sm-12">
							<h4 class="mb-3">이름</h4>
							<p><%=rDTO.getUser_name()%></p>
						</div>
					</div>
				<hr class="my-1">
				<div class="row g-3">
					<div class="col-sm-12">
						<h4 class="mb-3">이메일</h4>
						<p><%=rDTO.getUser_mailid()%>@<%=rDTO.getUser_maildomain()%></p>
					</div>
				</div>
				<hr class="my-1">
				<div class="row g-3">
					<div class="col-sm-12">
						<h4 class="mb-3">아이디</h4>
						<p><%=rDTO.getUser_id()%></p>
					</div>
				</div>
				<hr class="my-1">
				<div class="row g-3">
					<div class="col-sm-12">
						<h4 class="mb-3">가입일</h4>
						<p><%=rDTO.getRegdate().substring(0,10)%></p>
					</div>
				</div>
				<hr class="my-1">
				<div class="row g-3">
					<div class="col-sm-12">
						<a onclick="userDelete()">회원삭제</a><a>&nbsp;&nbsp;||&nbsp;&nbsp;</a><a onclick="goList()">목록</a>
					</div>
				</div>
				<hr class="my-2">
				<div id="mainWrapper">
					<ul>
						<!-- 게시판 제목 -->
						<li><h2>작성글 목록</h2></li>
						<!-- 게시판 목록  -->
						<li>
							<ul id ="ulTable">
								<li>
									<ul>
										<li>No</li>
										<li>제목</li>
										<li>코스명</li>
										<li>작성자</li>
										<li>작성일</li>
									</ul>
								</li>
								<!-- 게시물이 출력될 영역 -->
								<%
									for (int i = 0; i < rList.size(); i++) {
										BoardDTO cDTO = rList.get(i);

										if (cDTO == null) {
											cDTO = new BoardDTO();
										}

								%>
								<li>
									<ul>
										<li><%=cDTO.getBoard_no()%></li>
										<li><a href="javascript:doDetail('<%=cDTO.getBoard_no()%>');">
											<%=CmmUtil.nvl(cDTO.getTitle())%>
										</a></li>
										<li><%=cDTO.getCoursename()%></li>
										<li><%=cDTO.getUser_name()%></li>
										<li><%=cDTO.getRegdate()%></li>
									</ul>
								</li>
								<%
									}
								%>
							</ul>
						</li>
					</ul>
				</div>
			</div>
	</main>
</div>
</body>
</html>