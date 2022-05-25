<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.CourseDTO" %>
<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    List<CourseDTO> rList = (List<CourseDTO>) request.getAttribute("rList");
    List<CertificationDTO> cList = (List<CertificationDTO>) request.getAttribute("cList");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style>
        .flex_container{
            display: flex;
            border:100px solid white;
        }
        .flex-item{
            margin:5px;
            width: 200px;
            height: 200px;
        }

        #index { display: none; }
        #index:checked ~ .divider { display: block; }
        .divider { display: none; }

        #check-btn { display: none; }
        #check-btn:checked ~ .menubars { display: block; }
        .menubars { display: none; }

        #check-btn2 { display: none; }
        #check-btn2:checked ~ .menubars2 { display: block; }
        .menubars2 { display: none; }

        #check-btn3 { display: none; }
        #check-btn3:checked ~ .menubars3 { display: block; }
        .menubars3 { display: none; }

        #check-btn4 { display: none; }
        #check-btn4:checked ~ .menubars4 { display: block; }
        .menubars4 { display: none; }

        #check-btn5 { display: none; }
        #check-btn5:checked ~ .menubars5 { display: block; }
        .menubars5 { display: none; }

        #check-btn6 { display: none; }
        #check-btn6:checked ~ .menubars6 { display: block; }
        .menubars6 { display: none; }

        #check-btn7 { display: none; }
        #check-btn7:checked ~ .menubars7 { display: block; }
        .menubars7 { display: none; }

        #check-btn8 { display: none; }
        #check-btn8:checked ~ .menubars8 { display: block; }
        .menubars8 { display: none; }

        #check-btn9 { display: none; }
        #check-btn9:checked ~ .menubars9 { display: block; }
        .menubars9 { display: none; }

        #check-btn10 { display: none; }
        #check-btn10:checked ~ .menubars10 { display: block; }
        .menubars10 { display: none; }

        #check-btn11 { display: none; }
        #check-btn11:checked ~ .menubars11 { display: block; }
        .menubars11 { display: none; }

    </style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코스 조회</title>

</head>
<body>
<div class="w3-center w3-large w3-margin-top">
    <input type="checkbox" id="index"><strong>종주코스</strong></input>
    <button type="button" class="btn btn-primary" onclick="">테마코스</button>
    <button type="button" class="btn btn-primary" onclick="">종주인증소</button>
</div>
<div class="flex_container">
<div class="flex-item">
    <ul class="divider">
    <%
        for (int i = 0; i < rList.size(); i++) {
            CourseDTO rDTO = rList.get(i);
            if (Objects.equals(rDTO.getCourseDiv(), "종주코스")) {
    %>
    <li><a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a></li></br>
            <%}%>
        <%}%>
    </ul>
</div>
<div class="flex-item">
    <%
        for (int i = 0; i < rList.size(); i++) {
            CourseDTO rDTO = rList.get(i);
            if (Objects.equals(rDTO.getCourseDiv(), "테마코스")) {
    %>
    <a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a></br>
        <%}%>
    <%}%>
</div>
<div class="flex-item">
<input id="check-btn" type="checkbox"/>
<label for="check-btn">금강</label>
<ul class="menubars">
    <%
        for (int i = 0; i < cList.size(); i++) {
            CertificationDTO cDTO = cList.get(i);
            if (Objects.equals(cDTO.getCourseName(), "금강"))
            {
    %>
    <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
    <%}%>

    <%}%>
</ul></br>
    <input id="check-btn2" type="checkbox" />
    <label for="check-btn2">낙동강</label>
    <ul class="menubars2">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "낙동강"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>
    <input id="check-btn3" type="checkbox" />
    <label for="check-btn3">동해안</label>
    <ul class="menubars3">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "동해안"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>
    <input id="check-btn4" type="checkbox" />
    <label for="check-btn4">북한강</label>
    <ul class="menubars4">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "북한강"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>
    <input id="check-btn5" type="checkbox" />
    <label for="check-btn5">새재길</label>
    <ul class="menubars5">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "새재길"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn6" type="checkbox" />
    <label for="check-btn6">섬진강</label>
    <ul class="menubars6">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "섬진강"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn7" type="checkbox" />
    <label for="check-btn7">아라뱃길</label>
    <ul class="menubars7">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "아라뱃길"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn8" type="checkbox" />
    <label for="check-btn8">영산강</label>
    <ul class="menubars8">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "영산강"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn9" type="checkbox" />
    <label for="check-btn9">오천</label>
    <ul class="menubars9">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "오천"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn10" type="checkbox" />
    <label for="check-btn10">제주환상</label>
    <ul class="menubars10">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "제주환상"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>

    <input id="check-btn11" type="checkbox" />
    <label for="check-btn11">한강</label>
    <ul class="menubars11">
        <%
            for (int i = 0; i < cList.size(); i++) {
                CertificationDTO cDTO = cList.get(i);
                if (Objects.equals(cDTO.getCourseName(), "한강"))
                {
        %>
        <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
        <%}%>

        <%}%>
    </ul></br>
</div>
</div>
</body>
</html>