<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<style>

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    text-align: center;
}

.div1 {
    display: grid;
    grid-template-columns: 1fr;
    margin: 0 auto;
}

#datepicker {
    padding: 15px;
    font-size: 23px;
    border-radius: 5px;
    border: 1px solid gray;
    text-align: center;
}

#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}

#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}

#time-buttons {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 5px;
    margin-top: 20px;
}

.time-slot {
    background-color: white;
    transition: background-color 0.4s;
    padding: 10px;
    text-align: center;
    border: 1px solid gray;
    cursor: pointer;
    border-radius: 5px;
}

.time-slot.selected {
    background-color: #FFEB33;
    color: #535252;
    transition: background-color 0.4s;
}

#submitBtn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 19px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin: 5px;
    display: inline-block;
    background-color: #ffc107;
}

#submitBtn:hover:enabled {
    background-color: #e0a800;
}


/* 예약 가능한 버튼 스타일 */
.time-slot.available {
    background-color: #FFFFFF;	/* 흰색  */
    color: #3C1E1E;
}

.time-slot.selected {
	background-color: #FFEB33;	/* 노란색  */
	color: #3C1E1E;
}

/* 예약 불가능 버튼 스타일 */
.time-slot.unavailable {
    background-color: #CCCCCC; 	/* 회색  */
    color: #a0a0a0;
    cursor: not-allowed;
}



#nextStepBtn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin: 5px;
    display: inline-block;
    background-color: #ffc107;
}

#nextStepBtn:hover:enabled {
    background-color: #e0a800;
}


</style>

<div class="header-placeholder"></div>
<div class="content">
<br><br>
    <!-- 
★loginEmail: [${sessionScope.loginEmail}] , <br>
★loginName: [${sessionScope.loginName}]<br>
★loginPhone: [${sessionScope.loginPhone}] , <br>
 -->
<br>

    <input type="hidden" id="vendorEmail" value="${sessionScope.selectedItemsDto.email}">
    <input type="hidden" id="vendorBusiness_regi_num" value="${sessionScope.selectedItemsDto.business_regi_num}">
    <input type="hidden" id="datepicker" placeholder="날짜를 선택하세요">
<input type="hidden" id="vendor_email" value="${sessionScope.selectedItemsDto.email}"  data-comment="★vendorEmail: ">
<input type="hidden" id="business_regi_num" value="${sessionScope.selectedItemsDto.business_regi_num}"  data-comment="★vendorBusiness_regi_num: ">
<!-- ★reeservationDate는다음페이지에서 생성<br> -->
<input type="hidden" id="selected_date" value="${selectedDate}"  data-comment="★reservationUseDate=selectedDate ">
<input type="hidden" id="timevalues" value=""  data-comment="★timevalues ">
<input type="hidden" id="selectedDate" value="${selectedDate}" readonly data-comment="★이용예정날짜 yyyy-MM-dd형식">
<input type="hidden" id="selectedTime" readonly data-comment="★이용예정시간 HH:mm형식">
<input type="hidden" id="" value="${sessionScope.myPickServiceNames }" data-comment="★서비스 이름들 ">
<input type="hidden" id="" value="${sessionScope.selectedItemsDto.totalServicePrice}" data-comment="★서비스 가격 총 합 :  ">
<input type="hidden" id="" value="${sessionScope.selectedItemsDto.totalRequiredTime}" data-comment="★제공(필요)시간 총 합 ">

<%-- 
selectedItems: [${sessionScope.selectedItemsDto.selectedItems}] ,<br><br><br>
selectedItemsDto: [<input type="txt" id="seletedItemsDto" value="${sessionScope.selectedItemsDto}">] ,<br>

<br>
<br><br>
selectedItemsDto
<input type="text" id="selectedItemsDto" value="${sessionScope.selectedItemsDto}"><br>
selectedItemsDto.email
<input type="text" id="selectedItemsDto" value="${sessionScope.selectedItemsDto.email}"><br>
selectedItemsDto.business_regi_num
<input type="text" id="selectedItemsDto" value="${sessionScope.selectedItemsDto.business_regi_num}"><br>
selectedItemsDto.totalRequiredTime
<input type="text" id="selectedItemsDto" value="${sessionScope.selectedItemsDto.totalRequiredTime}"><br>
selectedItemsDto.totalServicePrice
<input type="text" id="selectedItemsDto" value="${sessionScope.selectedItemsDto.totalServicePrice}"><br>
 --%>
<%-- 다음 주문확인 페이지에서 정보들 정리해서 userreservation테이블로 넘기면 주문완료 --%>
<div class="div1">
	<div id="container444">
        <div class="empty-space"></div>
    		<h3>${selectedDate}<br>예약(이용/방문) 시간 선택</h3>
        <div class="empty-space"></div>
   	</div>
    <div id="container282">
        <div class="empty-space"></div>
        	<div id="time-buttons"></div>
        <div class="empty-space"></div>
    </div>
    <!-- 
    <button type="button" id="getSubmitBtn">g</button>
    <button type="button" id="nextStepBtn">다음단계</button> -->
    
    <div id="container444">
        <div class="empty-space"></div>
		    <form action="/ex/member/memberReservation" method="POST">
		    <br>
		        <button type="submit" id="nextStepBtn">다음단계</button>
		        <input type="hidden" id="user_email" name="user_email" value="${sessionScope.loginEmail}"><br>
		        <input type="hidden" id="user_name" name="user_name" value="${sessionScope.loginName}" ><br>
		        <input type="hidden" id="user_phone" name="user_phone" value="${sessionScope.loginPhone}" ><br>
		        <input type="hidden" id="vendor_email" name="vendor_email" value="${sessionScope.selectedItemsDto.email}" ><br>
		        <input type="hidden" id="business_regi_num" name="business_regi_num" value="${sessionScope.selectedItemsDto.business_regi_num}" ><br>
		        <input type="hidden" id="reservation_use_date" name="reservation_use_date" value="${selectedDate}"><br>
		        <input type="hidden" id="times" name="times" value=""><br>
		        <input type="hidden" id="times_hhmm" name="times_hhmm" value=""><br><!-- HH:mm -->
		        <input type="hidden" id="total_service_name" name="total_service_name" value="${sessionScope.myPickServiceNames }"><br>
		        <input type="hidden" id="total_service_price" name="total_service_price" value="${sessionScope.selectedItemsDto.totalServicePrice}"><br>
		        <input type="hidden" id="total_required_time" name="total_required_time" value="${sessionScope.selectedItemsDto.totalRequiredTime}"><br>
		    </form>
        <div class="empty-space"></div>
   	</div>
</div>

</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="../resources/js/mscheduleselect.js"></script>
<%@include file="../include/footer.jsp"%>
