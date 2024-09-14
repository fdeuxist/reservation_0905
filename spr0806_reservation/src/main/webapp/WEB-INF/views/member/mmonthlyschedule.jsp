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


</style>
<main>
<%--
    <p>사업자명: ${sessionScope.data.email}</p>
    <p>사업자 이메일: ${sessionScope.data.business_regi_num}</p>
 --%>
    <h2>예약 날짜 선택</h2>
    
    <!-- 월 선택 UI -->
    <label for="monthSelect">조회 월 선택: </label>
    <select id="monthSelect" onchange="loadReservations()">
    </select>
    
    <!-- 예약 목록 테이블 -->
    <table border="1" id="reservationTable">
        <thead>
            <tr>
                <th>영업중으로 등록된 날</th>
                <th>예약 가능 여부</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
<%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
${sessionScope.loginBusiness_regi_num}<br> --%>
</main>
<script>
var currentDate = new Date();
//console.log(currentDate);
var currentYear = currentDate.getFullYear();
//console.log(currentYear);
var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
//console.log(currentMonth);

	function populateMonthOptions() {
	    var select = document.getElementById("monthSelect");
	
	    for (var i = -3; i <= 12; i++) {	//이전 3개월부터 이후12개월
	        var optionDate = new Date(currentYear, currentMonth - 1 + i);
	        var year = optionDate.getFullYear();
	        var month = optionDate.getMonth() + 1;
	
	        var formattedMonth = month < 10 ? '0' + month : month;	//10보다 작은 달은 앞에 0붙임
	
	        var optionValue = year + '-' + formattedMonth;			//'YYYY-MM'
	        var optionText = year + '년 ' + formattedMonth + '월';	//'YYYY년 MM월'
	
	        var option = document.createElement("option");
	        option.value = optionValue;
	        option.text = optionText;	// <option value="YYYY-MM">YYYY년 MM월</option>
	
	        // 현재 월이 기본 선택되도록 설정
	        if (i === 0) {
	            option.selected = true;
	        }
	
	        select.appendChild(option);
	    }
	}

    function loadReservations() {
        var selectedMonth = document.getElementById("monthSelect").value;
        $.ajax({
            url: '/ex/memberrest/youronemonth',	
            type: 'GET',
            data: { month: selectedMonth },
            dataType: 'json',
            success: function(data) {
                updateReservationTable(data);
                console.log(data);
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });

    }

    
    // 테이블 그리기
    function updateReservationTable(reservations) {
	    var tableBody = document.querySelector("#reservationTable tbody");
	    tableBody.innerHTML = ""; // 테이블 초기화
	
	    for (var i = 0; i < reservations.length; i++) {
	        let reservation = reservations[i]; // let을 사용하여 클로저 유지
	
	        let row = document.createElement("tr");
	
	        let dateCell = document.createElement("td");
	        dateCell.textContent = reservation.open_date.split(' ')[0]; 
	        // 공백 기준으로 문자열을 나눠서 날짜 부분("YYYY-MM-DD")만을 추출
	        // "2024-08-15 14:30".split(' ')를 호출하면, 
	        // 이 문자열은 공백을 기준으로 나뉘어 ["2024-08-15", "14:30"]라는 배열이 생성
	
	        dateCell.style.cursor = "pointer";
	        dateCell.addEventListener("click", function() {
	            //alert(reservation.open_date.split(' ')[0]);
	            window.location.href = "/ex/member/mscheduleselect?date=" + reservation.open_date.split(' ')[0];
	        });
	        row.appendChild(dateCell);
	        
	        let statusCell = document.createElement("td");
	        statusCell.textContent = reservation.status_flag === '1' ? '예약 가능' : '예약 불가';
	        row.appendChild(statusCell);
	
	        tableBody.appendChild(row);
	    	}


    }

    // 페이지 로드 시 기본적으로 현재 월의 데이터를 불러오고 옵션을 설정
    document.addEventListener("DOMContentLoaded", function() {
        populateMonthOptions();
        loadReservations();
    });
</script>
<%@include file="../include/footer.jsp"%>