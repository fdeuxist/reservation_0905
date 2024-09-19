<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="header-placeholder"></div>
<main>

이름 : ${sessionScope.loginName}<br>
이메일 : ${sessionScope.loginEmail}<br>
예약주문번호 ${reservationNumber} 의 이용후기를 작성 하는 페이지
<%--${sessionScope.loginAuthority}<br> --%>
</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>