<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page import="kopo.poly.dto.CertificationDTO" %>
<%@ page import="kopo.poly.dto.BikeCertificateDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: data12
  Date: 2022-10-10
  Time: 오후 3:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<CertificationDTO> rList = (List<CertificationDTO>) request.getAttribute("rList");
    List<BikeCertificateDTO> dList = (List<BikeCertificateDTO>) request.getAttribute("cList");
    String courseName = (String) request.getAttribute("courseName");
%>
<html>
<head>
    <title><%=courseName%></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"/>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/album/">
</head>
<body>
<header>
    <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a href="#" class="navbar-brand d-flex align-items-center">
                <img src="/image/bike.jpg" height="35" width="35">
                <strong>자전거여행</strong>
            </a>
        </div>
    </div>
</header>

<main>
    <div class="album py-5 bg-light">
        <div class="container">
            <div style="text-align: center;" class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <%
                            int res = 0;
                            for (CertificationDTO cDTO : rList) {
                                if (Objects.equals(cDTO.getCourseName(), courseName)) {
                        for (BikeCertificateDTO dDTO : dList) {
                        if (Objects.equals(cDTO.getCheckPoint(), dDTO.getCertificate())) {
                        %>
                <div class="col">
                    <div class="card shadow-sm">
                        <img style="background-color: #55595c" src='https://biketravel.s3.ap-northeast-2.amazonaws.com/passstamp.png' class="bd-placeholder-img card-img-top"/></svg>
                        <div class="card-body">
                            <strong class="card-text"><%=dDTO.getCertificate()%></strong>
                            <p class="card-text"><%=dDTO.getReg_dt().substring(0,16)%></p>
                            <div class="d-flex justify-content-between align-items-center">
                            </div>
                        </div>
                    </div>
                </div>
                        <%   break;  }%>
                <div class="col">
                    <div class="card shadow-sm">
                        <svg class="bd-placeholder-img card-img-top" width="300px" height="200px" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#ffffff" dy=".2em">미완주</text></svg>
                        <div class="card-body">
                            <strong class="card-text"><%=cDTO.getCheckPoint()%></strong>
                            <br/>
                        </div>
                    </div>
                </div>
                <%

                            }
                        %>
                        <%}%>
                        <%}%>
            </div>
        </div>
    </div>
</main>

</body>
</html>
