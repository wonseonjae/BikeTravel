<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.WaitDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %><%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-06-08
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<WaitDTO> rList = (List<WaitDTO>) request.getAttribute("rList");
%>
<html>
<head>
    <title>가입신청 리스트</title>
    <script>
        function Accept(chk,wNo) {
            if (chk=="Y"){
                if (confirm('승인하시겠습니까?')===true){
            location.href="/club/joinAccept?chk="+chk+"&wNo="+wNo
                }
            }else {
                if (confirm('거절하시겠습니까?')===true){
                    location.href="/club/joinAccept?chk="+chk+"&wNo="+wNo
            }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');

        :root {
            --button-color: #ffffff;
            --button-bg-color: #0d6efd;
            --button-hover-bg-color: #025ce2;
        }

        .board_list_wrap {
            padding: 50px;
        }

        .board_list_head,
        .board_list_body .item {
            padding: 10px 0;
            font-size: 0;
        }

        .board_list_head {
            border-top: 2px solid green;
            border-bottom: 1px solid #ccc;
        }

        .board_list_body .item {
            border-bottom: 1px solid #ccc;
        }

        .board_list_head > div,
        .board_list_body .item > div {
            display: inline-block;
            text-align: center;
            font-size: 14px;
        }

        .board_list_head > div {
            font-weight: 600;
        }

        .board_list .num {
            width: 10%;
        }

        .board_list .tit {
            width: 30%;
        }

        .board_list_body div.tit {
            text-align: left;
        }

        .board_list_body div.tit a:hover {
            text-decoration: underline;
        }

        .board_list .writer {
            width: 10%;
        }

        .board_list .date {
            width: 20%;
        }

        .board_list .view {
            width: 30%;
        }
        button {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;

            background: var(--button-bg-color);
            color: var(--button-color);

            margin: 0;
            padding: 0.5rem 1rem;

            font-family: 'Noto Sans KR', sans-serif;
            font-size: 1rem;
            font-weight: 400;
            text-align: center;
            text-decoration: none;

            border: none;
            border-radius: 4px;

            display: inline-block;
            width: auto;

            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);

            cursor: pointer;

            transition: 0.5s;
        }
        button.success {
            --button-bg-color: #28a745;
            --button-hover-bg-color: #218838;
        }
    </style>
    <link rel="stylesheet" href="/css/table.css">
</head>
<body>
<!--경계선-->
<div style="border-radius: 1%"  class="board_list_wrap">
    <div class="board_list">
        <div class="board_list_head">
            <div style="color:#1b1c1d" class="writer">이름</div>
            <div style="color:#1b1c1d" class="tit">주소</div>
            <div style="color:#1b1c1d" class="view">가입인사</div>
            <div style="color:#1b1c1d" class="date">작성일</div>
        </div>
            <%
							for (int i = 0; i < rList.size(); i++) {
								WaitDTO rDTO = rList.get(i);

								if (rDTO == null) {
									rDTO = new WaitDTO();
								}
						%>
        <div class="board_list_body">
            <div class="item">
                <div style="color:#1b1c1d" class="writer"><p><%=CmmUtil.nvl(rDTO.getName()) %></p></div>
                <div style="color:#1b1c1d" class="tit">
                    <a class="move">
                        <%=CmmUtil.nvl(rDTO.getAddress())%>
                    </a>
                </div>
                <div style="color:#1b1c1d" class="view"><%=CmmUtil.nvl(String.valueOf(rDTO.getGreeting()))%></div>
                <div style="color:#1b1c1d" class="date"><%=CmmUtil.nvl(rDTO.getRegdate()) %></div>
            </div>
            <button type="button" class="success" onclick="Accept('Y',<%=rDTO.getWait_no()%>)" value="승인">승인</button>
            <button type="button" class="success" onclick="Accept('N',<%=rDTO.getWait_no()%>)" value="거절">거절</button>
        </div>
            <%}%>
    </div>
</div>

</body>
</html>
