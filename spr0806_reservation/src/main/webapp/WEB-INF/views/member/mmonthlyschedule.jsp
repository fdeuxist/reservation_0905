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

<div class="header-placeholder"></div>
<style>
<%-- 
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

header, main, footer {
    padding: 20px;
}

.header-placeholder {
    height: 50px;
}

h2 {
    color: #333;
    margin-bottom: 20px;
    text-align: center;
}

.centered-container {
    text-align: center;
    margin-bottom: 20px;
}

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

table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
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
--%>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}

</style>
<main>
<%--
    <p>사업자명: ${sessionScope.data.email}</p>
    <p>사업자 이메일: ${sessionScope.data.business_regi_num}</p>
 --%>
	<div class="row">
		<div class="col-2">
		</div>
		<div class="col-8">
		    <h2 class ="text-center">예약 날짜 선택</h2>
		    
		    <div class="centered-container text-center">
			    <label for="monthSelect">조회 월 선택: </label>
			    <select id="monthSelect" onchange="loadReservations()">
			    </select>
		    </div>
		    
		    <table  class="table table-hover table-striped  text-center">
		        <thead>
		            <tr>
		                <th>영업중으로 등록된 날</th>
		                <th>예약 가능 여부</th>
		            </tr>
		        </thead>
		        <tbody id="openDateTbody">
		        </tbody>
		    </table>
		</div>
		<div class="col-2">
		</div>
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
            url: '/ex/memberrest/youronemonth',	
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
            trtdStr += reservation.status_flag == "1" ? "예약 가능" : "예약 불가";
            trtdStr += ctrtr;
        }

        //console.log(trtdStr);

        tableBody.innerHTML = trtdStr;

        
        var dateCells = document.getElementsByClassName("openDate");
        for (var i = 0; i < dateCells.length; i++) {
            let dateCell = dateCells[i];
            dateCell.addEventListener("click", function() {
                window.location.href = "/ex/member/mscheduleselect?date=" + dateCell.innerText;
            });
        }

    }

    
</script>
<%@include file="../include/footer.jsp"%>