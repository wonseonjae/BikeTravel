
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	List<ClubListDTO> rList = (List<ClubListDTO>) request.getAttribute("list");
	int res = 0;
	if (session.getAttribute("user") != null) {
		res=1;
	}

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<ClubListDTO>();

	}

%>
<html>
<head>
	<title>동호회 찾아보기</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/album.css">

	<script>
		function doDetail(cNo) {
			if ("<%=res%>"==1){
				location.href = "/club/clubInfo?cNo=" + cNo
			}else{
				alert('로그인 해주시기 바랍니다.')
				location.reload()
			}

		}
		function doPaging(pNo) {
			let loc = window.location.href;
			location.href = loc+"&pNo="+pNo;
		}
	</script>
	<style>
		.submitBtn {
			background-color: #FFFFFF;
			border: #ffeeba;
		}
		ul {
			list-style:none;
		}
		.addClub{
			margin-top: 25px;
			text-align: left;
		}
		.paging {
			text-align: center;
		}

		.paging a {
			display: inline-block;
			vertical-align: middle;
		}

		.paging a.bt:hover {
			background-color: #999;
		}

		.paging a.first {
			background-position: 10px -40px;
		}

		.paging a.prev {
			margin-right: 5px;
			background-position: 10px 10px;
		}

		.paging a.next {
			margin-left: 5px;
			background-position: -40px 10px;
		}

		.paging a.last {
			background-position: -40px -40px;
		}

		.paging a.num {
			margin: 0 5px;
		}

		.paging a.num.on {
			color: green;
		}

		.paging a.num:hover {
			text-decoration: underline;
		}
	</style>
</head>
<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="/course/index">코스 조회</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="/board/list">후기게시판</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link disabled" href="/weather/Form">기상조회</a>
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
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">관리자 페이지</a></li>
				<%}%>
			</ul>
		</form>
	</div>
</nav>
<main>
	<section class="py-5 text-center container">
		<div class="row py-lg-5">
			<div class="col-lg-6 col-md-8 mx-auto">
				<h1 class="fw-light">동호회 리스트</h1>

			</div>
		</div>
	</section>
	<div class="album py-5 bg-light">
		<div class="container">
			<form method="get" action="/club/listByRange">
				<select id="s1" name="s1" onchange="rangeCheck()">
					<option>전국</option>
					<option>경기도</option>
					<option>강원도</option>
					<option>충청북도</option>
					<option>충청남도</option>
					<option>전라북도</option>
					<option>경상북도</option>
					<option>경상남도</option>
				</select>
				<input style="color:#1b1c1d" class="submitBtn" type="submit" value="찾기">
			</form>
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
				<%
					for (int i = 0; i < rList.size(); i++) {
						ClubListDTO rDTO = rList.get(i);

						if (rDTO == null) {
							rDTO = new ClubListDTO();
						}
						if (rDTO.getMemberCnt() == 0) {

				%>
				<div class="col">
					<div class="card shadow-sm">
						<% if (rDTO.getImgLink() != null){%>
						<img class="bd-placeholder-img card-img-top" height="225" src="<%=rDTO.getImgLink()%>"/>
						<%}else {%>
						<svg class="bd-placeholder-img card-img-top" href="" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#55595c"></rect></svg>
						<%}%>
						<div class="card-body">
							<p style="font-size: 2em" class="card-text"><%=rDTO.getClub_name()%></p>
							<p style="font-size: 1em"class="card-text"><%=rDTO.getClub_intro()%></p>
							<small style="font-size: smaller" class="text-muted">활동지역 : <%=rDTO.getClubrange()%></small><br>
							<small style="font-size: smaller" class="text-muted">창설일 : <%=rDTO.getRegdate().substring(0,10)%></small>
							<div class="d-flex justify-content-between align-items-center">
								<div class="btn-group">
									<button type="button" class="btn btn-sm btn-outline-secondary" onclick="doDetail(<%=rDTO.getClub_no()%>)">바로가기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%}%>
				<%
					}
				%>
			</div>
			<% if (session.getAttribute("user") != null) {
			%>
			<a class="aTag" location="left" href="/club/newClub">동호회 만들기</a>
			<%}%>
		</div>
		<div class="paging">
			<ul id="pageInfo" class="pageInfo">
				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/club/list?cNo=${num}" class="num">${num}</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</main>
</body>
</html>