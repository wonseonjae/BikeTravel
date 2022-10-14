<%@ page import="kopo.poly.dto.NoticeDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-10-06
  Time: 오전 8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%  int edit = 1;

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
<html>
<head>
    <title>거리 측정</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <style>
        @import url("https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap");


        button {
            margin-left: 25%;
        }

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


        .w-btn-indigo {
            background-color: aliceblue;
            color: #1e6b7b;
        }



        .w-btn:hover {
            letter-spacing: 2px;
            transform: scale(1.2);
            cursor: pointer;
        }


        .w-btn:active {
            transform: scale(1.5);
        }

        @keyframes gradient1 {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        @keyframes gradient2 {
            0% {
                background-position: 100% 50%;
            }
            50% {
                background-position: 0% 50%;
            }
            100% {
                background-position: 100% 50%;
            }
        }

        @keyframes ring {
            0% {
                width: 30px;
                height: 30px;
                opacity: 1;
            }
            100% {
                width: 300px;
                height: 300px;
                opacity: 0;
            }
        }
    </style>
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3113b55ca889a7c68dfb770c6a6ff2d4&libraries=services"></script>
<script type="text/javascript">
    var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
    var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
    var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
    var dots = []; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

    let mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    let map = new kakao.maps.Map(mapContainer, mapOption);

    let start = new Date();
    let startDate = moment(start).format('yyyy-MM-DDTHH:mm:ss.SSS');

    let watchID = navigator.geolocation.watchPosition((position) => {
        if (!navigator.geolocation) {
            alert("위치 정보가 지원되지 않습니다.")
        }
        let coords = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);
        map.setCenter(coords);
        map.relayout()
        getUserLocation(position.coords.latitude, position.coords.longitude);
    });

    function getUserLocation(latitude, longitude) {
        // 지도를 생성합니다

        let coords = new kakao.maps.LatLng(latitude, longitude);

        // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
        if (!drawingFlag) {

            // 상태를 true로, 선이 그리고있는 상태로 변경합니다
            drawingFlag = true;

            // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
            clickLine = new kakao.maps.Polyline({
                map: map, // 선을 표시할 지도입니다
                path: [coords], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                strokeWeight: 3, // 선의 두께입니다
                strokeColor: '#db4040', // 선의 색깔입니다
                strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });

            // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
            moveLine = new kakao.maps.Polyline({
                strokeWeight: 3, // 선의 두께입니다
                strokeColor: '#db4040', // 선의 색깔입니다
                strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });

            // 클릭한 지점에 대한 정보를 지도에 표시합니다
            displayCircleDot(coords, 0);


        } else { // 선이 그려지고 있는 상태이면

            // 그려지고 있는 선의 좌표 배열을 얻어옵니다
            let path = clickLine.getPath();

            // 좌표 배열에 클릭한 위치를 추가합니다
            path.push(coords);

            // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
            clickLine.setPath(path);

            let distance = Math.round(clickLine.getLength());
            displayCircleDot(coords, distance);
        }

        map.setCenter(coords);
        map.relayout()
    }

    // 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여
    // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
    function displayCircleDot(position, distance) {

        // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
        let circleOverlay = new kakao.maps.CustomOverlay({
            content: '<span class="dot"></span>',
            position: position,
            zIndex: 1
        });

        // 지도에 표시합니다
        circleOverlay.setMap(map);

        if (distance > 0) {
            $("#distance").empty();
            document.getElementById("dis").value = distance
            $("#distance").append("<h1>현재 주행 거리 : " + distance + "m</h1>");
        }

        // 배열에 추가합니다
        dots.push({circle:circleOverlay, distance: distanceOverlay});
    }
    function regDistance() {
        let distance = document.getElementById("dis").value
        console.log(distance)
        let end = new Date();
        let endDate = moment(end).format('yyyy-MM-DDTHH:mm:ss.SSS');
        console.log(distance)
        if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");
            return false;
        } else {
            $.ajax({
                url: "/bike/regDistance",
                type: "get",
                data: {
                    "distance": distance,
                    "startDate": startDate,
                    "endDate": endDate
                },
                success: function () {
                    alert('등록되었습니다.')
                    window.close()
                }
            })
        }
    }
    function setClock(){
        var dateInfo = new Date();
        var hour = modifyNumber(dateInfo.getHours());
        var min = modifyNumber(dateInfo.getMinutes());
        var sec = modifyNumber(dateInfo.getSeconds());
        document.getElementById("time").innerHTML = "시간 : " + hour + ":" + min  + ":" + sec;
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
</script>
<div>
    <div style="display: flex; border: 2px solid black">
    <h1 id="time" class="time"></h1>
    <div id="distance" style="text-align: right; width: 55%;" name="distance">

    </div>
</div>
    <button style="width: 300px; font-size: 36px" id="btn-Yes" class="w-btn w-btn-indigo" type="button" onclick="regDistance()">
        등 록
    </button>
    <input id="dis" type="hidden" value="0">
</div>
</body>
</html>
