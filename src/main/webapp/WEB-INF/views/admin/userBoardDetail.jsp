<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%

	BoardDTO rDTO = (BoardDTO) request.getAttribute("rDTO");

//공지글 정보를 못불러왔다면, 객체 생성
	if (rDTO == null) {
		rDTO = new BoardDTO();

	}
	int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
	if (session.getAttribute("user")==null) {
		edit = 3;
	} else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");

//로그인 안했다면....
		if (uDTO == null) {
			edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
		} else if (uDTO.getAuthority().equals("ADMIN")) {

			edit = 2;

		}
	}



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>게시판 글보기</title>
	<script type="text/javascript">
		//삭제하기
		function doDelete() {
			if ("<%=edit%>" == 2) {
				if (confirm("작성한 글을 삭제하시겠습니까?")) {
					location.href = "/userBoardDelete?bNo="+<%=String.valueOf(rDTO.getBoard_no())%>;

				}

			} else if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");

			} else {
				alert("본인이 작성한 글만 삭제 가능합니다.");

			}
		}
	</script>
</head>
<body>
<table border="1">
	<col width="100px"/>
	<col width="200px"/>
	<col width="100px"/>
	<col width="200px"/>
	<tr>
		<td align="center">제목</td>
		<td colspan="3"><%=CmmUtil.nvl(rDTO.getTitle())%>
		</td>
	</tr>
	<tr>
		<td align="center">작성일</td>
		<td><%=CmmUtil.nvl(rDTO.getRegdate())%>
		</td>
		<td align="center">작성자</td>
		<td colspan="3"><%=CmmUtil.nvl(rDTO.getUser_name())%>
		</td>
	</tr>
	<tr>
		<td colspan="4" height="300px" valign="top">
			<%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
			<c:set var="link" value="<%=CmmUtil.nvl(rDTO.getImglink())%>"></c:set>
			<c:choose>
			<c:when test="${link eq ''}">
			</c:when>
			<c:otherwise>
				<img src="<%=CmmUtil.nvl(rDTO.getImglink())%>" width="150px" height="150px">
			</c:otherwise>

			</c:choose>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="4">
			<a href="javascript:doDelete();">[삭제]</a>
		</td>
	</tr>
</table>
</body>
</html>