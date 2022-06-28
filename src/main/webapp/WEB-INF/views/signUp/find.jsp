<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://github.com/MinJunjang1/my2022PRJ/blob/7adfa4c9dc7a20b427ada2a2ad3e15a328089c3a/src/main/webapp/WEB-INF/views/js/seouljs.js"></script>
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
            let user_mailid = document.getElementById("user_mailid").value;
            let user_maildomain = document.getElementById("user_maildomain").value;
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

        function mailcheck(){
            let mail = $("#mail3 option:selected").val(); //value값 가져오기
            console.log(mail)
            document.getElementById('user_maildomain').value=mail

        }
    </script>
    <style type="text/css">
        .block {
            width: 45%
        }
        .btn{
            width:48%;
        }
        .inp{
            padding:8px;
            border:none;
            border-bottom:1px solid #ccc;
            width:30%;
            text-align: left;
        }
        .margin-top{
            margin-top:4px
            !important
        }

    </style>
</head>
<body>
<div class="w3-content w3-container w3-margin-top">
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
        <button class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onclick="findId()">찾기</button>
    </div>
        <div id="resultForm">

        </div>
    </div>
</div>
</body>
</html>