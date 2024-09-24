<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
</style>
<div class="header-placeholder"></div>
<main>

<%--
<form action="<c:url value='/member/searchplacebt'/>" method="post">
    business_type <br>
    <input type="text" id="business_type" name="business_type" required>
    <button type="submit">search by business_type</button>
</form>
<br>

<form action="<c:url value='/member/searchplaceba'/>" method="post">
    basic_address<br>
    <input type="text" id="basic_address" name="basic_address" required>
    <button type="submit">search by '%basic_address%'</button>
</form>
--%>
 
<c:if test="${not empty spList}">
    <%--
    <table border="1">
        <thead>
            <tr>
                <th>Email</th>
                <th>Business Registration Number</th>
                <th>Business Name</th>
                <th>Business Type</th>
                <th>Zipcode</th>
                <th>Basic Address</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="place" items="${spList}">
                <tr>
                    <td>${place.business_type}</td>
                    <td>${place.business_name}</td>
                    <td>
                        <a href="<c:url value='/member/businessplaceinfo?email=${place.email}&business_regi_num=${place.business_regi_num}'/>">
                            ${place.business_name}
                        </a>
                    </td>
                    <td>${place.place_info}</td>
                    <td>${place.phone}</td>
                    <td>${place.basic_address}${place.detail_address}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
     --%>
    <div class="container">
    <div class="row">
        <c:forEach var="place" items="${spList}">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${place.business_name}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">${place.business_type}</h6>
                        <p class="card-text">
                            <i class="fa-solid fa-phone"></i> ${place.phone}<br>
                            <i class="fa-solid fa-map-location-dot"></i> ${place.basic_address}${place.detail_address}<br>
                        </p>
                        <a href="<c:url value='/member/businessplaceinfo?email=${place.email}&business_regi_num=${place.business_regi_num}'/>" class="btn btn-primary">상세보기</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</c:if>

<c:if test="${empty spList}">
<div class="container">
    <div class="row mx-auto">
	    <div class="col-md-4 mb-4 mx-auto">
            <div class="card">
				<div class="card-body">
					<h5 class="card-title text-center"><i class="fa-solid fa-circle-exclamation"></i></h5>
                    <h6 class="card-subtitle mb-2 text-muted">검색된 장소가 없습니다.</h6>
                    <p class="card-text">
                        <i class="fa-solid fa-phone"></i><br>
                        <i class="fa-solid fa-map-location-dot"></i> <br>
                    </p>
                    <%--<a href="<c:url value='/member/businessplaceinfo?email=${place.email}&business_regi_num=${place.business_regi_num}'/>" class="btn btn-primary">상세보기</a> --%>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>
<%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
 --%>
</main>
<%@include file="../include/footer.jsp"%>
