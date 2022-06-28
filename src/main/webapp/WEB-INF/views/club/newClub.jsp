<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO userDTO = (UserDTO) session.getAttribute("user");
    System.out.println(userDTO.getUser_name());
    String user_no = String.valueOf(userDTO.getUser_no());
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>동호회 창설</title>
    <!-- css 가져오기 -->
    <link rel="stylesheet" type="text/css" href="/css/semantic.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <!-- js 가져오기 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>

    <script>
        function rangeCheck() {
            let i = document.join.s1.selectedIndex // 선택항목의 인덱스 번호
            // 선택항목 value
            document.join.f_title.value=document.join.s1.options[i].value
        }
        function nameCheck() {
            $.ajax({
                url : "/nameChk",
                type : "POST",
                dataType :"JSON",
                data : {"club_name" : $("#club_name").val()},
                success : function (data) {
                    console.log(data)
                    if(data >= 1) {
                        alert("중복된 닉네임 입니다.");
                    } else if (data == 0) {
                        document.getElementById('nameChkYN').value = "Y";
                        alert("사용 가능한 닉네임 입니다.")
                    }
                }

            })
        }
        function doSubmit(f){

            if(f.nameChkYN.value == ""){
                alert("동호회명 중복체크를 해주시기 바랍니다.");
                f.club_name.focus();
                return false;
            }
            if (f.club_name.value == ""){
                alert("동호회명을 해주시기 바랍니다.");
                f.club_name.focus();
                return false;
            }
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
            padding-top: 80px;
            background-color: #e5dfa1;
        }
        .classBtn{
            background-color: #00b5ad;
            border: #00b5ad;
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
            동호회 창설
        </h2>
        <form id="join" name="join" class="ui large form" method="post" action="/club/clubReg" onsubmit="return doSubmit(this);">
            <div class="ui stacked segment">
                <div class="field">
                    <h4 align="left">동호회명</h4>
                    <input type="text" id="club_name" name="club_name" placeholder="동호회명" autocomplete="off" autofocus="autofocus">
                    <input type="hidden" id="nameChkYN" name="nameChkYN">
                </div>
                <div class="ui fluid large teal submit button" type="button" id="write_bb">
                    <input type="button" class="classBtn" onclick="nameCheck()" value="중복체크">
                </div>
                <div class="field">
                    <h4 align="left">이름</h4>
                    <input type="text" id="user_name" name="user_name" value="<%=userDTO.getUser_name()%>" readonly>
                </div>
                <div class="field">
                    <h4 align="left">주소</h4>
                    <input type="text" id="address" name="address" placeholder="주소" autocomplete="off" readonly>
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
                    <input type="text" id="phonenumber" name="phonenumber" placeholder="휴대전화번호를 -를 포함해서 입력해주세요" autocomplete="off" onchange="regPhone()" autofocus="autofocus">
                    <input type="hidden" id="phoneCheck" name="phoneCheck">
                </div>
                <div class="field">
                    <h4 align="left">활동지역</h4>
                    <select id="s1" name="s1" onchange="rangeCheck()">
                        <option>전국</option>
                        <option>경기도</option>
                        <option>강원도</option>
                        <option>충청북도</option>
                        <option>충청남도</option>
                        <option>전라북도</option>
                        <option>경상북도</option>
                        <option>경상남도</option>
                    </select>
                </div>
                <div class="field">
                    <h4 align="left">동호회 소개글</h4>
                    <div class="ui left icon input">
                        <textarea style="resize: vertical;" id="clubintro" name="clubintro" placeholder="게시글 내용" rows="8"></textarea>
                    </div>
                </div>
                <div class="ui fluid large teal submit button" type="submit" id="write_bbs">
                    <input class="submitBtn" type="submit" value="동호회 창설">
                </div>
            </div>
            <div class="ui error message">
                <input type="hidden" id="user_no" name="user_no" value="<%=user_no%>">
            </div>
        </form>
        <a href="/club/list"><button class="ui fluid large teal submit button">뒤로가기</button></a>
    </div>
</div>

</body>

</html>

