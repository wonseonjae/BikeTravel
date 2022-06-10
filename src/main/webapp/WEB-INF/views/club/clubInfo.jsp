<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kopo.poly.dto.ClubDTO" %>
<%@ page import="kopo.poly.dto.ClubListDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
    ClubListDTO rDTO = (ClubListDTO) request.getAttribute("rDTO");
    List<ClubDTO> rList = (List<ClubDTO>) request.getAttribute("rList");
    String user_name = "";
    if (session.getAttribute("user")!=null) {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        user_name = uDTO.getUser_name();
        int isAdm = 0;
        if (uDTO.getUser_no()== rDTO.getPresident_num()){
            isAdm = 1;
        }
    }

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
            location.href="/club/clubEditInfo?cNo="+cNo
        }
        function goAccept(cNo){
            <%if (session.getAttribute("user")!=null) {
                UserDTO uDTO = (UserDTO) session.getAttribute("user");

                if (rDTO.getPresident_num() == uDTO.getUser_no()){
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
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <style>
        #calendar {
            background-color : #ffffff;
            max-width: 1100px;
            margin: 40px auto;

        }
        #form-div {
            background-color: '';
            padding:5px 5px 5px;
            width: 100%;
            margin-top:5px;
            -moz-border-radius: 7px;
            -webkit-border-radius: 7px;
        }

        .feedback-input {
            color:#3c3c3c;
            font-family: Helvetica, Arial, sans-serif;
            font-weight:400;
            font-size: 11px;
            border-radius: 0;
            line-height: 22px;
            background-color: #ffffff;
            padding: 3px 3px 3px 6px;
            margin-bottom: 10px;
            width:100%;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -ms-box-sizing: border-box;
            box-sizing: border-box;
            border: 3px solid rgba(0,0,0,0);
        }

        .feedback-input:focus{
            background: #fff;
            box-shadow: 0;
            /*border: 3px solid #3498db;*/
            border-color: #3498db;
            color: #3498db;
            outline: none;
            /*padding: 13px 13px 13px 54px;*/
        }

        .focused {
            color:#30aed6;
            border:#30aed6 solid 3px;
        }

        /* Icons */
        #name{
            background-image: url(http://rexkirby.com/kirbyandson/images/name.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        #email{
            background-image: url(http://rexkirby.com/kirbyandson/images/email.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        #comment{
            background-image: url(http://rexkirby.com/kirbyandson/images/comment.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        textarea {
            width: 100%;
            height: 150px;
            line-height: 150%;
            resize:vertical;
        }

        input:hover, textarea:hover,
        input:focus, textarea:focus {
            background-color:white;
        }

        #button-blue{
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
            float:left; /* 플롯 중요(::after 가상요소 이용)*/
            width: 100%;
            border: #fbfbfb solid 4px;
            cursor:pointer;
            background-color: #3498db;
            color:white;
            font-size:24px;
            padding-top:22px;
            padding-bottom:22px;
            -webkit-transition: all 0.3s;
            -moz-transition: all 0.3s;
            transition: all 0.3s;
            margin-top:-4px;
            font-weight:700;
        }

        #button-blue:hover{
            background-color: rgba(0,0,0,0);
            color: #0493bd;
        }

        .ease {
            width: 0;
            height: 74px;
            background-color: #fbfbfb;
            -webkit-transition: .3s ease;
            -moz-transition: .3s ease;
            -o-transition: .3s ease;
            -ms-transition: .3s ease;
            transition: .3s ease;
        }

        .submit:hover .ease{
            width:100%;
            background-color:white;
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
        var ctx ="${path}";
        var edit = true;

        var diaLogOpt={
            modal:true        //모달대화상자
            ,resizable:false  //크기 조절 못하게
            , width : "570"   // dialog 넓이 지정
            , height : "470"  // dialog 높이 지정
        };
        var calFunc ={
            calcDate: function(arg,calendar){
                var rObj = new Object();
                var start  = null;
                var end    = null;
                var allDay = arg.allDay;
                var startDisp =null;
                var endDisp = null;
                var id = null;
                var xcontent = null;
                var title = null;
                //============================== date get / set ======================================

                if(arg.id!=""&& arg.id!=null && arg.id!=undefined) id=arg.id;
                if(arg.title!=""&& arg.title!=null && arg.title!=undefined) title=arg.title;
                if(arg.extendedProps!=undefined){
                    if(arg._def.extendedProps.xcontent!=""&& arg._def.extendedProps.xcontent!=null && arg._def.extendedProps.xcontent!=undefined){
                        xcontent=arg._def.extendedProps.xcontent;
                    }
                }

                if(allDay){//하루종일이면
                    var start = arg.start.toISOString().slice(0,10); //returnCdate(calendar,arg.start);
                    var end=null;
                    if(arg.end!=""&& arg.end!=null && arg.end!=undefined){
                        end    = arg.end.toISOString().slice(0,10);  //실제 데이터는 날짜를 하루 빼지 않는다
                    }
                    if(start==end) end=null;  //같은날이면 end날짜 없음

                    startDisp = start;
                    if(end!=null) endDisp = dateRel(arg.end.toISOString().slice(0,10)); //알릴때만 날짜 하루 빼기
                }else{//시간이 같이 들어오면
                    start = arg.start.toISOString();
                    if(arg.end!=""&& arg.end!=null && arg.end!=undefined){
                        end   = arg.end.toISOString();
                    }
                    startDisp = returnCdate(calendar,arg.start);
                    if(end!=null) endDisp = returnCdate(calendar,arg.end);
                }
                rObj.start=start;
                rObj.end=end;
                rObj.start=start;
                rObj.startDisp=startDisp;
                rObj.endDisp=endDisp;
                rObj.id=id;
                rObj.xcontent=xcontent;
                rObj.title=title;
                //============================== date get / set ======================================
                return rObj;
            },


//등록초기
            setDateRangeView :function(xobj){
                var dispStr = xobj.startDisp;
                if(xobj.endDisp!=null) dispStr+=" ~ "+xobj.endDisp;

                $("form#diaForm").find("input[name='xdate']").val(dispStr);
                $("form#diaForm").find("input[name='start']").val(xobj.start);
                $("form#diaForm").find("input[name='end']").val(xobj.end);
                $("form#diaForm").find("input[name='actType']").val("C"); //등록
            },


            //form안에 name값을 $obj에 주입
            getFormValue :function(){
                var $dForm =$("form#diaForm");
                var $obj = new Object();
                $("form#diaForm").find("input,textarea,select").each(function(){
                    var xval = $(this).val();
                    $obj[$(this).attr("name")]=xval;
                });

                return $obj;
            },

            //모든 태그 비활성화
            formDsbTrue :function(){
                $("form#diaForm").find("input,textarea,select").each(function(){
                    $(this).attr("disabled",true);
                });
            },


            //모든 태그 활성화
            formDsbFalse :function(){
                $("form#diaForm").find("input,textarea,select").each(function(){
                    $(this).attr("disabled",false);
                });
            },

            //데이터 조회
            setDataForm :function(xobj){
                var dispStr = xobj.startDisp;
                if(xobj.endDisp!=null) dispStr+=" ~ "+xobj.endDisp;

                $("form#diaForm").find("input[name='xdate']").val(dispStr);
                $("form#diaForm").find("input[name='start']").val(xobj.start);
                $("form#diaForm").find("input[name='end']").val(xobj.end);
                $("form#diaForm").find("input[name='actType']").val("U"); //수정


                $("form#diaForm").find("input[name='id']").val(xobj.id);
                $("form#diaForm").find("input[name='title']").val(xobj.title);
                $("form#diaForm").find("textarea[name='xcontent']").val(xobj.xcontent);
            }
        };
        //calFunc[e]




        //등록 액션
        function createClnd(cal,xobj){
            if(!confirm("일정을 등록 하시겠습니까?")) return false;
            var $obj = calFunc.getFormValue();

            $.ajax({
                url: ctx+"/adms/calendar/management/create_ajx.do",
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                data:JSON.stringify($obj)
            }).done(function(data) {
                var result = jQuery.parseJSON(data);
                //모든 소스에서 이벤트를 다시 가져와 화면에 다시 렌더링
                cal.refetchEvents();
            }).fail(function(e) {
                alert("실패하였습니다."+e);
            }).always(function() {
                $("#name").val("");
                $("#comment").val("");
            });

        }
        //수정액션
        function updateClnd(cal,xobj,event){
            if(!confirm("해당일정을 정말로 수정 하시겠습니까?")){
                if(event!=undefined) event.revert();
                return false;
            }
            var $obj = calFunc.getFormValue();

            $.ajax({
                url: ctx+"/adms/calendar/management/update_ajx.do",
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                data:JSON.stringify($obj)
            }).done(function(data) {
                var result = jQuery.parseJSON(data);
                cal.refetchEvents();
            }).fail(function(e) {
                alert("실패하였습니다."+e);
            }).always(function() {
                $("#name").val("");
                $("#comment").val("");
            });
        }

        //삭제액션
        function deleteClnd(cal,xobj){
            if(!confirm("해당일정을 정말로 삭제 하시겠습니까?")) return false;

            var $obj = calFunc.getFormValue();
            $.ajax({
                url: ctx+"/adms/calendar/management/delete_ajx.do",
                type: "POST",
                contentType: "application/json;charset=UTF-8",
                data:JSON.stringify($obj)
            }).done(function(data) {
                var result = jQuery.parseJSON(data);
                cal.refetchEvents();
            }).fail(function(e) {
                alert("실패하였습니다."+e);
            }).always(function() {
                $("#name").val("");
                $("#comment").val("");
            });
        }
        //=========================================== function ===========================================

        //관리자만 ,주,일 옵션 뷰
        var rightm = "";
        rightm+=',listWeek';

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
                            left: 'today',
                            center: 'prev,title,next',
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
                <a class="nav-link disabled" href="/weather/Form">기상조회</a>
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
                    <h2><strong>Menu</strong></h2>
                </div>
                <div class="control-box p-3 mt-3 sidebar">
                    <ul>
                        <%if (session.getAttribute("user") != null) {
                            UserDTO uDTO = (UserDTO) session.getAttribute("user");
                            for (int i = 0; i < rList.size(); i++) {
                                if (rList.get(i).getUser_no() == uDTO.getUser_no()){

                        %>
                        <li><a href="/club/memberList">회원조회</a></li>
                        <%
                                    }else {%>

                                    <%}
                                }
                            }%>
                        <%if (session.getAttribute("user") != null) {
                            UserDTO uDTO = (UserDTO) session.getAttribute("user");
                            if (uDTO.getUser_no() == rDTO.getPresident_num()) {
                            %>
                        <li><a href="javascript:goAccept(<%=rDTO.getClub_no()%>)">회원 가입승인</a></li>
                       <% }}%>
                        <%if (session.getAttribute("user") != null) {
                            UserDTO uDTO = (UserDTO) session.getAttribute("user");
                            for (int i = 0; i < rList.size(); i++) {
                                if (rList.get(i).getUser_no() == uDTO.getUser_no()){

                        %>
                        <li><a href="javascript:goPost()">동호회 대화방</a></li>
                        <%
                                    }else {
                                    }
                                }
                            }%>
                    </ul>

                </div>
            </div>
            <div class="col-md-8">
                <div class="control-box p-2 breadcrumb">
                    <h3>동호회장 : </h3><h3><%=rDTO.getClub_president()%>&nbsp;&nbsp;&nbsp;&nbsp;</h3><h3>Hp : </h3><h3><%=rDTO.getPresident_phonenum()%></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%if (session.getAttribute("user") != null) {
                        UserDTO uDTO = (UserDTO) session.getAttribute("user");
                        for (int i = 0; i < rList.size(); i++) {
                            if (rList.get(i).getUser_no() == uDTO.getUser_no()){
                                break;
                            }else {
                    %>
                    <a href="/club/joinApply?club_no=<%=rDTO.getClub_no()%>" align="right" style="font-size: 24px">가입신청</a>
                    <%
                                break;
                            }
                            }
                        }%>

                </div>
                <div class="control-box p-3 main-content">
                    <%
                        if (rDTO.getImgLink() != null) {
                    %>
                    <img src="<%=rDTO.getImgLink()%>" height="300px" width="300px">
                    <%}%>
                    <p><%=rDTO.getClub_intro()%></p>
                    <% if (session.getAttribute("user") !=null) {
                        UserDTO uDTO = (UserDTO) session.getAttribute("user");
                        if (uDTO.getUser_no() == rDTO.getPresident_num()) {
                    %>
                    <a href="Javascript:doUpdate(<%=rDTO.getClub_no()%>)">[수정]</a>
                    <%
                        }
                    }
                    %>

                </div>
            </div>
        </div>
    </div>
</div>
    <br/>
<div id="contents">
    <div id="dialog" title="일정 관리" style="display:none;">
        <div id="form-div">
            <form class="diaForm" id="diaForm" >
                <input type="hidden" name="actType" value="C" /> <!-- C:등록 U:수정 D:삭제 -->
                <input type="hidden" name="id" value="" />
                <input type="hidden" name="start" value="" />
                <input type="hidden" name="end" value="" />

                <p class="name">
                    <input name="title" type="text" class="validate[required,custom[onlyLetter],length[0,100]] feedback-input" placeholder="일정타이틀" id="name" />
                </p>

                <p class="email">
                    <input name="xdate" type="text" readonly="readonly" class="validate[required,custom[email]] feedback-input"  placeholder="선택된날짜 및 시간" />
                </p>

                <p class="text">
                    <textarea name="xcontent" class="validate[required,length[6,300]] feedback-input" id="comment" placeholder="일정내용"></textarea>
                </p>
            </form>
        </div>
    </div>
    <br/>
    <div id='calendar'></div>
</div>




</body>
</html>
