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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js">

	</script>
</head>
<body>
<h2>후기게시판</h2>
<hr/>
<br/>
<form method="get" action="/board/boardListCourse">
	<p>
		<select id="s1" name="s1" onchange="optionChange();">
			<option>코스선택</option>
			<option value="jonCor">종주코스</option>
			<option value="theCor">테마코스</option>
		</select>
		<select id="s2" name="s2">
			<option>코스명 선택</option>
		</select>
		<input type="submit" value="검색">
	</p>
</form>
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
</div>
</body>
</html>