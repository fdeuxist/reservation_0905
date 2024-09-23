<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"><%-- Font Awesome 아이콘 --%>
    <title>모두의 예약</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <header class="header">
        <div class="hcontainer">
            <h1 class="logo">모두의 예약</h1>
            <div class="menu-toggle" id="menu-toggle">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
            <nav class="nav" id="nav">
    <ul>
        <li>
            <c:choose>
                <c:when test="${sessionScope.loginAuthority == '관리자'}">
                    <a href="${pageContext.request.contextPath}/admin/selectAll">selectAll </a>
                </c:when>
                <c:when test="${sessionScope.loginAuthority == '매니저'}">
                    <a href="#home">manager Home</a>
                    <a href="#about">About</a>
                    <a href="#services">Services</a>
                    <a href="#contact">Contact</a>
                </c:when>
                <c:when test="${sessionScope.loginAuthority == '사업자회원'}">
                <%--
                    <a href="${pageContext.request.contextPath}/vendor/shopinfo">샵정보등록/수정</a>
                    <a href="${pageContext.request.contextPath}/vendor/serviceiteminsert">샵메뉴등록</a>
                    <a href="${pageContext.request.contextPath}/vendor/monthlyschedule">월별스케줄목록</a>
                    <a href="${pageContext.request.contextPath}/vendor/scheduleinsert">일일스케줄등록</a>
                    <a href="${pageContext.request.contextPath}/vendor/myorders">예약요청(주문)목록</a> --%>
                </c:when>
                <c:when test="${sessionScope.loginAuthority == '일반회원'}">
                    <%--<a href="${pageContext.request.contextPath}/member/searchplace"><i class="fa-solid fa-magnifying-glass-location"></i>예약 장소 검색</a>--%>
                </c:when>
                <c:otherwise>
                    <%--<a href="/ex/user/insert">회원가입</a> --%>
                </c:otherwise>
            </c:choose>
        </li>
        
        <!-- 로그인 상태에 따른 메뉴 표시 -->
        <li>
           <%--n${sessionScope.loginName},e${sessionScope.loginEmail},a${sessionScope.loginAuthority} --%> 
            <c:choose>
			    <c:when test="${sessionScope.loginName == null}">
			        <div class="text-right">
			            <a href="/ex/user/login"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
			            <br>
			            <a href="/ex/user/insert"><i class="fa-solid fa-users"></i>회원가입</a>
			        </div>
			    </c:when>
			    <c:otherwise>
			        <div class="text-right">
			            <%--${sessionScope.loginName}님 반갑습니다! <br> --%>
			            <c:choose>
			                <c:when test="${sessionScope.loginAuthority == '일반회원'}">
			                    <a href="${pageContext.request.contextPath}/member/mypage"><i class="fas fa-user"></i> 마이페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '사업자회원'}">
			                    <a href="${pageContext.request.contextPath}/vendor/mypage"><i class="fas fa-user"></i> 마이페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '매니저'}">
			                    <a href="${pageContext.request.contextPath}/manager/mypage"><i class="fas fa-user"></i> 매니저 페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '관리자'}">
			                    <a href="${pageContext.request.contextPath}/admin/selectAll"><i class="fas fa-user"></i> 관리자 페이지 </a>
			                </c:when>
			            </c:choose>
			            <br>
			            <a href="/ex/user/logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			        </div>
			    </c:otherwise>
			</c:choose>
        </li>
    </ul>
</nav>
<input type="hidden" id="loginEmail" value="${sessionScope.loginEmail}">
<input type="hidden" id="loginName" value="${sessionScope.loginName}">
<input type="hidden" id="loginPhone" value="${sessionScope.loginPhone}">
        </div>
    </header>
<!-- <img src="../resources/imgs/fwr.jpg"></img> -->
<!-- 
loginName: <div id="loginName">${sessionScope.loginName}</div><br><br><br>
loginEmail: <div id="loginEmail">${sessionScope.loginEmail }</div>
<br><br>
authority: ${sessionScope.loginAuthority }
<br><br>
<br><br> -->
<!-- 
<c:forEach var="authority" items="${authorities}">
    <li>${authority.authority}</li>
</c:forEach>
 -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>

