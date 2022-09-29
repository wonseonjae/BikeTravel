<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kopo.poly.dto.ClubDTO" %>
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.core.annotation.AliasFor" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
    ClubListDTO rDTO = (ClubListDTO) request.getAttribute("rDTO");
    List<ClubDTO> rList = (List<ClubDTO>) request.getAttribute("rList");
    UserDTO uDTO = (UserDTO) session.getAttribute("user");
    String user_name = uDTO.getUser_name();
%>

<html>
<head>
    <script>
        function goPost(){
            let f = document.createElement('form');
            let obj;
            obj = document.createElement('input');
            obj.setAttribute('type','hidden');
            obj.setAttribute('name','cName');
            obj.setAttribute('value','<%=rDTO.getClub_name()%>');
            let obj2;
            obj2 = document.createElement('input');
            obj2.setAttribute('type','hidden');
            obj2.setAttribute('name','uName');
            obj2.setAttribute('value','<%=user_name%>')
            f.appendChild(obj);
            f.appendChild(obj2);
            f.setAttribute('method','post');
            f.setAttribute('action','/club/chat');
            document.body.appendChild(f);
            f.submit();
        }
    </script>
    <title><%=rDTO.getClub_name()%></title>
    <script>
        function doUpdate(cNo){
            location.href="/club/clubUpdateForm?cNo="+cNo
        }
        function goAccept(cNo){
            <% if(session.getAttribute("user")!=null) {
                if(rDTO.getPresident_num() == uDTO.getUser_no()){
            %>
            window.open("/club/joinAcceptList?cNo=<%=rDTO.getClub_no()%>","승인대기리스트","width = 800, height = 500, top = 100, left = 200, location = no")
            <%      }else{%>
            alert("동호회장만 접근할수 있습니다.")
            <%      }
                }%>
        }
    </script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <script src="/js/fullcalendar.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <style>
        #calendar {
            background-color : #ffffff;
            max-width: 80%;
            margin: 40px auto;
        }
    </style>
    </style>
    <style>
        body {
            padding-top: 1.5rem;
            background: #c8fad5;
        }
        p {
            margin: 0;
        }
        .header {
            background: #c8fad5;
            padding: 20px 0;
            padding-top: 60px;
        }
        .control-box h2 {
            font-family: 'Roboto', sans-serif;
            font-weight: 300;
        }
        .control-box {
            border: 1px solid #dddcd8;
            background-color: #fff;
        }
        .control-box .links {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .control-box .links li {
            margin-bottom: 10px;
        }
        .control-box .links li a {
            color: #aa1212;
            text-decoration: underline;
        }
        .content {
            margin-top: 20px;
        }
        .breadcrumb p {
            font-family: 'Roboto', sans-serif;
            font-weight: 300;
            color: #777;
            font-size: 14px;
        }
        .breadcrumb p a {
            color: #aa1212;
        }
        .main-content h6 {
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            font-size: 27px;
            color: #000;
            margin-bottom: 20px;
        }
        .main-content p {
            font-size: 17px;
            color: #777;
            line-height: 29px;
            margin-bottom: 20px;
        }
        .main-content img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: auto;
        }
        .main-content h1 {
            margin-bottom: 20px;
        }
        .footer {
            margin-top: 40px;
            padding-top: 20px;
            padding-bottom: 20px;
            border-top: 1px solid #fff;
            background-color: #fff;
        }
        .footer ul {
            margin-bottom: 0;
        }
        .footer ul li a {
            color: #aa1212;
            font-size: 14px;
        }
    </style>
    <script src="/js/ko.js"></script>
    <script>
        //-------------------------------------------------------------------------------------------------
        document.addEventListener('DOMContentLoaded', function () {
            $(function () {
                var request = $.ajax({
                    url: "/club/getClubCalendar", // 변경하기
                    method: "GET",
                    data: {"club_no":<%=rDTO.getClub_no()%>},
                    dataType: "json"
                });
                request.done(function (data) {
                    var calendarEl = document.getElementById('calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        initialView: 'dayGridMonth',
                        headerToolbar: {
                            left: 'prev,next,today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek'
                        },
                        editable: true,
                        droppable: true, // this allows things to be dropped onto the calendar
                        locale:'ko',
                        timeZone: 'Asia/Seoul',
                        selectable: true,
                        selectMirror: true,
                        drop: function (arg) {
                            // is the "remove after drop" checkbox checked?
                            if (document.getElementById('drop-remove').checked) {
                                // if so, remove the element from the "Draggable Events" list
                                arg.draggedEl.parentNode.removeChild(arg.draggedEl);
                            }
                        },
                        select: function(arg) { // 캘린더에서 이벤트를 생성할 수 있다.
                            var title = prompt('일정명을 입력해주세요.');
                            if (title) {
                                calendar.addEvent({
                                    title: title,
                                    start: arg.start,
                                    end: arg.end,
                                    allDay: arg.allDay
                                })
                            }

                            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                            var obj = new Object();     // Json 을 담기 위해 Object 선언
                            obj.title = title; // 이벤트 명칭  ConsoleLog 로 확인 가능.
                            obj.start = arg.start; // 시작
                            console.log(arg.start)
                            obj.end = arg.end; // 끝
                            console.log(arg.end)
                            obj.club_no = <%=rDTO.getClub_no()%>
                            events.push(obj);
                            $(function saveData(jsondata) {
                                $.ajax({
                                    url: "/club/insertCalendar",
                                    method: "POST",
                                    dataType: "json",
                                    data: JSON.stringify(events),
                                    contentType: 'application/json',
                                })
                                // .done(function (events) {
                                //     // alert(events);
                                // })
                                // .fail(function (request, status, error) {
                                //      // alert("에러 발생" + error);
                                // });
                                calendar.unselect()

                            });
                        },
                        eventClick: function (info){
                            if(confirm("'"+ info.event.title +"'일정을 삭제하시겠습니까 ?")){
                                // 확인 클릭 시
                                info.event.remove();
                                console.log(info.event);
                                var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                                var obj = new Object();
                                obj.title = info.event._def.title;
                                obj.start = info.event._instance.range.start;
                                obj.end = info.event._instance.range.end;
                                obj.club_no = <%=rDTO.getClub_no()%>
                                    events.push(obj);
                                console.log(events);
                            }
                            $(function deleteData(){
                                $.ajax({
                                    url: "/club/deleteCalendar",
                                    method: "DELETE",
                                    dataType: "json",
                                    data: JSON.stringify(events),
                                    contentType: 'application/json',
                                })
                            })
                        },
                        /**
                         * data 로 값이 넘어온다. log 값 전달.
                         */
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
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/course/index">코스 조회<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/board/list">후기게시판</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link disabled" onclick="window.open('/weather/Form','기상조회','width=500 height=500')">기상조회</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link disabled" href="/club/list">동호회</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav ms-auto">
                <% if(session.getAttribute("user") == null){%>
                <li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
                <%}%>
                <!--<form  required oninput="Show()">-->
                <% if(session.getAttribute("user") != null){%>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">관리자 페이지</a></li>
                <%}%>
            </ul>
        </form>
    </div>
</nav>
<div>

</div>
<div class="header">
    <div class="container">
        <div class="row">
            <div class="col-6">
                <h1><%=rDTO.getClub_name()%></h1>
            </div>
        </div>
    </div>
</div>
<div class="content">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="control-box p-3">
                    <h2><strong>메뉴</strong></h2>
                </div>
                <div class="control-box p-3 mt-3 sidebar">
                    <ul>
                        <%if (session.getAttribute("user") != null) {
                            if (uDTO.getUser_no() == rDTO.getPresident_num()) {
                        %>
                        <li><a href="javascript:goAccept(<%=rDTO.getClub_no()%>)">회원 가입승인</a></li>
                        <% }}%>
                        <%if (session.getAttribute("user") != null) {
                            for (int i = 0; i < rList.size(); i++) {
                                if (rList.get(i).getUser_no() == uDTO.getUser_no()){
                        %>
                        <li><a href="javascript:goPost()">동호회 대화방</a></li>
                        <%
                                    }else {
                                    }
                                }
                            }%>
                        <%if (session.getAttribute("user") != null) {
                            for (int i = 0; i < rList.size(); i++) {
                                if (rList.get(i).getUser_no() == uDTO.getUser_no()){
                                    break;
                                }else {
                        %>
                        <a href="/club/joinApply?club_no=<%=rDTO.getClub_no()%>" align="right" >가입신청</a>
                        <%
                                        break;
                                    }
                                }
                            }%>

                    </ul>

                </div>
            </div>
            <div class="col-md-8">
                <div class="control-box p-2 breadcrumb">
                    <h3>동호회장 : <%=rDTO.getClub_president()%>&nbsp;&nbsp;&nbsp;&nbsp;</h3><h3>Hp : <%=rDTO.getPresident_phonenum()%></h3><br>
                    <h5>회원수 : <%=rDTO.getMemberCnt()%>명</h5>
                </div>
                <div class="control-box p-3 main-content">
                    <%
                        if (rDTO.getImgLink() != null) {
                    %>
                    <img src="<%=rDTO.getImgLink()%>" style="width: available; height: available">
                    <%}%>
                    <p><%=rDTO.getClub_intro()%></p>
                    <% if (session.getAttribute("user") !=null) {
                        if (uDTO.getUser_no() == rDTO.getPresident_num()) {
                    %>
                    <a href="Javascript:doUpdate(<%=rDTO.getClub_no()%>)">[수정]</a>
                    <%
                            }
                        }
                    %>

                </div>
            </div>
        </div><br>
        <%if (session.getAttribute("user") != null) {
            for (int i = 0; i < rList.size(); i++) {
                if (rList.get(i).getUser_no() == uDTO.getUser_no()){
        %>
        <h3>동호회 일정</h3><hr style="border: solid 5px saddlebrown">
        <div id='calendar'>
        </div>
        <%
                    }else {
                    }
                }
            }%>
    </div>
</div>
<br/>

</body>
</html>