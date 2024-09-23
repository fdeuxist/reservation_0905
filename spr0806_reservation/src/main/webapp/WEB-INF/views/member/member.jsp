<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<%--미사용예정 --%>
<main>
Member 페이지<br>
회원과 사업자와 매니저가 들어 올 수 있습니다. (로그인 된 모든 종류의 계정)<br><br>


<br><br><br><br><br><br>
<a href="../member/membertovendor">사업자 회원 전환</a>




<form:form action="${pageContext.request.contextPath}/user/logout" method="POST">
    <input type="submit" value="로그아웃" />
</form:form>
</main>
<%@include file="../include/footer.jsp"%>