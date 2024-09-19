<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>


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

<c:if test="${not empty vendorList}">
    <h3>검색 결과:</h3>
    <table border="1">
        <thead>
            <tr>
                <th>Email</th>
                <th>Business Registration Number</th>
                <th>Business Name</th>
                <th>Business Type</th>
                <th>Zipcode</th>
                <th>Basic Address</th>
                <th>Detail Address</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="vendor" items="${vendorList}">
                <tr>
                    <td>${vendor.email}</td>
                    <td>${vendor.business_regi_num}</td>
                    <td>
                        <a href="<c:url value='/member/businessplaceinfo?email=${vendor.email}&business_regi_num=${vendor.business_regi_num}'/>">
                            ${vendor.business_name}
                        </a>
                    </td>
                    <td>${vendor.business_type}</td>
                    <td>${vendor.zipcode}</td>
                    <td>${vendor.basic_address}</td>
                    <td>${vendor.detail_address}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
 --%>
</main>
<%@include file="../include/footer.jsp"%>
