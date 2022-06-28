<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="/css/w3.css">
<link rel="stylesheet" href="/css/font.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원가입</title>
    <script type="text/javascript">
        let msg = "${msg}";

        if (msg != "") {
            alert(msg);
        }
        function findId() {
            location.href
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
            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호
            let mail = document.join.mail3.options[i].value // 선택항목 value
            document.join.user_maildomain.value=mail
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
<div class="w3-container w3-margin-top">
    <div class="w3-container w3-card-4">
        <form name="join" method="post" action="/sendPw" onsubmit="return doSubmit(this);">
            <div class="w3-large w3-margin-top">
                <button type="button" class="btn block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='/findIdPw'">아이디 찾기</button>&nbsp;&nbsp;
                <button type="button" class="btn block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='/findPw'">비밀번호 재발급</button>
                <br/>
            </div>
            <div>
                <h2>비밀번호 재발급</h2>
                <div class="w3-center w3-large w3-margin-top">
                    <input class="w3-input" type="text" style="width:100%;height:20px;" id="user_id" name="user_id" placeholder="아이디" >
                </div>
                <div class="w3-large margin-top" >
                    <input class="inp" type="text" id="user_mailid" name="user_mailid" placeholder="Email아이디">
                    <input type="text" style=" border:none; width:7%;text-align: left;" value="@" readonly>
                    <input class="inp" style="width: 37%" type="text" id="user_maildomain" name="user_maildomain" placeholder="도메인" readonly>
                    <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">
                    <select name="mail3" onChange="mailcheck()">
                        <option>선택</option>
                        <option value="gmail.com" >gmail.com</option>
                        <option value="naver.com">naver.com</option>
                    </select>
                </div>


                <button class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" type="submit">찾기</button>
            </div>

        </form>
    </div>
</div>
</body>
</html>