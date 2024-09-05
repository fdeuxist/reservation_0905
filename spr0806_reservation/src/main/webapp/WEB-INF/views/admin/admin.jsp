<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
<div class="content">
Admin 페이지<br>
관리자(사이트 운영자)만 들어 올 수 있습니다.



<form:form action="${pageContext.request.contextPath}/user/logout" method="POST">
    <input type="submit" value="로그아웃" />
</form:form>
</div>
</main>
<%@include file="../include/footer.jsp"%>