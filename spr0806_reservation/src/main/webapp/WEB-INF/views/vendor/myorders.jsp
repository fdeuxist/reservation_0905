<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
/* styles.css */

.header-placeholder {
    height: 60px; /* 헤더 높이와 동일하게 설정 */
}

.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center; /* 제목 중앙 정렬 */
}

.orders-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.orders-table th,
.orders-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.orders-table th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.orders-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.orders-table tr:hover {
    background-color: #f1f1f1;
}

</style>
<div class="header-placeholder"></div>
<main>
        <br><br><h1>주문 내역</h1><br>
    <div class="container">
        
        <table class="orders-table">
            <thead>
                <tr>
                    <th>예약주문 번호</th>
                    <th>예약 날짜</th>
                    <th>이용 예정 날짜</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${dtoList}">
                    <tr>
                        <td><a href="${pageContext.request.contextPath}/vendor/orderinfo?reservationNumber=${order.reservation_number}">${order.reservation_number}</a></td>
                        <td>${order.reservation_date}</td>
                        <td>${order.reservation_use_date}</td>
                        <td>
                        	<c:choose>
		                    <c:when test="${order.status == 1}">입금대기</c:when>
		                    <c:when test="${order.status == 2}">입금완료</c:when>
		                    <c:when test="${order.status == 3}">이용완료</c:when>
		                    <c:when test="${order.status == 4}">취소대기</c:when>
		                    <c:when test="${order.status == 5}">취소완료</c:when>
		                    <c:when test="${order.status == 6}">환불대기</c:when>
		                    <c:when test="${order.status == 7}">환불완료</c:when>
		                	</c:choose>
                        </td>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>
