<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.hidden {
    display: none;
}
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
<%--
/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* 메인 컨텐츠 영역 스타일 */
main {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

/* 주문 상세 정보 카드 스타일 */
.order-card {
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 카드 제목 스타일 */
.order-card h3 {
    margin-top: 0;
    font-size: 24px;
    color: #333;
}

/* 카드 내 항목 스타일 */
.order-card p {
    margin: 8px 0;
    font-size: 16px;
    color: #555;
}

/* 레이블 스타일 */
.order-card .label {
    font-weight: bold;
    color: #333;
}

/* 주소 항목의 추가 스타일 */
.order-card p span:not(.label) {
    display: block;
    margin-top: 4px;
}

/* 공백 스타일 */
.order-card br {
    content: "\A";
    white-space: pre;
}
 --%>

body {
    background-color: #f4f4f4;
}

</style>
<div class="header-placeholder"></div>
<main>
    <div class="container">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">주문 상세 정보</h3>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">예약번호</th>
                        <td>${myOrder.reservation_number}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 이름</th>
                        <td>${myOrder.user_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 전화번호</th>
                        <td>${myOrder.user_phone}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약자 Email</th>
                        <td>${myOrder.user_email}</td>
                    </tr>
                  </tbody>
            </table>
        <div class="border-top my-3"></div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">사업자 이름</th>
                        <td>${myOrder.vendor_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">사업자 전화번호</th>
                        <td>${myOrder.vendor_phone}</td>
                    </tr>
                    <tr>
                        <th scope="row">장소 이름</th>
                        <td>${myOrder.business_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td>
                            ${myOrder.zipcode}<br>
                            ${myOrder.basic_address}<br>
                            ${myOrder.detail_address}
                        </td>
                    </tr>
                  </tbody>
            </table>
        <div class="border-top my-3"></div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">이용(방문)예정일</th>
                        <td>${myOrder.reservation_use_date}</td>
                    </tr>
                    <tr>
                        <th scope="row">이용(방문)예정 시간</th>
                        <td>${myOrder.times_hhmm}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약 목록</th>
                        <td>${myOrder.total_service_name}</td>
                    </tr>
                    <tr>
                        <th scope="row">예약 금액</th>
                        <td>${myOrder.total_service_price}</td>
                    </tr>
                    <tr>
                        <th scope="row">예상 소요 시간</th>
                        <td>${myOrder.total_required_time*0.5} 시간</td>
                    </tr>
                    <tr>
                        <th scope="row">주문자 메모</th>
                        <td>${myOrder.user_request_memo}</td>
                    </tr>
                    <tr>
                        <th scope="row">주문 상태</th>
                        <td>
                            <c:choose>
                                <c:when test="${myOrder.status == 1}">입금대기</c:when>
                                <c:when test="${myOrder.status == 2}">입금완료</c:when>
                                <c:when test="${myOrder.status == 3}">이용완료</c:when>
                                <c:when test="${myOrder.status == 4}">취소대기</c:when>
                                <c:when test="${myOrder.status == 5}">취소완료</c:when>
                                <c:when test="${myOrder.status == 6}">환불대기</c:when>
                                <c:when test="${myOrder.status == 7}">환불완료</c:when>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>

            <input type="hidden" id="reservationNumber" value="${myOrder.reservation_number}">
            <input type="hidden" id="status" value="${myOrder.status}">
        </div>
        <div class="card-footer" id="card-footer">
            <c:if test="${myOrder.status == 4 || myOrder.status == 6}">
                <button class="btn btn-success" id="confirmCancel">취소/환불 승인</button>
            </c:if>
            <c:if test="${myOrder.status == 1 || myOrder.status == 2}">
                <button class="btn btn-danger" id="confirmCancel">강제취소/환불하기</button>
            </c:if>
            <c:if test="${myOrder.status == 3}">
	        	<div class="row comment-form" id="reply">
    	        <div class="col text-left">
    	            <div>별점 : <span id="star">
    	            	<input type="text" class="hidden" id="s_point"/>	<%--몇번째 별이 클릭되었는지(별점) 기록해두는 곳--%>
    	                <i class="fa-regular fa-star hidden"></i>	<%--index가 0부터 시작하므로 0번째 별은 숨겨둔다--%>
    	                <i class="fa-regular fa-star"></i>
    	                <i class="fa-regular fa-star"></i>
    	                <i class="fa-regular fa-star"></i>
    	                <i class="fa-regular fa-star"></i>
    	                <i class="fa-regular fa-star"></i>
    	            </span></div>
    	        </div>
    	        <div class="col text-right">
    	            <div>작성일 : <span id="r_date"></span></div>
    	        </div>
	    	    </div>
	    	    <textarea id="m_content" class="form-control mt-2 text-left" rows="3" placeholder="이용후기가 아직 작성되지 않았습니다." readonly></textarea>
	    	    <textarea id="v_content" class="form-control mt-2 text-right" rows="3"  placeholder="소중한 후기에 대한 답글을 작성해주세요!"></textarea>
	    	    <button id="answerSubmit" class="btn btn-primary mt-2 submit-comment">등록/수정완료</button>
	        </c:if>
        </div>
    </div>
</div>
<script>
$(function() {

	var reservationNumber = $("#reservationNumber").val();	//이 페이지 주문번호

	onload();	//이 이후에 후기폼이 생김. 후기폼 관련 요소 선택 등, 관련 작업은 이 이하로 기술
	var stars = $('.fa-star'); // 별 요소들
	
	//========================================================================
	function paintStars(starPoint) {	//별 색칠
	    console.log("paintStars() , starPoint : " + starPoint);
	    for (let j = 0; j < stars.length; j++) {	//stars.length는   $('.fa-star') 배열의 길이
	        if (j <= starPoint) {
	            $(stars[j]).removeClass('fa-regular').addClass('fa-solid'); // fa-regular ☆, fa-solid ★
	        } else {
	            $(stars[j]).removeClass('fa-solid').addClass('fa-regular'); 
	        }
	    }
	}
	

	//========================================================================
	function onload(){
		var rDate = $("#r_date");
		var mContent = $("#m_content");
		var vContent = $("#v_content");
		var sPoint = $("#s_point");
		var answerSubmitBtn = $("#answerSubmit");
		
		$.ajax({
            url: '/ex/reviews/selectOne',
            method: 'GET',
            data: { reservation_number: reservationNumber },
            success: function(response) {
            	console.log("response.dto : ", response.dto);
            	if (response.dto == null) { //member가 작성한 후기가없음
            		console.log("null임");
            		vContent.addClass("hidden");
            		answerSubmitBtn.addClass("hidden");
            	}else{
            		console.log("null이 아님")
                	console.log("response.dto.review_date : ", response.dto.review_date);
                	console.log("response.dto.star_point : ", response.dto.star_point);
                	console.log("response.dto.member_content : ", response.dto.member_content);
                	console.log("response.dto.vendor_content : ", response.dto.vendor_content);
                	
            		
            		rDate.html(response.dto.review_date);
            		sPoint.val(response.dto.star_point);
            		mContent.val(response.dto.member_content);
            		vContent.val(response.dto.vendor_content);
            		
            		paintStars(response.dto.star_point);
            	}
            },
            error: function(xhr, status, error) {
                console.error('error:', error);
            }
        });
	}

	//========================================================================
	
	
	$("#answerSubmit").click(function() {
		submitAnswer();
	});

	//========================================================================
	function submitAnswer(){
        var vendorContent = $("#v_content").val(); // 답글 내용
        
        //console.log('Reservation Number:', reservationNumber);
        //console.log('Vendor Content:', vendorContent);

		$.ajax({
            url: "/ex/reviews/vendorUpdateComment",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                reservation_number: reservationNumber,
                vendor_content: vendorContent
            }),
            success: function(response) {
                //alert("수정 완료: " + response);
                onload();
            },
            error: function(xhr, status, error) {
                console.error("error : ", error);
                //alert("수정 실패: " + xhr.responseText);
                onload();
            }
        });
		
	}
	
	
	
	
	
	
	
	
	//========================================================================
    $("#confirmCancel").click(function() {
    	
    	var userConfirmed = confirm("예약의 취소를 승인합니다.");
        
        if (userConfirmed) {
	        var email = $("#loginEmail").val();
	        var reservationNumber = $("#reservationNumber").val();
	        var status = $("#status").val();
	        console.log(email, reservationNumber, status);	//member 2024082613221338 1
	        $.ajax({
	            url: '/ex/vendorrest/confirmCancel',
	            method: 'POST',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify({
	                email: email,
	                reservationNumber: reservationNumber,
	                status: status
	            }),
	            success: function(response) {
	                //console.log(response.message);
	                window.location.href = "/ex/vendor/orderinfo?reservationNumber=" + reservationNumber;
	            },
	            error: function(xhr, status, error) {
	                console.error('error : ', error);
	            }
        	});
        }
    });
    
});
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>