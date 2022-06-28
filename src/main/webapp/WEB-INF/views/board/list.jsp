
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("list");

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<BoardDTO>();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>후기 게시판</title>
	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/css/bootstrap.min.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<style>
		body{
			line-height:2em;
			padding-top: 100px;
			font-family:"맑은 고딕";
		}
		ul, li{
			list-style:none;
			text-align:center;
			padding:0;
			margin:0;
		}

		#mainWrapper{
			width: 80%;
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

		#divPaging {
			padding-top: 20px;
			clear:both;
			margin:0 auto;
			max-width:1400px;
			height:50px;
		}

		#divPaging > div {
			width: 30px;
			margin:0 auto;
			text-align:center;
		}
		#divPaging > .write {
			float:left;
			width: 70px;
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
<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="/course/index">코스 조회<span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="/board/list">후기게시판</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link disabled" onclick="window.open('/weather/Form','기상조회','width=500 height=500')">기상조회</a>
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
<div id="mainWrapper">
	<ul>
		<!-- 게시판 제목 -->
		<li><h2>후기게시판</h2></li>
		<!-- 게시판 목록  -->
		<li>
			<form method="get" action="/board/listByCourse">
				<p style="text-align: left">
					<select style="width: 100px" id="s1" name="s1" onchange="optionChange();">
						<option>코스선택</option>
						<option value="jonCor">종주코스</option>
						<option value="theCor">테마코스</option>
					</select>
					<select id="s2" name="s2">
						<option>코스명 선택</option>
					</select>
					<input type="image" src="/image/search.jpg" height="20px" width="20px">
				</p>
			</form>
			<script>
				function optionChange() {
					let jongju = [
						'남한강자전거길',
						'북한강 종주자전거길',
						'섬진강 종주자전거길',
						'오천자전거길',
						'아라 종주자전거길',
						'한강(서울) 종주자전거길',
						'새재 종주자전거길',
						'영산강 종주자전거길',
						'동해안(경북) 자전거길',
						'금강 종주자전거길',
						'한강 종주자전거길',
						'낙동강 종주자전거길',
						'동해안(강원) 자전거길',
						'한강 종주 자전거길',
						'제주환상자전거길'
					];
					let theme = [
						'화천역사생태공원길',
						'새재자전거길',
						'양수리-가평구간',
						'북한강 섬여행',
						'섬강, 남한강 넘나들기 1',
						'섬강 자전거길',
						'섬강, 남한강 넘나들기',
						'섬강 관동팔경길',
						'개발과 보존길',
						'섬강 자전거길',
						'강촌길',
						'금강 철새길',
						'19C 말 금강변길',
						'사비길',
						'남한강 등대 Tour',
						'삼랑진 은빛물결길',
						'부용대의 절개길',
						'과학문화길',
						'추억 만들기길',
						'행복한 소풍길',
						'문화의 향기길',
						'생명의 노래길',
						'남한강 섬여행',
						'북한강 자전거길',
						'강변오솔길',
						'상생의 노래길',
						'흑두루미 군무길',
						'역사의 숨결길',
						'그린웨이 자전거길',
						'남한강 자전거길',
						'화왕산 달빛기행길',
						'철새의 낙원길',
						'가사문학권 탐방로',
						'메타세쿼이아길',
						'직지와 미호종개길',
						'갈대의 노래길',
						'삼강주막과 노목길',
						'남한강자전거길2',
						'춘천 하늘자전거길',
						'화천 100리 산소길',
						'동강 자전거길',
						'DMZ 평화 자전거길',
						'향수 100리 자전거길',
						'탄금호 자전거길',
						'변산해변 자전거길',
						'금강포구 자전거길',
						'선유도 자전거길',
						'담양 힐링 자전거길',
						'마실길',
						'구림길',
						'회산백련지길',
						'황포돛배길',
						'의향길',
						'나주걷기길',
						'웅진길',
						'강변풀숲길',
						'의암호수변길',
						'영산강 느러지 자전거길',
						'상주 낙동강 자전거길',
						'경주 역사 탐방',
						'울릉도 자전거길',
						'남지 자전거길',
						'우포늪 생태 자전거길',
						'통영 자전거길',
						'원동 매화 자전거길'
					];
					let v = $( '#s1' ).val();
					let o;
					if ( v == 'jonCor' ) {
						o = jongju;
					} else if ( v == 'theCor' ) {
						o = theme;
					} else {
						o = [];
					}
					$( '#s2' ).empty();
					$( '#s2' ).append( '<option></option>' );
					for ( let i = 0; i < o.length; i++ ) {
						$( '#s2' ).append( '<option>' + o[ i ] + '</option>' );
					}
				}
				function doDetail(bNo) {
					location.href = "/board/boardInfo?bNo=" + bNo;
				}
				function doPaging(pNo) {
					let loc = window.location.href;
					location.href = loc+"&pNo="+pNo;
				}
			</script>

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
						BoardDTO rDTO = rList.get(i);

						if (rDTO == null) {
							rDTO = new BoardDTO();
						}

				%>
				<li>
					<ul>
						<li><%=rDTO.getBoard_no()%></li>
						<li><a href="javascript:doDetail('<%=rDTO.getBoard_no()%>');">
							<%=CmmUtil.nvl(rDTO.getTitle())%>
						</a></li>
						<li><%=rDTO.getCoursename()%></li>
						<li><%=rDTO.getUser_name()%></li></li>
						<li><%=rDTO.getRegdate().substring(0,16)%></li>
					</ul>
				</li>
				<%
					}
				%>
			</ul>
		</li>

		<!-- 게시판 페이징 영역 -->
		<li>
			<div id="divPaging">
				<% if (session.getAttribute("user")!=null){%>
				<div style="text-align: left" class="write">
					<a href="/board/boardWrite" class="top_btn">후기 등록</a>
				</div>
				<%

				}%>
				<div style="text-align: center;display: flex">
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<div><a href="/board/list?pNo=${num}">${num}</a></div>
				</c:forEach>
				</div>
			</div>
		</li>
	</ul>
</div>

</body>
</html>