<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.CourseDTO" %>
<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
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
            max-width: 100%;
        }
        a{
            color: #1b1c1d;
            text-decoration: none;
            font-size: 24px;
        }
        label{
            font-size: 24px;
        }
        .flex-item{
            display: flex;
            width: 100%;
            height: 80%;
        }
        ul{
            list-style: none;
            padding-left: 0;
        }
        ul.menubars{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 500px;
            width: 100%;
        }
        ul.menubars li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 18px;
        }
        ul.menubars li:last-child{
            border-bottom: 0px;
        }
        ul.menubars li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars2{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 250px;
            width: 100%;
        }
        ul.menubars2 li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 12px;
        }
        ul.menubars2 li:last-child{
            border-bottom: 0px;
        }
        ul.menubars2 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars3{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 250px;
            width: 100%;
        }
        ul.menubars3 li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 12px;
        }
        ul.menubars3 li:last-child{
            border-bottom: 0px;
        }
        ul.menubars3 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars4{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 250px;
            width: 100%;
        }
        ul.menubars4 li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 12px;
        }
        ul.menubars4 li:last-child{
            border-bottom: 0px;
        }
        ul.menubars4 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars5{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 250px;
            width: 100%;
        }
        ul.menubars5 li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #efefef;
            font-size: 12px;
        }
        ul.menubars5 li:last-child{
            border-bottom: 0px;
        }
        ul.menubars5 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars6{
            list-style: none;
            margin: 0px;
            padding: 0px;
            max-width: 500px;
            width: 100%;
        }
        ul.menubars6 li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #6c4e4e;
            font-size: 18px;
        }
        ul.menubars6 li:last-child{
            border-bottom: 0px;
        }
        ul.menubars6 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        .btn{
            background-color: #FFFFFF;
            border-right: #1b1c1d;
            border-bottom: #1b1c1d;
            width: 30%;
            font-size: 20px;
        }
        #check-btn { display: none; }
        #check-btn:checked ~ .menubars { display: block; }
        .menubars{ display: none;
        }

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
        .menubars11 {display: none; }

        ul{
            list-style:none;
            font-size: 24px;
        }
    </style>
    <script>

        function jongjuList(){
            document.getElementById("jonJu").style.display="block"
            document.getElementById("theme").style.display="none"
            document.getElementById("certification").style.display="none"

        }
        function themeList(){
            document.getElementById("jonJu").style.display="none"
            document.getElementById("theme").style.display="block"
            document.getElementById("certification").style.display="none"

        }
        function certificationList(){
            document.getElementById("jonJu").style.display="none"
            document.getElementById("theme").style.display="none"
            document.getElementById("certification").style.display="block"
        }
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코스 조회</title>

</head>
<body>
<div class="flex_container">
    <button type="button" class="btn" onclick="jongjuList()">종주코스</button>
    <button type="button" class="btn" onclick="themeList()">테마코스</button>
    <button type="button" class="btn" onclick="certificationList()">종주인증소</button>
    <br>
    <br>
    <div class="flex-item" style="display: block" id="jonJu">
        <%if (session.getAttribute("user")!=null){
            UserDTO uDTO = (UserDTO) session.getAttribute("user");
            if (uDTO.getAuthority().equals("ADMIN")){
        %>
        <a style="font-size: 28px" onclick="location.href='/course/courseForm'">코스등록</a><br>
        <%
                }
            }
        %>
        <ul class="divider">
            <%
                for (int i = 0; i < rList.size(); i++) {
                    CourseDTO rDTO = rList.get(i);
                    if (Objects.equals(rDTO.getCourseDiv(), "종주코스")) {
            %>
            <li><a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a></li><hr>
            <%}%>
            <%}%>
        </ul>
    </div>
    <div class="flex-item" style="display: none" id="theme">
        <%if (session.getAttribute("user")!=null){
            UserDTO uDTO = (UserDTO) session.getAttribute("user");
            if (uDTO.getAuthority().equals("ADMIN")){
        %>
        <a style="font-size: 28px;" onclick="location.href='/course/courseForm'">코스등록</a><br>
        <%
                }
            }
        %>
        <ul>
            <%
                for (int i = 0; i < rList.size(); i++) {
                    CourseDTO rDTO = rList.get(i);
                    if (Objects.equals(rDTO.getCourseDiv(), "테마코스")) {
            %>
            <a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a><hr>
            <%}%>
            <%}%>
        </ul>
    </div>
    <div class="flex-item" style="display: none;" id="certification">
        <%if (session.getAttribute("user")!=null){
            UserDTO uDTO = (UserDTO) session.getAttribute("user");
            if (uDTO.getAuthority().equals("ADMIN")){
        %>
        <a style="font-size: 28px" onclick="location.href='/course/certificateForm'">종주인증소 등록</a><br><br><hr>
        <%
                }
            }
        %>
        <input id="check-btn" type="checkbox"/>
        <label for="check-btn">금강 종주자전거길</label><hr>
        <ul class="menubars" style="margin-top: 0">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "금강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul>
        </br>
        <input id="check-btn2" type="checkbox" />
        <label for="check-btn2">낙동강 종주자전거길</label><hr>
        <ul class="menubars2">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "낙동강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul>
        <br>
        <input id="check-btn3" type="checkbox" />
        <label for="check-btn3">동해안(강원) 자전거길</label><hr>
        <ul class="menubars3">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "동해안(강원) 자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>
            <%}%>
        </ul><br>
        <input id="check-btn4" type="checkbox" />
        <label for="check-btn4">북한강 종주자전거길</label><hr>
        <ul class="menubars4">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "북한강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul><br>
        <input id="check-btn5" type="checkbox" />
        <label for="check-btn5">새재 종주자전거길</label><hr>
        <ul class="menubars5">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "새재 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul><br>

        <input id="check-btn6" type="checkbox" />
        <label for="check-btn6">섬진강 종주자전거길</label><hr>
        <ul class="menubars6">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "섬진강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul></br>

        <input id="check-btn7" type="checkbox" />
        <label for="check-btn7">아라 종주자전거길</label><hr>
        <ul class="menubars7">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "아라 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul></br>

        <input id="check-btn8" type="checkbox" />
        <label for="check-btn8">영산강 종주자전거길</label><hr>
        <ul class="menubars8">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "영산강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul></br>

        <input id="check-btn9" type="checkbox" />
        <label for="check-btn9">오천자전거길</label><hr>
        <ul class="menubars9">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "오천자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul></br>

        <input id="check-btn10" type="checkbox" />
        <label for="check-btn10">제주환상자전거길</label><hr>
        <ul class="menubars10">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "제주환상자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>

            <%}%>
        </ul></br>

        <input id="check-btn11" type="checkbox" />
        <label for="check-btn11">한강 종주자전거길</label><hr>
        <ul class="menubars11">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "한강 종주자전거길"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>
            <%}%>
        </ul>
        </br>
    </div>
</div>
</body>
</html>