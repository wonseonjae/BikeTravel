<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.PageMakeDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("list");
	String s1 = (String) request.getAttribute("s1");
	System.out.println(s1);
	String s2 = (String) request.getAttribute("s2");
	System.out.println(s2);

//게시판 조회 결과 보여주기
	if (rList == null) {
		rList = new ArrayList<BoardDTO>();

	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>후기 게시판</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<style>
		a{
			text-decoration : none;
		}
		table{
			border-collapse: collapse;
			width: 1000px;
			margin-top : 20px;
			text-align: center;
		}
		td, th{
			border : 1px solid black;
			height: 50px;
		}
		th{
			font-size : 17px;
		}
		thead{
			font-weight: 700;
		}
		.table_wrap{
			margin : 50px 0 0 50px;
		}
		.bno_width{
			width: 12%;
		}
		.writer_width{
			width: 20%;
		}
		.regdate_width{
			width: 15%;
		}
		.updatedate_width{
			width: 15%;
		}
		.top_btn{
			font-size: 20px;
			padding: 6px 12px;
			background-color: #fff;
			border: 1px solid #ddd;
			font-weight: 600;
		}
		.pageInfo{
			list-style : none;
			display: inline-block;
			margin: 50px 0 0 100px;
		}
		.pageInfo li{
			float: left;
			font-size: 20px;
			margin-left: 18px;
			padding: 7px;
			font-weight: 500;
		}
		a:link {color:black; text-decoration: none;}
		a:visited {color:black; text-decoration: none;}
		a:hover {color:black; text-decoration: underline;}
		.active{
			background-color: #cdd5ec;
		}
		.search_area{
			display: inline-block;
			margin-top: 30px;
			margin-left: 260px;
		}
		.search_area input{
			height: 30px;
			width: 250px;
		}
		.search_area button{
			width: 100px;
			height: 36px;
		}
		.search_area select{
			height: 35px;
		}

	</style>
</head>
<body>
<form method="get" action="/board/listByCourse">
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
	function doDetail(bNo) {
		location.href = "/board/boardInfo?bNo=" + bNo;
	}
	function doPaging(pNo) {
		let loc = window.location.href;
		location.href = loc+"&pNo="+pNo;
	}
</script>


<div class="table_wrap">
	<table>
		<thead>
		<tr>
			<th class="bno_width">번호</th>
			<th class="bno_width">코스명</th>
			<th class="title_width">제목</th>
			<th class="writer_width">작성자</th>
			<th class="regdate_width">작성일</th>
		</tr>
		</thead>
		<%
			for (int i = 0; i < rList.size(); i++) {
				BoardDTO rDTO = rList.get(i);

				if (rDTO == null) {
					rDTO = new BoardDTO();
				}

		%>
		<tr>
			<td>
				<%=CmmUtil.nvl(String.valueOf(rDTO.getBoard_no()))%>
			</td>
			<td align="center">
				<%=CmmUtil.nvl(rDTO.getCoursename()) %>
			</td>
			<td align="center">
				<a class="move" href="javascript:doDetail('<%=rDTO.getBoard_no()%>');">
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
	<div class="pageInfo_wrap" >
		<div class="pageInfo_area">
			<a href="/board/boardWrite" class="top_btn">후기 등록</a>
			<ul id="pageInfo" class="pageInfo">

				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
				</c:if>
				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="/board/listByCourse?s1=<%=s1%>&s2=<%=s2%>&pNo=${num}">${num}</a></li>
				</c:forEach>

				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>

			</ul>
		</div>
	</div>
	<form id="moveForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
	</form>
</div>

</body>
</html>