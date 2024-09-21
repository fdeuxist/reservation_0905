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
<style>
body {
    margin: 0;
    background-color: #f4f4f4;
}
#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}
#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}
</style>
<div class="header-placeholder"></div>
<main>
    <div class="container mt-5">
        <h2 class="text-center mb-4">${result}</h2>

        <div class="card">
            <div class="card-body">
                <p class="card-text">예약 번호: <strong>${dto.reservation_number}</strong></p>
                <p class="card-text">유저 이메일: <strong>${dto.user_email}</strong></p>
                <p class="card-text">유저 이름: <strong>${dto.user_name}</strong></p>
                <p class="card-text">이용 예정 날짜: <strong>${dto.reservation_use_date}</strong></p>
                <p class="card-text">이용 예정 시간: <strong>${dto.times_hhmm}</strong></p>
                <p class="card-text">서비스 이름들: <strong>${dto.total_service_name}</strong></p>
                <p class="card-text">서비스 가격 총 합: <strong>${dto.total_service_price}</strong></p>

                <a href="/ex/member/mypage" class="btn btn-primary mt-3">메인으로 돌아가기</a>
            </div>
        </div>
    </div>
</main>
<%@include file="../include/footer.jsp"%>