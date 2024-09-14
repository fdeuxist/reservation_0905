<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
<h4>데이터 입력</h4>
<form action="/ex/user/insert" method="post">
	이메일:<input type="email" id="email" name="email" placeholder="example@domain.com" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><input type="button" id="checkemail" value="중복확인" /><div class="console"></div>
	<button type="button" id="emailBtn">인증번호 발송</button><br>
	이메일 인증번호:<input type="text" id="emailAuth" name="emailAuth" required><button type="button" id="emailAuthBtn">이메일 인증</button><br>
	비밀번호:<input type="text" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><br>
	비밀번호 확인:<input type="text" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><label id="pwWarning"></label><br>
	이름:<input type="text" name="name" required><br>
	전화번호:<input type="text" id="phone" name="phone" pattern="\d{11}" placeholder="01012341234" required><input type="button" id="checkphone" value="중복검사" /><div class="consolep"></div>
	<button type="button" id="phoneBtn">전화번호 인증번호 발송</button><br>
	전화번호 인증번호:<input type="text" id="phoneAuth" name="phoneAuth" required><button type="button" id="phoneAuthBtn">전화번호 인증</button><br>
	<input type="hidden" name="enable" value="1"><br>
	<input type="submit" value="등록"><br>
</form>
	<input type="hidden" id="random" value="${random }" />
	<input type="hidden" id="randomp" value="${randomp }" />
</main>



<script src="../resources/js/authemail.js"></script><!-- 이메일 인증코드 관련-->
<script src="../resources/js/authphone.js"></script><!-- 전화번호 인증코드 관련-->

<script type="text/javascript">
	$(function() {
		
		$("#checkemail").click(function() {
			// 사용자 입력값 얻어오기
			var input_value = $("input[name='email']").val();

			// 입력여부 검사. email 입력 없이 버튼을 누르면 alert
			if (!input_value) {
				alert("이메일을 입력하세요.");
				$("input[name='email']").focus();/*focus()는 선택시 활성화되는것*/
				return false;//기본이벤트 막음 
			}
			
			var url = "/ex/userrest/emailcheck";

			$.ajax({
			    url: '/ex/userrest/emailcheck', // 이메일 중복 체크
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
		                $(".console").html("<span style='color:blue'>사용할 수 있는 아이디입니다.</span>");
		            } else if (result === "false") {
		                $(".console").html("<span style='color:red'>사용할 수 없는 아이디입니다.</span>");
		            } else {
		                $(".console").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패: ", status, error);
		            $(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
		        }
		    });
		});

		//비밀번호 검증
		$("#password2").keyup(function (){
               var pw1 = $("#password").val();
               var pw2 = $("#password2").val();
               if(pw1==pw2){
                   $("#pwWarning").hide();
                   $("#password2").css("background-color", "white");
               } else {
                   $("#pwWarning").show();
                   $("#pwWarning").html("입력된 비밀번호가 서로 다릅니다");
                   $("#password2").css("background-color", "red");
               }
           });
	});
	

			
		$("#checkphone").click(function() {
			var input_value = $("input[name='phone']").val();
	
			if (!input_value) {
				alert("전화번호를 입력하세요.");
				$("input[name='phone']").focus();/*focus()는 선택시 활성화되는것*/
				return false;//기본이벤트 막음 
			}
			
		$.ajax({
	        url: '/ex/userrest/phonecheck', // 전화번호 중복 체크
	        type: 'GET', // HTTP 메서드
	        data: {
	            phone: input_value // 서버로 보낼 파라미터
	        },
	        success: function(response) {
	        	console.log(response);
	            // 서버에서 반환된 JSON 데이터를 파싱
	            var result = response.result;
	            console.log(result);
	            // result가 "true"인지 "false"인지 판단하여 사용자에게 메시지 표시
	            if (result === "true") {
	                $(".consolep").html("<span style='color:blue'>사용할 수 있는 전화번호입니다.</span>");
	            } else if (result === "false") {
	                $(".consolep").html("<span style='color:red'>사용할 수 없는 전화번호입니다.</span>");
	            } else {
	                $(".consolep").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패: ", status, error);
	            $(".consolep").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
	        }
	    });

});
		
</script>
		

