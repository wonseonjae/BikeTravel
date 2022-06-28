<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.CommentDTO" %>
<%@ page import="org.apache.catalina.User" %>
<%
	BoardDTO rDTO = (BoardDTO) request.getAttribute("rDTO");
	List<CommentDTO> rList= (List<CommentDTO>) request.getAttribute("rList");

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
		int ss_user_no = uDTO.getUser_no();

//로그인 안했다면....
		if (uDTO == null) {
			edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
		} else if (ss_user_no == rDTO.getUser_no()) {

			edit = 2;

		}
	}

	int rep = 0;
	if (session.getAttribute("user")!=null) {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");
		rep = uDTO.getUser_no();


	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>게시판 글보기</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="/css/bootstrap.min.css"/>
	<script type="text/javascript">
		//삭제하기
		function doDelete() {
			if ("<%=edit%>" == 2) {
				if (confirm("작성한 글을 삭제하시겠습니까?")) {
					location.href = "/userBoardDelete?bNo=<%=String.valueOf(rDTO.getBoard_no())%>";

				}
			} else if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");

			} else {
				alert("본인이 작성한 글만 삭제 가능합니다.");
			}
		}
		function goList(){
			location.href="/admin"
		}
		function repDelete(cNo) {
				let comment_no = cNo
				let data = new Array();
				let obj = new Object();
				obj.comment_no =comment_no
				data.push(obj)
				console.log(data)
				if (confirm("작성한 댓글을 삭제하시겠습니까?")) {
					$.ajax({
						url:'/repDelete',
						method:'post',
						contentType:'application/json',
						data:JSON.stringify(data) ,
						success: function (){
							location.reload();
						},
					})
				}

		}

	</script>
	<style>
		body{
			padding-top: 80px;
		}
		.main{
			max-width: 1400px;
			height: 60%;
			padding-right:15px;
			padding-left:15px;
			margin-right:auto;
			margin-left:auto

		}
		.box{

		}

	</style>
</head>

<body>


<div class="main">
	<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		<a class="navbar-brand" href="#">관리자페이지</a>
		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
				<li class="nav-item active">

				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">[목록]</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="Javascript:doDelete(<%=rDTO.getBoard_no()%>)">[삭제]</a></li>
				</ul>
			</form>
		</div>
	</nav>
	<hr>
	<div class="box" style="width: 100%; font-size: 24px">
		<%=rDTO.getTitle()%>
	</div>
	<hr>
	<div class="box" style="display:flex;width: 100%;color: #272a15">
		<p>코스명:<%=rDTO.getCoursename()%>&nbsp;&nbsp;|&nbsp;&nbsp;</p><p>작성자:<%=rDTO.getUser_name()%>&nbsp;&nbsp;|&nbsp;&nbsp;</p><p>작성일:<%=rDTO.getRegdate().substring(0,16)%></p>
	</div>
	<hr>
	<div class="box" style="width: 100%; font-size:16px">
		<c:set var="link" value="<%=CmmUtil.nvl(rDTO.getImglink())%>"></c:set>
		<c:choose>
			<c:when test="${link eq ''}">
			</c:when>
			<c:otherwise>
				<br>
				<img src="<%=CmmUtil.nvl(rDTO.getImglink())%>" width="40%" height="40%">
			</c:otherwise>
		</c:choose>
		<br>
		<p><%=rDTO.getContents()%></p>
	</div>
	<hr>
	<div>
		<!-- Comments Form -->
		<div class="card my-4">
			<h5 class="card-header">댓글 작성</h5>
			<div class="card-body">
				<div class="form-group">
					<textarea id="content" name="content" class="form-control" rows="2"></textarea>
				</div>
				<button class="btn btn-primary" onclick="doReply()">등록</button>
			</div>
			<div class="card my-4">
				<h5 class="card-header">댓글 목록</h5>
				<%
					for (int i = 0; i < rList.size(); i++) {
						CommentDTO cDTO = rList.get(i);

						if (cDTO == null) {
							cDTO = new CommentDTO();
						}

				%>
				<div class="card-body">
					<a><%=CmmUtil.nvl(cDTO.getUser_name()) %></a>
					<a><%=cDTO.getRegdate().substring(0,16)%></a>
					<a href="javascript:repDelete('<%=cDTO.getComment_no()%>')">삭제</a><br>
					<a><%=CmmUtil.nvl(cDTO.getComment_text()) %></a>
				</div>
				<hr>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>
