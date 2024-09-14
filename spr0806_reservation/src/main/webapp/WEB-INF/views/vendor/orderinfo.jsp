<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="header-placeholder"></div>
<main>
    <div class="order-card">
        <h3>주문 상세 정보</h3>
        <p><span class="label">예약번호:</span> ${myOrder.reservation_number}</p>
        <p><span class="label">예약자 Email:</span> ${myOrder.user_email}</p>
        <p><span class="label">예약자 전화번호:</span> ${myOrder.user_phone}</p>
        <p><span class="label">예약자 이름:</span> ${myOrder.user_name}</p><br><br>
        <p><span class="label">사업자 이름:</span> ${myOrder.vendor_name}</p>
        <p><span class="label">사업자 전화번호:</span> ${myOrder.vendor_phone}</p>
        <p><span class="label">장소 이름:</span> ${myOrder.business_name}</p>
        <p><span class="label">주소:</span> ${myOrder.zipcode} </p>
        <p><span class="label"></span> ${myOrder.basic_address}</p>
        <p><span class="label"></span> ${myOrder.detail_address}</p>
        <p><span class="label">이용(방문)예정일:</span> ${myOrder.reservation_use_date}"</p>
        <p><span class="label">이용예정 시간:</span> ${myOrder.times_hhmm}</p>
        <p><span class="label">예약 목록:</span> ${myOrder.total_service_name}</p>
        <p><span class="label">예약 금액:</span> ${myOrder.total_service_price}</p>
        <p><span class="label">예상 소요 시간:</span> ${myOrder.total_required_time}</p>
        <p><span class="label">주문자 메모:</span> ${myOrder.user_request_memo}</p>
        <p><span class="label">주문 상태:</span>
        	<c:choose>
                <c:when test="${myOrder.status == 1}">입금대기</c:when>
                <c:when test="${myOrder.status == 2}">입금완료</c:when>
                <c:when test="${myOrder.status == 3}">이용완료</c:when>
                <c:when test="${myOrder.status == 4}">취소대기</c:when>
                <c:when test="${myOrder.status == 5}">취소완료</c:when>
                <c:when test="${myOrder.status == 6}">환불대기</c:when>
                <c:when test="${myOrder.status == 7}">환불완료</c:when>
           	</c:choose>
        </p>
        <input type="hidden" id="reservationNumber" value="${myOrder.reservation_number}">
        <input type="hidden" id="status" value="${myOrder.status}">
        <c:if test="${myOrder.status == 4 || myOrder.status == 6}">
        	<input type="button" id="confirmCancel" value="취소/환불 승인">
        </c:if>
        <c:if test="${myOrder.status == 1 || myOrder.status == 2}">
	        <input type="button" id="confirmCancel" value="강제취소,환불하기">
        </c:if>
    </div>
</main>
<script>
$(function() {

    $("#confirmCancel").click(function() {
    	
    	var userConfirmed = confirm("예약의 취소를 승인합니다.");
        
        if (userConfirmed) {
	        var email = $("#loginEmail").val();
	        var reservationNumber = $("#reservationNumber").val();
	        var status = $("#status").val();
	        console.log(email, reservationNumber, status);	//member 2024082613221338 1
	        $.ajax({
	            url: '/ex/vendorrest/confirmCancel',
	            method: 'POST',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify({
	                email: email,
	                reservationNumber: reservationNumber,
	                status: status
	            }),
	            success: function(response) {
	                //console.log(response.message);
	                window.location.href = "/ex/vendor/orderinfo?reservationNumber=" + reservationNumber;
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
        	});
        }
    });
    
});
</script>

<style>
/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* 메인 컨텐츠 영역 스타일 */
main {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

/* 주문 상세 정보 카드 스타일 */
.order-card {
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 카드 제목 스타일 */
.order-card h3 {
    margin-top: 0;
    font-size: 24px;
    color: #333;
}

/* 카드 내 항목 스타일 */
.order-card p {
    margin: 8px 0;
    font-size: 16px;
    color: #555;
}

/* 레이블 스타일 */
.order-card .label {
    font-weight: bold;
    color: #333;
}

/* 주소 항목의 추가 스타일 */
.order-card p span:not(.label) {
    display: block;
    margin-top: 4px;
}

/* 공백 스타일 */
.order-card br {
    content: "\A";
    white-space: pre;
}
</style>
<%@include file="/WEB-INF/views/include/footer.jsp"%>