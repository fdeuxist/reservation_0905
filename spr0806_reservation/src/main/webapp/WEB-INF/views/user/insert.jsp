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
--%>



<%-- id달린거 --%>
<%--
<div id="container282">
        <div class="empty-space"></div>
<div>
    <h4>회원가입</h4>
    <form action="/ex/user/insert" method="post" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="email">이메일 아이디: email</label>
            <input type="email" class="form-control" id="email" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" placeholder="example@domain.com" required>
            <div id="valid_email" class=""></div>
            <div class="console"></div>
            <button type="button" id="checkemail" class="btn btn-secondary" disabled>checkemail 중복확인</button>
            <button type="button" id="emailBtn" class="btn btn-info" disabled>emailBtn 인증번호 발송</button>
        </div>
        
        <div class="form-group">
            <label for="emailAuth">이메일 인증번호: emailAuth</label>
            <input type="text" class="form-control" id="emailAuth" name="emailAuth" disabled required>
            <div id="valid_email2"></div>
            <button type="button" id="emailAuthBtn" class="btn btn-info" disabled>emailAuthBtn 이메일 인증</button>
        </div>
        
        <div class="form-group">
            <label for="password">비밀번호: password     valid_pw</label>
            <input type="password" class="form-control" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" disabled required>
            <div id="valid_pw"></div>
            <div class="invalid-feedback">비밀번호는 4-20자의 영문자 또는 숫자만 포함해야 합니다.</div>
        </div>
        
        <div class="form-group">
            <label for="password2">비밀번호 확인: password2       valid_pw2</label>
            <input type="password" class="form-control" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" disabled required>
            <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
            <div id="valid_pw2"></div>
            <label id="pwWarning" style="color:red; display:none;">입력된 비밀번호가 서로 다릅니다</label>
        </div>
        
        <div class="form-group">
            <label for="name">이름: name</label>
            <input type="text" class="form-control" name="name" id="name" disabled required>
            <div id="valid_name"></div>
        </div>
        
        <div class="form-group">
            <label for="phone">전화번호: phone       valid_phone </label>
            <input type="text" class="form-control" id="phone" name="phone" pattern="\d{11}" placeholder="01012341234" disabled required>
            <div id="valid_phone"></div>
            <div class="consolep"></div>
            <div class="invalid-feedback">유효한 전화번호를 입력하세요.</div>
            <button type="button" id="checkphone" class="btn btn-secondary" disabled>checkphone 중복검사</button>
            <button type="button" id="phoneBtn" class="btn btn-info" disabled>phoneBtn 전화번호 인증번호 발송</button>
        </div>
        
        <div class="form-group">
            <label for="phoneAuth">전화번호 인증번호: phoneAuth       valid_phone2</label>
            <input type="text" class="form-control" id="phoneAuth" name="phoneAuth" disabled required>
            <div id="valid_phone2"></div>
            <button type="button" id="phoneAuthBtn" class="btn btn-info" disabled>phoneAuthBtn 전화번호 인증</button>
        </div>
        
        <input type="hidden" name="enable" value="1">
        <button id="submit" type="submit" class="btn btn-primary" disabled>가입</button>
        <br><br>
    </form>
    <br><br>
    <input type="hidden" id="random" value="${random}" />
    <input type="hidden" id="randomp" value="${randomp}" />
    </div>
            <div class="empty-space">
    <!-- <button id="test1" type="button" class="btn btn-primary" >test1</button></div> --!>
</div>
 --%>
 
<div id="container282">
        <div class="empty-space"></div>
<div>
	<div><h3 class="text-center mt-3 mb-3">회원가입</h3></div>
    <form action="/ex/user/insert" method="post" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="email">이메일 아이디:</label>
            <input type="email" class="form-control" id="email" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" placeholder="example@domain.com" required>
            <div id="valid_email" class=""></div>
            <div class="console"></div>
            <button type="button" id="checkemail" class="btn btn-secondary" disabled>중복확인</button>
            <button type="button" id="emailBtn" class="btn btn-info" disabled>인증번호 발송</button>
        </div>
        
        <div class="form-group">
            <label for="emailAuth">이메일 인증번호:</label>
            <input type="text" class="form-control" id="emailAuth" name="emailAuth" disabled required>
            <div id="valid_email2"></div>
            <button type="button" id="emailAuthBtn" class="btn btn-info" disabled>이메일 인증</button>
        </div>
        
        <div class="form-group">
            <label for="password">비밀번호:</label>
            <input type="password" class="form-control" id="password" name="password" pattern="[A-Za-z0-9]{4,20}" maxlength="20" disabled required>
            <div id="valid_pw"></div>
        </div>
        
        <div class="form-group">
            <label for="password2">비밀번호 확인:</label>
            <input type="password" class="form-control" id="password2" name="password2" pattern="[A-Za-z0-9]{4,20}" maxlength="20" disabled required>
            <div id="valid_pw2"></div>
            <label id="pwWarning" style="color:red; display:none;">입력된 비밀번호가 서로 다릅니다</label>
        </div>
        
        <div class="form-group">
            <label for="name">이름:</label>
            <input type="text" class="form-control" name="name" id="name" disabled required>
            <div id="valid_name"></div>
        </div>
        
        <div class="form-group">
            <label for="phone">전화번호:</label>
            <input type="text" class="form-control" id="phone" name="phone" pattern="\d{11}" placeholder="01012341234" disabled required>
            <div id="valid_phone"></div>
            <div class="consolep"></div>
            <button type="button" id="checkphone" class="btn btn-secondary" disabled>중복검사</button>
            <button type="button" id="phoneBtn" class="btn btn-info" disabled>전화번호 인증번호 발송</button>
        </div>
        
        <div class="form-group">
            <label for="phoneAuth">전화번호 인증번호:</label>
            <input type="text" class="form-control" id="phoneAuth" name="phoneAuth" disabled required>
            <div id="valid_phone2"></div>
            <button type="button" id="phoneAuthBtn" class="btn btn-info" disabled>전화번호 인증</button>
        </div>
        
        <input type="hidden" name="enable" value="1">
        <button id="submit" type="submit" class="btn btn-primary" disabled> 가 입 </button>
        <br><br>
    </form>
    <br><br>
    <input type="hidden" id="random" value="${random}" />
    <input type="hidden" id="randomp" value="${randomp}" />
    </div>
            <div class="empty-space">
    <!-- <button id="test1" type="button" class="btn btn-primary" >test1</button></div> --!>
</div>

</main>

<script src="../resources/js/userinsert.js"></script><!-- 전화번호 인증코드 관련-->
<script src="../resources/js/authemail.js"></script><!-- 이메일 인증코드 관련-->
<script src="../resources/js/authphone.js"></script><!-- 전화번호 인증코드 관련-->

<script type="text/javascript">
var emailVerified = false;
var passwordVerified = false;
var nameEntered = false;
var phoneVerified = false;

var test = (emailVerified+" "+ passwordVerified+" "+ nameEntered+" "+ phoneVerified);
function checkVerificationStatus() {
    if (emailVerified && passwordVerified && nameEntered && phoneVerified) {
        $("#submit").prop('disabled', false);  // 가입 버튼 활성화
    } else {
        $("#submit").prop('disabled', true);   // 가입 버튼 비활성화
    }
}
</script>
		


<%@include file="../include/footer.jsp"%>