<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String user_mail = uDTO.getUser_mailid() + "@" + uDTO.getUser_maildomain();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://github.com/MinJunjang1/my2022PRJ/blob/7adfa4c9dc7a20b427ada2a2ad3e15a328089c3a/src/main/webapp/WEB-INF/views/js/seouljs.js"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>마이페이지</title>

    <script>
        function chgName() {
            location.href="/admin/chgName"
        }
    </script>

</head>
<body>
<table>
    <tr>
        <td>
            아이디
        </td>
        <td>
            <input type="text" id="user_id" name="user_id" value="<%=uDTO.getUser_id()%>" disabled>
        </td>
    </tr>
    <tr>
        <td>
            닉네임
        </td>
        <td>
            <input type="text" id="user_name" name="user_name" value="<%=uDTO.getUser_name()%>" disabled>
            <input type="button" onclick="chgName()" value="변경">
        </td>
    </tr>
    <tr>
        <td>
            이메일
        </td>
        <td>
            <input type="text" id="user_mail" name="user_mail" value="<%=user_mail%>" disabled>
        </td>
    </tr>
    <tr>
        <td>
            가입일
        </td>
        <td>
            <input type="text" id="user_regDt" name="user_regDt" value="<%=uDTO.getRegdate()%>" disabled>
        </td>
    </tr>
    <tr>
        <td>
            권한
        </td>
        <td>
            <input type="text" id="user_auth" name="user_auth" value="<%=uDTO.getAuthority()%>" disabled>
        </td>
    </tr>
</table>
<li class="nav-item"><a class="nav-link" href="/pwCheck">비밀번호 변경</a></li>
<li class="nav-item"><a class="nav-link" href="/deleteUser?user_no=<%=uDTO.getUser_no()%>">회원탈퇴</a></li>

</body>
</html>