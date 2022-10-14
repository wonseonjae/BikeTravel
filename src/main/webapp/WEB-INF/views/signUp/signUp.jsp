<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원가입</title>
    <script>
        function mailCheck() {
            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호
            let domain = document.join.mail3.options[i].value // 선택항목 value
            document.join.user_maildomain.value=domain
        }
        function doSubmit(f){
            if(f.user_id.value == ""){
                alert("아이디를 입력해주시기 바랍니다.");
                f.user_id.focus();
                return false;
            }
            if(f.user_name.value == ""){
                alert("닉네임을 입력해주시기 바랍니다.");
                f.user_name.focus();
                return false;
            }

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

            if(f.idChkYN.value == ""){
                alert("아이디 중복체크를 해주시기 바랍니다.");
                f.user_id.focus();
                return false;
            }

            if(f.nameChkYN.value == ""){
                alert("닉네임 중복체크를 해주시기 바랍니다.");
                f.user_id.focus();
                return false;
            }
            if(f.pwChkYN.value == ""){
                alert("비밀번호가 일치하지않습니다");
                f.user_pw.focus();
                return false;
            }

            if(f.mailChkYN.value == ""){
                alert("이메일 중복체크를 해주시기 바랍니다.");
                f.user_id.focus();
                return false;
            }

            if(f.certificationYN.value == ""){
                alert("메일인증을 해주시기 바랍니다.");
                f.certificationYN.focus();
                return false;
            }

        }
        function mailcheck(){
            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호
            let mail = document.join.mail3.options[i].value // 선택항목 value
            document.join.user_maildomain.value=mail
    }
        function emailSend(){
            let clientEmailId = document.getElementById('user_mailid').value;
            let clientEmailDomain = document.getElementById('user_maildomain').value;
            let emailYN = isEmail(clientEmailId+"@"+clientEmailDomain);
            let clientEmail = clientEmailId+"@"+clientEmailDomain

            console.log('입력 이메일 ' + clientEmail );

            if (emailYN == true) {

                $.ajax({
                    type:"POST",
                    url:"/mailSend",
                    data:{userEmail:clientEmail},
                    success : function (data){
                        alert('메일이 전송되었습니다. 인증번호를 확인해주세요.')
                    },error : function (e) {
                        alert('오류입니다. 잠시 후 다시 시도해주세요')
                    }
                });
            }   else('이메일 형식에 알맞게 입력해주세요');
        }
        function isEmail(asValue) {
            let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
            return regExp.test(asValue);
        }

        function emailCertification(){
            let clientEmailId = document.getElementById('user_mailid').value;
            let clientEmailDomain = document.getElementById('user_maildomain').value;
            let inputCode = document.getElementById('certificationCode').value;
            console.log("인증코드 : " + inputCode);
            let clientEmail = clientEmailId+"@"+clientEmailDomain

            $.ajax({
                type:"POST",
                url:"/mailReg",
                data:{ userEmail:clientEmail , inputCode:inputCode},
                success : function (result){
                    console.log(result);
                    if (result == true) {
                        alert('인증완료');
                        document.getElementById('certificationYN').value = "Y";
                        clientEmail.onchange = function (){
                            document.getElementById('certificationYN').value = "false";
                        }
                    }else{
                        alert('다시 입력해주세요');
                    }
                }
                }
            );
        }
    </script>    <script>
        function idCheck() {
            $.ajax({
                url : "/idCheck",
                type : "POST",
                dataType :"JSON",
                data : {"user_id" : $("#user_id").val()},
                success : function (result) {
                    console.log(result)
                    if(result >= 1) {
                        alert("중복된 아이디입니다.");
                    } else if (result == 0) {
                        $("#idChk").attr("value", "Y");
                        document.getElementById('idChkYN').value = "Y";
                        alert("사용 가능한 아이디입니다.")
                    }
                }

            })
        }
        function emailCheck() {
            let clientEmailId = document.getElementById('user_mailid').value;
            let clientEmailDomain = document.getElementById('user_maildomain').value;
            console.log(clientEmailId)
            console.log(clientEmailDomain)
            if (clientEmailDomain==="" || clientEmailId===""){
                alert("공백없이 입력해주시기 바랍니다.");
                return
            }


            $.ajax({
                url : "/mailCheck",
                type : "POST",
                dataType :"JSON",
                data : {user_mailid: clientEmailId , user_maildomain:clientEmailDomain},
                success : function (data) {
                    console.log(data)
                    if(data >= 1) {
                        alert("중복된 이메일입니다.");
                    } else if (data == 0) {
                        document.getElementById('mailChkYN').value = "Y";
                        alert("사용 가능한 이메일입니다.")
                    }
                }

            })
        }

        function nameCheck() {
            $.ajax({
                url : "/nameCheck",
                type : "POST",
                dataType :"JSON",
                data : {"user_name" : $("#user_name").val()},
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
    </script>    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        function check_pw(){
            let pw = document.getElementById('pw').value;
            let SC = ["!","@","#","$","%","*"];
            let check_SC = 0;

            if(pw.length < 6 || pw.length>16){
                window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
                document.getElementById('pw').value='';
            }
            for(let i=0;i<SC.length;i++){
                if(pw.indexOf(SC[i]) != -1){
                    check_SC = 1;
                }
            }
            if(check_SC == 0){
                window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
                document.getElementById('pw').value='';
            }
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                    document.getElementById('pwChkYN').value='Y';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
    </script>
    <style>
        *, *:before, *:after {
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        body {
            font-family: 'Nunito', sans-serif;
            color: #384047;
            padding-left: 30px;
        }

        h1 {
            margin: 0 0 30px 0;
            text-align: center;
        }

        input[type="text"],
        input[type="password"],
        input[type="date"],
        input[type="datetime"],
        input[type="email"],
        input[type="number"],
        input[type="search"],
        input[type="tel"],
        input[type="time"],
        input[type="url"],
        textarea,
        select {
            border: none;
            font-size: 16px;
            height: auto;
            margin: 0;
            outline: 0;
            padding: 15px;
            width: 100%;
            background: #e8eeef;
            color: #8a97a0;
            box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
            margin-bottom: 30px;
        }
        input[type="email"],
        select {
            border: none;
            font-size: 16px;
            height: auto;
            margin: 0;
            outline: 0;
            padding: 15px;
            width: 40%;
            background: #e8eeef;
            color: #8a97a0;
            box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
            margin-bottom: 30px;
        }

        input[type="radio"],
        input[type="checkbox"] {
            margin: 0 4px 8px 0;
        }

        button {
            padding: 19px 39px 18px 39px;
            color: #FFF;
            background-color: #4bc970;
            font-size: 18px;
            text-align: center;
            font-style: normal;
            border-radius: 5px;
            width: 100%;
            border: 1px solid #3ac162;
            border-width: 1px 1px 3px;
            box-shadow: 0 -1px 0 rgba(255,255,255,0.1) inset;
            margin-bottom: 10px;
        }

        fieldset {
            margin-bottom: 30px;
            border: none;
        }

        legend {
            font-size: 1.4em;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        label.light {
            font-weight: 300;
            display: inline;
        }

        .number {
            background-color: #5fcf80;
            color: #fff;
            height: 30px;
            width: 30px;
            display: inline-block;
            font-size: 0.8em;
            margin-right: 4px;
            line-height: 30px;
            text-align: center;
            text-shadow: 0 1px 0 rgba(255,255,255,0.2);
            border-radius: 100%;
        }

        @media screen and (min-width: 480px) {

            form {
                max-width: 480px;
            }

        }

    </style>
</head>
<body>
<form name="join" method="post" action="/signUpReg" onsubmit="return doSubmit(this);">
<div class="row">
    <div class="col-md-12">
        <form action="index.html" method="post">
            <h1> 회 원 가 입 </h1>
            <fieldset>
                <legend><span class="number">1</span> 내 정보</legend>

                <label for="user_id">아이디:</label>
                <input type="text" id="user_id" name="user_id" placeholder="아이디">
                <input type="hidden" class="form-control" name="idChkYN" id="idChkYN">
                <button class="btn btn-primary" class="idChk" type="button" id="idChk" onclick="idCheck()" value="N">중복체크</button>


                <label for="user_name">닉네임:</label>
                <input type="text" id="user_name" name="user_name" placeholder="닉네임">
                <input type="hidden" class="form-control" name="nameChkYN" id="nameChkYN">
                <button class="btn btn-primary" class="nameChk" type="button" id="nameChk" onclick="nameCheck()" value="N">중복체크</button>


                <label for="pw">비밀번호:</label>
                <input type="password" name="user_pw" id="pw" onchange="check_pw()" placeholder="비밀번호">

                <label for="pw2">비밀번호 확인:</label>
                <input type="password" name="user_pw_check" id="pw2" onchange="check_pw()" placeholder="비밀번호 확인">
                <span id="check"></span>
                <input type="hidden" class="form-control" name="pwChkYN" id="pwChkYN">

                <label for="user_mailid">이메일:</label>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="user_mailid" name="user_mailid" placeholder="Email아이디">
                    <span class="input-group-text">@</span>
                    <select style="height: 54px; background: #e8eeef;" class="form-control" name="mail3" onChange="mailCheck()">
                        <optgroup label="Web">
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                        </optgroup>
                    </select>
                </div>
                    <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">
                    <input type="hidden" style="width:150px;height:35px;" id="user_maildomain" name="user_maildomain"/>
                    <button type="button" class="btn btn-primary" onclick="emailCheck()">중복체크</button>
                    <button type="button" class="btn btn-primary" onclick="emailSend()">인증번호 발송</button>

                <label for="pw">인증번호 :</label>
                <input type="text" name="certificationCode" id="certificationCode" placeholder="인증번호">
                <input type="hidden" class="form-control" name="certificationYN" id="certificationYN">
                <button type="button" class="btn btn-primary" onclick="emailCertification()">인증하기</button>
            </fieldset>

            <button type="submit">가입</button>

        </form>
    </div>
</div>
</form>
</body>
</html>