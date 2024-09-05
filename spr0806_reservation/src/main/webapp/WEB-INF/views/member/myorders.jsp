<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div class="header-placeholder"></div>
<main>



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
                <div class="card-footer">
                	<a href="${pageContext.request.contextPath}/member/orderinfo?reservationNumber=${order.reservation_number}" class="button">상세보기</a>
                </div>
            </div>
        </c:forEach>
    </div>

</main>
    <style1>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        .card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #333;
        }

        .card-content {
            margin-bottom: 10px;
            color: #555;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-footer span {
            font-size: 0.9em;
            color: #888;
        }

        .button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        .button:hover {
            background-color: #0056b3;
        }
    </style1>
<%@include file="/WEB-INF/views/include/footer.jsp"%>