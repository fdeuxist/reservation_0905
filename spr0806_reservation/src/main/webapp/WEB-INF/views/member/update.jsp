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
<div>
	<h4>비밀번호 변경/탈퇴</h4>
	<form action="/ex/member/update" id="memberUpdateForm" method="post">
	    이메일 아이디:
	    <input type="email" id="email" name="email" placeholder="example@domain.com" value="${userDto.email}" required><br>
	    비밀번호:
	    <input type="text" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><br>
	    비밀번호 확인:
	    <input type="text" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><label id="pwWarning"></label><br>
	    <div id="valid_pw"></div><br>
	    이름:
	    <input type="text" name="name" value="${userDto.name}" readonly/><br>
	    전화번호:
	    <input type="text" name="phone" value="${userDto.phone}" readonly/><br>
	    <input type="hidden" name="enable" value="1"/><br>
	    <input type="submit" value="수정"> <input type="submit" id="deleteBtn" value="탈퇴"><br>
	</form>
</div> --%>

<div id="container282" class="mb-5">
	<div class="empty-space"></div>
	<div>
	<div><h3 class="text-center mt-3 mb-3">비밀번호 변경/탈퇴</h3></div>
		<form action="/ex/member/update" id="memberUpdateForm" method="post" class="needs-validation" novalidate>
		    <div class="form-group">
		        <label for="email">이메일 아이디:</label>
		        <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com" value="${userDto.email}" required readonly>
		    </div>
		    
		    <div class="form-group">
		        <label for="password">비밀번호:</label>
		        <input type="password" class="form-control" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required>
		        <div id="valid_pw"></div>
		    </div>
		    
		    <div class="form-group">
		        <label for="password2">비밀번호 확인:</label>
		        <input type="password" class="form-control" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required>
		        <div id="valid_pw2"></div>
		        <%-- <label id="pwWarning" style="color:red; display:none;">입력된 비밀번호가 서로 다릅니다.</label> --%>
		    </div>
		    
		    <div class="form-group">
		        <label for="name">이름:</label>
		        <input type="text" class="form-control" name="name" value="${userDto.name}" readonly>
		    </div>
		    
		    <div class="form-group">
		        <label for="phone">전화번호:</label>
		        <input type="text" class="form-control" name="phone" value="${userDto.phone}" readonly>
		    </div>
		    
		    <input type="hidden" name="enable" value="1">
		    
		    <button type="submit" class="btn btn-primary">수정</button>
		    <button type="submit" id="deleteBtn" class="btn btn-danger ml-3">탈퇴</button>
		</form>
	</div>
	<div class="empty-space"></div>
</main>
<script type="text/javascript">


const regExpPassword = /^(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{4,20}$/;

//비밀번호 검증
$("#password").keyup(function (){
         var pw1 = $("#password").val();
         if(!regExpPassword.test(pw1)){
             $("#valid_pw").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
					`비밀번호는 4자 이상 20자 이하이어야 하며, 1개 이상의 특수문자(!@#$%^&*)를 포함해야 합니다.`+
				 `</div>`);
             $("#valid_pw2").html("");
         } else {
             $("#valid_pw").html("");
             //$("#password2").css("background-color", "red");
         }
         pw2keyup();
     });
		//비밀번호 검증
$("#password2").keyup(function (){
	pw2keyup();
});

function pw2keyup(){
	var pw1 = $("#password").val();
    var pw2 = $("#password2").val();
    if(pw1==pw2){
 	   $("#valid_pw2").html("");
        //$("#pwWarning").hide();
        //$("#password2").css("background-color", "white");

    } else {
        //$("#pwWarning").show();
        //$("#pwWarning").html("입력된 비밀번호가 서로 다릅니다");
        //$("#password2").css("background-color", "red");
        $("#valid_pw2").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
					`입력된 비밀번호가 서로 다릅니다.`+
			  `</div>`);

    }
}



document.getElementById('deleteBtn').addEventListener('click', function() {
    var confirmDelete = confirm("정말로 탈퇴하시겠습니까?");
    if (confirmDelete) {
        document.getElementById('memberUpdateForm').action = '/ex/member/delete'; // 폼의 action을 탈퇴 처리 URL로 변경
        document.getElementById('memberUpdateForm').submit(); // 폼 제출
    }
});
</script>
<%@include file="../include/footer.jsp"%>