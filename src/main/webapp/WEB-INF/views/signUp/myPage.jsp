
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String user_mail = uDTO.getUser_mailid() + "@" + uDTO.getUser_maildomain();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="/js/fullcalendar.js" type="text/javascript"></script>
    <script src="/js/ko.js" type="text/javascript"></script>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <title>마이페이지</title>
</head>

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

        }
        function mainWrapper2(){
            document.getElementById("myPage").style.display="none"
            document.getElementById("JongjuCourse").style.display="block"
            document.getElementById("bikeDistance").style.display="none"

        }
        function mainWrapper3(){
            document.getElementById("myPage").style.display="none"
            document.getElementById("JongjuCourse").style.display="none"
            document.getElementById("bikeDistance").style.display="block"
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
<div style="padding-top: 20px">
    <h3>마이페이지</h3>
</div>

<div class="container-fluid">
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
                <div class="row g-3">

                </div>
                <hr class="my-2">
            </div>
            <div id="bikeDistance" style="display: none; height: 690px" class="col-md-7 col-lg-8"> <!--fullcalender 활용해서 그날 탄 자전거거리 표시 -->
                <h2 class="mb-3">내가 탄 자전거 거리</h2>
                <hr class="my-4">
                <div class="row g-3">
                    <div id='calendar' style="overflow-y: scroll; height: 400px">
                    </div>
                </div>
                <hr class="my-2">
            </div>
        </main>
    </div>
</div>

</body>
</html>