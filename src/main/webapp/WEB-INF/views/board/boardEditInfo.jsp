<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.dto.UserDTO" %>
<%
	BoardDTO rDTO = (BoardDTO)request.getAttribute("rDTO");
	int access = 1; //(작성자 : 2 / 다른 사용자: 1)
	if (session.getAttribute("user")==null) {
		access = 1;
	}else {
		UserDTO uDTO = (UserDTO) session.getAttribute("user");

		if (uDTO.getUser_no() == rDTO.getUser_no()) {
			access = 2;
		}
	}


	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>게시판 글쓰기</title>
	<!-- css 가져오기 -->
	<link rel="stylesheet" href="/css/semantic.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/css/bootstrap.min.css" rel="stylesheet" />
	<style>
		.input-file-button{
			padding: 6px 25px;
			background-color:#0d6efd;
			border-radius: 4px;
			color: white;
			cursor: pointer;
		}
		body {
			padding-top: 80px;
			background-color: #71dd8a;
		}
		.submitBtn{
			background-color: #00b5ad;
			border: #00b5ad;
		}

		body>.grid {
			height: 100%;
		}

		.image {
			margin-top: -100px;
		}

		.column {
			max-width: 850px;
			max-height: 1200px;
		}

	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script type="text/javascript">

		//작성자 여부체크
		function doOnload(){

			if ("<%=access%>"=="1"){
				alert("작성자만 수정할 수 있습니다.");
				location.href="/board/boardList";

			}
		}

		//전송시 유효성 체크
		function doSubmit(f){
			if(f.title.value == ""){
				alert("제목을 입력하시기 바랍니다.");
				f.title.focus();
				return false;
			}

			if(calBytes(f.title.value) > 200){
				alert("최대 200Bytes까지 입력 가능합니다.");
				f.title.focus();
				return false;
			}

			if(f.contents.value == ""){
				alert("내용을 입력하시기 바랍니다.");
				f.contents.focus();
				return false;
			}
			if (f.s2.value == ""){
				alert("코스를 선택해주시기 바랍니다");
				f.s2.focus();
				return false
			}

			if(calBytes(f.contents.value) > 4000){
				alert("최대 4000Bytes까지 입력 가능합니다.");
				f.contents.focus();
				return false;
			}


		}
			$(document).ready(function () {
				$("preview").click(function () {
					$(this).attr('src',"");
				})
			});

		//글자 길이 바이트 단위로 체크하기(바이트값 전달)
		function calBytes(str){

			var tcount = 0;
			var tmpStr = new String(str);
			var strCnt = tmpStr.length;

			var onechar;
			for (i=0;i<strCnt;i++){
				onechar = tmpStr.charAt(i);

				if (escape(onechar).length > 4){
					tcount += 2;
				}else{
					tcount += 1;
				}
			}

			return tcount;
		}
		function optionChange() {
			let jongju = [
				'남한강자전거길',
				'북한강 종주자전거길',
				'섬진강 종주자전거길',
				'오천자전거길',
				'아라 종주자전거길',
				'한강(서울) 종주자전거길',
				'새재 종주자전거길',
				'영산강 종주자전거길',
				'동해안(경북) 자전거길',
				'금강 종주자전거길',
				'한강 종주자전거길',
				'낙동강 종주자전거길',
				'동해안(강원) 자전거길',
				'한강 종주 자전거길',
				'제주환상자전거길'
			];
			let theme = [
				'화천역사생태공원길',
				'새재자전거길',
				'양수리-가평구간',
				'북한강 섬여행',
				'섬강, 남한강 넘나들기 1',
				'섬강 자전거길',
				'섬강, 남한강 넘나들기',
				'섬강 관동팔경길',
				'개발과 보존길',
				'섬강 자전거길',
				'강촌길',
				'금강 철새길',
				'19C 말 금강변길',
				'사비길',
				'남한강 등대 Tour',
				'삼랑진 은빛물결길',
				'부용대의 절개길',
				'과학문화길',
				'추억 만들기길',
				'행복한 소풍길',
				'문화의 향기길',
				'생명의 노래길',
				'남한강 섬여행',
				'북한강 자전거길',
				'강변오솔길',
				'상생의 노래길',
				'흑두루미 군무길',
				'역사의 숨결길',
				'그린웨이 자전거길',
				'남한강 자전거길',
				'화왕산 달빛기행길',
				'철새의 낙원길',
				'가사문학권 탐방로',
				'메타세쿼이아길',
				'직지와 미호종개길',
				'갈대의 노래길',
				'삼강주막과 노목길',
				'남한강자전거길2',
				'춘천 하늘자전거길',
				'화천 100리 산소길',
				'동강 자전거길',
				'DMZ 평화 자전거길',
				'향수 100리 자전거길',
				'탄금호 자전거길',
				'변산해변 자전거길',
				'금강포구 자전거길',
				'선유도 자전거길',
				'담양 힐링 자전거길',
				'마실길',
				'구림길',
				'회산백련지길',
				'황포돛배길',
				'의향길',
				'나주걷기길',
				'웅진길',
				'강변풀숲길',
				'의암호수변길',
				'영산강 느러지 자전거길',
				'상주 낙동강 자전거길',
				'경주 역사 탐방',
				'울릉도 자전거길',
				'남지 자전거길',
				'우포늪 생태 자전거길',
				'통영 자전거길',
				'원동 매화 자전거길'
			];
			let v = $( '#s1' ).val();
			let o;
			if ( v == 'jonCor' ) {
				o = jongju;
			} else if ( v == 'theCor' ) {
				o = theme;
			} else {
				o = [];
			}
			$( '#s2' ).empty();
			$( '#s2' ).append( '<option>코스명 선택</option>' );
			for ( let i = 0; i < o.length; i++ ) {
				$( '#s2' ).append( '<option>' + o[ i ] + '</option>' );
			}
		}
		function readURL(input) {
			$("#preview").attr('src',"");
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview').src = e.target.result;
					document.getElementById('preview').style.textAlign="left";
					document.getElementById('preview').style.width="450px";
					document.getElementById('preview').style.height="350px";
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				document.getElementById('preview').src = "";
			}
		}

	</script>
</head>
<body>
<!-- Navigation-->
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
		<form class="form-inline my-2 my-lg-0" onsubmit="return doSubmit(this);">
			<ul class="navbar-nav ms-auto">
				<% if(session.getAttribute("user") == null){%>
				<li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
				<%}%>
				<!--<form  required oninput="Show()">-->
				<% if(session.getAttribute("user") != null){%>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/admin">관리자 페이지</a></li>
				<%}%>
			</ul>
		</form>
	</div>
</nav>
<div class="ui middle aligned center aligned grid">
	<div class="column">
		<h2 class="ui teal image header">
			후기글 수정
		</h2>
		<form method="post" class="ui large form" encType="multipart/form-data" action="/boardUpdate" onsubmit="return doSubmit(this);">
			<div class="ui stacked segment">
				<div class="field">
					<h4 align="left">글 제목</h4>
					<input type="text" id="title" name="title" value="<%=rDTO.getTitle()%>" placeholder="제목" autocomplete="off" autofocus="autofocus">
					<input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
				</div>
				<div class="field">
					<h4 align="left">코스명</h4>
					<select id="s1" name="s1" onchange="optionChange();" readonly="">
						<option>코스선택</option>
						<option value="jonCor">종주코스</option>
						<option value="theCor">테마코스</option>
					</select>
					<select data-value="" id="s2" name="s2" readonly="">
						<option><%=rDTO.getCoursename()%></option>
					</select>
				</div>
				<div class="field">
					<h4 align="left">내용</h4>
					<div class="ui left icon input">
						<textarea style="resize: vertical;" id="contents" name="contents" placeholder="게시글 내용" rows="8"><%=rDTO.getContents()%></textarea>
					</div>
				</div>
				<div class="field">
					<label class="input-file-button" for="file">
						사진첨부
					</label>
					<input style="display: none;" type="file" id="file" name="file" onchange="readURL(this);">
					<input type="hidden" id="imgLink" name="imgLink" value="<%=rDTO.getImglink()%>">
					<% if (rDTO.getImglink() != ""){
						%>
					<img id="preview" style="height: 450px;width: 350px" src="<%=rDTO.getImglink()%>" />
					<%}else{%>
					<img id="preview" />
					<%}%>
				</div>
				<div class="ui fluid large teal submit button" type="submit" id="write_bbs">
					<input class="submitBtn" type="submit" value="후기 수정">
				</div>
			</div>
		</form>
	</div>
</div>
</body>

<%--<h2>후기글 수정</h2>
<form name="f" method="post" action="/boardUpdate" onsubmit="return doSubmit(this);">
	<input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
	&lt;%&ndash;<table border="1">
		<col width="100px" />
		<col width="500px" />
		<tr>
			<td align="center">제목</td>
			<td>
				<input type="text" name="title" maxlength="100"
					   value="<%=CmmUtil.nvl(rDTO.getTitle()) %>" style="width: 450px"/>
			</td>
		</tr>
		<tr>
			<td align="center">코스길</td>
			<td>
				<select id="s1" name="s1" onchange="optionChange();">
					<option>코스선택</option>
					<option value="jonCor">종주코스</option>
					<option value="theCor">테마코스</option>
				</select>
				<select id="s2" name="s2">
					<option>코스명 선택</option>
				</select>
				</p>
				<script>
					function optionChange() {
						let jongju = [
							'남한강자전거길',
							'북한강 종주자전거길',
							'섬진강 종주자전거길',
							'오천자전거길',
							'아라 종주자전거길',
							'한강(서울) 종주자전거길',
							'새재 종주자전거길',
							'영산강 종주자전거길',
							'동해안(경북) 자전거길',
							'금강 종주자전거길',
							'한강 종주자전거길',
							'낙동강 종주자전거길',
							'동해안(강원) 자전거길',
							'한강 종주 자전거길',
							'제주환상자전거길'
						];
						let theme = [
							'화천역사생태공원길',
							'새재자전거길',
							'양수리-가평구간',
							'북한강 섬여행',
							'섬강, 남한강 넘나들기 1',
							'섬강 자전거길',
							'섬강, 남한강 넘나들기',
							'섬강 관동팔경길',
							'개발과 보존길',
							'섬강 자전거길',
							'강촌길',
							'금강 철새길',
							'19C 말 금강변길',
							'사비길',
							'남한강 등대 Tour',
							'삼랑진 은빛물결길',
							'부용대의 절개길',
							'과학문화길',
							'추억 만들기길',
							'행복한 소풍길',
							'문화의 향기길',
							'생명의 노래길',
							'남한강 섬여행',
							'북한강 자전거길',
							'강변오솔길',
							'상생의 노래길',
							'흑두루미 군무길',
							'역사의 숨결길',
							'그린웨이 자전거길',
							'남한강 자전거길',
							'화왕산 달빛기행길',
							'철새의 낙원길',
							'가사문학권 탐방로',
							'메타세쿼이아길',
							'직지와 미호종개길',
							'갈대의 노래길',
							'삼강주막과 노목길',
							'남한강자전거길2',
							'춘천 하늘자전거길',
							'화천 100리 산소길',
							'동강 자전거길',
							'DMZ 평화 자전거길',
							'향수 100리 자전거길',
							'탄금호 자전거길',
							'변산해변 자전거길',
							'금강포구 자전거길',
							'선유도 자전거길',
							'담양 힐링 자전거길',
							'마실길',
							'구림길',
							'회산백련지길',
							'황포돛배길',
							'의향길',
							'나주걷기길',
							'웅진길',
							'강변풀숲길',
							'의암호수변길',
							'영산강 느러지 자전거길',
							'상주 낙동강 자전거길',
							'경주 역사 탐방',
							'울릉도 자전거길',
							'남지 자전거길',
							'우포늪 생태 자전거길',
							'통영 자전거길',
							'원동 매화 자전거길'
						];
						let v = $( '#s1' ).val();
						let o;
						if ( v == 'jonCor' ) {
							o = jongju;
						} else if ( v == 'theCor' ) {
							o = theme;
						} else {
							o = [];
						}
						$( '#s2' ).empty();
						$( '#s2' ).append( '<option>코스명 선택</option>' );
						for ( let i = 0; i < o.length; i++ ) {
							$( '#s2' ).append( '<option>' + o[ i ] + '</option>' );
						}
					}
				</script>
			</td>
		</tr>
		<tr>
			<td>
				내용
			</td>
			<td colspan="2">
				<textarea
						name="contents" style="width: 550px; height: 400px"
				><%=CmmUtil.nvl(rDTO.getContents()) %></textarea>
			</td>
		</tr>
		<tr>
			<td>
				이미지
			</td>
			<td>
				<c:set var="link" value="<%=CmmUtil.nvl(rDTO.getImglink())%>"></c:set>
				<c:choose>
					<c:when test="${link eq ''}">
					</c:when>
					<c:otherwise>
						<img src="<%=CmmUtil.nvl(rDTO.getImglink())%>" width="150px" height="150px">
						<input type="hidden" id="imgLink" name="imgLink" value="<%=CmmUtil.nvl(rDTO.getImglink())%>"/>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="수정" />
				<input type="reset" value="다시 작성" />
			</td>
		</tr>
	</table>&ndash;%&gt;
</form>
</body>--%>
</html>