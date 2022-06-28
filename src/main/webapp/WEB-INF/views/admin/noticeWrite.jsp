<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	UserDTO userDTO = (UserDTO) session.getAttribute("user");
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

	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		function goList(){
			location.href="/admin"
		}
		function doSubmit(f){
			if(f.title.value == ""){
				alert("제목을 입력하시기 바랍니다.");
				f.title.focus();
				return false;
			}

			if(calBytes(f.title.value) > 200){
				alert("최대 200Bytes까지 입력 가능합니다.");
				f.title.focus();
				return false;
			}

			if(f.contents.value == ""){
				alert("내용을 입력하시기 바랍니다.");
				f.contents.focus();
				return false;
			}

			if(calBytes(f.contents.value) > 500){
				alert("최대 500Bytes까지 입력 가능합니다.");
				f.contents.focus();
				return false;
			}


		}
	</script>
	<title>자전거 여행</title>
</head>
<body>
<div class="ui middle aligned center aligned grid">
	<div class="column">
		<h2 class="ui teal image header">
			공지 작성
		</h2>
		<form method="post" class="ui large form" encType="multipart/form-data" action="/noticeReg" onsubmit="return doSubmit(this);">
			<div class="ui stacked segment">
				<div class="field">
					<h4 align="left">공지 제목</h4>
					<input type="text" id="title" name="title" placeholder="제목" autocomplete="off" autofocus="autofocus">
				</div>
				<div class="field">
					<h4 align="left">작성자</h4>
					<input type="text" id="adminName" name="adminName" autocomplete="off" autofocus="autofocus" value="<%=userDTO.getUser_name()%>" readonly>
				</div>
				<div class="field">
					<h4 align="left">공지 내용</h4>
					<div class="ui left icon input">
						<textarea style="resize: vertical;" id="contents" name="contents" placeholder="공지 내용" rows="8"></textarea>
					</div>
				</div>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="submit" value="공지 작성">
				</div>
				<br>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="button" onclick="goList()" value="목록">
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>