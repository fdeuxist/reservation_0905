<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<style>
.acontainer {
	width: 80%;
	margin: 0 auto;
}

#calendar {
	width: 100%;
}

.ui-datepicker-calendar td {
	cursor: pointer;
}

.ui-datepicker-calendar td.available {
	background-color: #dff0d8; /* 예약 가능한 날짜 색상 */
}

.ui-datepicker-calendar td.unavailable {
	background-color: #f2dede; /* 예약 불가능 날짜 색상 */
}

.ui-datepicker-calendar td.ui-datepicker-today {
	background-color: #d9edf7;
}

.ui-datepicker-calendar td.ui-state-highlight {
	background-color: #f5f5f5;
}
</style>

<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<div class="content">
<br><br>

loginEmail: [${sessionScope.loginEmail}] , <br>
loginBusiness_regi_num: [${sessionScope.loginBusiness_regi_num}] ,<br>
loginName: [${sessionScope.loginName}]

<br>

	특정 벤더 특정일 스케줄 조회/수정<br>
	'수정을 하려면 해당 일을 예약 중지 상태로 변경해야 합니다.'<br>
	'수정을 마친 뒤 예약을 받으려면 예약 중지 상태를 다시 예약 가능 상태로 변경해주세요.'
<div class="acontainer">
    <h2>스케줄 관리</h2>
    <div id="calendar"></div>
</div>

</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
$(function() {
    // Initialize the calendar
    $("#calendar").datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText, inst) {
            const isAvailable = $(inst.selectedDay).hasClass('available');
            if (isAvailable) {
                window.location.href = `/path/to/updateSchedulePage?date=${dateText}`;
            } else {
                window.location.href = `/path/to/insertSchedulePage?date=${dateText}`;
            }
        }
    });

    function fetchCalendarData() {
        $.ajax({
            url: '/ex/vendorrest/calendarData',
            method: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ 
                email: '${sessionScope.loginEmail}',
                business_regi_num: '${sessionScope.loginBusiness_regi_num}'
            }),
            success: function(response) {
                updateCalendar(response.dates);
            },
            error: function(xhr, status, error) {
                console.error('Failed to fetch calendar data:', error);
            }
        });
    }

    function updateCalendar(dates) {
        const availableDates = dates.availableDates; // List of available dates
        const unavailableDates = dates.unavailableDates; // List of unavailable dates

        // Set background color for available dates
        availableDates.forEach(date => {
            $(`[data-date="${date}"]`).addClass('available');
        });

        // Set background color for unavailable dates
        unavailableDates.forEach(date => {
            $(`[data-date="${date}"]`).addClass('unavailable');
        });
    }

    fetchCalendarData(); // Fetch and update calendar data on page load
});
</script>
<%@include file="../include/footer.jsp"%>

