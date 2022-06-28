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
	<script type="text/javascript">
		function doSubmit(f){
			if ($('#address').val() == ""){
				alert('주소를 입력해주세요');
				$("#address").focus();
				return false;
			}
			if ($('#checkPoint').val() == ""){
				alert('문화관명을 입력해주세요');
				$("#checkPoint").focus();
				return false;
			}

			if ($('#title').val() == ""){
				alert('제목을 입력해주세요');
				$("#title").focus();
				return false;
			}

			if ($('#phonenum').val() == ""){
				alert('전화번호를 입력해주세요');
				$("#phonenum").focus();
				return false;
			}

			if ($('#hour').val() == ""){
				alert('운영시간을 입력해주세요');
				$("#hour").focus();
				return false;
			}
			if ($('#auto select').val() == 0){
				alert('유인/무인 여부를 선택해주세요');
				$("#auto").focus();
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
			종주인증소 작성
		</h2>
		<form method="post" class="ui large form" action="/course/certificateUpload" onsubmit="return doSubmit()">
			<div class="ui stacked segment">
				<div class="field">
					<h4 align="left">코스명</h4>
					<input type="text" id="title" name="title" placeholder="제목" autocomplete="off" autofocus="autofocus">
					<input type="hidden" name="user_no" id="user_no" value="${user.user_no}">
				</div>
				<div class="field">
					<h4 align="left">문화관명</h4>
					<div class="ui left icon input">
						<input type="text" id="checkPoint" name="checkPoint" placeholder="문화관명">
					</div>
				</div>
				<div class="field">
					<h4 align="left">주소</h4>
					<div class="ui left icon input">
						<input type="text" id="address" name="address" placeholder="주소" readonly>
					</div>
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
						window.onload = function(){
							document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
								//카카오 지도 발생
								new daum.Postcode({
									oncomplete: function(data) { //선택시 입력값 세팅
										document.getElementById("address").value = data.address; // 주소 넣기
									}
								}).open();
							});
						}
					</script>
				</div>
				<div class="field">
					<h4 align="left">전화번호</h4>
					<div class="ui left icon input">
						<input style="width: 50%" type="text" id="phonenum" name="phonenum" placeholder="전화번호">
					</div>
				</div>
				<div class="field">
					<h4 align="left">운영시간</h4>
					<div class="ui left icon input">
						<input style="width: 50%" type="text" id="hour" name="hour" placeholder="시간">
					</div>
				</div>
				<div class="field">
					<h4 align="left">유인/무인</h4>
					<div class="ui left icon input">
						<select id="auto" name="auto">
							<option value="유인">유인</option>
							<option value="무인">무인</option>
						</select>
					</div>
				</div>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="submit" value="종주 인증소 작성">
				</div>
				<hr>

			</div>
		</form>
		<div class="ui fluid large teal button">
			<a href="/course/index"><button class="ui fluid large teal submit button">뒤로가기</button></a>
		</div>
	</div>
</div>
</body>
</html>