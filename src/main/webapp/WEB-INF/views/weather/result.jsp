<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   String gungu = (String) request.getAttribute("gungu");
   String sido = (String) request.getAttribute("sido");
   String dong = (String) request.getAttribute("dong");
   String asd = (String) request.getAttribute("time");
   String time = "";
   if (asd.substring(0) != "0") {
      time = asd.substring(0,2);
   }else {
      time = asd.substring(0,1);
   }
   String pty = (String) request.getAttribute("pty");
   String reh = (String) request.getAttribute("reh");
   String vec = (String) request.getAttribute("vec");
   String wsd = (String) request.getAttribute("wsd");
   String tH = (String) request.getAttribute("t1h");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>

   <script>
      window.onload = function() {
         $('#datepicker').datepicker({
            showOn: 'button',
            buttonImage: 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
            buttonImageOnly: true,
            showButtonPanel: true,
            dateFormat: 'yymmdd',
            minDate: "D",
            maxDate: 0,
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: "주",
            yearSuffix: '년',
            showMonthAfterYear: true,
            onSelect:function (d) {
               document.getElementById("datePick").value = d;

            }

         });



         loadArea('city');

         $('#step1').on("change", function() {
            loadArea('county', $(this));
         });

         $('#step2').on("change", function() {
            loadArea('town', $(this));
         });
         $('#step3').on("change", function() {
            getCoordinate();
         });
      };
      function getCoordinate() {
         let areacode = '';
         let cityCode = $('#step1 option:selected').val();
         let countyCode = $('#step2 option:selected').val();
         let townCode = $('#step3 option:selected').val();

         if (townCode == '' && countyCode == '') {
            areacode = cityCode;
         }
         else if(townCode == '' && countyCode != '') {
            areacode = countyCode;
         }
         else if(townCode != '') {
            areacode = townCode;
         }

         $.ajax({
                    url: "/getCoordinate",
                    data: {AR : areacode},
                    dataType: "JSON",
                    method: "POST",
                    success : function (data){
                       let gridX = data.gridX;
                       let gridY = data.gridY;
                       $('input[name=gridX]').attr('value',gridX);
                       $('input[name=gridY]').attr('value',gridY);


                    }

                 }


         )
      }

      function loadArea(type, element) {
         let value = $(element).find('option:selected').text();
         let data = {type : type, keyword : value};

         console.log(data);
         $.ajax({
            url: "/weatherStep",
            data: data,
            dataType: "JSON",
            method : "POST",
            success : function(res){
               if (type == 'city'){
                  res.forEach(function (city) {
                     $('#step1').append('<option value="'+city.areacode+'">'+city.step1+'</option>')
                  });
               }
               else if(type == 'county'){
                  $('#county').siblings().remove();
                  $('#town').siblings().remove();
                  res.forEach(function (county) {
                     $('#step2').append('<option value="'+county.areacode+'">'+county.step2+'</option>')
                  });
               }
               else{
                  $('#town').siblings().remove();
                  res.forEach(function (town) {
                     $('#step3').append('<option value="'+town.areacode+'">'+town.step3+'</option>')
                  });
               }
            },
            error : function(xhr){
               alert(xhr.responseText);
            }
         });
      }
   </script>
</head>
<body>
<form class="form-horizontal" method="get" action="/weatherReg">
   <div class="form-group">
      <select id="step1" class="emptyCheck" title="시/도">
         <option id="city" value="">시/도</option>
      </select>
      <select id="step2">
         <option id="county" value="">시/군/구</option>
      </select>
      <select id="step3">
         <option id="town" value="">읍/면/동</option>
      </select>
      <input type="hidden" id="gridX" name="gridX">
      <input type="hidden" id="gridY" name="gridY">
      <input type="hidden" id="datePick" name="datePick">
      <span>날짜 선택: <input type="text" id="datepicker" name="datepicker" disabled="disabled" title="날짜"></span>
      <select id="time" name="time" title="시간" class="form-control">
         <option value="" selected>시간</option>
         <c:forEach var="i" begin="0" end="23">
            <c:choose>
               <c:when test="${i lt 10 }">
                  <option value="0${i}00">0${i}시</option>
               </c:when>
               <c:otherwise>
                  <option value="${i}00">${i}시</option>
               </c:otherwise>
            </c:choose>
         </c:forEach>
      </select>

      <%--<button type="button" class="btn btn-primary waves-effect waves-light" onclick="getWeather()">
          <span>실행</span>
      </button>--%>
      <input type="submit" value="조회">
   </div>
</form>
<div>
   <h4><%=sido%>&nbsp;<%=gungu%>&nbsp;<%=dong%>의 <%=time%>시날씨입니다.</h4>
</div>
<div>
   <a>날씨 : </a>
   <%
      if (Integer.parseInt(pty) == 0) {

   %>
      <a>맑음</a><img width="50px" height="50px" src="/image/맑음.JPG">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%
      } else if (Integer.parseInt(pty) == 1){
   %>
      <a>비</a><img src="/image/비.JPG">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%
      } else if (Integer.parseInt(pty) == 5) {
   %>
      <a>소나기</a><img src="/image/소나기.JPG">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%
      }
   %>
   <a>기온 : <%=tH%>℃</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%
      if (Integer.parseInt(reh) <40) {
   %>
   <a>습도 : 건조(<%=reh%>%)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else if (Integer.parseInt(reh) >=40 && Integer.parseInt(reh) < 60) {%>
   <a>습도 : 적정(<%=reh%>%)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else {%>
   <a>습도 : 습함(<%=reh%>%)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%}%>
   <% if (Integer.parseInt(vec) <=90) {
      %>
   <a>풍향 : 북동 </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else if (Integer.parseInt(vec) <=180 && Integer.parseInt(vec) > 90){%>
   <a>풍향 : 남동</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else if (Integer.parseInt(vec) <=270 && Integer.parseInt(vec) > 180){%>
   <a>풍향 : 남서</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else{%>
   <a>풍향 : 북서</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%}%>
   <% if (Double.parseDouble(wsd) <=14) { %>
   <a>풍속 : 보통(<%=wsd%>m/s)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%} else if (Double.parseDouble(wsd) >14) {%>
   <a>풍속 : 강풍(<%=wsd%>m/s)</a>
   <%}%>
</div>
</body>
</html>