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
                    <h5 class="card-title">내 사업장 정보</h5>
                    <p class="card-text">사업장 정보를 등록하고 수정합니다.</p>
                    <a href="${pageContext.request.contextPath}/vendor/shopinfo" class="btn btn-primary">등록하기</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">내 서비스 등록</h5>
                    <p class="card-text">새로운 서비스를 등록하고 관리합니다.</p>
                    <a href="${pageContext.request.contextPath}/vendor/serviceiteminsert" class="btn btn-primary">등록하기</a>
                    <a href="${pageContext.request.contextPath}/vendor/serviceitemselectAll" class="btn btn-primary">관리하기</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">스케줄 관리</h5>
                    <p class="card-text">영업중으로 등록한 날을 조회 하며<br>일일 스케줄의 등록, 수정을 합니다</p>
                    <a href="${pageContext.request.contextPath}/vendor/scheduleinsert" class="btn btn-primary">일일등록</a>
                    <a href="${pageContext.request.contextPath}/vendor/monthlyschedule" class="btn btn-primary">월별관리</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">예약 내역 보기</h5>
                    <p class="card-text">고객의 예약 내역을 확인하세요.</p>
                    <a href="${pageContext.request.contextPath}/vendor/myorders" class="btn btn-primary">확인하기</a>
                </div>
            </div>
        </div>

		<div class="col-md-6 mb-3">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">내 사진첩 관리하기</h5>
					<p class="card-text">내가 올린 사진들을 관리해보세요.</p>
					<a href="${pageContext.request.contextPath}/vendor/imgList" class="btn btn-primary">확인하기</a>
				</div>
			</div>
		</div>

        <div class="col-md-6 mb-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">공지사항/자유게시판</h5>
                    <p class="card-text">서비스 관련 공지와 자유로운 의견 교환을 위한 공간입니다.</p>
                    <a href="${pageContext.request.contextPath}/board/listAll" class="btn btn-primary">확인하기</a>
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
                    <h5 class="card-title">이용후기 관리</h5>
                    <p class="card-text">고객님이 남겨주신 후기에 대한 답글을 작성할 수 있습니다.</p>
                    <a href="${pageContext.request.contextPath}/vendor/reviews" class="btn btn-primary">확인하기</a>
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
