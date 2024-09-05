<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery Framework 참조하기 -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<h4>데이터 입력</h4>
<form action="/ex/user/membertovendor" method="post">
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



<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="../resources/js/mbtvaddrapi.js"></script>
		<!-- 사용자 스크립트 블록 -->
		
		<script type="text/javascript">
			$(function() {

		        const submitBtn = document.getElementById('submitBtn');
		        const checkbusiness_regi_numBtn = document.getElementById('checkbusiness_regi_num');
		        

	        	
					// 사용자 입력값 얻어오기
		        	var input_value = $("input[name='email']").val();
					 $.ajax({
					        url: '/ex/vendorrest/emailcheck', // 서버에서 정의한 URL
					        type: 'GET', // HTTP 메서드
					        data: {
					        	email: input_value // 서버로 보낼 파라미터
					        },
					        success: function(response) {
					        	console.log(response);
					            // 서버에서 반환된 JSON 데이터를 파싱
					            var result = response.result;
					            console.log(result);
					            // result가 "true"인지 "false"인지 판단하여 사용자에게 메시지 표시
					            if (result === "true") {
					                $(".console1").html("<span style='color:blue'>사업자회원 전환이 가능한 이메일입니다.</span>");
					                checkbusiness_regi_numBtn.disabled = false;
					            } else if (result === "false") {
					                $(".console1").html("<span style='color:red'>이미 사업자회원으로 전환 되어 있는 이메일입니다.</span>");
					            } else {
					                $(".console1").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
					            }
					        },
					        error: function(xhr, status, error) {
					            console.error("AJAX 요청 실패: ", status, error);
					            $(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
					        }
					    });
					
		        
		        
		        
		        
		        	
				
				
				
				
				$("#checkbusiness_regi_num").click(function() {
					// 사용자 입력값 얻어오기
					var input_value = $("input[name='business_regi_num']").val();

					// 입력여부 검사 input tag에 입력값 없이 버튼 누를시 alert이 실행된다.
					if (!input_value) {
						alert("사업자번호를 입력하세요.");
						$("input[name='business_regi_num']").focus();/*focus()는 선택시 활성화되는것*/
						return false;//기본이벤트 막음 
					}
					
					 $.ajax({
					        url: '/ex/vendorrest/business_regi_numcheck', // 서버에서 정의한 URL
					        type: 'GET', // HTTP 메서드
					        data: {
					        	business_regi_num: input_value // 서버로 보낼 파라미터
					        },
					        success: function(response) {
					        	console.log(response);
					            // 서버에서 반환된 JSON 데이터를 파싱
					            var result = response.result;
					            console.log(result);
					            // result가 "true"인지 "false"인지 판단하여 사용자에게 메시지 표시
					            if (result === "true") {
					                $(".console2").html("<span style='color:blue'>사용할 수 있는 사업자번호입니다.</span>");
					                submitBtn.disabled = false;
					            } else if (result === "false") {
					                $(".console2").html("<span style='color:red'>이미 가입 되어 있는 사업자번호입니다.</span>");
					            } else {
					                $(".console2").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
					            }
					        },
					        error: function(xhr, status, error) {
					            console.error("AJAX 요청 실패: ", status, error);
					            $(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
					        }
					    });
					
				});
				
			});
		</script>
		


</html>