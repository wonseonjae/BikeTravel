<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	CertificationDTO rDTO = (CertificationDTO) request.getAttribute("rDTO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
</head>
<body>
	<h3><%=rDTO.getCheckPoint()%></h3>
	<div>
		<img width="800px" height="600px" src="">
	</div>
	<div>
		<h5>구간명 : <%=rDTO.getCourseName()%></h5></br>
		<h5>문화관명 : <%=rDTO.getCheckPoint()%></h5></br>
		<h5>주소 : <%=rDTO.getAddress()%></h5>
		<%
			if (!Objects.equals(rDTO.getAutoCkeck(), "")) {
		%>
		<h5>유인/무인 : <%=rDTO.getAutoCkeck()%></h5>
		<%} else {%>
		<h5>전화번호 : <%=rDTO.getPhoneNum()%></h5></br>
		<h5>운영시간 : <%=rDTO.getOperateTime()%></h5>
		<%}%>

	</div>
</body>
</html>