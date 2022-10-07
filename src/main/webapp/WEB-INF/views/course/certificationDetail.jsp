<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	CertificationDTO rDTO = (CertificationDTO) request.getAttribute("rDTO");
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

	</style>
	<script type="text/javascript">
		function goList(){
			location.href="/course/index"
		}
		function goDelete(){
			if (confirm('<%=rDTO.getCheckPoint()%>를 삭제하시겠습니까?')===true) {
				location.href = "/course/deleteCertificate?checkPoint=<%=rDTO.getCheckPoint()%>"
			}else{
			}
		}
		function goCertificate(){
			location.href = "/course/certificateRegForm?checkPoint=<%=rDTO.getCheckPoint()%>"+"&address=<%=rDTO.getAddress()%>"+"&coursename=<%=rDTO.getCourseName()%>"
		}

	</script>
</head>
<body>
<div style="font-size: 18px" class="container">
	<header class="blog-header py-3">
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div style="font-size: 18px" class="col-4 pt-1">
				<a class="link-secondary" onclick="goList()">목록으로  </a>
				<%if (session.getAttribute("user")!=null){
					UserDTO uDTO = (UserDTO) session.getAttribute("user");
					if (uDTO.getAuthority().equals("ADMIN")){
				%>
				<a class="link-secondary" onclick="goDelete()">|  종주소삭제</a>
				<%
						}
					}
				%>
			</div>
		</div>
	</header>
</div>
<div style="height: 1000px" class="container">
	<h1 style="text-align: center"><%=rDTO.getCheckPoint()%></h1>
	<div id="map" style="width:100%;height:350px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3113b55ca889a7c68dfb770c6a6ff2d4&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
				mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level: 3 // 지도의 확대 레벨
				};

		// 지도를 생성합니다
		let map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		let geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('<%=rDTO.getAddress()%>', function(result, status) {

			// 정상적으로 검색이 완료됐으면
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});

				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=rDTO.getCheckPoint()%></div>'
				});
				infowindow.open(map, marker);

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});
	</script>
	<div class="row flex-nowrap justify-content-between align-items-center">
		<div style="font-size: 18px" class="col-4 pt-1">
			<a class="link-secondary" onclick="goCertificate()">종주소 완주등록</a>

		</div>
	</div>
	<div style="max-height: 1000px" class="row mb-2">
		<div style="height: 40%" class="col-md-12">
			<div style="height: 40%" class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong style="font-size: 18px" class="d-inline-block mb-2 text-primary">소개</strong><hr>
					<p class="card-text mb-auto">코스명 : <%=rDTO.getCourseName()%></p><hr>
					<p class="card-text mb-auto">문화관명 : <%=rDTO.getCheckPoint()%></p><hr>
					<p class="card-text mb-auto">주소 : <%=rDTO.getAddress()%></p><hr>
					<p class="card-text mb-auto">유인/무인 : <%=rDTO.getAutoCkeck()%></p>
					<p class="card-text mb-auto"></p>
					<h5></h5></br>
					<h5></h5>
					<%
						if (!Objects.equals(rDTO.getAutoCkeck(), "")) {
					%>
					<%} else {%>
					<p class="card-text mb-auto">전화번호 : <%=rDTO.getPhoneNum()%></p><hr>
					<h5>운영시간 : <%=rDTO.getOperateTime()%></h5>
					<%}%>
				</div>
			</div>
		</div>
	</div>
</div>
</body>

</html>
