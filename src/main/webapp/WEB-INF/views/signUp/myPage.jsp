
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page import="kopo.poly.dto.BikeCertificateDTO" %>
<%@ page import="kopo.poly.dto.BikeDistanceDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        List<CertificationDTO> rList = (List<CertificationDTO>) request.getAttribute("rList");
        List<BikeCertificateDTO> dList = (List<BikeCertificateDTO>) request.getAttribute("cList");



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="/js/fullcalendar.js" type="text/javascript"></script>
    <script src="/js/ko.js" type="text/javascript"></script>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <title>마이페이지</title>
</head>
<style>
    @font-face {
        font-family: 'RixInooAriDuriR';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2207-01@1.0/RixInooAriDuriR.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
    }

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

    #check-btn12 { display: none; }
    #check-btn12:checked ~ .menubars12 { display: block; }
    .menubars12 {display: none; }

    ul{
        list-style:none;
        font-size: 24px;
    }
    #ex1 {

    }
</style>

    <script>
        function chgName() {
            window.open('/admin/chgName','이름변경','width=800px,height=400px')
        }
        function deleteUser() {
            if (confirm('정말 탈퇴하시겠습니까?')===true){
                location.href="/deleteUser?user_no=<%=uDTO.getUser_no()%>"
            }
        }
        function mainWrapper(){
            document.getElementById("myPage").style.display="block"
            document.getElementById("JongjuCourse").style.display="none"
            document.getElementById("bikeDistance").style.display="none"
            document.getElementById("myChart").style.display="none";

        }
        function mainWrapper2(){
            document.getElementById("myPage").style.display="none"
            document.getElementById("JongjuCourse").style.display="block"
            document.getElementById("bikeDistance").style.display="none"
            document.getElementById("myChart").style.display="none";

        }
        function mainWrapper3(){
            document.getElementById("myPage").style.display="none"
            document.getElementById("JongjuCourse").style.display="none"
            document.getElementById("bikeDistance").style.display="block"
            document.getElementById("myChart").style.display="none";
        }
        document.addEventListener('DOMContentLoaded', function () {
            $(function () {
                var request = $.ajax({
                    url: "/bike/selectDistance", // 변경하기
                    method: "GET",
                    data: {"club_no":<%=uDTO.getUser_no()%>},
                    dataType: "json"
                });
                request.done(function (data) {
                    var calendarEl = document.getElementById('calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        height:'580px',
                        initialView: 'dayGridMonth',
                        headerToolbar: {
                            left: 'prev,next,today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek,dayGridDay'
                        },
                        editable: true,
                        droppable: true, // this allows things to be dropped onto the calendar
                        locale:'ko',
                        timeZone: 'Asia/Seoul',
                        selectable: true,
                        selectMirror: true,
                        events: data
                    });
                    calendar.render();
                });
                request.fail(function( jqXHR, textStatus ) {
                    alert( "Request failed: " + textStatus );
                });
            });
        });

    </script>
<body>

<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>

</header>
<div style="padding-top: 20px;padding-left: 5%">
    <h3>마이페이지</h3>
</div>

<div style="padding-left: 5%" class="container-fluid">
    <div class="row">
        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3 sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a style="font-size: 20px" onclick="mainWrapper()">
                            내 정보
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="layers" class="align-text-bottom"></span>
                            <hr/>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a style="font-size: 20px" onclick="mainWrapper3()">
                            내가 탄 자전거 거리
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="layers" class="align-text-bottom"></span>
                            <hr/>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a style="font-size: 20px" onclick="mainWrapper2()">
                            내 완주 코스
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <main style="height: 690px" class="col-md-9 col-lg-10 px-md-4">
            <div id="myPage" style="display: block; width: 690px" class="col-md-7 col-lg-8">
                <h2 class="mb-3">내 정보</h2>
                <hr class="my-4">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <br/>
                        <h4 class="mb-3">이름</h4>
                        <br/>
                        <p style="font-size: 20px;font-weight: bold"><%=uDTO.getUser_name()%>&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn" onclick="chgName()"><strong style="color:blue">변경</strong></a></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <br/>
                        <h4 class="mb-3">이메일</h4>
                        <br/>
                        <p style="font-size: 20px;font-weight: bold"><%=uDTO.getUser_mailid()%>@<%=uDTO.getUser_maildomain()%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <br/>
                        <h4 class="mb-3">아이디</h4>
                        <br/>
                        <p style="font-size: 20px;font-weight: bold"><%=uDTO.getUser_id()%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <br/>
                        <h4 class="mb-3">가입일</h4>
                        <br/>
                        <p style="font-size: 20px;font-weight: bold"><%=uDTO.getRegdate().substring(0,10)%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <a onclick="window.open('/pwCheck','비밀번호 변경','width=600 height=400')">비밀번호 변경</a><a>&nbsp;&nbsp;||&nbsp;&nbsp;</a><a onclick="deleteUser()">회원탈퇴</a>
                    </div>
                </div>
                <hr class="my-2">
            </div>
            <div id="JongjuCourse" style="display: none; height: 690px" class="col-md-7 col-lg-8"> <!--종주 코스별로 내가 가본 종주소는 색깔채워주기 -->
                <h2 class="mb-3">내가 가본 종주 코스</h2>
                <hr class="my-4">
                <div class="row g-3" style="overflow-x:scroll; overflow-y: scroll; height: 580px;">
                    <input id="check-btn" type="checkbox"/>
                    <label for="check-btn">금강 종주자전거길</label><hr>
                    <ul class="menubars" style="margin-top: 0">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                        <%
                            for (CertificationDTO cDTO : rList) {
                                if (Objects.equals(cDTO.getCourseName(), "금강 종주자전거길")) {
                                    for (BikeCertificateDTO dDTO : dList) {
                                        if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                        %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                                <%}else {%>
                                <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                                </div>&nbsp;

                                    <%}
                                }
                            %>
                            <%}%>
                            <%}%>
                        <br/>
                            </div>
                    </ul>
                    <br/>
                    <input id="check-btn2" type="checkbox" />
                    <label for="check-btn2">낙동강 종주자전거길</label><hr>
                    <ul class="menubars2">
                        <div style="display: flex; width: 3000px; height : 150px; border-top: solid #0d6efd 5px;border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "낙동강 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul>
                    <br>
                    <input id="check-btn3" type="checkbox" />
                    <label for="check-btn3">동해안(강원) 자전거길</label><hr>
                    <ul class="menubars3">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "동해안(강원) 자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul><br>
                    <input id="check-btn4" type="checkbox" />
                    <label for="check-btn4">북한강 종주자전거길</label><hr>
                    <ul class="menubars4">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "북한강 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul><br>
                    <input id="check-btn5" type="checkbox" />
                    <label for="check-btn5">새재 종주자전거길</label><hr>
                    <ul class="menubars5">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "새재 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul><br>
                    <input id="check-btn6" type="checkbox" />
                    <label for="check-btn6">섬진강 종주자전거길</label><hr>
                    <ul class="menubars6">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "섬진강 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul></br>

                    <input id="check-btn7" type="checkbox" />
                    <label for="check-btn7">아라 종주자전거길</label><hr>
                    <ul class="menubars7">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "아라 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="padding-top:50px;font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul></br>

                    <input id="check-btn8" type="checkbox" />
                    <label for="check-btn8">영산강 종주자전거길</label><hr>
                    <ul class="menubars8">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "영산강 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul></br>

                    <input id="check-btn9" type="checkbox" />
                    <label for="check-btn9">오천자전거길</label><hr>
                    <ul class="menubars9">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "오천자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul></br>

                    <input id="check-btn10" type="checkbox" />
                    <label for="check-btn10">제주환상자전거길</label><hr>
                    <ul class="menubars10">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "제주환상자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="margin-top:50px; font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul></br>

                    <input id="check-btn11" type="checkbox" />
                    <label for="check-btn11">한강 종주자전거길</label><hr>
                    <ul class="menubars11">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "한강 종주자전거길")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul>
                    </br>
                    <input id="check-btn12" type="checkbox" />
                    <label for="check-btn12">한국폴리텍 강서캠퍼스</label><hr>
                    <ul class="menubars12">
                        <div style="display: flex; width: 3000px; height : 150px;border-top: solid #0d6efd 5px; border-bottom: solid #0d6efd 5px">
                            <%
                                for (CertificationDTO cDTO : rList) {
                                    if (Objects.equals(cDTO.getCourseName(), "한국폴리텍 강서캠퍼스")) {
                                        for (BikeCertificateDTO dDTO : dList) {
                                            if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {

                            %>
                            <div style="font-family: 'RixInooAriDuriR';background: url('https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png') center no-repeat; background-size: 400px 120px; align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%><br/><%=dDTO.getReg_dt()%></div>&nbsp;
                            <%}else {%>
                            <div style="font-family: 'RixInooAriDuriR';align-items: center;border: 5px solid red;width: 400px;height: 100px;font-size: 28px;text-align: center;"><%=cDTO.getCheckPoint()%>
                            </div>&nbsp;

                            <%}
                            }
                            %>
                            <%}%>
                            <%}%>
                            <br/>
                        </div>
                    </ul>
                    </br>
                </div>
                <hr class="my-2">
            </div>
            <div id="bikeDistance" style="display: none; height: 690px" class="col-md-7 col-lg-8"> <!--fullcalender 활용해서 그날 탄 자전거거리 표시 -->
                <h2 class="mb-3">내가 탄 자전거 거리</h2>
                <hr class="my-4">
                    <div id='calendar' style="overflow-y: scroll; height: 580px; width: 1000px">
                    </div>
                <hr class="my-2">
            </div>
        </main>
    </div>
</div>

</body>
</html>