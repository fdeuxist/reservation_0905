<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>

body {
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}

#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}
</style>
<div class="header-placeholder"></div>
<main>

    <div id="container282">
        <div class="empty-space"></div>
        <div>
    <h2>예약 정보 확인</h2>
    
    <form:form action="/ex/member/reservationComplete" id="reservationCompleteFrm" method="post" modelAttribute="dto">
        <!-- 예약(주문)번호 -->
            <%--<form:input path="reservation_number" id="reservationNumber" type="hidden" /> --%>
            <input class="form-control" name="reservation_number" id="reservationNumber" type="hidden" />
        <div>
            <label for="userEmail">회원 이메일:</label>
            <form:input class="form-control" path="user_email" id="userEmail" type="text" />
        </div>
        <div>
            <label for="userName">예약자 이름:</label>
            <form:input class="form-control" path="user_name" id="userName" type="text" />
        </div>
        <div>
            <label for="userPhone">예약자 전화번호:</label>
            <form:input class="form-control" path="user_phone" id="user_phone" type="text" />
        </div>
        <div>
            <label for="vendorEmail">사업자 이메일:</label>
            <form:input class="form-control" path="vendor_email" id="vendorEmail" type="text" value="${sessionScope.selectedItemsDto.email}"/>
        </div>
        <!-- 사업자등록번호: -->
            <form:input path="business_regi_num" id="businessRegiNum" type="hidden" value="${sessionScope.selectedItemsDto.business_regi_num}"/>
        <div>
            <label for="vendorName">장소 이름(간판명):</label>
            <form:input class="form-control" path="business_name" id="business_name" type="text" />
        </div>
        <div>
            <label for="vendorName">사업자 이름:</label>
            <form:input class="form-control" path="vendor_name" id="vendorName" type="text" />
        </div>
        <div>
            <label for="vendorPhone">사업자 전화번호:</label>
            <form:input class="form-control" path="vendor_phone" id="vendorPhone" type="text" />
        </div>
        <div>
            <label for="zipcode">우편번호:</label>
            <form:input class="form-control" path="zipcode" id="zipcode" type="text" />
        </div>
        <div>
            <label for="basicAddress">기본 주소:</label>
            <form:input class="form-control" path="basic_address" id="basicAddress" type="text" />
        </div>
        <div>
            <label for="detailAddress">상세 주소:</label>
            <form:input class="form-control" path="detail_address" id="detailAddress" type="text" />
        </div>
        <div>
            <!-- 예약 발생 날짜: -->
            <%--<form:input path="reservation_date" id="reservationDate" type="text"/>--%>
            <input name="reservation_date" id="reservationDate" type="hidden" />
        </div>
        <div>
            <label for="reservationUseDate">이용 예정 날짜:</label>
            <form:input class="form-control" path="reservation_use_date" id="reservationUseDate" type="text"/>
        </div>
        <div>
            <!-- 이용 예정 시간 값: -->
            <form:input path="times" id="times" type="hidden" />
        </div>
        <div>
            <label for="times">이용 예정 시간 HH:mm :</label>
            <form:input class="form-control" path="times_hhmm" id="times_hhmm" type="text" />
        </div>
        <div>
            <label for="totalServiceName">이용 예정 서비스 이름들:</label>
            <form:textarea class="form-control" path="total_service_name" id="totalServiceName" rows="2" cols="40"></form:textarea>
        </div>
        <div>
            <label for="totalServicePrice">서비스 가격 총 합:</label>
            <form:input class="form-control" path="total_service_price" id="totalServicePrice" type="number" />
        </div>
        <div>
            <label for="totalRequiredTime">예상 필요 시간 총 합:</label>
            <form:input class="form-control" path="total_required_time" id="totalRequiredTime" type="number" />
        </div>
        <div>
            <label for="userRequestMemo">유저 요청사항 메모:</label>
            <form:textarea class="form-control" path="user_request_memo" id="userRequestMemo" rows="5" cols="40"></form:textarea>
        </div>
        
        <!-- 주문 상태 
        <div>
            <label for="status">주문 상태:</label>
            <form:select path="status" id="status">
                <option value="1">입금대기</option>
                <option value="2">입금완료</option>
                <option value="3">이용완료</option>
                <option value="4">취소대기</option>
                <option value="5">취소완료</option>
                <option value="6">환불대기</option>
                <option value="7">환불완료</option>
            </form:select>
        </div>
-->

        <div>
            <button class="btn btn-success mt-3" type="submit" id="submitBtn">예약 하기</button>
        </div>
    </form:form>
    </div>
        <div class="empty-space"></div>
    </div>
<br><br><br>
</main>
<script>


	function generateReservationNumber() {
		let now = new Date();
		return now.getFullYear().toString()
				+ (now.getMonth() + 1).toString().padStart(2, '0')	//월은 0부터 시작
				+ now.getDate().toString().padStart(2, '0')
				+ now.getHours().toString().padStart(2, '0')
				+ now.getMinutes().toString().padStart(2, '0')
				+ now.getSeconds().toString().padStart(2, '0')
				+ now.getMilliseconds().toString().padStart(3, '0');
	}
	
	function getCurrentDate() {
	    let now = new Date();
	    let year = now.getFullYear();
	    let month = (now.getMonth() + 1).toString().padStart(2, '0');
	    let day = now.getDate().toString().padStart(2, '0');
	    
	    return year + '-' + month + '-' + day;
	}
	
	// 폼 제출 이벤트 처리
	document.addEventListener("DOMContentLoaded", function() {
	    // submit 버튼을 눌렀을 때 이벤트 발생
	    document.getElementById("submitBtn").addEventListener("click", function(event) {
	        event.preventDefault(); // 기본 submit 이벤트 막기
	        
	        // 예약 번호와 예약 발생일 설정
	        let reservationNumber = generateReservationNumber();
	        let reservationDate = getCurrentDate();
	        
	        document.getElementById("reservationNumber").value = reservationNumber;
	        document.getElementById("reservationDate").value = reservationDate;
	        
	        // 폼 제출
	        document.getElementById("reservationCompleteFrm").submit();
	    });
    });
	
</script>
<%@include file="../include/footer.jsp"%>