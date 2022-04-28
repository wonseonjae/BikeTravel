<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width", initial-scale="1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js">
		let imageFile;

		// 첨부파일을 변경할때 마다 실행되는 이벤트 
		$("#image").on("change", function(event){
			imageFile = event.target.files[0];
		});

		let testForm = document.getElementById("testForm");

		let formData = new FormData(testForm);

		formData.append("imageFile", imageFile);

		$.ajax({
			url: "/upload",
			async: true,
			type: "POST",
			data: formData,
			processData: false,
			contentType: false,
			dataType: "json",
			success: function(response) {
				// 전송이 성공한 경우 받는 응답 처리
			},
			error: function(error) {
				// 전송이 실패한 경우 받는 응답 처리
			}
		});

	</script>
	<title>자전거 여행</title>
</head>
<body>

<form method="post" encType = "multipart/form-data" action="/upload">
	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
		<thead>
		<tr>
			<th style="text-align: center;">게시판 글쓰기 양식</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text" class="form-control" placeholder="글 제목" name="title" id="title" maxlength="50"></td>
			<td><input type="hidden" name="user_no" id="user_no" value="${user.user_no}"></td>
		</tr>
		<tr>
			<td><input type="text" class="form-control" placeholder="코스명" name="coursename" id="coursename" maxlength="50"></td>
		</tr>
		<tr>
			<td><textarea class="form-control" placeholder="글 내용" name="contents" id="contents" maxlength="2048" style="height:350px;"></textarea></td>
		</tr>
		<tr>
			<td><input type="file" name="file" id="file" accept="image/*"></td>
		</tr>
		</tbody>
	</table>
	<input type="submit" class="btn-primary pull-right" value="글쓰기">
</form>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>