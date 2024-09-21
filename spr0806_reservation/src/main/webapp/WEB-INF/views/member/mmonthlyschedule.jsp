<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<div class="header-placeholder"></div>
<style>
/* 전반적인 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* 헤더, 메인, 푸터 */
header, main, footer {
    padding: 20px;
}

/* 헤더를 위한 자리 유지 */
.header-placeholder {
    height: 50px; /* 헤더의 높이에 맞춰 조절 */
}

/* 제목 중앙 정렬 */
h2 {
    color: #333;
    margin-top: 20px;
    margin-bottom: 20px;
    text-align: center; /* 제목 중앙 정렬 */
}

/* 월 선택 UI 중앙 정렬 */
.centered-container {
    text-align: center;
    margin-bottom: 20px; /* 제목과 월 선택 UI 사이의 간격 */
}

/* 월 선택 UI 스타일 */
label {
    font-weight: bold;
}

select {
    margin-left: 10px;
    padding: 5px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #fff;
}

/* 예약 목록 테이블 스타일 */
table {
    width: 80%; /* 테이블의 너비를 화면 너비의 80%로 설정 */
    margin: 20px auto; /* 화면 중앙에 배치 */
    border-collapse: collapse;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center; /* 중앙 정렬 */
}

table th {
    background-color: #f2f2f2;
    font-weight: bold;
}

table tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
}

table tbody tr:hover {
    background-color: #f1f1f1;
}

td:hover {
    background-color: #e0e0e0;
}

.text-center {
    text-align: center;
    margin-top: 20px;
}
.notice-text {
    font-size: 18px;
    color: #333;
    margin: 20px 0;
    text-align: center;
}

.a-btn {
	display: inline-block;
    padding: 10px 20px;
    margin-top: 15px;
    background-color: #007bff; /* 파란색 배경 */
    color: white; /* 흰색 글자 */
    text-align: center;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
    font-size: 18px;
}

.a-btn:active {
    background-color: #003f7f; /* 클릭 시 더 어두운 색상 */
}

</style>
<main>
<%--
    <p>사업자명: ${sessionScope.loginName}</p>
    <p>사업자 이메일: ${sessionScope.loginEmail}</p>
    <p>권한: ${sessionScope.loginAuthority}</p>
 --%>
 
    <h2>월별 스케줄 조회</h2>
    
    <div class="centered-container">
	    <label for="monthSelect">조회 월 선택: </label>
	    <select id="monthSelect" onchange="loadReservations()">
	    </select>
    <div class="notice-text">
        <h5>등록일을 클릭하면 그 날의 스케줄을 수정할 수 있습니다.</h5>
    </div>
    </div>
    
    <table border="1">
        <thead>
            <tr>
                <th>영업중으로 등록된 날</th>
                <th>회원에게 공개</th>
            </tr>
        </thead>
        <tbody id="openDateTbody">
        </tbody>
    </table>

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/vendor/scheduleinsert" class="a-btn">일일 스케줄 등록하러 가기</a>
    </div>
    
<%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
${sessionScope.loginBusiness_regi_num}<br> --%>
</main>
<script>
document.addEventListener("DOMContentLoaded", function() {
    monthOptions();
    loadReservations();
});


var currentDate = new Date();
//console.log(currentDate);
var currentYear = currentDate.getFullYear();
//console.log(currentYear);
var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
//console.log(currentMonth);

	function monthOptions() {
	    var monthSelect = document.getElementById("monthSelect");
	    var optionsStr = "";
	    
	    /*
	    <select id="monthSelect" onchange="loadReservations()">
			<option value="2024-06">2024년 06월</option>
			<option value="2024-07">2024년 07월</option>
			<option value="2024-08">2024년 08월</option>
			<option value="2024-09">2024년 09월</option>
			<option value="2024-10">2024년 10월</option>
			<option value="2024-11">2024년 11월</option>
			<option value="2024-12">2024년 12월</option>
			<option value="2025-01">2025년 01월</option>
			<option value="2025-02">2025년 02월</option>
			<option value="2025-03">2025년 03월</option>
		</select>
	    */
	    
	    for (var i = -3; i <= 6; i++) {	//이전 3개월 ~ 이후 6개월
	        let optionDate = new Date(currentYear, currentMonth - 1 + i); //월은 0부터 시작이라 -1 빼줌
	        //console.log(optionDate)
	        let year = optionDate.getFullYear();
	        let month = optionDate.getMonth() + 1;
	
	        let formattedMonth = month < 10 ? "0" + month : month;	//10보다 작은 달은 앞에 0붙임
	
	        let optionValue = year + "-" + formattedMonth;			//'YYYY-MM'
	        let optionText = year + "년 " + formattedMonth + "월";	//'YYYY년 MM월'
	

	        // 현재 월을 기본 선택
	        if (i === 0) {
	            optionsStr += `<option value="` + optionValue + `" selected>` + optionText + `</option>`;
	        } else {
	            optionsStr += `<option value="` + optionValue + `">` + optionText + `</option>`;
	        }
	    }
	    
	    //console.log("optionsStr ", optionsStr);
        monthSelect.innerHTML = optionsStr;
	}

    function loadReservations() {
        var selectedMonth = document.getElementById("monthSelect").value;
        $.ajax({
            url: '/ex/vendorrest/myonemonth',
            type: 'GET',
            data: { month: selectedMonth },
            dataType: 'json',
            success: function(data) {
                console.log("reservations ", data);
                updateReservationTable(data);
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });

    }

    
    function updateReservationTable(reservations) {
        var tableBody = document.getElementById("openDateTbody");
        tableBody.innerHTML = "";
        /*
        <table border="1">
	        <thead>
	            <tr>
	                <th>영업중으로 등록된 날</th>
	                <th>예약 가능 여부</th>
	            </tr>
	        </thead>
	        <tbody id="openDateTbody">
				<tr>
					<td class="openDate" style="cursor: pointer">2024-09-02</td><td>예약 가능</td>
				</tr>
				<tr>
					<td class="openDate" style="cursor: pointer">2024-09-03</td><td>예약 가능</td>
				</tr>
				<tr>
					<td class="openDate" style="cursor: pointer">2024-09-04</td><td>예약 가능</td>
				</tr>
			</tbody>
		    </table>
        */
        var otrtd = `<tr><td class="openDate" style="cursor: pointer">`;
        var ctdotd = "</td><td>";
        var ctrtr = "</td></tr>";

        var trtdStr = "";

        for (var i = 0; i < reservations.length; i++) {
            let reservation = reservations[i];

            trtdStr += otrtd + reservation.open_date + ctdotd;
            trtdStr += reservation.status_flag == "1" ? "공개" : "비공개";
            trtdStr += ctrtr;
        }

        //console.log(trtdStr);

        tableBody.innerHTML = trtdStr;

        
        var dateCells = document.getElementsByClassName("openDate");
        for (var i = 0; i < dateCells.length; i++) {
            let dateCell = dateCells[i];
            dateCell.addEventListener("click", function() {
                window.location.href = "/ex/vendor/dailyscheduleupdate?date=" + dateCell.innerText;
            });
        }
        
        
        
        
        
}


</script>
<%@include file="../include/footer.jsp"%>