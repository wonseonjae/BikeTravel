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

			if(calBytes(f.contents.value) > 4000){
				alert("최대 4000Bytes까지 입력 가능합니다.");
				f.contents.focus();
				return false;
			}


		}

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

	</script>
</head>
<body onload="doOnload();">
<h2>글 수정</h2>
<form name="f" method="post" action="/boardUpdate" onsubmit="return doSubmit(this);">
	<input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
	<table border="1">
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
						$( '#s2' ).append( '<option></option>' );
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
	</table>
</form>
</body>
</html>