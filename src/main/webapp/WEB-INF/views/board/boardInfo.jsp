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
	int res = (Integer) request.getAttribute("res");

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
		//댓글쓰기
		function doReply() {
			if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");
				return false;
			} else {
				let data = new Array();
				let obj = new Object();
				let board_no = <%=rDTO.getBoard_no()%>;
				let comment = document.getElementById("content").value;
				console.log(comment)
				obj.board_no = board_no
				obj.comment = comment
				console.log(comment)
				data.push(obj)
				console.log(data)
				$.ajax({
					url: '/commentReg',
					method: 'post',
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function () {
						location.reload();
					}
				})
			}
		}
		function editReply(rid, reg_id, content){
			var htmls = "";
			htmls += '<div style="font-size: 16px" class="card-body" id="repbox'+rid+'">';
			htmls += '<title>Placeholder</title>';
			htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
			htmls += '<p>';
			htmls += '<span>';
			htmls += '<strong class="text-gray-dark">' + reg_id + '</strong>';
			htmls += '<span style="padding-left: 7px; font-size: 12pt">';
			htmls += '<a href="javascript:void(0)" onclick="updateReply('+rid+')" style="padding-right:5px">저장</a>';
			htmls += '<a href="javascript:void(0)" onClick="location.reload()">취소<a>';
			htmls += '</span>';
			htmls += '</span>';
			htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
			htmls += content;
			htmls += '</textarea>';
			htmls += '</p>';
			htmls += '</div>';
			$('#repbox' + rid).replaceWith(htmls);
			$('#repbox' + rid + '#editContent').focus();
		}
		function updateReply(rid){
			let comment_no = rid
			let content = document.getElementById('editContent').value
			if (content == ""){
				alert('최소 1글자 이상 입력해야합니다.')
				return
			}
			let data = new Array();
			let obj = new Object();
			obj.comment_no = comment_no
			obj.comment_text = content
			data.push(obj)
			console.log(data)
			$.ajax({
				url: '/commentUpdate',
				method: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function () {
					location.reload();
				}
			})

		}

		function doEdit() {
			if ("<%=edit%>" == 2) {
				location.href = "/board/boardEditInfo?nSeq=<%=CmmUtil.nvl(String.valueOf(rDTO.getBoard_no()))%>";

			} else if ("<%=edit%>" === 3) {
				alert("로그인 하시길 바랍니다.");

			} else {
				alert("본인이 작성한 글만 수정 가능합니다.");
			}
		}
		//삭제하기
		function doDelete() {
			if ("<%=edit%>" == 2) {
				if (confirm("작성한 글을 삭제하시겠습니까?")) {
					location.href = "/boardDelete?nSeq=<%=String.valueOf(rDTO.getBoard_no())%>";

				}
			} else if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");

			} else {
				alert("본인이 작성한 글만 삭제 가능합니다.");
			}
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

		//목록으로 이동
		function doList() {
			location.href = "/board/list";

		}

	</script>
	<style>
		body{
			padding-top: 100px;
		}
		.main{
			max-width: 1400px;
			height: 60%;
			padding-right:15px;
			padding-left:15px;
			margin-right:auto;
			margin-left:auto

		}
	</style>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="/main"><img src="/image/bike.jpg" height="35" width="35">자전거여행</a>
	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="/course/index">코스 조회<span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="/board/list">후기게시판</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link disabled" onclick="window.open('/weather/Form','기상조회','width=500 height=500')">기상조회</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link disabled" href="/club/list">동호회</a>
			</li>
		</ul>
		<form class="form-inline my-2 my-lg-0">
			<ul class="navbar-nav ms-auto">
				<% if(session.getAttribute("user") == null){%>
				<li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
				<%}%>
				<!--<form  required oninput="Show()">-->
				<% if(session.getAttribute("user") != null){%>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" onclick="window.open('/admin','관리자 페이지','width=1000 height=1200')">관리자 페이지</a></li>
				<%}%>
			</ul>
		</form>
	</div>
</nav>
<div class="main">
	<h2>후기 게시판</h2>
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
	<div class="box">
		<a href="javascript:doEdit();">[수정]</a>
		<a href="javascript:doDelete();">[삭제]</a>
		<a href="javascript:doList();">[목록]</a>
	</div>
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
			<h5 class="card-header">댓글 목록[<%=res%>]</h5>
			<%
				for (int i = 0; i < rList.size(); i++) {
					CommentDTO cDTO = rList.get(i);

					if (cDTO == null) {
						cDTO = new CommentDTO();
					}

			%>
			<div class="card-body" id="repbox<%=cDTO.getComment_no()%>">
				<a><%=CmmUtil.nvl(cDTO.getUser_name()) %></a>
				<a><%=cDTO.getRegdate().substring(0,16)%></a>
				<%
					if (session.getAttribute("user")!=null){
						UserDTO uDTO = (UserDTO) session.getAttribute("user");
						if (uDTO.getUser_no()==cDTO.getUser_no()){
							%>
				<a href="javascript:repDelete('<%=cDTO.getComment_no()%>')">삭제</a><a>&nbsp;&nbsp;|&nbsp;&nbsp;</a><a href="javascript:editReply('<%=cDTO.getComment_no()%>','<%=cDTO.getUser_name()%>','<%=cDTO.getComment_text()%>')">수정</a>
				<%
						}
					}
				%>
				<br>
				<a><%=CmmUtil.nvl(cDTO.getComment_text()) %></a>
			</div>
			<hr>
			<%
				}
			%>
		</div>
	</div>
	</div>
	</div>
</body>
</html>