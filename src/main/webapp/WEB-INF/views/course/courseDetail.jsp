<%@ page import="java.util.Objects" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	CourseDTO rDTO = (CourseDTO) request.getAttribute("rDTO");
	ImageDTO iDTO = (ImageDTO) request.getAttribute("iDTO");
	List<CourseReviewDTO> rList = (List<CourseReviewDTO>) request.getAttribute("rList");

	int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
	if (session.getAttribute("user")==null) {
		edit = 3;
	} else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		int ss_user_no = uDTO.getUser_no();
	}

	int rep = 0;
	if (session.getAttribute("user")!=null) {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		rep = uDTO.getUser_no();


	}

%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
	<!-- Custom styles for this template -->
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="/css/album.css"/>
	<link rel="stylesheet" href="/css/blog.css"/>
	<style>
		@import url('//fonts.googleapis.com/earlyaccess/nanumpenscript.css');

		h1{
			font-family: 'Nanum Pen Script', cursive;
		}
		body{
			height: 100%;
		}
		.star {
			position: relative;
			font-size: 2rem;
			color: #ddd;
		}

		.star input {
			width: 25%;
			height: 100%;
			position: absolute;
			left: 0;
			opacity: 0;
			cursor: pointer;
		}

		.updateSpan{
			width: 0;
			height: 50px;
			position: absolute;
			left: 0;
			color: Gold;
			overflow: hidden;
			pointer-events: none;
		}

		.star span {
			width: 0;
			height: 50px;
			position: absolute;
			left: 0;
			color: Gold;
			overflow: hidden;
			pointer-events: none;
		}

		.updateInput{
			width: 100%;
			height: 100%;
			position: absolute;
			left: 0;
			opacity: 0;
			cursor: pointer;
		}

		.reviewInput{
			width: 100%;
			height: 100%;
			position: absolute;
			left: 0;
			opacity: 0;
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">
		function goList(){
			location.href="/course/index"
		}
		function goDelete(){
			if (confirm('<%=rDTO.getCourseName()%>을 삭제하시겠습니까?')===true){
				location.href="/course/deleteCourse?coursename=<%=rDTO.getCourseName()%>"
			}else {

			}

		}
		//댓글쓰기
		function doReply(coursename) {
			let comment = document.getElementById("content").value;
			console.log(comment)
			let starpoint = document.getElementById("point").value * 2;
			console.log(starpoint)
			console.log(coursename)
			if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");
				return false;
			} else {
				$.ajax({
					url: '/bike/insertReview',
					method: 'get',
					contentType: 'application/json',
					data: {
						"text" : comment,
						"starpoint" : starpoint,
						"course_name" : coursename
					},
					success: function () {
						location.reload();
					}
				})
			}
		}
		function repDelete(cNo) {
				if (confirm("작성한 댓글을 삭제하시겠습니까?")) {
					$.ajax({
						url:'/bike/deleteReview',
						method:'get',
						contentType:'application/json',
						data: {
							"distance_no" : cNo
						} ,
						success: function (){
							location.reload();
						},
					})
				}

		}
		function editReply(rid, reg_id, content){
			var htmls = "";
			htmls += '<div style="font-size: 16px" class="card-body" id="repbox'+rid+'">';
			htmls += '<title>Placeholder</title>';
			htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
			htmls += '<p>';
			htmls += '<span>';
			htmls += '<strong class="text-gray-dark">' + reg_id + '</strong>';
			htmls += '<span style="padding-left: 7px; font-size: 12pt">';
			htmls += '<a href="javascript:void(0)" onclick="updateReply('+rid+')" style="padding-right:5px">저장</a>';
			htmls += '<a href="javascript:void(0)" onClick="location.reload()">취소</a>';
			htmls += '<br/>'
			htmls += '</span>';
			htmls += '</span>';
			htmls += '<span class="star">★★★★★';
			htmls += '<span style="color: Gold" class="updateSpan">★★★★★</span>';
			htmls += '<input type="range" style="width: 100%" class="updateInput" oninput="updateStar(this)" value="1" step="1" min="0" max="10">';
			htmls += '</span>';
			htmls += '<input style="border: none; width: 50px" type="text" name="updatePoint" id="updatePoint" value="0.0" disabled>';
			htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
			htmls += content;
			htmls += '</textarea>';
			htmls += '</p>';
			htmls += '</div>';
			$('#repbox' + rid).replaceWith(htmls);
			$('#repbox' + rid + '#editContent').focus();
		}
		function updateReply(rid){
			let comment_no = rid
			let content = document.getElementById('editContent').value
			let starPoint = document.getElementById('updatePoint').value * 2
			if (content === ""){
				alert('최소 1글자 이상 입력해야합니다.')
				return
			}
			$.ajax({
				url: '/bike/updateReview',
				method: 'get',
				contentType: 'application/json',
				data: {
					"distance_no" : comment_no,
					"content" : content,
					"starPoint" : starPoint
				},
				success: function () {
					location.reload();
				}
			})

		}
		const drawStar = (target) => {
			console.log('${target.value}')
			document.querySelector(`.star span`).style.width = target.value * 2.5  + '%';
			document.getElementById("point").value = Math.round(target.value / 2);
		}
		const updateStar = (target) => {
			console.log('${target.value}')
			document.querySelector(`.updateSpan`).style.width = target.value * 10  + '%';
			document.getElementById("updatePoint").value = Math.round(target.value / 2);
		}
	</script>
</head>
<body>
<div style="font-size: 18px" class="container">
	<header class="blog-header py-3">
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div style="font-size: 18px" class="col-4 pt-1">
				<a class="link-secondary" onclick="goList()">목록으로</a>
				<%if (session.getAttribute("user")!=null){
					UserDTO uDTO = (UserDTO) session.getAttribute("user");
					if (uDTO.getAuthority().equals("ADMIN")){
				%>
				<a class="link-secondary" onclick="goDelete()">|코스삭제</a>
				<%
						}
					}
				%>
			</div>
		</div>
	</header>
</div>
<div style="height: 1000px" class="container">
	<h1 style="text-align: center"><%=rDTO.getCourseName()%></h1>
	<div class="rounded bg-dark">
		<img style="width: 100%" height="auto" src="<%=iDTO.getCourseimg()%>">
	</div>
	<div class="row g-5">
		<a style="text-align: center" onclick="window.open('https://map.kakao.com/?map_type=TYPE_MAP&target=bike&rt=%2C%2C523953%2C1084098&rt1=<%=rDTO.getStartPoint()%>&rt2=<%=rDTO.getEndPoint()%>&rtIds=%2C&rtTypes=%2C%208','길찾기')">카카오맵으로 길찾기</a><br>
	</div>
	<div style="max-height: 1000px" class="row mb-2">
		<div class="col-md-6">
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong style="font-size: 18px" class="d-inline-block mb-2 text-success">코스</strong><hr>
					<p class="mb-auto">출발점 : <%=rDTO.getStartPoint()%> -> 도착점 : <%=rDTO.getEndPoint()%></p><br>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
			<strong style="font-size: 18px" class="d-inline-block mb-2 text-danger">소요시간</strong><hr>
			<%
				if (rDTO.getTimeHour() == "") {
			%>
			<p>소요시간 : <%=rDTO.getTimeMinute()%>분</p><br>
			<%} else if (!Objects.equals(rDTO.getTimeHour(), "") && !Objects.equals(rDTO.getTimeMinute(), "")){%>
			<p>소요시간 : <%=rDTO.getTimeHour()%>시간 <%=rDTO.getTimeMinute()%>분</p><br>
			<%}else {%>
			<p>소요시간 : <%=rDTO.getTimeHour()%>시간</p><br>
			<%}%>
				</div>
			</div>
		</div>
		<div style="height: 40%" class="col-md-12">
			<div style="height: 40%" class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong style="font-size: 18px" class="d-inline-block mb-2 text-primary">소개</strong><hr>
					<p class="card-text mb-auto"><%=rDTO.getCourseIntro()%></p>
				</div>
			</div>
		</div>
		<div style="height: 40%" class="col-md-12">
			<div>
				<!-- Comments Form -->
				<div class="card my-4">
					<h5 class="card-header">별점등록</h5>
					<span class="star">
							  ★★★★★
							  <span style="color: Gold">★★★★★</span>
							  <input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
						</span>
					<input style="border: none; width: 50px" type="text" name="point" id="point" value="0.0" disabled>
					<div class="card-body">
						<div class="form-group">
							<textarea id="content" name="content" class="form-control" rows="2"></textarea>
						</div>
						<button class="btn btn-primary" onclick="doReply('<%=rDTO.getCourseName()%>')">등록</button>
					</div>
				</div>
				<div class="card my-4">
					<h5 class="card-header">후기 목록[<%=rList.size()%>]</h5>
					<%
						for (int i = 0; i < rList.size(); i++) {
							CourseReviewDTO cDTO = rList.get(i);
							int starpoint = (int) (cDTO.getStarpoint() * 10);

							if (cDTO == null) {
								cDTO = new CourseReviewDTO();
							}

					%>
					<div class="card-body" id="repbox<%=cDTO.getDistance_no()%>">
						<a><%=CmmUtil.nvl(cDTO.getUser_name()) %></a>
						<a><%=cDTO.getReg_dt().substring(0,16)%></a>
						<%
							if (session.getAttribute("user")!=null){
								UserDTO uDTO = (UserDTO) session.getAttribute("user");
								if (uDTO.getUser_no()==cDTO.getUser_no()){
						%>
						<a href="javascript:repDelete('<%=cDTO.getDistance_no()%>')">삭제</a><a>&nbsp;&nbsp;|&nbsp;&nbsp;</a><a href="javascript:editReply('<%=cDTO.getDistance_no()%>','<%=cDTO.getUser_name()%>','<%=cDTO.getText()%>','<%=cDTO.getStarpoint()%>')">수정</a>
						<%
								}
							}
						%>
						<br>
						<span class="star">
							  ★★★★★
							  <span style="color:gold;width:<%=starpoint%>%">★★★★★</span>
							  <input type="range" class="reviewInput" id="reviewInput" step="1" min="0" max="10" disabled>
						</span>
						<input style="border: none;color: #999999" type="text" name="point" id="reviewPoint" value="<%=cDTO.getStarpoint()/2%>" disabled><hr/>
						<a><%=CmmUtil.nvl(cDTO.getText()) %></a>

					</div>
					<hr>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>