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
}--%>
</style>

<div class="header-placeholder"></div>
<main>

<%--
    <div class="order-card">
        <h3>주문 상세 정보</h3>
        <p><span class="label">예약번호:</span> ${myOrder.reservation_number}</p>
        <p><span class="label">예약자 Email:</span> ${myOrder.user_email}</p>
        <p><span class="label">예약자 전화번호:</span> ${myOrder.user_phone}</p>
        <p><span class="label">예약자 이름:</span> ${myOrder.user_name}</p><br><br>
        <p><span class="label">사업자 이름:</span> ${myOrder.vendor_name}</p>
        <p><span class="label">사업자 전화번호:</span> ${myOrder.vendor_phone}</p>
        <p><span class="label">장소 이름:</span> ${myOrder.business_name}</p>
        <p><span class="label">주소:</span> ${myOrder.zipcode} </p>
        <p><span class="label"></span> ${myOrder.basic_address}</p>
        <p><span class="label"></span> ${myOrder.detail_address}</p>
        <p><span class="label">이용(방문)예정일:</span> ${myOrder.reservation_use_date}</p>
        <p><span class="label">이용예정 시간:</span> ${myOrder.times_hhmm}</p>
        <p><span class="label">예약 목록:</span> ${myOrder.total_service_name}</p>
        <p><span class="label">예약 금액:</span> ${myOrder.total_service_price}</p>
        <p><span class="label">예상 소요 시간:</span> ${myOrder.total_required_time}</p>
        <p><span class="label">주문자 메모:</span> ${myOrder.user_request_memo}</p>
        <p><span class="label">주문 상태:</span>
        	<c:choose>
                <c:when test="${myOrder.status == 1}">입금대기</c:when>
                <c:when test="${myOrder.status == 2}">입금완료</c:when>
                <c:when test="${myOrder.status == 3}">이용완료</c:when>
                <c:when test="${myOrder.status == 4}">취소대기</c:when>
                <c:when test="${myOrder.status == 5}">취소완료</c:when>
                <c:when test="${myOrder.status == 6}">환불대기</c:when>
                <c:when test="${myOrder.status == 7}">환불완료</c:when>
           	</c:choose>
        </p>
        <input type="hidden" id="reservationNumber" value="${myOrder.reservation_number}">
        <input type="hidden" id="status" value="${myOrder.status}">
        <c:if test="${myOrder.status == 1 || myOrder.status == 2}">
        	<input type="button" id="tryCancel" value="취소요청하기">
        </c:if>
        <c:if test="${myOrder.status == 2 || myOrder.status == 4 || myOrder.status == 6}">
	        <input type="button" id="orderCompleted" value="이용완료확정하기">
        </c:if>
    </div>
--%>
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
                        <td>${myOrder.total_service_price} 원</td>
                    </tr>
                    <tr>
                        <th scope="row">예상 소요 시간</th>
                        <td>약 ${myOrder.total_required_time*0.5} 시간</td>
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
            <input type="hidden" id="loginEmail" value="${myOrder.user_email}">
            <input type="hidden" id="reservationNumber" value="${myOrder.reservation_number}">
            <input type="hidden" id="business_regi_num" value="${myOrder.business_regi_num}">
            <input type="hidden" id="vendor_email" value="${myOrder.vendor_email}">
        	<input type="hidden" id="status" value="${myOrder.status}">
        <div class="card-footer" id="card-footer"><%--id reviewable의 부모요소--%>
	        <c:if test="${myOrder.status == 1 || myOrder.status == 2}">
	        	<input type="button" class="btn btn-danger" id="tryCancel" value="취소요청하기">
	        </c:if>
	        <c:if test="${myOrder.status == 2 || myOrder.status == 4 || myOrder.status == 6}">
		        <input type="button" class="btn btn-success" id="orderCompleted" value="이용완료확정하기">
	        </c:if>
	        <c:if test="${myOrder.status == 3}"><%--이용완료면 id reviewable div가 보임--%>
        		<div id="reviewable"></div>
	        </c:if>
	    <%-- 안씀   <script>
   				 document.getElementById("reply").addEventListener("click", function() {
        			window.location.href = "reviewsWrite?reservationNumber=${myOrder.reservation_number}";  // 이동할 페이지 경로
    			});
			</script>	--%>
        </div>
    </div>


</main>
<script>
$(function() {
	var reservationNumber = $("#reservationNumber").val();	//이 페이지 주문번호
    const insertUrl = "/ex/reviews/insert";		//ReviewsController
    const updateUrl = "/ex/reviews/update"; 	//ReviewsController
	var submitUrl = "";
    
	onload();	//이 이후에 후기폼이 생김. 후기폼 관련 요소 선택 등, 관련 작업은 이 이하로 기술
	var stars = $('.fa-star'); // 별 요소들
	

	//========================================================================
	
	for(let i=0; i<stars.length; i++){
		stars[i].addEventListener('click', () => {	//별 아이콘 클릭이벤트 등록
			//alert(i);
			$('#s_point').val(i); // 몇번째 별이 클릭되었는지 s_point text박스에 기록해둠, 별점으로 사용
			paintStars(i);	//클릭된 별만큼 색칠
			//alert("별점 : " + $('#s_point').val() );
		});
	}

	//========================================================================
	function paintStars(starPoint) {	//별 색칠
	    console.log("paintStars() , starPoint : " + starPoint);
	    for (let i=0; i<stars.length; i++) {	//stars.length는   $('.fa-star') 배열의 길이
	        if (i <= starPoint) {
	            $(stars[i]).removeClass('fa-regular').addClass('fa-solid'); // fa-regular ☆, fa-solid ★ 
	        } else {
	            $(stars[i]).removeClass('fa-solid').addClass('fa-regular'); 
	        }
	    }
	}
	
	//========================================================================
	function onload(){	//이용완료 상태면 후기작성 폼 생성
	    var reviewForm = $("#reviewable").parent();	//id reviewable 의 부모속성을 선택. id reviewable은 이용완료상태일떄만 보임.
	    
    	var commentForm = `
    	    <div class="row comment-form">
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
    	    <textarea id="m_content" class="form-control mt-2" rows="3" placeholder="이용후기를 작성해주세요!"></textarea>
    	    <textarea id="v_content" class="form-control mt-2 text-right hidden" rows="3" placeholder="이용후기에 대한 답변이 아직 작성되지 않았습니다!" readonly></textarea>
    	    <div id="valid_review" class="" style="font-size: 0.75rem;"></div><%-- 유효성체크 메시지 보여주는곳 --%>
    	    <button id="reviewSubmit" class="btn btn-primary mt-2 submit-comment">등록/수정완료</button>
    	`;	//후기작성하는 칸 tag

        reviewForm.html(commentForm);
    	
//        {reservation_number: '20240906130915938', 
//        	review_date: '2024-10-01 00:00:00', 
//        	member_content: '첫번째 리뷰~~~~', 
//        	vendor_content: null }
        $.ajax({
            url: '/ex/reviews/isReviewExist',
            method: 'GET',
            data: { reservation_number: reservationNumber },
            success: function(response) {
            	console.log("response.dto : ", response.dto);
            	if (response.dto == null) {	//member가 작성한 후기가 없음
            		console.log("null임");
            		//작성가능한상태
            		submitUrl = insertUrl;
            	}else{	//member가 작성한 후기가 있음
            		console.log("null이 아님")
                	console.log("response.dto.review_date : ", response.dto.review_date);
                	console.log("response.dto.star_point : ", response.dto.star_point);
                	console.log("response.dto.member_content : ", response.dto.member_content);
                	console.log("response.dto.vendor_content : ", response.dto.vendor_content);
                	
            		var rDate = $("#r_date");
            		var mContent = $("#m_content");
            		var sPoint = $("#s_point");

            		rDate.html(response.dto.review_date);
            		sPoint.val(response.dto.star_point);
            		mContent.val(response.dto.member_content);
            		
            		//수정
            		submitUrl = updateUrl;
            		paintStars(response.dto.star_point);
            		
            		if(response.dto.vendor_content != ""){	//vendor가 작성한 답글이 있음
            			//vendor 답글 보여주는 form 생성,삽입
            			//alert(response.dto.vendor_content)
            			var vContent = $("#v_content");
            			vContent.val(response.dto.vendor_content);
            			$("#v_content").removeClass("hidden");
            		}
            		
            	}
            },
            error: function(xhr, status, error) {
                console.error('Failed to fetch data:', error);
            }
        });
		
		
	}
	
	//========================================================================
		
	$("#reviewSubmit").click(function() {
		submitReview();
	});

	//========================================================================
		
	function submitReview(){
		var starPoint = $("#s_point").val();	//별점
        var memberContent = $("#m_content").val(); // 후기 내용

        console.log("starPoint : ", starPoint);
        console.log("memberContent : ", memberContent);
        console.log("submitUrl : ", submitUrl);
        
        if(starPoint=='' || memberContent.trim().length < 3 ){
        	$("#valid_review").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
					`리뷰를 등록/수정하기 위해서는 별점과 후기(3자이상)를 작성해주어야 합니다.`+
					  `</div>`);
        }else{
        	$("#valid_review").html("");
        	$.ajax({
                url: submitUrl,	//insert or update 선택적
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    reservation_number: reservationNumber,
                    star_point : starPoint,
                    member_content: memberContent
                }),
                success: function(response) {
                    //alert("수정 완료: " + response);
                    onload();
                },
                error: function(xhr, status, error) {
                    console.error("Error updating review:", error);
                    //alert("수정 실패: " + xhr.responseText);
                    onload();
                }
            });
        }
		
	}
	
	//========================================================================
		
	$("#orderCompleted").click(function() {
        
        var userConfirmed = confirm("이용완료합니다. 취소나 환불처리가 불가합니다.");
        
        if (userConfirmed) {
            var email = $("#loginEmail").val();
            var reservationNumber = $("#reservationNumber").val();
            var status = $("#status").val();
            //console.log(email, reservationNumber, status);    //member 2024082613221338 1
            $.ajax({
                url: '/ex/memberrest/orderCompleted',
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
                    window.location.href = "/ex/member/orderinfo?reservationNumber=" + reservationNumber;
                },
                error: function(xhr, status, error) {
                    console.error('Failed to fetch data:', error);
                }
            });
        }
    });
    
	//========================================================================
    $("#tryCancel").click(function() {
    	
    	var userConfirmed = confirm("예약의 취소를 요청합니다. 사업자의 취소 승인 후 취소 완료 됩니다.");
        
        if (userConfirmed) {
	        var email = $("#loginEmail").val();
	        var reservationNumber = $("#reservationNumber").val();
	        var status = $("#status").val();
	        console.log(email, reservationNumber, status);	//member 2024082613221338 1
	        $.ajax({
	            url: '/ex/memberrest/tryCancel',
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
	                window.location.href = "/ex/member/orderinfo?reservationNumber=" + reservationNumber;
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
        	});
        }
    });
    
    
});
</script>


<%@include file="/WEB-INF/views/include/footer.jsp"%>