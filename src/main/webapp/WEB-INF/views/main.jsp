<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.NoticeDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
   List<NoticeDTO> rList = (List<NoticeDTO>) request.getAttribute("rList");

   if (rList == null) {
      rList = new ArrayList<NoticeDTO>();

   }

   int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
   if (session.getAttribute("user")==null) {
      edit = 3;
   } else {
      UserDTO uDTO = (UserDTO) session.getAttribute("user");
      int ss_user_no = uDTO.getUser_no();
//로그인 안했다면....

   }

   int rep = 0;
   if (session.getAttribute("user")!=null) {
      UserDTO uDTO = (UserDTO) session.getAttribute("user");
      rep = uDTO.getUser_no();


   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
   <link rel="shortcut icon" href="#">
   <!-- Google fonts-->
   <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
   <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" type="text/javascript"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
   <link href="/css/modal.css" rel="stylesheet" />
   <link href="/css/jumbotron.css" rel="stylesheet" />
   <script type="text/javascript" src="/js/bootstrap.js"></script>
   <link href="/css/clock.css" rel="stylesheet">
   <link href="/css/table.css" rel="stylesheet">
   <script type="text/javascript">
      //openweather 날씨 호출 api
      function showLocation(event) {
         var latitude = event.coords.latitude
         var longitude = event.coords.longitude
         let apiKey = "cb52d54e328d4cac58b024400099907c"
         let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=" + latitude
                 + "&lon=" + longitude
                 + "&appid=" + apiKey;

         let options = { method: 'GET' }
         $.ajax(weatherUrl, options).then((response) => {
            console.log(response)
            let icon = response.weather[0].icon
            let name = response.name
            document.querySelector("#region").textContent = name
            let iconUrl = "http://openweathermap.org/img/wn/" + icon + "@4x.png"
            let img = document.querySelector("#icon")
            img.src = iconUrl
            const roundNum = ((response.main.temp-273).toFixed(1));
            document.querySelector("#temp").textContent = roundNum+ "℃"
         }).catch((error) => {
            console.log(error)
         })
      }

      //geolocation 에러
      function showError(event) {
         alert("위치 정보를 얻을 수 없습니다.")
      }

      //메인페이지 호출시 geolocation 실행
      window.addEventListener('load', () => {
         if(window.navigator.geolocation) {
            window.navigator.geolocation.getCurrentPosition(showLocation,showError)
         }
      })
      //디지털 시계
      function setClock(){
         var dateInfo = new Date();
         var hour = modifyNumber(dateInfo.getHours());
         var min = modifyNumber(dateInfo.getMinutes());
         var sec = modifyNumber(dateInfo.getSeconds());
         var year = dateInfo.getFullYear();
         var month = dateInfo.getMonth()+1; //monthIndex를 반환해주기 때문에 1을 더해준다.
         var date = dateInfo.getDate();
         document.getElementById("time").innerHTML = hour + ":" + min  + ":" + sec;
         document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";
      }
      function modifyNumber(time){
         if(parseInt(time)<10){
            return "0"+ time;
         }
         else
            return time;
      }
      window.onload = function(){
         setClock();
         setInterval(setClock,1000); //1초마다 setClock 함수 실행
      }

      function noticeDetail(bNo) {
         console.log(bNo)
         let url = "/noticeDetail?bNo="+bNo
         window.open(url,'공지','width=1000, height=800')
      }
      </script>
   <style type="text/css">
      body{
         padding-top: 85px;
      }
      ul, li{
         list-style:none;
         text-align:center;
         padding:0;
         margin:0;
      }
      #mainWrapper{
         width: 100%;
         margin: 0 auto; /*가운데 정렬*/
      }

      #mainWrapper > ul > li:first-child {
         text-align: center;
         font-size:14pt;
         height:40px;
         vertical-align:middle;
         line-height:30px;
      }

      #ulTable {margin-top:10px;}


      #ulTable > li:first-child > ul > li {
         background-color:#c9c9c9;
         font-weight:bold;
         text-align:center;
      }

      #ulTable > li > ul {
         clear:both;
         padding:0px auto;
         position:relative;
         min-width:40px;
      }
      #ulTable > li > ul > li {
         float:left;
         font-size:10pt;
         border-bottom:1px solid silver;
         vertical-align:baseline;
      }

      #ulTable > li > ul > li:first-child           	{width:15%;} /*No 열 크기*/
      #ulTable > li > ul > li:first-child +li       	{width:35%;} /*제목 열 크기*/
      #ulTable > li > ul > li:first-child +li+li    	{width:30%;} /*코스명 열 크기*/
      #ulTable > li > ul > li:first-child +li+li+li 	{width:20%;} /*작성자 열 크기*/


      #divPaging {
         clear:both;

         width:100%;
         height:50px;
      }

      #divPaging > div {

         width: 30px;
         margin:0 auto;
         text-align:center;
      }
      #divPaging > .write {
         float:left;
         width: 70px;
         margin:0 auto;
         text-align:center;
      }

      #liSearchOption {clear:both;}
      #liSearchOption > div {
         margin:0 auto;
         margin-top: 30px;
         width:auto;
         height:100px;

      }

      .left {
         text-align : left;
      }
      .modal{
         position: fixed;
         top: 50%;
         left: 50%;
         transform: translate(-50%, -50%);
         width: 70%;
         height: 70%;
      }
      .dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}
      .dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
      .dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
      .number {font-weight:bold;color:#ee6152;}
      .dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
      .distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
      .distanceInfo .label {display:inline-block;width:50px;}
      .distanceInfo:after {content:none;}
   </style>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
   <a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
   <div class="collapse navbar-collapse" id="navbarsExampleDefault">
      <ul class="navbar-nav mr-auto">
         <li class="nav-item active">
            <a class="nav-link" onclick="window.open('/weather/Form','기상조회','width=500 height=500')">기상조히</a>
         </li>
         <li class="nav-item active">
            <a class="nav-link" href="/board/list">후기게시판</a>
         </li>
         <li class="nav-item active">
            <a class="nav-link disabled" onclick="window.open('/course/index','코스조회','width= height=800')">코스조회</a>
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
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" onclick="window.open('/admin','관리자 페이지','width=1000 height=1200')">관리자 페이지</a></li>
            <%}%>
         </ul>
      </form>
   </div>
</nav>
<main role="main">
   <div class="jumbotron" style="height: 300px; background-color: #a1b4af">
      <div class="container">
         <h1 class="display-3">자전거 여행</h1>
         <br>
         <h4>전국 자전거 코스 한눈에 알아보기</h4>
         <br>
         <br>
      </div>
   </div>
   <div style="height: 50px">
      <br/>
   </div>

      <div class="row" style="margin-left: 20%; margin-right: 10%">
         <div class="col-md-2">
            <h2>코스조회</h2>
            <p>종주코스, 테마코스를 확인해보세요</p>
            <p><a class="btn btn-secondary" onclick="window.open('/course/index','코스조회','width=600 height=800')" role="button">바로가기 &raquo;</a></p>
         </div>
         <div class="col-md-2">
            <h2>후기게시판</h2>
            <p>코스 후기를 같이 공유해 주세요</p>
            <p><a class="btn btn-secondary" href="/board/list" role="button">바로가기 &raquo;</a></p>
         </div>
         <div class="col-md-2">
            <h2>기상조회</h2>
            <p>출발전에 날씨를 확인해보세요</p>
            <p><a class="btn btn-secondary" onclick="window.open('/html/today_weather.html','기상조회','width=1025, height=800, scrollbars=no, resizable=no, toolbars=no, menubar=no')" role="button">바로가기 &raquo;</a></p>
         </div>
         <div class="col-md-2">
            <h2>동호회</h2>
            <p>마음이 맞는분들과 함께해보세요</p>
            <p><a class="btn btn-secondary" href="/club/list" role="button">바로가기 &raquo;</a></p>
         </div>
         <div class="col-md-2">
            <h2>도전 10KM</h2>
            <p>하루에 10KM씩 도전해 보세요.</p>
            <p><a class="btn btn-secondary" role="button" onclick="window.open('/bike/getDistanceForm','거리 측정','width=600, height=600, scrollbars=no, resizable=no, toolbars=no, menubar=no')">바로가기 &raquo;</a></p>

         </div>
         <div class="col-md-2">
            <h2>자전거 대여소 알아보기</h2>
            <p>전국 자전거 대여소 알아보기</p>
            <p><a class="btn btn-secondary" role="button" onclick="window.open('/course/bikeRental','자전거 대여소','width=800, height=600, scrollbars=no, resizable=no, toolbars=no, menubar=no')">바로가기 &raquo;</a></p>

         </div>
         <div style="text-align: center" class="col-md-6">
            <div style="text-align: center" id="mainWrapper">
               <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                  <h1 class="h2">공지</h1>&nbsp;&nbsp;
                  <%if (session.getAttribute("user") != null){
                     UserDTO uDTO = (UserDTO) session.getAttribute("user");
                     if (Objects.equals(uDTO.getAuthority(), "ADMIN")){%>
                  <a href="/admin/noticeInsertForm">공지 등록</a>
                  <%
                        }
                     }%>
               </div>
               <ul>
                  <ul id ="ulTable">
                     <li>
                        <ul>
                           <li>공지번호</li>
                           <li>제목</li>
                           <li>작성자</li>
                           <li>작성일</li>
                        </ul>
                     </li>
                     <!-- 게시물이 출력될 영역 -->
                     <%
                        for (int i = 0; i < rList.size(); i++) {
                           NoticeDTO rDTO = rList.get(i);

                           if (rDTO == null) {
                              rDTO = new NoticeDTO();
                           }

                     %>
                     <li>
                        <ul>
                           <li><%=CmmUtil.nvl(String.valueOf(rDTO.getNotice_no()))%></li>
                           <li><a href="javascript:noticeDetail('<%=rDTO.getNotice_no()%>');">
                              <%=CmmUtil.nvl(rDTO.getTitle())%>
                           </a></li>
                           <li><%=rDTO.getAdminname()%></li>
                           <li><%=rDTO.getRegdate().substring(0,10)%></li>
                        </ul>
                     </li>
                     <%
                        }
                     %>
                  </ul>
                  <!-- 게시판 페이징 영역 -->
                  <li>
                     <div style="text-align: center;" id="divPaging">
                        <div><strong>[</strong></div>
                        <!-- 각 번호 페이지 버튼 -->
                        <c:forEach var="num" begin="${noticePageMake.startPage}" end="${noticePageMake.endPage}">
                           <div><a href="/main?tNo=${num}" class="num">${num}</a></div>
                        </c:forEach>
                        <div><strong>]</strong></div>
                     </div>
                  </li>
               </ul>
            </div>
         </div>
         <div style="text-align: center" class="col-md-6">
            <br>
            <h3><strong>현재 날씨</strong></h3>
            <br>
            <h1 id="region"></h1><br>
            <img id="icon" src=""><br>
            <h3 id="temp"></h3>
            <h1 id="date" class="date"></h1>
            <h1 id="time" class="time"></h1>
         </div>

   </div>
   <!-- /container-->
</main>

</body>
</html>