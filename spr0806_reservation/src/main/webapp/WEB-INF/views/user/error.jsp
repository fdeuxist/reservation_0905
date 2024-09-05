<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<div class="content">
<body>
403 ERROR 페이지
<br> : 권한 없음
<h2>${SPRING_SECURITY_403_EXCEPTION.message }</h2>

<a href="/ex/user/user">사용자 페이지로 이동</a>

</body>
</html>