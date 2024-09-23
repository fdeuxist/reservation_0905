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
body {
    margin: 0;
    background-color: #f4f4f4;
}
</style>
<main class="container mt-5">
    <div class="row">
    
        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">예약 장소 검색</h5>
                    <p class="card-text">원하는 서비스, 원하는 장소를 찾아보세요.</p>
                    <a href="${pageContext.request.contextPath}/member/searchplace" class="btn btn-primary">검색하기</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">주문 내역 보기</h5>
                    <p class="card-text">주문 내역을 확인하세요.</p>
                    <a href="${pageContext.request.contextPath}/member/myorders" class="btn btn-primary">확인하기</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">비밀번호 변경 / 탈퇴</h5>
                    <p class="card-text">계정 관리를 여기에서 할 수 있습니다.</p>
                    <a href="${pageContext.request.contextPath}/member/update" class="btn btn-primary">확인하기</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">사업자회원으로 전환하기</h5>
                    <p class="card-text">예약 시간을 오픈하고 자기의 서비스를 제공할 수 있습니다.</p>
                    <a href="${pageContext.request.contextPath}/member/membertovendor" class="btn btn-primary">전환하기</a>
                </div>
            </div>
        </div>

    
    <%-- 
    <div class="list-group">
        <a href="${pageContext.request.contextPath}/member/myorders" class="list-group-item list-group-item-action">주문 내역 보기</a>
        <a href="${pageContext.request.contextPath}/member/update" class="list-group-item list-group-item-action">비밀번호 변경 / 탈퇴</a>
        <a href="${pageContext.request.contextPath}/member/membertovendor" class="list-group-item list-group-item-action">사업자회원으로 전환하기</a>
        <a href="${pageContext.request.contextPath}/member/searchplace" class="list-group-item list-group-item-action">샵검색</a>
    </div>--%>
    <%--    
    <div class="mt-4">
        <p>${sessionScope.loginName}</p>
        <p>${sessionScope.loginEmail}</p>
        <p>${sessionScope.loginAuthority}</p>
    </div> --%>
    
    
</main>
<%@include file="../include/footer.jsp"%>
