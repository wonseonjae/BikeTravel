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
	<script>
		function readURL(input) {
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
		function doSubmit(f){
			if($('#file').val() == "") {
				alert("첨부파일은 필수입니다.");
				$("#file").focus();
				return false;
			}
			if ($('#s1').val() == 0){
				alert('코스를 선택해주세요');
				$("#s1").focus();
				return false;
			}
			if ($('#title').val() == ""){
				alert('코스명을 입력해주세요');
				$("#title").focus();
				return false;
			}
			if ($('#startPoint').val() == ""){
				alert('출발점을 입력해주세요');
				$("#startPoint").focus();
				return false;
			}

			if ($('#endPoint').val() == ""){
				alert('도착점을 입력해주세요');
				$("#endPoint").focus();
				return false;
			}

			if ($('#hour').val() == ""){
				alert('시간을 입력해주세요');
				$("#hour").focus();
				return false;
			}

			if ($('#minute').val() == ""){
				alert('분을 입력해주세요');
				$("#minute").focus();
				return false;
			}
			if ($('#courseIntro').val() == ""){
				alert('코스소개를 입력해주세요');
				$("#courseIntro").focus();
				return false;
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

	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	</script>
	<title>자전거 여행</title>
</head>
<body>
<div class="ui middle aligned center aligned grid">
	<div class="column">
		<h2 class="ui teal image header">
			코스 작성
		</h2>
		<form method="post" class="ui large form" encType="multipart/form-data"  action="/course/courseUpload" onsubmit="return doSubmit(this);">
			<div class="ui stacked segment">
				<div class="field">
					<h4 align="left">코스명</h4>
					<input type="text" id="title" name="title" placeholder="제목" autocomplete="off" autofocus="autofocus">
					<input type="hidden" name="user_no" id="user_no" value="${user.user_no}">
				</div>
				<div class="field">
					<h4 align="left">코스 종류</h4>
					<select id="s1" name="s1">
						<option value="0">코스선택</option>
						<option value="종주코스">종주코스</option>
						<option value="테마코스">테마코스</option>
					</select>
				</div>
				<div class="field">
					<h4 align="left">출발점</h4>
					<div class="ui left icon input">
						<input type="text" id="startPoint" name="startPoint" placeholder="출발점">
					</div>
				</div>
				<div class="field">
					<h4 align="left">도착점</h4>
					<div class="ui left icon input">
						<input type="text" id="endPoint" name="endPoint" placeholder="종착점">
					</div>
				</div>
				<div class="field">
					<h4 align="left">소요시간</h4>
					<div class="ui left icon input">
						<input style="width: 50%" type="text" id="hour" name="hour" placeholder="시간">
						<input style="width: 50%"type="text" id="minute" name="minute" placeholder="분">
					</div>
				</div>
				<div class="field">
					<h4 align="left">코스소개</h4>
					<div class="ui left icon input">
						<textarea style="resize: vertical;" rows="8" type="text" id="courseIntro" name="courseIntro" placeholder="코스소개"></textarea>
					</div>
				</div>
				<div class="field">
					<label class="input-file-button" for="file">
						사진첨부
					</label>
					<input style="display: none;" type="file" id="file" name="file" onchange="readURL(this);">
					<img id="preview" />
				</div>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="submit" value="코스 등록">
				</div>
				<hr>

			</div>
		</form>
		<div class="ui fluid large teal button">
			<a href="/course/index"><button class="ui fluid large teal button">뒤로가기</button></a>
		</div>
	</div>
</div>
</body>
</html>