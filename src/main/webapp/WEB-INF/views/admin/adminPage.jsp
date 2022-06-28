<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.dto.NoticeDTO" %>
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%
	List<UserDTO> uList = (List<UserDTO>) request.getAttribute("uList");
	List<NoticeDTO> nList = (List<NoticeDTO>) request.getAttribute("nList");
	List<ClubListDTO> cList = (List<ClubListDTO>) request.getAttribute("cList");

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
	if (uList == null) {
		uList = new ArrayList<UserDTO>();

	}
	if (nList == null) {
		nList = new ArrayList<NoticeDTO>();

	}
	if (cList == null) {
		cList = new ArrayList<ClubListDTO>();

	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>관리자페이지</title>
	<link rel="stylesheet" href="/css/table.css">
	<script type="text/javascript">
		//상세보기 이동
		function doDetail(bNo) {
			location.href = "/userDetail?bNo="+bNo;
		}
		function clubDetail(cNo) {
			location.href = "/admin/clubDetail?cNo="+cNo;
		}
		function noticeDetail(cNo) {
			location.href = "/noticeDetail?bNo="+cNo;
		}
		function doOnload(){
			if ("<%=access%>"=="1"){
				alert("관리자만 접근할수 있는 페이지 입니다");
				window.close()
			}
		}
		function mainWrapper(){
			document.getElementById("mainWrapper").style.display="block"
			document.getElementById("mainWrapper2").style.display="none"
			document.getElementById("mainWrapper3").style.display="none"

		}
		function mainWrapper2(){
			document.getElementById("mainWrapper").style.display="none"
			document.getElementById("mainWrapper2").style.display="block"
			document.getElementById("mainWrapper3").style.display="none"

		}
		function mainWrapper3(){
			document.getElementById("mainWrapper").style.display="none"
			document.getElementById("mainWrapper2").style.display="none"
			document.getElementById("mainWrapper3").style.display="block"
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="/css/album.css"/>
	<link rel="stylesheet" href="/css/blog.css"/>
	<style>
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
		 body{
								  line-height:2em;
								  font-family:"맑은 고딕";
							  }
		ul, li{
			list-style:none;
			text-align:center;
			padding:0;
			margin:0;
		}

		#mainWrapper{
			width: 800px;
			margin: 0 auto; /*가운데 정렬*/
		}

		#mainWrapper > ul > li:first-child {
			text-align: center;
			font-size:14pt;
			height:40px;
			vertical-align:middle;
			line-height:30px;
		}
		#mainWrapper2{
			width: 800px;
			margin: 0 auto; /*가운데 정렬*/
		}

		#mainWrapper2 > ul > li:first-child {
			text-align: center;
			font-size:14pt;
			height:40px;
			vertical-align:middle;
			line-height:30px;
		}#mainWrapper3{
			 width: 800px;
			 margin: 0 auto; /*가운데 정렬*/
		 }

		#mainWrapper3 > ul > li:first-child {
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

		#ulTable > li > ul > li:first-child               {width:10%;} /*No 열 크기*/
		#ulTable > li > ul > li:first-child +li           {width:45%;} /*제목 열 크기*/
		#ulTable > li > ul > li:first-child +li+li        {width:20%;} /*작성일 열 크기*/
		#ulTable > li > ul > li:first-child +li+li+li     {width:15%;} /*작성자 열 크기*/
		#ulTable > li > ul > li:first-child +li+li+li+li{width:10%;} /*조회수 열 크기*/

		#divPaging {
			clear:both;
			margin:0 auto;
			width:220px;
			height:50px;
		}

		#divPaging > div {
			float:left;
			width: 30px;
			margin:0 auto;
			text-align:center;
		}

		#liSearchOption {clear:both;}
		#liSearchOption > div {
			margin:0 auto;
			margin-top: 30px;
			width:auto;
			height:100px;

		}

		.left {
			text-align : left;
		}


	</style>
</head>
<%--<body onload="doOnload()">
	<h2>공지목록</h2>
	<br>
	<div style="text-align: center">
		<ul id ="ulTable">

		</ul>
		<br>
		<br>

		<hr>
		<br>

	</div>
</div>
</body>--%>
<body onload="doOnload()">
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
	<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3">관리자페이지</a>
	<button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="navbar-nav">
		<div class="nav-item text-nowrap">
		</div>
	</div>
</header>
<div class="container-fluid">
	<div class="row">
		<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
			<div class="position-sticky pt-3">
				<ul class="nav flex-column">
					<br>
					<li class="nav-item">
						<a onclick="mainWrapper()">
							회원 조회
						</a>
					</li><br><hr><br>
					<li class="nav-item">
						<a onclick="mainWrapper3()">
							공지 조회
						</a>
					</li><br><hr><br>
					<li class="nav-item">
						<a onclick="mainWrapper2()">
							동호회 조회
						</a>
					</li><br><hr><br>
				</ul>
			</div>
		</nav>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!--회원조회-->
			<div style="display: block" id="mainWrapper">
				<div id="userinfo" class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">회원 조회</h1>
				</div>
				<ul>
					<ul id ="ulTable">
						<li>
							<ul>
								<li>회원아이디</li>
								<li>이메일</li>
								<li>회원이름</li>
								<li>가입일</li>
							</ul>
						</li>
						<!-- 게시물이 출력될 영역 -->
						<%
							for (int i = 0; i < uList.size(); i++) {
								UserDTO rDTO = uList.get(i);

								if (rDTO == null) {
									rDTO = new UserDTO();
								}

						%>
						<li>
							<ul>
								<li><%=CmmUtil.nvl(String.valueOf(rDTO.getUser_id()))%></li>
								<li><a href="javascript:doDetail('<%=rDTO.getUser_no()%>');">
									<%=CmmUtil.nvl(rDTO.getUser_mailid())%>@<%=CmmUtil.nvl(rDTO.getUser_maildomain())%>
								</a></li>
								<li><%=rDTO.getUser_name()%></li>
								<li><%=rDTO.getRegdate().substring(0,10)%></li>
							</ul>
						</li>
						<%
							}
						%>
					</ul>
					<!-- 게시판 페이징 영역 -->
					<li>
						<div id="divPaging">
							<div><strong>[</strong></div>
							<!-- 각 번호 페이지 버튼 -->
							<c:forEach var="num" begin="${userPageMake.startPage}" end="${userPageMake.endPage}">
								<div><a href="/admin?uNo=${num}" class="num">${num}</a></div>
							</c:forEach>
							<div><strong>]</strong></div>
						</div>
					</li>
				</ul>
			</div>
			<div style="display: none" id="mainWrapper3">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">공지 조회</h1>&nbsp;&nbsp;
					<%if (session.getAttribute("user") != null){
						UserDTO uDTO = (UserDTO) session.getAttribute("user");
						if (uDTO.getAuthority()=="ADMIN"){%>
					<a href="/admin/noticeInsertForm">공지 등록</a>
					<%

						}

					}%>
				</div>
				<ul>
					<ul id ="ulTable">
						<li>
							<ul>
								<li>공지번호</li>
								<li>제목</li>
								<li>작성자</li>
								<li>작성일</li>
							</ul>
						</li>
						<!-- 게시물이 출력될 영역 -->
						<%
							for (int i = 0; i < nList.size(); i++) {
								NoticeDTO rDTO = nList.get(i);

								if (rDTO == null) {
									rDTO = new NoticeDTO();
								}

						%>
						<li>
							<ul>
								<li><%=CmmUtil.nvl(String.valueOf(rDTO.getNotice_no()))%></li>
								<li><a href="javascript:noticeDetail('<%=rDTO.getNotice_no()%>');">
									<%=CmmUtil.nvl(rDTO.getTitle())%>
								</a></li>
								<li><%=rDTO.getAdminname()%></li>
								<li><%=rDTO.getRegdate()%></li>
							</ul>
						</li>
						<%
							}
						%>
					</ul>
					<!-- 게시판 페이징 영역 -->
					<li>
						<div id="divPaging">
							<div><strong>[</strong></div>
							<!-- 각 번호 페이지 버튼 -->
							<c:forEach var="num" begin="${noticePageMake.startPage}" end="${noticePageMake.endPage}">
								<div><a href="/admin?tNo=${num}" class="num">${num}</a></div>
							</c:forEach>
							<div><strong>]</strong></div>
						</div>
					</li>
				</ul>
			</div>
			<div style="display: none" id="mainWrapper2">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">동호회 조회</h1>
				</div>
				<ul>
					<ul id ="ulTable">
						<li>
							<ul>
								<li>번호</li>
								<li>동호회명</li>
								<li>동호회장</li>
								<li>창설일</li>
							</ul>
						</li>
						<!-- 게시물이 출력될 영역 -->
						<%
							for (int i = 0; i < cList.size(); i++) {
								ClubListDTO rDTO = cList.get(i);

								if (rDTO == null) {
									rDTO = new ClubListDTO();
								}

						%>
						<li>
							<ul>
								<li><%=CmmUtil.nvl(String.valueOf(rDTO.getClub_no()))%></li>
								<li><a href="javascript:clubDetail('<%=rDTO.getClub_no()%>');">
									<%=CmmUtil.nvl(rDTO.getClub_name())%>
								</a></li>
								<li><%=rDTO.getClub_president()%></li>
								<li><%=rDTO.getRegdate().substring(0,10)%></li>
							</ul>
						</li>
						<%
							}
						%>
					</ul>
					<!-- 게시판 페이징 영역 -->
					<li>
						<div id="divPaging">
							<div><strong>[</strong></div>
							<!-- 각 번호 페이지 버튼 -->
							<c:forEach var="num" begin="${ClubPageMaker.startPage}" end="${ClubPageMaker.endPage}">
								<div><a href="/admin?cNo=${num}" class="num">${num}</a></div>
							</c:forEach>
							<div><strong>]</strong></div>
						</div>
					</li>
				</ul>
			</div>
		</main>
	</div>
	<!--회원조회-->
</div>
</body>
</html>