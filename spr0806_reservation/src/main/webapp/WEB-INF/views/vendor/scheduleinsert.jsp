<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%--
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
 --%>
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

#space{
	margin-bottom: 20px;
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


<%--
<div class="div1">
    <!-- <h1>영업일 및 영업시간 선택</h1> -->
    <br><br>
    <div class="row">
        <div class="col-4"></div>
    	<input type="text" id="datepicker" class="col-4" placeholder="날짜를 선택하세요">
        <div class="col-4"></div>
   	</div>
    <div class="row">
        <div class="col-2"></div>
       	<div class="col-8 row" id="time-buttons"></div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-5"></div>
    	<button type="button" class="col-2" id="submitBtn">전송</button>
        <div class="col-5"></div>
   	</div>
</div>
 --%>

<div class="div1">
    <!-- <h1>영업일 및 영업시간 선택</h1> -->
    <br><br>
    <div id="container444">
        <div class="empty-space"></div>
    	<input type="text" id="datepicker" placeholder="등록일을 먼저 선택해주세요">
        <div class="empty-space"></div>
   	</div>
    <div id="container282">
        <div class="empty-space"></div>
        <div id="time-buttons"></div>
        <div class="empty-space"></div>
    </div>
    <div id="space"></div>
    <div id="container444">
        <div class="empty-space"></div>
    	<button type="button" id="submitBtn" >등록</button>
        <div class="empty-space"></div>
   	</div>
</div>

 
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="../resources/js/scheduleinsert.js"></script>
<%@include file="../include/footer.jsp"%>
