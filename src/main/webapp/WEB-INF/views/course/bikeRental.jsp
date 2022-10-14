<%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-10-05
  Time: 오전 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>자전거 대여소</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <style>
        .search-box {
            background-color: #949BA0;
            height: 40px;
            padding: 10px;
        }
        .search-txt {
            width: 90%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
        }
        .search-btn {
            color: #EDEDED;
            float: right;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>

</head>
<body>
<div class="search-box">
        <input class="search-txt" type="text" id="searchBar" onkeypress="if (event.keyCode==13){getLocation();}" placeholder="지역을 입력해주세요">
        <button class="search-btn"  onclick="getLocation()" ><img style="width: 30px;height: 30px;text-align: center" src="/image/search.jpg"/></button>
</div>
<br/>
<div id="map2" style="width:100%;height:500px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3113b55ca889a7c68dfb770c6a6ff2d4&libraries=services"></script>
<script type="text/javascript">

    navigator.geolocation.getCurrentPosition(function(position) {

        let latitude = position.coords.latitude; // 위도
        let longitude = position.coords.longitude; // 경도

        let mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div
            mapOption2 = {
                center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
                level: 8 // 지도의 확대 레벨
            };
        let map2 = new kakao.maps.Map(mapContainer2, mapOption2);

        markerSet();

        function markerSet(){
            $.ajax({
                url: "/weather/getRental",
                type: "get",
                dataType: "JSON",
                success: function (data) {
                    $.each(data, function (index, val){

                        let markerPosition  = new kakao.maps.LatLng(val.latitude, val.longitude);

// 마커를 생성합니다
                        let marker = new kakao.maps.Marker({
                            position: markerPosition
                        });

                        let address;

                        if (val.lnmadr === null){
                            address = val.rdnmadr;
                        }else {
                            address = val.lnmadr;
                        }
// 마커가 지도 위에 표시되도록 설정합니다
                        marker.setMap(map2);

                        let iwContent = '<div style="padding:5px;">' +
                                '<p> 자전거 대여소 : '+val.bcyclLendNm +'</p>'+
                                '<p> 주소 : '+ address +'</p>' +
                                '<p> 운영시간 : '+val.operOpenHm + '~' + val.operCloseHm +'</p>' +
                                '<p> 휴무일 : '+ val.rstde +'</p>' +
                                '<p> 요금 : '+ val.bcyclUseCharge +'</p>' +
                                '<p> 전화번호 : '+ val.phoneNumber +'</p>' +
                                '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                            iwPosition = new kakao.maps.LatLng(val.latitude, val.longitude); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
                        let infowindow = new kakao.maps.InfoWindow({
                            position : iwPosition,
                            content : iwContent
                        });

// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                        kakao.maps.event.addListener(marker, 'mouseover', function() {
                            // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
                            infowindow.open(map2, marker);
                        });

// 마커에 마우스아웃 이벤트를 등록합니다
                        kakao.maps.event.addListener(marker, 'mouseout', function() {
                            // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                            infowindow.close();
                        });

                    });
                }

            })
        }
    });
    function getLocation(){
        let address = document.getElementById("searchBar").value
        console.log(address)
        if (address===""){
            alert('검색어를 입력해주세요')
            return false
        }
        let geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(address, function(result, status) {
            let y = result[0].y
            let x = result[0].x
            let mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div
                mapOption2 = {
                    center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
                    level: 8 // 지도의 확대 레벨
                };
            let map2 = new kakao.maps.Map(mapContainer2, mapOption2);

            markerSet();

            function markerSet(){
                $.ajax({
                    url: "/weather/getRental",
                    type: "get",
                    dataType: "JSON",
                    success: function (data) {
                        $.each(data, function (index, val){

                            let markerPosition  = new kakao.maps.LatLng(val.latitude, val.longitude);

// 마커를 생성합니다
                            let marker = new kakao.maps.Marker({
                                position: markerPosition
                            });

                            let address;

                            if (val.lnmadr === null){
                                address = val.rdnmadr;
                            }else {
                                address = val.lnmadr;
                            }
// 마커가 지도 위에 표시되도록 설정합니다
                            marker.setMap(map2);

                            let iwContent = '<div style="padding:5px;">' +
                                    '<p> 자전거 대여소 : '+val.bcyclLendNm +'</p>'+
                                    '<p> 주소 : '+ address +'</p>' +
                                    '<p> 운영시간 : '+val.operOpenHm + '~' + val.operCloseHm +'</p>' +
                                    '<p> 휴무일 : '+ val.rstde +'</p>' +
                                    '<p> 요금 : '+ val.bcyclUseCharge +'</p>' +
                                    '<p> 전화번호 : '+ val.phoneNumber +'</p>' +
                                    '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                                iwPosition = new kakao.maps.LatLng(val.latitude, val.longitude); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
                            let infowindow = new kakao.maps.InfoWindow({
                                position : iwPosition,
                                content : iwContent
                            });

// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                            kakao.maps.event.addListener(marker, 'mouseover', function() {
                                // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
                                infowindow.open(map2, marker);
                            });

// 마커에 마우스아웃 이벤트를 등록합니다
                            kakao.maps.event.addListener(marker, 'mouseout', function() {
                                // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                                infowindow.close();
                            });

                        });
                    }

                })
            }
        });
    }
</script>

</body>
</html>
