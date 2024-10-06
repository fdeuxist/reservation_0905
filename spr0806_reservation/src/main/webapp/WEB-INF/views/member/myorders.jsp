<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div class="header-placeholder"></div>
<main>
<div class="m-5">
	<c:forEach var="order" items="${myOrderList}">
		<div class="card mt-3 ml-3 mr-3">
			<div class="card-body">
				<div class="card-title">예약 주문번호 : ${order.reservation_number}</div>
				<div class="card-text">
					<strong>예약 장소:</strong> ${order.business_name} <br>
					<strong>이용예정 날짜:</strong> ${order.reservation_use_date} <br>
					<strong>예약 시간 :</strong> ${order.times_hhmm} <br>
					<strong>주문상태 :</strong>
					<c:choose>
					<c:when test="${order.status == 1}">입금대기</c:when>
					<c:when test="${order.status == 2}">입금완료</c:when>
					<c:when test="${order.status == 3}">이용완료</c:when>
					<c:when test="${order.status == 4}">취소대기</c:when>
					<c:when test="${order.status == 5}">취소완료</c:when>
					<c:when test="${order.status == 6}">환불대기</c:when>
					<c:when test="${order.status == 7}">환불완료</c:when>
					</c:choose>
				</div>
				<div class="card-text">
				<a class="btn btn-primary" href="${pageContext.request.contextPath}/member/orderinfo?reservationNumber=${order.reservation_number}">상세보기</a>
				<c:choose><c:when test="${order.status == 3}">
				<a class="btn btn-success" href="${pageContext.request.contextPath}/member/orderinfo?reservationNumber=${order.reservation_number}#card-footer">이용후기작성하기</a>
				</c:when></c:choose>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<div class="container mt-2">
</div>
        	
<%--
        <div>
			<c:choose>
		    <c:when test="${order.status == 3}">
	        	
	        </c:when>
	        </c:choose>
        </div>
		</div>
 --%>

<%--
    <div class="container">
        <c:forEach var="order" items="${myOrderList}">
            <div class="card">
                <div class="card-header">
                    예약주문번호 : ${order.reservation_number}
                </div>
                <div class="card-content">
                    <strong>예약 장소:</strong> ${order.business_name} <br>
                    <strong>이용예정 날짜:</strong> ${order.reservation_use_date} <br>
                    <strong>예약 시간 :</strong> ${order.times_hhmm} <br>
                    <strong>주문상태 :</strong>
                    <c:choose>
	                    <c:when test="${order.status == 1}">입금대기</c:when>
	                    <c:when test="${order.status == 2}">입금완료</c:when>
	                    <c:when test="${order.status == 3}">이용완료</c:when>
	                    <c:when test="${order.status == 4}">취소대기</c:when>
	                    <c:when test="${order.status == 5}">취소완료</c:when>
	                    <c:when test="${order.status == 6}">환불대기</c:when>
	                    <c:when test="${order.status == 7}">환불완료</c:when>
                	</c:choose>
                </div>
                <div class="c">
                	<a href="${pageContext.request.contextPath}/member/orderinfo?reservationNumber=${order.reservation_number}" class="button">상세보기</a>
                </div>
            </div>
        </c:forEach>
    </div>
 --%>
</main>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
</style>
<%@include file="/WEB-INF/views/include/footer.jsp"%>