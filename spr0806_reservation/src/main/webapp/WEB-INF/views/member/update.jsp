<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
<h4>비밀번호 변경/탈퇴</h4>
<form action="/ex/member/update" id="memberUpdateForm" method="post">
    이메일:
    <input type="email" id="email" name="email" placeholder="example@domain.com" value="${userDto.email}" required><br>
    비밀번호:
    <input type="text" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><br>
    비밀번호 확인:
    <input type="text" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" required/><label id="pwWarning"></label><br>
    유저명:
    <input type="text" name="name" value="${userDto.name}" readonly/><br>
    전화번호:
    <input type="text" name="phone" value="${userDto.phone}" readonly/><br>
    <input type="hidden" name="enable" value="1"/><br>
    <input type="submit" value="수정"><input type="submit" id="deleteBtn" value="탈퇴"><br>
</form>
</main>
<script type="text/javascript">
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

document.getElementById('deleteBtn').addEventListener('click', function() {
    var confirmDelete = confirm("정말로 탈퇴하시겠습니까?");
    if (confirmDelete) {
        document.getElementById('memberUpdateForm').action = '/ex/member/delete'; // 폼의 action을 탈퇴 처리 URL로 변경
        document.getElementById('memberUpdateForm').submit(); // 폼 제출
    }
});
</script>
<%@include file="../include/footer.jsp"%>