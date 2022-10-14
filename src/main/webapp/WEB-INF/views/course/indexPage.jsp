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
            max-width: 80%;
            width: 100%;
        }
        ul.menubars li{
            padding: 5px 0px 5px 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid black;
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
        ul.menubars7 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars8 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars9 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars10 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars11 li:before{
            content: ">";
            display: inline-block;
            vertical-align: middle;
            padding: 0px 5px 6px 0px;
        }
        ul.menubars12 li:before{
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

        #check-btn12 { display: none; }
        #check-btn12:checked ~ .menubars12 { display: block; }
        .menubars12 {display: none; }

        ul{
            list-style:none;
            font-size: 24px;
        }
        .custom-btn {
            width: 150px;
            height: 50px;
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            border-radius: 5px;
            padding: 10px 25px;
            font-family: 'Lato', sans-serif;
            font-weight: 500;
            background: transparent;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            display: inline-block;
            box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
            7px 7px 20px 0px rgba(0,0,0,.1),
            4px 4px 5px 0px rgba(0,0,0,.1);
            outline: none;
        }
        .btn-5 {
            width: 150px;
            height: 50px;
            line-height: 42px;
            padding: 0;
            border: none;
            background: rgb(255,27,0);
            background: linear-gradient(0deg, rgba(255,27,0,1) 0%, rgba(251,75,2,1) 100%);
        }
        .btn-5:hover {
            color: #f0094a;
            background: transparent;
            box-shadow:none;
        }
        .btn-5:before,
        .btn-5:after{
            content:'';
            position:absolute;
            top:0;
            right:0;
            height:2px;
            width:0;
            background: #f0094a;
            box-shadow:
                    -1px -1px 5px 0px #fff,
                    7px 7px 20px 0px #0003,
                    4px 4px 5px 0px #0002;
            transition:400ms ease all;
        }
        .btn-5:after{
            right:inherit;
            top:inherit;
            left:0;
            bottom:0;
        }
        .btn-5:hover:before,
        .btn-5:hover:after{
            width:100%;
            transition:800ms ease all;
        }
        .btn-3 {
            width: 150px;
            height: 50px;
            line-height: 42px;
            padding: 0;
            border: none;
            background: skyblue;
            background: linear-gradient(0deg, skyblue 0%, greenyellow 100%);
        }
        .btn-3:hover {
            color: #f0094a;
            background: transparent;
            box-shadow:none;
        }
        .btn-3:before,
        .btn-3:after{
            content:'';
            position:absolute;
            top:0;
            right:0;
            height:2px;
            width:0;
            background: #f0094a;
            box-shadow:
                    -1px -1px 5px 0px #fff,
                    7px 7px 20px 0px #0003,
                    4px 4px 5px 0px #0002;
            transition:400ms ease all;
        }
        .btn-3:after{
            right:inherit;
            top:inherit;
            left:0;
            bottom:0;
        }
        .btn-3:hover:before,
        .btn-3:hover:after{
            width:100%;
            transition:800ms ease all;
        }
        .btn-4 {
            width: 150px;
            height: 50px;
            line-height: 42px;
            padding: 0;
            border: none;
            background: skyblue;
            background: linear-gradient(0deg, sandybrown 0%, peachpuff 100%);
        }
        .btn-4:hover {
            color: #f0094a;
            background: transparent;
            box-shadow:none;
        }
        .btn-4:before,
        .btn-4:after{
            content:'';
            position:absolute;
            top:0;
            right:0;
            height:2px;
            width:0;
            background: #f0094a;
            box-shadow:
                    -1px -1px 5px 0px #fff,
                    7px 7px 20px 0px #0003,
                    4px 4px 5px 0px #0002;
            transition:400ms ease all;
        }
        .btn-4:after{
            right:inherit;
            top:inherit;
            left:0;
            bottom:0;
        }
        .btn-4:hover:before,
        .btn-4:hover:after{
            width:100%;
            transition:800ms ease all;
        }
    </style>
    <style type="text/css">
        .transition, p, ul li i:before, ul li i:after {
            transition: all 0.25s ease-in-out;
        }

        .flipIn, h1, ul li {
            animation: flipdown 0.5s ease both;
        }

        .no-select, h2 {
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        html {
            width: 100%;
            height: 100%;
            perspective: 900px;
            overflow-y: scroll;
            background-color: #dce7eb;
            font-family: "Titillium Web", sans-serif;
            color: rgba(48, 69, 92, 0.8);
        }

        body {
            min-height: 0;
            display: inline-block;
            position: relative;
            left: 50%;
            margin: 50px 0;
            transform: translate(-50%, 0);
            box-shadow: 0 10px 0 0 #ff6873 inset;
            background-color: #fefffa;
            max-width: 90%;
            padding: 5%;
        }

        @media (max-width: 550px) {
            body {
                box-sizing: border-box;
                transform: translate(0, 0);
                max-width: 100%;
                min-height: 100%;
                margin: 0;
                left: 0;
            }
        }

        h1, h2 {
            color: #ff6873;
        }

        h1 {
            text-transform: uppercase;
            font-size: 36px;
            line-height: 42px;
            letter-spacing: 3px;
            font-weight: 100;
        }

        h2 {
            font-size: 26px;
            line-height: 34px;
            font-weight: 300;
            letter-spacing: 1px;
            display: block;
            background-color: #fefffa;
            margin: 0;
            cursor: pointer;
        }

        p {
            color: rgba(48, 69, 92, 0.8);
            font-size: 17px;
            line-height: 26px;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
            max-height: 800px;
            opacity: 1;
            transform: translate(0, 0);
            margin-top: 14px;
            z-index: 2;
        }

        ul {
            list-style: none;
            perspective: 900px;
            padding: 0;
            margin: 0;
        }

        ul li {
            position: relative;
            padding: 0;
            margin: 0;
            padding-bottom: 4px;
            padding-top: 18px;
            border-top: 1px dotted #dce7eb;
        }

        ul li:nth-of-type(1) {
            animation-delay: 0.5s;
        }

        ul li:nth-of-type(2) {
            animation-delay: 0.75s;
        }

        ul li:nth-of-type(3) {
            animation-delay: 1.0s;
        }

        ul li:nth-of-type(4) {
            animation-delay: 1.25s;
        }

        ul li:nth-of-type(5) {
            animation-delay: 1.5s;
        }

        ul li:nth-of-type(6) {
            animation-delay: 1.75s;
        }

        ul li:nth-of-type(7) {
            animation-delay: 2s;
        }

        ul li:nth-of-type(8) {
            animation-delay: 2.25s;
        }

        ul li:nth-of-type(9) {
            animation-delay: 2.5s;
        }

        ul li:nth-of-type(10) {
            animation-delay: 2.75s;
        }

        ul li:nth-of-type(11) {
            animation-delay: 3s;
        }

        ul li:nth-of-type(12) {
            animation-delay: 3.25s;
        }

        ul li:nth-of-type(13) {
            animation-delay: 3.5s;
        }

        ul li:nth-of-type(14) {
            animation-delay: 3.75s;
        }

        ul li:last-of-type {
            padding-bottom: 0;
        }

        ul li i {
            position: absolute;
            transform: translate(-6px, 0);
            margin-top: 16px;
            right: 0;
        }

        ul li i:before, ul li i:after {
            content: "";
            position: absolute;
            background-color: #ff6873;
            width: 3px;
            height: 9px;
        }

        ul li i:before {
            transform: translate(-2px, 0) rotate(45deg);
        }

        ul li i:after {
            transform: translate(2px, 0) rotate(-45deg);
        }

        ul li input[type=checkbox] {
            position: absolute;
            cursor: pointer;
            width: 100%;
            height: 100%;
            z-index: 1;
            opacity: 0;
        }

        ul li input[type=checkbox]:checked ~ p {
            margin-top: 0;
            max-height: 0;
            opacity: 0;
            transform: translate(0, 50%);
        }

        ul li input[type=checkbox]:checked ~ i:before {
            transform: translate(2px, 0) rotate(45deg);
        }

        ul li input[type=checkbox]:checked ~ i:after {
            transform: translate(-2px, 0) rotate(-45deg);
        }

        @keyframes flipdown {
            0% {
                opacity: 0;
                transform-origin: top center;
                transform: rotateX(-90deg);
            }
            5% {
                opacity: 1;
            }
            80% {
                transform: rotateX(8deg);
            }
            83% {
                transform: rotateX(6deg);
            }
            92% {
                transform: rotateX(-3deg);
            }
            100% {
                transform-origin: top center;
                transform: rotateX(0deg);
            }
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
    <button class="custom-btn btn-5" onclick="jongjuList()"><span>종주코스</span></button>
    <button class="custom-btn btn-3" onclick="themeList()"><span>테마코스</span></button>
    <button class="custom-btn btn-4" onclick="certificationList()"><span>종주인증소</span></button>
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
            <li><a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a></li>
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
            <a href="/course/courseDetail?coursename=<%=rDTO.getCourseName()%>"><%=rDTO.getCourseName()%></a>
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
        <label for="check-btn">금강 종주자전거길</label><hr/>
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
        </ul>
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
        </ul>
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
        </ul>

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
        </ul>

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
        </ul>

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
        </ul>

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
        </ul>

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
        </ul>

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

        <input id="check-btn12" type="checkbox" />
        <label for="check-btn12">한국폴리텍 강서캠퍼스</label><hr>
        <ul class="menubars12">
            <%
                for (int i = 0; i < cList.size(); i++) {
                    CertificationDTO cDTO = cList.get(i);
                    if (Objects.equals(cDTO.getCourseName(), "한국폴리텍 강서캠퍼스"))
                    {
            %>
            <li><a href="/course/certificateDetail?checkPoint=<%=cDTO.getCheckPoint()%>"><%=cDTO.getCheckPoint()%></a></li>
            <%}%>
            <%}%>
        </ul>
    </div>
</div>
</body>
</html>