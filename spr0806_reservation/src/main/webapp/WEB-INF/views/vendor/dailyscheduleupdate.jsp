<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<style>

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.hidden {
    display: none;
}
.div1 {
	width: 400px;
	margin: 0 auto;
}

#time-buttons {
	display: grid;
	grid-template-columns: repeat(6, 1fr);
	gap: 5px;
	margin-top: 20px;
}

/*
.time-slot {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
}
*/

.time-slot {
    background-color: white;
    transition: background-color 0.4s;
    padding: 10px;
    text-align: center;
    border: 1px solid gray;
    cursor: pointer;
    border-radius: 5px;
}

/* 0 수정가능 열지 않은 시간 */
.time-slot.closeO {
    background-color: #FFFFFF;	/* 흰색  */
    color: #3C1E1E;
	cursor: pointer;
}
/* 1 수정가능 예약 가능하게 오픈 해둔 시간 */
.time-slot.openO {
	background-color: #FFEB33;	/* 노란색  */
	color: #3C1E1E;
	cursor: pointer;
}
/* 0 수정 불가능 열지 않은 시간 */
.time-slot.closeX {
    background-color: #EEEEEE;	/* 연회색  */
    color: #3C1E1E;
}
/* 1 수정 불가능 예약 가능하게 오픈 해둔 시간 */
.time-slot.openX {
	background-color: #CCCCCC;	/* 회색  */
	color: #3C1E1E;
}

/* 예약되어진 버튼 스타일 */
.time-slot.reservated {
	background-color: #444444; /*  */
	color: #CCCCCC;
}



h2 {
    color: #333;
    text-align: center; /* 제목 중앙 정렬 */
    margin-bottom: 20px;
}

h3 {
    text-align: center; /* 날짜 중앙 정렬 */
    color: #666;
}


#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
    text-align: center;
}

#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
    text-align: center;
}


/* 버튼 기본 스타일 */
button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin: 5px; /* 버튼 간의 간격 */
    display: inline-block; /* 버튼을 인라인 블록으로 설정 */
}

/* 버튼 활성화 상태 */
button:enabled {
    opacity: 1;
    cursor: pointer;
}

/* 버튼 비활성화 상태 */
button:disabled {
    background-color: #d6d6d6;
    color: #a1a1a1;
    cursor: not-allowed;
    opacity: 0.7;
}

/* 각 버튼의 개별 스타일 */
#modifySubmitBtn {
    background-color: #28a745; /* 녹색 */
}

#modifySubmitBtn:hover:enabled {
    background-color: #1e7e34;
}

#cancelSubmitBtn {
    background-color: #dc3545; /* 빨간색 */
}

#cancelSubmitBtn:hover:enabled {
    background-color: #c82333;
}

#updateSubmitBtn {
    background-color: #ffc107; /* 노란색 */
}

#updateSubmitBtn:hover:enabled {
    background-color: #e0a800;
}


#mt {
	margin-top: 20px;
}


</style>


<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<div class="content">
<br><br>
<%--
loginEmail: [${sessionScope.loginEmail}] , <br>
loginBusiness_regi_num: [${sessionScope.loginBusiness_regi_num}] ,<br>
loginName: [${sessionScope.loginName}]
 --%>
<br>


<div >

    <div id="container444">
        <div class="empty-space"></div>
        <div>
		    <!-- <h1>영업일 및 영업시간 선택</h1> --><h2>일일 스케줄 수정</h2>
		    <input type="hidden" id="vendorEmail" value="${sessionScope.loginEmail}">
		    <input type="hidden" id="vendorBusiness_regi_num" value="${sessionScope.loginBusiness_regi_num}">
		    <input type="hidden" id="selectedDate" value="${selectedDate}" readonly>
		    <h3>${selectedDate}</h3>
		</div>
        <div class="empty-space"></div>
   	</div>
    
    <div id="container282">
        <div class="empty-space"></div>
        	<div id="time-buttons"></div>
        <div class="empty-space"></div>
    </div>
    <div id="mt"></div>
    <div id="container282">
        <div class="empty-space"></div>
        <div>
		    <button type="button" id="modifySubmitBtn">스케줄 수정</button>
		    <button type="button" id="cancelSubmitBtn">수정 취소</button>
		    <button type="button" id="updateSubmitBtn">수정 완료</button>
		    <div id="mt">스케줄 수정 버튼을 누르면 수정중인 날짜는 예약이 불가능한 상태(비공개)로 전환 되어집니다. <br>
		    수정취소나 수정 완료를 누르면 다시 예약이 가능한 상태가 됩니다.<br>
		    예약받고 싶은 시간대를 클릭하여 노란색으로 만든 후 수정 완료를 눌러주세요.<br>
		    이미 예약 되어진 시간은 수정 할 수 없습니다.</div>
	    </div>
        <div class="empty-space"></div>
    </div>
    <%--<button type="button" id="timesNow">지금시간값</button> --%>
</div>

</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="../resources/js/dailyscheduleupdate.js"></script>
<%@include file="../include/footer.jsp"%>
