<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorator="board/layout/defaultLayout">

<head>
    <title>Weather</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>

    <script>
        function mailcheck(){
            let i = document.join.step3.selectedIndex // 선택항목의 인덱스 번호
            let sido = document.join.step3.options[i].value // 선택항목 value
            document.join.sido.value=sido
        }
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
    <%--<script>
        function getWeather() {
            let xhr = new XMLHttpRequest();
            let gridX = document.getElementById("coordX").value;
            let gridY = document.getElementById("coordY").value;
            let day = document.getElementById("datepicker").value;
            let time = document.getElementById("time").value;
            let url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst'; /*URL*/
            let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'7EpF3TCkgMENfaz3eaLHbldfYrPuDMZRi2IEbYu1fGqnoUxT5ZB6xm28C3Xv6TB2IegtMlKzIlLLNExhFq1FsQ%3D%3D'; /*Service Key*/
            queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
            queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /**/
            queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON'); /**/
            queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(day); /**/
            queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(time); /**/
            queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent(gridX); /**/
            queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent(gridY); /**/
            xhr.open('GET', url + queryParams);
            xhr.onreadystatechange = function () {
                if (this.readyState == 4) {
                    alert(' nBody: '+this.responseText);
                    let header = JSON.stringify(this.responseText);
                    $('input[name=weather]').attr('nbody',header);
                }
            };

            xhr.send();
        }
    </script>--%>
    </head>

<body>
    <form name="join" class="form-horizontal" method="get" action="/weatherReg">
        <div class="form-group">
            <input id="sido" name ="sido" type="hidden">
            <select id="step1" name="step1" class="emptyCheck" title="시/도">
                <option id="city" value="">시/도</option>
            </select>
            <select id="step2">
                <option id="county" value="">시/군/구</option>
            </select>
            <select id="step3" name="step3" onChange="mailcheck()">
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

</body>
</html>