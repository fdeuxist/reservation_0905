<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<div class="header-placeholder"></div>
<main>
    샵 메뉴(상품) 등록<br>
    selectAllMyItems  목록
    
    <form:form action="${pageContext.request.contextPath}/vendor/serviceiteminsert" method="post" modelAttribute="serviceItems">
    <div>
        <label for="service_name">상품명:</label>
        <form:input path="service_name" id="service_name" required="true"/>
    </div>
    <div>
        <label for="service_description">설명:</label>
        <form:input path="service_description" id="service_description" required="true"/>
    </div>
    <div>
        <label for="required_time">필요 시간 (30분단위):</label>
        <form:input path="required_time" id="required_time" type="number" required="true"/>
    </div>
    <div>
        <label for="service_price">가격:</label>
        <form:input path="service_price" id="service_price" type="number" required="true"/>
    </div>
    <div>
        <label for="item_status">상태:</label>
        <form:select path="item_status" id="item_status" required="true">
            <form:option value="1" label="사용 가능"/>
            <form:option value="0" label="사용 불가"/>
        </form:select>
    </div>
    <button type="submit">등록</button>
</form:form>
</main>

${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
</main>
<%@include file="../include/footer.jsp"%>