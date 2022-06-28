<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO uDTO = (UserDTO) session.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>비밀번호 변경</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        function check_pw(){
            let pw = document.getElementById('pw').value;
            let SC = ["!","@","#","$","%","*"];
            let check_SC = 0;

            if(pw.length < 8 || pw.length>20){
                window.alert('비밀번호는 8글자 이상, 20글자 이하만 이용 가능합니다.');
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

        }

    </script>
    <style type="text/css">
        .main{
            padding-top: 80px;
            text-align: center;
            max-width: 600px;
            height: 60%;
            padding-right:15px;
            padding-left:15px;
            margin-right:auto;
            margin-left:auto

        }
    </style>

</head>
<body>
<div class="main">
<form name="join" method="post" action="/admin/chgPw">

    <div class="container">
        <h2>비밀번호 변경</h2>
        <div class="form-group">
            <input type="password" style="width:400px;height:35px;" id="pw" name="pw" onchange="check_pw()" placeholder="특수문자를 포함한 8~20자 이내의 문자로 입력해 주세요" >
            <input type="hidden" id="user_no" name="user_no" value="<%=uDTO.getUser_no()%>">
        </div>
        <button type="submit" class="btn btn-primary">변경</button>
    </div>

</form>
</div>
</body>
</html>