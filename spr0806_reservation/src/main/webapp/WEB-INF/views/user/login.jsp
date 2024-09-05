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
<h3>아이디와 비밀번호를 입력해주세요.</h3>
<c:url value="/login" var="loginUrl" />
<form name="frmLogin" action="${loginUrl}" method="POST">
<!-- csrf가 있어야 된다. -->
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
</form>
<br>
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

</main>
<%@include file="../include/footer.jsp"%>