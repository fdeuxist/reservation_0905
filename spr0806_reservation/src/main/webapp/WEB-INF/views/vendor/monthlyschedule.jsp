<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<div class="header-placeholder"></div>
<main>
    	예약 관리

    <p>사업자명: ${sessionScope.loginName}</p>
    <p>사업자 이메일: ${sessionScope.loginEmail}</p>
    <p>권한: ${sessionScope.loginAuthority}</p>

    <h2>선택 달 예약 등록일</h2>
    
    <!-- 월 선택 UI -->
    <label for="monthSelect">조회 월 선택: </label>
    <select id="monthSelect" onchange="loadReservations()">
    </select>
    
    <!-- 예약 목록 테이블 -->
    <table border="1" id="reservationTable">
        <thead>
            <tr>
                <th>영업중으로 등록된 날</th>
                <th>이용자에게 공개</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
${sessionScope.loginBusiness_regi_num}<br>
</main>
<script>
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌

    function populateMonthOptions() {
        var select = document.getElementById("monthSelect");

        // 동적으로 이전/다음 몇 개월의 옵션을 추가 (예: 지난 3개월, 앞으로 12개월)
        for (var i = -3; i <= 12; i++) {
            var optionDate = new Date(currentYear, currentMonth - 1 + i);
            var year = optionDate.getFullYear();
            var month = optionDate.getMonth() + 1;

            // 월이 한 자리 수일 경우 앞에 '0'을 추가
            var formattedMonth = month < 10 ? '0' + month : month;

            // 옵션 값: "YYYY-MM"
            var optionValue = year + '-' + formattedMonth;
            var optionText = year + '년 ' + formattedMonth + '월';

            // 옵션 생성
            var option = document.createElement("option");
            option.value = optionValue;
            option.text = optionText;

            // 현재 월이 기본 선택되도록 설정
            if (i === 0) {
                option.selected = true;
            }

            select.appendChild(option);
        }
    }

    // 예약 데이터를 불러오는 함수
    function loadReservations() {
        var selectedMonth = document.getElementById("monthSelect").value;
        $.ajax({
            url: '/ex/vendorrest/myonemonth',
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

    // 테이블 업데이트 함수
    function updateReservationTable(reservations) {
	    var tableBody = document.querySelector("#reservationTable tbody");
	    tableBody.innerHTML = ""; // 테이블 초기화
	
	    // for문을 사용하여 reservations 배열을 순회
	    for (var i = 0; i < reservations.length; i++) {
	        var reservation = reservations[i]; // 현재 예약 객체
	
	        var row = document.createElement("tr");
	
	        var dateCell = document.createElement("td");
	        dateCell.textContent = reservation.open_date.split(' ')[0]; 
        	//공백 기준으로 문자열을 나눠서 날짜 부분("YYYY-MM-DD")만을 추출
        	//"2024-08-15 14:30".split(' ')를 호출하면, 
        	//이 문자열은 공백을 기준으로 나뉘어 ["2024-08-15", "14:30"]라는 배열이 생성
            dateCell.style.cursor = "pointer";
	        dateCell.addEventListener("click", function() {
	            // 클릭 시 dailyschedule 페이지로 이동하며 날짜를 쿼리 파라미터로 전달
	            window.location.href = "/ex/member/mscheduleselect?date=" + reservation.open_date.split(' ')[0];
	        });
	        row.appendChild(dateCell);
	
	        var statusCell = document.createElement("td");
	        statusCell.textContent = reservation.status_flag === '1' ? '공개' : '비공개';
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