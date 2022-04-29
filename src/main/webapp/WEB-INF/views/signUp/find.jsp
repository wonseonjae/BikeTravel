<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원가입</title>
    <script type="text/javascript">



        let msg = "${msg}";

        if (msg != "") {
            alert(msg);
        }


    </script>
    <script>
        function findId() {
            location.href
        }
    </script>
    <script>

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
    </script>
    <script>
        function mailcheck(){
            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호
            let mail = document.join.mail3.options[i].value // 선택항목 value
            document.join.user_maildomain.value=mail
        }
    </script>

</head>
<body>
<form name="join" method="post" action="/findId" onsubmit="return doSubmit(this);">
    <div class="container">
        <button type="button" class="btn btn-primary" onclick="location.href='/findIdPw'"><strong>아이디 찾기</strong></button>
        <button type="button" class="btn btn-primary" onclick="location.href='/findPw'">비밀번호 찾기</button>
        <br/>
        <br/>
        <br/>
    </div>

    <div class="container">
        <h2>아이디 찾기</h2>
        <div class="form-group">
            <input type="text" style="width:400px;height:35px;" id="user_mailid" name="user_mailid" placeholder="Email아이디" >

            <label>&nbsp;@&nbsp;</label>

            <input type="text" style="width:500px;height:35px;" id="user_maildomain" name="user_maildomain" placeholder="도메인을 선택해주세요" readonly>
            <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">

            <select style="width:120px;height:35px;" name="mail3" onChange="mailcheck()">
                <option value="gmail.com" >gmail.com</option>
                <option value="naver.com">naver.com</option>
            </select>
        </div>


        <button type="submit" class="btn btn-primary">찾기</button>
    </div>

</form>
</body>
</html>