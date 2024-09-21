<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
 <c:if test="${param.error != null}">
        <p>아이디와 비밀번호가 잘못되었습니다.</p>
    </c:if>
    <c:if test="${param.logout != null}">
        <p>로그아웃 하였습니다.</p>
</c:if>
<c:if test="${param.vendor != null}">
        <p>사업자회원으로 전환되었습니다. 로그인 해 주세요.</p>
</c:if>
<c:if test="${param.member != null}">
        <p>회원 가입 되었습니다. 로그인 해 주세요.</p>
</c:if>
<c:if test="${param.update != null}">
        <p>회원정보가 수정되었습니다. 로그인 해 주세요.</p>
</c:if>
<c:if test="${param.delete != null}">
        <p>회원탈퇴되었습니다. 이용해주셔서 감사합니다.</p>
</c:if>
<h3>아이디와 비밀번호를 입력해주세요.</h3>
<c:url value="/login" var="loginUrl" />
<form name="frmLogin" action="${loginUrl}" method="POST">
<%-- CSRF가 있어야 된다. 
Security에서 CSRF (Cross-Site Request Forgery) 공격을 방지하기 위한 CSRF 토큰을 HTML 폼에 포함시키는 방식
CSRF 공격이란: 공격자가 사용자의 권한을 이용해 웹 애플리케이션에서 원하지 않는 요청을 보내는 공격입니다. 
	예를 들어, 사용자가 로그인된 상태에서 악의적인 사이트를 방문하면 
	해당 사이트가 사용자의 인증 정보를 이용해 임의의 요청을 보낼 수 있습니다.
CSRF 토큰의 역할: CSRF 토큰은 서버가 클라이언트에게 전달하는 고유한 비밀 토큰입니다. 
	폼을 제출할 때 이 토큰을 함께 전송하여 요청이 실제로 의도된 사용자에 의해 발생한 것임을 확인합니다.
--%>
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
    <p>
        <label for="email">이메일</label>
        <input type="text" id="email" name="email" />
    </p>
    <p>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password"/>
    </p>
    <button type="submit" class="btn">로그인</button>  
    <input type="button" id="findIdBtn" class="btn" value="계정 찾기">
    <input type="button" id="memberJoinBtn" class="btn" value="회원가입">
</form>
<br>

<%--
<!-- form태그를 이용한 경우/ 상단에  <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 추가해야함 -->
<c:url value="/login" var="loginUrl" />
<form:form name="frmLogin" action="${loginUrl}" method="POST">
    <c:if test="${param.error != null}">
        <p>아이디와 비밀번호가 잘못되었습니다.</p>
    </c:if>
    <c:if test="${param.logout != null}">
        <p>로그아웃 하였습니다.</p>
    </c:if>
    <p>
        <label for="email">이메일</label>
        <input type="text" id="email" name="email" />
    </p>
    <p>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password"/>
    </p>
    <button type="submit" class="btn">로그인</button>
</form:form>
 --%>
</main>
<script>
$(document).ready(function() {
    $('#findIdBtn').click(function() {
    	window.location.href = 'findMyAccount';
    });
});

</script>
<%@include file="../include/footer.jsp"%>