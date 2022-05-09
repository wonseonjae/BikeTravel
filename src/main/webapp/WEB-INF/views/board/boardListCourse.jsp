<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%
	List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("rList");

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<BoardDTO>();

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
			location.href = "/board/boardInfo?bNo=" + bNo;
		}

	</script>
</head>
<body>
<h2>후기게시판</h2>
<hr/>
<br/>


<table border="1" width="600px">
	<tr>
		<td width="100" align="center">코스명</td>
		<td width="200" align="center">제목</td>
		<td width="100" align="center">등록자</td>
		<td width="100" align="center">등록일</td>
	</tr>
	<%
		for (int i = 0; i < rList.size(); i++) {
			BoardDTO rDTO = rList.get(i);

			if (rDTO == null) {
				rDTO = new BoardDTO();
			}

	%>
	<tr>
		<td align="center">
			<%=CmmUtil.nvl(rDTO.getCoursename()) %>
		</td>
		<td align="center">
			<a href="javascript:doDetail('<%=rDTO.getBoard_no()%>');">
				<%=CmmUtil.nvl(rDTO.getTitle()) %>
			</a>
		</td>
		<td align="center"><%=CmmUtil.nvl(rDTO.getUser_name()) %>
		</td>
		<td align="center"><%=CmmUtil.nvl(rDTO.getRegdate()) %>
		</td>
	</tr>
	<%
		}
	%>
</table>
<a href="/board/boardWrite">[글쓰기]</a>
</body>
</html>