<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.dto.CourseDTO" %>
<%@ page import="kopo.poly.dto.ImageDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	CourseDTO rDTO = (CourseDTO) request.getAttribute("rDTO");
	ImageDTO iDTO = (ImageDTO) request.getAttribute("iDTO");
%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
	<!-- Custom styles for this template -->
	<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/css/album.css"/>
	<link rel="stylesheet" href="/css/blog.css"/>
	<style>
		@import url('//fonts.googleapis.com/earlyaccess/nanumpenscript.css');

		h1{
			font-family: 'Nanum Pen Script', cursive;
		}
		body{
			height: 1600px;
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
	</div>
</div>



</body>
</html>