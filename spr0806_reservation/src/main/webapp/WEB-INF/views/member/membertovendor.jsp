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
    font-family: Arial, sans-serif;
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
.hidden {
    display: none;
}
</style>
<div class="header-placeholder"></div>
<main>
<%--
<h4>데이터 입력</h4>
<form action="/ex/member/membertovendor" method="post">
	<div class="console1"></div>
	이메일:<input type="text" name="email" id="email" value="${sessionScope.loginEmail }" readonly><br>
	사업자번호:<input type="text" name="business_regi_num"><input type="button" id="checkbusiness_regi_num" value="중복검사" disabled /><div class="console2"></div>
	사업명(간판 등):<input type="text" name="business_name"><br>
	우편번호:<input type="text" id="zipcode" name="zipcode">
        <input type="button" id="postcodeBtn" value="우편번호 검색"><br>
	기본주소:<input type="text" id="basic_address" name="basic_address"><br>
	상세주소:<input type="text" id="detail_address" name="detail_address"><br>
	업종:<input type="text" name="business_type"><br>
	<input type="submit" id="submitBtn" value="등록" disabled ><br>
</form>
<div id="layer"></div>
</body>
 --%>
 
<div id="container282" class="mb-5">
    <div class="empty-space"></div>
    <div>
        <div><h3 class="text-center mt-3 mb-3">사업자 회원으로 전환</h3></div>
			<div id="layer" style="display:none; position:fixed; z-index:9999; background:white; border:1px solid black; overflow:hidden; -webkit-overflow-scrolling:touch;"></div>
        <form action="/ex/member/membertovendor" method="post" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="text" class="form-control" id="email" name="email" value="${sessionScope.loginEmail }" readonly>
                <div class="console1"></div>
            </div>

            <div class="form-group">
                <label for="business_regi_num">사업자번호:</label>
                <input type="text" class="form-control" id="business_regi_num" name="business_regi_num" required>
                <div class="console2"></div>
                <button type="button" id="checkbusiness_regi_num" class="btn btn-secondary mt-2" disabled>중복검사</button>
            </div>

            <div class="form-group">
                <label for="business_name">사업명 (간판 등):</label>
                <input type="text" class="form-control" id="business_name" name="business_name" required>
            </div>

            <div class="form-group">
                <label for="zipcode">우편번호:</label>
                <input type="text" class="form-control" id="zipcode" name="zipcode" required>
                <button type="button" id="postcodeBtn" class="btn btn-info mt-2">우편번호 검색</button>
            </div>
            <div class="form-group">
                <label for="basic_address">기본주소:</label>
                <input type="text" class="form-control" id="basic_address" name="basic_address" required>
            </div>

            <div class="form-group">
                <label for="detail_address">상세주소:</label>
                <input type="text" class="form-control" id="detail_address" name="detail_address" required>
            </div>

            <div class="form-group">
                <label for="business_type">업종:</label>
                <input type="text" class="form-control" id="business_type" name="business_type" required>
            </div>

            <button type="submit" id="submitBtn" class="btn btn-primary" disabled>등록</button>
        </form>
    </div>
    <div class="empty-space"></div>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../resources/js/mbtvaddrapi.js"></script>
<script type="text/javascript">
	$(function() {
		
		
		
		
		
		
		
		

        const submitBtn = document.getElementById('submitBtn');
        const checkbusiness_regi_numBtn = document.getElementById('checkbusiness_regi_num');
        

       	
			// 사용자 입력값 얻어오기
        	var input_value = $("#email").val();
			 $.ajax({
			        url: '/ex/vendorrest/emailcheck',
			        type: 'GET',
			        data: {
			        	email: input_value
			        },
			        success: function(response) {
			        	console.log(response);
			            var result = response.result;
			            console.log(result);
			            if (result === "true") {
			                //$(".console1").html("<span style='color:blue'>사업자회원 전환이 가능한 이메일입니다.</span>");
			                $(".console1").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
			    					`사업자회원 전환이 가능한 이메일입니다.`+
			    					  `</div>`);
			                checkbusiness_regi_numBtn.disabled = false;
			            } else if (result === "false") {
			                //$(".console1").html("<span style='color:red'>이미 사업자회원으로 전환 되어 있는 이메일입니다.</span>");
			                $(".console1").html(`<div class="alert-sm alert-primary alert-danger p-1" style="font-size: 0.75rem;">`+
			    					`이미 사업자회원으로 전환 되어 있는 이메일입니다.`+
			    					  `</div>`);
			            } else {
			                //$(".console1").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
			            }
			        },
			        error: function(xhr, status, error) {
			            console.error("AJAX 요청 실패: ", status, error);
			            //$(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
			        }
			    });
			
        
        
        
        
        	
		
		
		
		
		$("#checkbusiness_regi_num").click(function() {
			// 사용자 입력값 얻어오기
			var input_value = $("input[name='business_regi_num']").val();

			// 입력여부 검사 input tag에 입력값 없이 버튼 누를시 alert이 실행된다.
			if (!input_value) {
				alert("사업자번호를 입력하세요.");
				$("#business_regi_num").focus();
				return false; //기본이벤트 막음 
			}
			
			 $.ajax({
			        url: '/ex/vendorrest/business_regi_numcheck',
			        type: 'GET',
			        data: {
			        	business_regi_num: input_value
			        },
			        success: function(response) {
			        	console.log(response);
			            var result = response.result;
			            console.log(result);

			            if (result === "true") {
			                //$(".console2").html("<span style='color:blue'>사용할 수 있는 사업자번호입니다.</span>");
			                $(".console2").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
			    					`사용할 수 있는 사업자번호입니다.`+
			    					  `</div>`);
			                submitBtn.disabled = false;
			            } else if (result === "false") {
			                //$(".console2").html("<span style='color:red'>이미 가입 되어 있는 사업자번호입니다.</span>");
			            	$(".console2").html(`<div class="alert-sm alert-primary alert-danger p-1" style="font-size: 0.75rem;">`+
			    					`이미 가입 되어 있는 사업자번호입니다.`+
			    					  `</div>`);
			            } else {
			                //$(".console2").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
			            }
			        },
			        error: function(xhr, status, error) {
			            console.error("AJAX 요청 실패: ", status, error);
			            //$(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
			        }
			    });
			
		});
		
	});
</script>
		
