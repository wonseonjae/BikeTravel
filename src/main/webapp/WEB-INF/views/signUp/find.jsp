<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        let msg = "${msg}";

        if (msg != "") {
            alert(msg);
        }

        function findId(){
            let data = new Array();
            let obj = new Object();
            let user_mail= document.getElementById("user_mail").value;
            let mail = user_mail.split('@')
            console.log(mail)
            let user_mailid = mail[0];
            console.log(user_mailid)
            let user_maildomain= mail[1];
            console.log(user_maildomain)
            if (user_mailid==="" || user_maildomain===""){
                alert("공백없이 입력해주시기 바랍니다.");
                return
            }
            obj.user_mailid = user_mailid
            obj.user_maildomain = user_maildomain
            data.push(obj)
            console.log(data)
            $.ajax({
                url:'/findId',
                method:'POST',
                contentType: 'application/json',
                data:JSON.stringify(data),
                success: function(result) {
                    result.forEach(function (res) {
                        alert('회원님의 아이디는 '+res.user_id+'입니다.')
                        $('#resultForm').append('<h2 style="text-align: center">조회결과</h2>')
                        $('#resultForm').append('<h4 style="text-align: center">회원님의 아이디는 '+res.user_id+' 입니다'+'</h4>')
                    });

                }
         })

        }

        function doSubmit(f){
            if(f.user_mailid.value == ""){
                alert("이메일을 입력해주시기 바랍니다.");
                f.user_mailid.focus();
                return false;
            }

            if(f.user_maildomain.value == ""){
                alert("도메인을 선택해주시기 바랍니다.");
                f.user_maildomain.focus();
                return false;
            }
        }
        function sendPw(){
            let user_mail= document.getElementById("user_email").value;
            let mail = user_mail.split('@')
            console.log(mail)
            let user_mailid = mail[0];
            console.log(user_mailid)
            let user_maildomain= mail[1];
            console.log(user_maildomain)
            let user_id = document.getElementById("user_id").value;
            console.log(user_id);
            $.ajax({
                url: "/sendPw",
                type: "get",
                data: {
                    "user_mailid" : user_mailid,
                    "user_maildomain" : user_maildomain,
                    "user_id" : user_id
                },
                success: function() {
                    alert('비밀번호가 재발급되었습니다. 로그인후 변경해주세요')
                    window.close()
                }

            })

        }
    </script>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

        body{
            font-family: 'Poppins', sans-serif;
            font-weight: 300;
            font-size: 15px;
            line-height: 1.7;
            color: #c4c3ca;
            background-color: #1f2029;
            overflow-x: hidden;
        }
        a {
            cursor: pointer;
            transition: all 200ms linear;
        }
        a:hover {
            text-decoration: none;
        }
        .link {
            color: #c4c3ca;
        }
        .link:hover {
            color: #ffeba7;
        }
        p {
            font-weight: 500;
            font-size: 14px;
            line-height: 1.7;
        }
        h4 {
            font-weight: 600;
        }
        h6 span{
            padding: 0 20px;
            text-transform: uppercase;
            font-weight: 700;
        }
        .section{
            position: relative;
            width: 100%;
            display: block;
        }
        .full-height{
            min-height: 100vh;
        }
        [type="checkbox"]:checked,
        [type="checkbox"]:not(:checked){
            position: absolute;
            left: -9999px;
        }
        .checkbox:checked + label,
        .checkbox:not(:checked) + label{
            position: relative;
            display: block;
            text-align: center;
            width: 60px;
            height: 16px;
            border-radius: 8px;
            padding: 0;
            margin: 10px auto;
            cursor: pointer;
            background-color: #ffeba7;
        }
        .checkbox:checked + label:before,
        .checkbox:not(:checked) + label:before{
            position: absolute;
            display: block;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            color: #ffeba7;
            background-color: #102770;
            font-family: 'unicons';
            content: '\eb4f';
            z-index: 20;
            top: -10px;
            left: -10px;
            line-height: 36px;
            text-align: center;
            font-size: 24px;
            transition: all 0.5s ease;
        }
        .checkbox:checked + label:before {
            transform: translateX(44px) rotate(-270deg);
        }


        .card-3d-wrap {
            position: relative;
            width: 600px;
            max-width: 100%;
            height: 400px;
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
            perspective: 800px;
            margin-top: 60px;
        }
        .card-3d-wrapper {
            width: 100%;
            height: 100%;
            position:absolute;
            top: 0;
            left: 0;
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
            transition: all 600ms ease-out;
        }
        .card-front{
            width: 100%;
            height: 100%;
            background-color: #2a2b38;
            background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg');
            background-position: bottom center;
            background-repeat: no-repeat;
            background-size: 300%;
            position: absolute;
            border-radius: 6px;
            margin-left: 10%;
            left: 0;
            top: 0;
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
            -webkit-backface-visibility: hidden;
            -moz-backface-visibility: hidden;
            -o-backface-visibility: hidden;
            backface-visibility: hidden;
        }
        .card-back{
            width: 100%;
            height: 100%;
            background-color: #2a2b38;
            background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg');
            background-position: bottom center;
            background-repeat: no-repeat;
            background-size: 300%;
            position: absolute;
            border-radius: 6px;
            margin-left: -10%;
            left: 0;
            top: 0;
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
            -webkit-backface-visibility: hidden;
            -moz-backface-visibility: hidden;
            -o-backface-visibility: hidden;
            backface-visibility: hidden;
        }
        .card-back {
            transform: rotateY(180deg);
        }
        .checkbox:checked ~ .card-3d-wrap .card-3d-wrapper {
            transform: rotateY(180deg);
        }
        .center-wrap{
            position: absolute;
            width: 100%;
            padding: 0 35px;
            top: 50%;
            left: 0;
            transform: translate3d(0, -50%, 35px) perspective(100px);
            z-index: 20;
            display: block;
        }


        .form-group{
            position: relative;
            display: block;
            margin: 0;
            padding: 0;
        }
        .form-style {
            padding: 13px 20px;
            padding-left: 55px;
            height: 48px;
            width: 400px;
            font-weight: 500;
            border-radius: 4px;
            font-size: 14px;
            line-height: 22px;
            letter-spacing: 0.5px;
            outline: none;
            color: #c4c3ca;
            background-color: #1f2029;
            border: none;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
            box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
        }
        .form-style:focus,
        .form-style:active {
            border: none;
            outline: none;
            box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
        }
        .input-icon {
            position: absolute;
            top: 0;
            left: 18px;
            height: 48px;
            font-size: 24px;
            line-height: 48px;
            text-align: left;
            color: #ffeba7;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }

        .form-group input:-ms-input-placeholder  {
            color: #c4c3ca;
            opacity: 0.7;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input::-moz-placeholder  {
            color: #c4c3ca;
            opacity: 0.7;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input:-moz-placeholder  {
            color: #c4c3ca;
            opacity: 0.7;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input::-webkit-input-placeholder  {
            color: #c4c3ca;
            opacity: 0.7;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input:focus:-ms-input-placeholder  {
            opacity: 0;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input:focus::-moz-placeholder  {
            opacity: 0;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input:focus:-moz-placeholder  {
            opacity: 0;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }
        .form-group input:focus::-webkit-input-placeholder  {
            opacity: 0;
            -webkit-transition: all 200ms linear;
            transition: all 200ms linear;
        }

        .btn{
            border-radius: 4px;
            height: 44px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            -webkit-transition : all 200ms linear;
            transition: all 200ms linear;
            padding: 0 30px;
            letter-spacing: 1px;
            display: -webkit-inline-flex;
            display: -ms-inline-flexbox;
            display: inline-flex;
            -webkit-align-items: center;
            -moz-align-items: center;
            -ms-align-items: center;
            align-items: center;
            -webkit-justify-content: center;
            -moz-justify-content: center;
            -ms-justify-content: center;
            justify-content: center;
            -ms-flex-pack: center;
            text-align: center;
            border: none;
            background-color: #ffeba7;
            color: #102770;
            box-shadow: 0 8px 24px 0 rgba(255,235,167,.2);
        }
        .btn:active,
        .btn:focus{
            background-color: #102770;
            color: #ffeba7;
            box-shadow: 0 8px 24px 0 rgba(16,39,112,.2);
        }
        .btn:hover{
            background-color: #102770;
            color: #ffeba7;
            box-shadow: 0 8px 24px 0 rgba(16,39,112,.2);
        }
        .logo {
            position: absolute;
            top: 30px;
            right: 30px;
            display: block;
            z-index: 100;
            transition: all 250ms linear;
        }
        .logo img {
            height: 26px;
            width: auto;
            display: block;
        }
    </style>

</head>
<body>
<div class="section">
    <div class="container">
        <div class="row full-height justify-content-center">
            <div class="col-12 text-center align-self-center py-5">
                <div class="section pb-5 pt-5 pt-sm-2 text-center">
                    <h6 style="margin-left:28%" class="mb-0 pb-3"><span style="font-size: 24px">아이디 찾기 </span><span style="font-size: 24px">비밀번호 재발급</span></h6>
                    <input class="checkbox" type="checkbox" id="reg-log" name="reg-log"/>
                    <label for="reg-log"></label>
                    <div class="card-3d-wrap mx-auto">
                        <div class="card-3d-wrapper">
                            <div class="card-front">
                                <div class="center-wrap">
                                    <div class="section text-center">
                                        <h4 class="mb-4 pb-3">아이디 찾기</h4>
                                        <div class="form-group">
                                            <input type="email" id="user_mail" name="user_mail" class="form-style" placeholder="이메일">
                                        </div>
                                        <br/>
                                        <a onclick="findId()" class="btn mt-4">아이디 찾기</a>
                                        <div style="margin-left: -10%" id="resultForm">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-back">
                                <div class="center-wrap">
                                    <div class="section text-center">
                                        <h4 class="mb-4 pb-3">비밀번호 재발급</h4>
                                        <div class="form-group">
                                            <input type="text" name="user_id" class="form-style" placeholder="아이디" id="user_id" autocomplete="off">
                                            <i class="input-icon uil uil-user"></i>
                                        </div>
                                        <br/>
                                        <div class="form-group mt-2">
                                            <input type="email" name="user_email" class="form-style" placeholder="이메일" id="user_email" autocomplete="off">
                                            <i class="input-icon uil uil-at"></i>
                                        </div>
                                        <br/>
                                        <a onclick="sendPw();" class="btn mt-4">비밀번호 재발급</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> <!-- /form -->
<%--<div class="w3-content w3-container w3-margin-top">
    <div class="w3-container w3-card-4">
    <div class="w3-large w3-margin-top">
        <button type="button" class="btn block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='/findIdPw'">아이디 찾기</button>&nbsp;&nbsp;
        <button type="button" class="btn block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='/findPw'">비밀번호 재발급</button>
        <br/>
    </div>
    <div class="container">
        <h2>아이디 찾기</h2>
        <div class="w3-center w3-large w3-margin-top">
            <input class="inp" type="text" id="user_mailid" name="user_mailid" placeholder="Email아이디">
            <input type="text" style=" border:none; width:7%;text-align: left;" value="@" readonly>
            <input class="inp" style="width: 37%" type="text" id="user_maildomain" name="user_maildomain" placeholder="도메인" readonly>
            <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">
            <select id="mail3" name="mail3" onChange="mailcheck()">
                <option>선택</option>
                <option value="gmail.com" >gmail.com</option>
                <option value="naver.com">naver.com</option>
            </select>
        </div>
        <button class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" >찾기</button>
    </div>
        <div id="resultForm">

        </div>
    </div>
</div>--%>
</body>
</html>