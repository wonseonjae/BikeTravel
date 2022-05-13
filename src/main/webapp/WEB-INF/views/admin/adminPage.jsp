<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%
	List<UserDTO> rList = (List<UserDTO>) request.getAttribute("rList");
	int access = 0;
	if (session.getAttribute("user")==null) {
		access = 0;
	} else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		System.out.println(uDTO.getAuthority());
		if (uDTO.getAuthority().equals("ADMIN")) {
			access = 3;
		} else {
			access = 1;
		}
	}

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<UserDTO>();

	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>공지 리스트</title>
	<script type="text/javascript">

		//상세보기 이동
		function doDetail(bNo) {
			location.href = "/userDetail?bNo="+bNo;
		}

	</script>
	<script>
		function doOnload(){

			if ("<%=access%>"=="1"){
				alert("관리자만 접근할수 있는 페이지 입니다");
				location.href="/main";

			}
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js">

	</script>
</head>
<body onload="doOnload()">
<h2>회원 목록</h2>
<hr/>
<br/>
<form method="get" action="/admin/adminList">
	<p>
		<input type="text" id="user_id" name="user_id">
		<input type="submit" value="검색">
	</p>
</form>
<table border="1" width="600px">
	<tr>
		<td width="100" align="center">회원번호</td>
		<td width="200" align="center">아이디</td>
		<td width="100" align="center">닉네임</td>
		<td width="100" align="center">이메일</td>
	</tr>
	<%
		for (int i = 0; i < rList.size(); i++) {
			UserDTO rDTO = rList.get(i);

			if (rDTO == null) {
				rDTO = new UserDTO();
			}

	%>
	<tr>
		<td align="center">
			<%=CmmUtil.nvl(String.valueOf(rDTO.getUser_no()))%>
		</td>
		<td align="center">
			<a href="javascript:doDetail('<%=rDTO.getUser_no()%>');">
				<%=CmmUtil.nvl(rDTO.getUser_id()) %>
			</a>
		</td>
		<td align="center">
			<%=CmmUtil.nvl(rDTO.getUser_name()) %>
		</td>
		<td align="center">
			<%=CmmUtil.nvl(rDTO.getUser_mailid())%>@<%=CmmUtil.nvl(rDTO.getUser_maildomain())%>
		</td>
	</tr>
	<%
		}
	%>
</table>

</div>
</body>
</html>