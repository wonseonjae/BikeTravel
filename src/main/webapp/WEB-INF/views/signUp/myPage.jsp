
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

    .list {
        -webkit-transform-style: preserve-3d;
        -moz-transform-stle: preserve-3d;
        -ms-transform-style: preserve-3d;
        -o-transform-style: preserve-3d;
        transform-style: preserve-3d;
        text-transform: uppercase;
        top: 20%;
        width: 100%;
        heigt: 690px
    }
    .list a {
        display: block;
        color: black;
        width: 100%;
        height: 50px;
    }

    .list a:hover {
        text-indent: 20px;
    }

    .list dt{
        text-indent: 10px;
        line-height: 55px;
        background: #E0FBAC;
        margin: 0;
        width: 100%;
        color: black;
    }
    .list dd {
        text-indent: 10px;
        line-height: 55px;
        background: #E0FBAC;
        margin: 0;

        width: 100%;
        color: black;
    }

    .list dt {
        /* Since we're hiding elements behind here, we need it in 3d */
        -webkit-transform: translateZ(0.3px);
        -moz-transform: translateZ(0.3px);
        -ms-transform: translateZ(0.3px);
        -o-transform: translateZ(0.3px);
        transform: translateZ(0.3px);
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        font-size: 32px;
    }

    .list dd {
        border-top: 1px dashed brown;
        line-height: 35px;
        font-size: 24px;

        margin: 0;
    }
    /* Individual styles */
    .maki dt, .maki dd, .maki a { background: whitesmoke; }
    .maki a:hover { background: sandybrown; }
    .maki {
        left: 50%;
        width: 100%;
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
                        <a style="font-size: 20px" onclick="mainWrapper2()">
                            내 완주 코스
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <main style="height: 690px" class="col-md-9 col-lg-10 px-md-4">
            <div id="myPage" style="display: none; width: 690px" class="col-md-7 col-lg-8">
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
            <div id="JongjuCourse" style="display: none;width: 890px; height: 690px" class="col-md-7 col-lg-8"> <!--종주 코스별로 내가 가본 종주소는 색깔채워주기 -->
                <section class="demo">
                    <dl class="list maki" style="overflow-y: scroll;overflow-x: scroll">
                        <dt>내 완주 코스</dt>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=금강 종주자전거길','코스조회','width= height=800')">금강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=낙동강 종주자전거길','코스조회','width= height=800')">낙동강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('//bike/stampBook?courseName=동해안(강원) 자전거길','코스조회','width= height=800')">동해안(강원) 자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=북한강 종주자전거길','코스조회','width= height=800')">북한강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=새재 종주자전거길','코스조회','width= height=800')">새재 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=섬진강 종주자전거길','코스조회','width= height=800')">섬진강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=아라 종주자전거길','코스조회','width= height=800')">아라 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=영산강 종주자전거길','코스조회','width= height=800')">영산강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=오천자전거길','코스조회','width= height=800')">오천자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=제주환상자전거길','코스조회','width= height=800')">제주환상자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=한강 종주자전거길','코스조회','width= height=800')">한강 종주자전거길</a></dd>
                        <dd><a href="#" onclick="window.open('/bike/stampBook?courseName=한국폴리텍 강서캠퍼스','코스조회','width= height=800')">한국폴리텍 강서캠퍼스</a></dd>
                    </dl>
                </section>
            </div>
            <div id="bikeDistance" style="display: block; height: 690px;width: 1000px"> <!--fullcalender 활용해서 그날 탄 자전거거리 표시 -->
                <h2 class="mb-3">내가 탄 자전거 거리</h2>
                <hr class="my-4">
                    <div id='calendar' style="overflow-y:scroll;">
                    </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>