<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
<h4>데이터 수정</h4>
<form action="/ex/member/update" method="post">
    이메일:
    <input type="text" name="email" value="${userDto.email}" readonly/><br>
    비밀번호:
    <input type="text" name="password"/><br>
    유저명:
    <input type="text" name="name" value="${userDto.name}"/><br>
    전화번호:
    <input type="text" name="phone" value="${userDto.phone}"/><br>
    <input type="hidden" name="enable" value="1"/><br>
    <input type="submit" value="수정"><br>
</form>
</main>
<%@include file="../include/footer.jsp"%>