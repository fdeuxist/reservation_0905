<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
    <h2>예약이 완료되었습니다!</h2>

    <p>예약 번호: ${dto.reservation_number}</p>
    <p>유저 이메일: ${dto.user_email}</p>
    <p>유저 이름: ${dto.user_name}</p>
    <p>이용 예정 날짜: ${dto.reservation_use_date}</p>
    <p>이용 예정 시간: ${dto.times_hhmm}</p>
    <p>서비스 이름들: ${dto.total_service_name}</p>
    <p>서비스 가격 총 합: ${dto.total_service_price}</p>

    <a href="/ex/member/member">메인으로 돌아가기</a>
</main>
<%@include file="../include/footer.jsp"%>