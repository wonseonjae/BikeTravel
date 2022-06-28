<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	UserDTO userDTO = (UserDTO) session.getAttribute("user");
	ClubListDTO rDTO = (ClubListDTO) request.getAttribute("rDTO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- css 가져오기 -->
	<link rel="stylesheet" href="/css/semantic.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/css/bootstrap.min.css" rel="stylesheet" />
	<!-- js 가져오기 -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script type="text/javascript">
		function readURL(input) {
			$("#preview").attr('src',"");
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview').src = e.target.result;
					document.getElementById('preview').style.textAlign="left";
					document.getElementById('preview').style.width="450px";
					document.getElementById('preview').style.height="350px";
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				document.getElementById('preview').src = "";
			}
		}
	</script>
	<style>
		.input-file-button{
			padding: 6px 25px;
			background-color:#0d6efd;
			border-radius: 4px;
			color: white;
			cursor: pointer;
		}
		body {
			padding-top: 80px;
			background-color: #71dd8a;
		}
		.submitBtn{
			background-color: #00b5ad;
			border: #00b5ad;
		}

		body>.grid {
			height: 100%;
		}

		.image {
			margin-top: -100px;
		}

		.column {
			max-width: 850px;
			max-height: 1200px;
		}
		.preview {
			text-align: left;
		}

	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	</script>
	<title>자전거 여행</title>
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
<div class="ui middle aligned center aligned grid">
	<div class="column">
		<h2 class="ui teal image header">
			동호회 업데이트
		</h2>
		<form method="post" class="ui large form" encType="multipart/form-data" action="/club/updateReg">
			<div class="ui stacked segment">
				<div class="field">
					<h4 align="left">동호회명</h4>
					<input type="text" id="title" name="title" placeholder="제목" autocomplete="off" autofocus="autofocus" value="<%=rDTO.getClub_name()%>" readonly>
					<input type="hidden" id="club_no" name="club_no" value="<%=rDTO.getClub_no()%>">
				</div>
				<div class="field">
					<h4 align="left">활동지역</h4>
					<select id="s1" name="s1">
						<option>전국</option>
						<option>경기도</option>
						<option>강원도</option>
						<option>충청북도</option>
						<option>충청남도</option>
						<option>전라북도</option>
						<option>경상북도</option>
						<option>경상남도</option>
					</select>
				</div>
				<div class="field">
					<h4 align="left">소개글</h4>
					<div class="ui left icon input">
						<textarea style="resize: vertical;" id="contents" name="contents" placeholder="50자 이내로 입력해주세요" rows="8"><%=rDTO.getClub_intro()%></textarea>
					</div>
				</div>
				<div class="field">
					<label class="input-file-button" for="file">
						대표 이미지 첨부
					</label>
					<input style="display: none;" type="file" id="file" name="file" onchange="readURL(this);">
					<input type="hidden" id="imgLink" name="imgLink" value="<%=rDTO.getImgLink()%>">
					<% if (rDTO.getImgLink() != ""){
					%>
					<img id="preview" style="height: 450px;width: 350px" src="<%=rDTO.getImgLink()%>" />
					<%}else{%>
					<img id="preview" />
					<%}%>
				</div>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="submit" value="동호회 수정">
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>