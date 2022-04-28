<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원가입</title>
    <script>
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
    </script>    <script>
         function mailcheck(){
        let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호
        let mail=document.join.mail3.options[i].value // 선택항목 value
        document.join.user_maildomain.value=mail
    }
    </script>    <script>
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
    </script>    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>    <script>
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
</head>
<body>
<form name="join" method="post" action="/signUpReg" onsubmit="return doSubmit(this);">
    <div class="container">
        <h1>회원가입</h1>
        <div class="form-group">
            <label>아이디</label>
            <input type="text" id="user_id" class="form-control" name="user_id" placeholder="아이디">
            <input type="hidden" class="form-control" name="idChkYN" id="idChkYN">
            <button class="btn btn-primary" class="idChk" type="button" id="idChk" onclick="idCheck()" value="N">중복체크</button>

        </div>
        <div class="form-group">
            <label>닉네임</label>
            <input type="text" id="user_name" class="form-control" name="user_name" placeholder="닉네임">
            <input type="hidden" class="form-control" name="nameChkYN" id="nameChkYN">
            <button class="btn btn-primary" class="nameChk" type="button" id="nameChk" onclick="nameCheck()" value="N">중복체크</button>
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" class="form-control" name="user_pw" id="pw" onchange="check_pw()" placeholder="비밀번호">
        </div>
        <div class="form-group">
            <label>비밀번호 확인</label>
            <input type="password" class="form-control" name="user_pw_check" id="pw2"
                   onchange="check_pw()" placeholder="비밀번호 확인"><span id="check"></span>
            <input type="hidden" class="form-control" name="pwChkYN" id="pwChkYN">
        </div>
        <div class="form-group">
            <label>이메일 아이디</label>
        </div>
        <div class="form-group">
            <input type="text" style="width:400px;height:35px;" id="user_mailid" name="user_mailid" placeholder="Email아이디" >

                <label>&nbsp;@&nbsp;</label>

                <input type="text" style="width:500px;height:35px;" id="user_maildomain" name="user_maildomain" placeholder="도메인을 선택해주세요" readonly>
                <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">

                    <select style="width:120px;height:35px;" name="mail3" onChange="mailcheck()">
                    <option value="gmail.com" >gmail.com</option>
                    <option value="naver.com">naver.com</option>
                </select>
            <button type="button" class="btn btn-primary" onclick="emailSend()">발송</button>
            <button type="button" class="btn btn-primary" onclick="emailCheck()">중복체크</button>
        </div>
        <div class="form-group">
            <label>인증번호</label>
            <input type="text" class="form-control" name="certificationCode" id="certificationCode" placeholder="비밀번호">
            <input type="hidden" class="form-control" name="certificationYN" id="certificationYN">
            <button type="button" class="btn btn-primary" onclick="emailCertification()">인증하기</button>
        </div>


        <button type="submit" class="btn btn-primary">가입 완료</button>
    </div>

</form>
</body>
</html>