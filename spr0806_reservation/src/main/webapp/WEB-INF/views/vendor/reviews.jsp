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
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
</style>
<div class="header-placeholder"></div>
<main>

<table class="table" style="width: 80%; margin: 0 auto;">
    <thead>
        <tr class="text-center">
            <th>예약 주문 번호</th>
            <th>별점</th>
            <th>후기</th>
            <th>작성일</th>
        </tr>
    </thead>
    <tbody id="reviewTableBody">
    </tbody>
</table>
</main>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {

	getCommentList();
	
	function getCommentList(){
		
		var vendor_email = $('#loginEmail').val();
        var business_regi_num = $('#loginBusiness_regi_num').val();

        //alert(vendor_email);
        //alert(business_regi_num);
        
        $.ajax({
            url: '/ex/reviews/vendorMustCommentList',
            type: 'GET',
            data: {
                vendor_email: vendor_email,
                business_regi_num: business_regi_num
            },
            dataType: 'json',
            success: function(response) {
                console.log("response :", response.dtos);
                updateReviewTable(response.dtos);
            },
            error: function(xhr, status, error) {
                console.error("error :", error);
            }
        });
	}

	
	function updateReviewTable(dtos) {
	    const tableBody = $('#reviewTableBody');
	    tableBody.empty();
	    for (let i = 0; i < dtos.length; i++) {
			var review = dtos[i].member_content.substring(0, 10) + '...';
	        let row = `
	            <tr class="text-center">
	                <td><a href="${pageContext.request.contextPath}/vendor/orderinfo?reservationNumber=` + dtos[i].reservation_number + `#card-footer">` + dtos[i].reservation_number + `</a></td>
	                <td>` + dtos[i].star_point + `</td>
	                <td>` + review + `</td>
	                <td>` + dtos[i].review_date + `</td>
	            </tr>
	        `;
	        tableBody.append(row);
	    }
	}

	
	
});
</script>
<%@include file="/WEB-INF/views/include/footer.jsp"%>