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
    </script>
    <title><%=rDTO.getClub_name()%></title>
    <script>
        function doDelete(cNo){
            if (confirm('<%=rDTO.getClub_name()%> 동호회를 삭제하시겠습니까?')){
                location.href="/admin/clubDelete?cNo="+cNo
            }

        }
    </script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <style>
        #calendar {
            background-color : #ffffff;
            max-width: 1100px;
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
    <script src="/js/fullcalendar.js"></script>
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
                    console.log(data); // log 로 데이터 찍어주기.
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
    <a class="navbar-brand" href="#">관리자페이지</a>
    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">

            </li>
            <li class="nav-item active">

            </li>
            <li class="nav-item active">

            </li>
            <li class="nav-item active">

            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">[목록]</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="Javascript:doDelete(<%=rDTO.getClub_no()%>)">[삭제]</a></li>
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
            <div class="col-md-8">
                <div class="control-box p-2 breadcrumb">
                    <h3>동호회장 : </h3><h3><%=rDTO.getClub_president()%>&nbsp;&nbsp;&nbsp;&nbsp;</h3><h3>Hp : </h3><h3><%=rDTO.getPresident_phonenum()%></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
                    <h5>회원수 <%=rDTO.getMemberCnt()%>명</h5>

                </div>
                <div class="control-box p-3 main-content">
                    <%
                        if (rDTO.getImgLink() != null) {
                    %>
                    <img src="<%=rDTO.getImgLink()%>" style="width: available; height: available">
                    <%}%>
                    <p><%=rDTO.getClub_intro()%></p>

                </div>
            </div>
        </div><hr>
        <h3>동호회 일정</h3>
        <div id='calendar'></div>
    </div>
</div>
<br/>

</body>
</html>