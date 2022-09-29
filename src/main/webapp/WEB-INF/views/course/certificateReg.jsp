<%@ page import="java.util.Objects" %>
<%@ page import="kopo.poly.dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-09-14
  Time: 오후 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String address = (String) request.getAttribute("address");
    String checkPoint = (String) request.getAttribute("checkPoint");
%>
<html>
<head>
    <title>완주등록</title>
    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/album.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/css/blog.css"/>
    <style>
        @import url('//fonts.googleapis.com/earlyaccess/nanumpenscript.css');

        h1{
            font-family: 'Nanum Pen Script', cursive;
        }

    </style>
</head>
<body>
<div style="font-size: 18px" class="container">
    <header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
            <div style="font-size: 18px" class="col-4 pt-1">
                <a class="link-secondary" onclick="goList()">목록으로</a>
            </div>
        </div>
    </header>
</div>
<div style="height: 1000px" class="container">
    <h1 style="text-align: center"><%=checkPoint%></h1>
    <div id="map" style="width:100%;height:350px;"></div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3113b55ca889a7c68dfb770c6a6ff2d4&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
        var geocoder = new kakao.maps.services.Geocoder();
        // 지도를 생성합니다
        let map = new kakao.maps.Map(mapContainer, mapOption),
            customOverlay = new kakao.maps.CustomOverlay({}),
            infowindow = new kakao.maps.InfoWindow({removable: true});
            Initialization(map);
            getUserLocation();

        function Initialization(_map){
            map = _map;
        }

        // 주소-좌표 변환 객체를 생성합니다


        // 주소로 좌표를 검색합니다
        geocoder.addressSearch('<%=address%>', function(result, status) {

            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=checkPoint%></div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다

            }
        });

        let watchID = navigator.geolocation.watchPosition((position) => {
            if (!navigator.geolocation) {
                alert("위치 정보가 지원되지 않습니다.")
            }
            getUserLocation(position.coords.latitude, position.coords.longitude)
        });
        function getUserLocation(latitude, longitude) {

            var coords = new kakao.maps.LatLng(latitude, longitude);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;"></div>'
            });
            infowindow.open(map, marker);


            map.setCenter(coords);

            geocoder.addressSearch('<%=address%>', function(result, status) {
                console.log(latitude)
                console.log(result[0].y + 0.02)
                console.log(latitude >= result[0].y - 0.002)
                console.log(latitude <= result[0].y + 0.002)
                console.log(longitude >= result[0].x - 0.002)
                console.log(longitude <= result[0].x + 0.002)

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                    if ((latitude >= result[0].y - 0.002 && latitude <= result[0].y + 0.002) &&
                        (longitude >= result[0].x - 0.002 && longitude <= result[0].x + 0.002)){
                        if (!confirm('<%=checkPoint%>에 도착했습니다. 등록하시겠습니까?')) {
                            alert("등록하실려면 새로고침을 눌러주세요");
                        } else {
                            regCertificate()
                        }
                    }

            });

        }
        function regCertificate(){
            $.ajax({
                url: "/bike/regCertificate",
                type: "get",
                dataType:"JSON",
                data: {
                    "checkPoint" : <%=checkPoint%>
                },
                success: function (){
                    alert('등록되었습니다')

                }
            });
        }

        /*function drawLine(){
            $.getJSON("/json/course/한강(서울) 종주자전거길.json", function (geojson){
                let data = geojson.features;
                console.log(data)
                let name = '';
                let code = '';
                for(let i in data){
                    console.log(data[i].geometry.coordinates)

                };
            });
        }*/
    </script>
    </div>
</div>
</body>
</html>
