<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
    background-color: #f4f4f4;
}
</style>
<div class="header-placeholder"></div>
<main>
    <div class="container">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">주문 상세 정보</h3>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">예약번호</th>
                        <td>${myOrder.reservation_number}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 이름</th>
                        <td>${myOrder.user_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 전화번호</th>
                        <td>${myOrder.user_phone}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 Email</th>
                        <td>${myOrder.user_email}</td>
                    </tr>
                  </tbody>
            </table>
        <div class="border-top my-3"></div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">사업자 이름</th>
                        <td>${myOrder.vendor_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">사업자 전화번호</th>
                        <td>${myOrder.vendor_phone}</td>
                    </tr>
                    <tr>
                        <th scope="row">장소 이름</th>
                        <td>${myOrder.business_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td>
                            ${myOrder.zipcode}<br>
                            ${myOrder.basic_address}<br>
                            ${myOrder.detail_address}
                        </td>
                    </tr>
                  </tbody>
            </table>
        <div class="border-top my-3"></div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">이용(방문)예정일</th>
                        <td>${myOrder.reservation_use_date}</td>
                    </tr>
                    <tr>
                        <th scope="row">이용(방문)예정 시간</th>
                        <td>${myOrder.times_hhmm}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약 목록</th>
                        <td>${myOrder.total_service_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약 금액</th>
                        <td>${myOrder.total_service_price}</td>
                    </tr>
                    <tr>
                        <th scope="row">예상 소요 시간</th>
                        <td>${myOrder.total_required_time}</td>
                    </tr>
                    <tr>
                        <th scope="row">주문자 메모</th>
                        <td>${myOrder.user_request_memo}</td>
                    </tr>
                    <tr>
                        <th scope="row">주문 상태</th>
                        <td>
                            <c:choose>
                                <c:when test="${myOrder.status == 1}">입금대기</c:when>
                                <c:when test="${myOrder.status == 2}">입금완료</c:when>
                                <c:when test="${myOrder.status == 3}">이용완료</c:when>
                                <c:when test="${myOrder.status == 4}">취소대기</c:when>
                                <c:when test="${myOrder.status == 5}">취소완료</c:when>
                                <c:when test="${myOrder.status == 6}">환불대기</c:when>
                                <c:when test="${myOrder.status == 7}">환불완료</c:when>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="hidden" id="reservationNumber" value="${myOrder.reservation_number}">
            <input type="hidden" id="status" value="${myOrder.status}">
        </div>
        <div class="card-footer">
            <c:if test="${myOrder.status == 4 || myOrder.status == 6}">
                <button class="btn btn-success" id="confirmCancel">취소/환불 승인</button>
            </c:if>
            <c:if test="${myOrder.status == 1 || myOrder.status == 2}">
                <button class="btn btn-danger" id="confirmCancel">강제취소/환불하기</button>
            </c:if>
        </div>
    </div>
</div>
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

<%@include file="/WEB-INF/views/include/footer.jsp"%>