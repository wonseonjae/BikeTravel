<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String club_no = (String) request.getAttribute("clubNo");
    UserDTO userDTO = (UserDTO) session.getAttribute("user");
    System.out.println(userDTO.getUser_name());
    String user_no = String.valueOf(userDTO.getUser_no());
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>동호회 가입</title>
    <!-- css 가져오기 -->
    <link rel="stylesheet" type="text/css" href="/css/semantic.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <!-- js 가져오기 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>

    <script>
        function doSubmit(f){

            if (f.address.value == ""){
                alert("주소를 입력해주시기 바랍니다.");
                f.address.focus();
                return false;
            }
            if (f.phonenumber.value == ""){
                alert("전화번호호 입력해주시기 바랍니다.");
                f.phonenumber.focus();
                return false;
            }
            if (f.phoneCheck.value !== 'Y'){
                alert("형식에 맞지 않는 전화번호 입니다.");
                f.phonenumber.focus();
                return false;
            }

        }
        function regPhone(){
            let text = document.getElementById('phonenumber').value;
            let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
            if (regPhone.test(text) !== true) {
                alert('전화번호 형식에 맞게 입력해주세요');
                document.getElementById('phonenumber').value = ''
                return
            }else{
                document.getElementById('phoneCheck').value = 'Y'
            }
        }
    </script>
    <style type="text/css">
        body {
            padding-top: 60px;
            background-color: #e5dfa1;
        }
        .submitBtn{
            background-color: #00b5ad;
            border: #00b5ad;
        }

        body>.grid {
            height: 100%;
        }

        .image {
            margin-top: -100px;
        }

        .column {
            max-width: 850px;
            max-height: 1200px;
        }

    </style>
</head>

<body>
<!-- Navigation-->
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
<div class="ui middle aligned center aligned grid">
    <div class="column">
        <h2 class="ui teal image header">
            동호회 가입
        </h2>
        <form id="join" name="join" class="ui large form" method="post" action="/club/joinReg" onsubmit="return doSubmit(this);">
            <div class="ui stacked segment">
                <div class="field">
                    <h4>이름</h4>
                    <input type="text" id="user_name" name="user_name" value="<%=userDTO.getUser_name()%>">
                </div>
                <div class="field">
                    <h4 align="left">주소</h4>
                    <input type="text" id="address" name="address" placeholder="주소" autocomplete="off" autofocus="autofocus" readonly>
                    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script>
                        window.onload = function(){
                            document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
                                //카카오 지도 발생
                                new daum.Postcode({
                                    oncomplete: function(data) { //선택시 입력값 세팅
                                        document.getElementById("address").value = data.address; // 주소 넣기
                                    }
                                }).open();
                            });
                        }
                    </script>
                </div>
                <div class="field">
                    <h4 align="left">전화번호</h4>
                    <input type="text" id="phonenumber" name="phonenumber" placeholder="-를 포함해서 입력해주세요" autocomplete="off" autofocus="autofocus">
                </div>
                <div class="field">
                    <h4 align="left">가입인사</h4>
                    <div class="ui left icon input">
                        <textarea style="resize: vertical;" id="greeting" name="greeting" placeholder="간단한 인사말을 적어주세요" rows="8"></textarea>
                    </div>
                </div>
                <div class="ui fluid large teal submit button" type="submit" id="write_bbs">
                    <input class="submitBtn" type="submit" value="가입신청">
                </div>
            </div>
            <div class="ui error message">
                <input type="hidden" id="club_no" name="club_no" value="<%=club_no%>">
                <input type="hidden" id="user_no" name="user_no" value="<%=user_no%>">
            </div>
        </form>
    </div>
</div>

</body>

</html>

