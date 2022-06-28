<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Weather</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

    <script type='text/javascript'>
        function sidoCheck(){
            let i = document.getElementById("step3").selectedIndex // 선택항목의 인덱스 번호
            let sido = document.getElementById("step3").options[i].value // 선택항목 value
            document.getElementById("sido").value=sido
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
        function getWeather(){
            $('#result').empty();
            let data = new Array();
            let obj = new Object();
            let datePick =document.getElementById('datepicker').value;
            if (datePick === ""){
                alert('날짜를 선택해주시기 바랍니다.')
                return
            }
            let tm = document.getElementById('time').value;
            if (tm === ""){
                alert('시간을 선택해주시기 바랍니다.')
                return
            }
            let grX = document.getElementById('gridX').value;
            if (grX === ""){
                alert('지역을 선택해주시기 바랍니다.')
                return
            }
            let grY = document.getElementById('gridY').value;
            if (grX === ""){
                alert('지역을 선택해주시기 바랍니다.')
                return
            }
            let sd = document.getElementById('sido').value;
            if (grX === ""){
                alert('지역을 선택해주시기 바랍니다.')
                return
            }
            obj.date = datePick
            obj.time = tm
            obj.gridX = grX
            obj.gridY = grY
            obj.sido = sd
            data.push(obj);
            console.log(data);
            $.ajax({
                url: "/weatherReg",
                data: JSON.stringify(data),
                dataType:"JSON",
                method:"POST",
                contentType: 'application/json',
                success : function(res){
                    res.forEach(function (result) {
                        let time = result.time.substr(0,2);
                        $('#result').append('<hr>')
                        $('#result').append('<h4>'+result.sido+'&nbsp;'+result.gungu+'&nbsp;'+result.dong+'&nbsp;'+time+'시 날씨입니다'+'</h4>')
                        if (result.pty=="0"){
                            $('#result').append('<a>맑음</a><img width="50px" height="50px" src="/image/맑음.JPG">'+'&nbsp;'+'&nbsp;')
                        }else if (result.pty=="1") {
                            $('#result').append('<a>비</a><img width="50px" height="50px" src="/image/비.JPG">'+'&nbsp;'+'&nbsp;')
                        }else if (result.pty=="4") {
                            $('#result').append('<a>소나기</a><img width="50px" height="50px" src="/image/소나기.JPG">'+'&nbsp;'+'&nbsp;')
                        }

                        if (result.reh <=40){
                            $('#result').append('<a>습도 : 건조('+result.reh+'%)</a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.reh >40 && result.reh <=60){
                            $('#result').append('<a>습도 : 적정('+result.reh+'%)</a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.reh >60) {
                            $('#result').append('<a>습도 : 습함('+result.reh+'%)</a>'+'&nbsp;'+'&nbsp;')
                        }

                        if (result.vec <=90){
                            $('#result').append('<a>풍향 : 북동 </a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.vec >90 && result.vec <=180){
                            $('#result').append('<a>풍향 : 남동 </a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.vec >180 && result.vec <=270){
                            $('#result').append('<a>풍향 : 남서 </a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.vec > 270 && result.vec <=360){
                            $('#result').append('<a>풍향 : 북서 </a>'+'&nbsp;'+'&nbsp;')
                        }

                        if (result.wsd <= 14){
                            $('#result').append('<a>풍속 : 보통('+result.wsd+'m/s)</a>'+'&nbsp;'+'&nbsp;')
                        }else if (result.wsd > 14){
                            $('#result').append('<a>풍속 : 강풍('+result.wsd+'m/s)</a>'+'&nbsp;'+'&nbsp;')
                        }


                    });
                }


                })

        }
    </script>
    <style>
        .w-btn {
            position: relative;
            border: none;
            display: inline-block;
            padding: 15px 30px;
            border-radius: 15px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 600;
            transition: 0.25s;
        }
        .w-btn-brown {
            background-color: #ce6d39;
            color: #ffeee4;
        }
    </style>


    </head>

<body>

        <div class="form-group">
            <input id="sido" name ="sido" type="hidden">
            <span>시/도</span>
            <select style="max-width: 80px" id="step1" name="step1" class="emptyCheck" title="시/도">
                <option id="city" value="">시/도</option>
            </select>
            <span>시/군/구</span>
            <select id="step2" style="max-width: 80px">
                <option id="county" value="">시/군/구</option>
            </select>
            <span>읍/면/동</span>
            <select style="max-width: 80px" id="step3" name="step3" onchange="sidoCheck()">
                <option id="town" value="">읍/면/동</option>
            </select>
            <input type="hidden" id="gridX" name="gridX">
            <input type="hidden" id="gridY" name="gridY">
            <input type="hidden" id="datePick" name="datePick">
            <br>
            <br>
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
            <button class="w-btn w-btn-brown" type="button" onclick="getWeather()">
                기상조회
            </button>
        </div>

        <div id="result" name="result" class="result">

        </div>

</body>
</html>