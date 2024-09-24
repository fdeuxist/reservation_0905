<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="../include/header.jsp"%>
<head>
<style>
/* 레이아웃을 위한 기본 스타일 */
.container {
    display: flex;
}

.sidebar {
    width: 200px;
    background-color: #f4f4f4;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.menu {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.menu li {
    margin-bottom: 10px;
}

.menu li a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
    display: block;
    padding: 10px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.menu li a:hover {
    background-color: #ddd;
}

.content {
    flex: 1;
    padding: 20px;
}

</style>

</head>
<div class="header-placeholder"></div>
<main>
    <div class="container">
        <aside class="sidebar">
            <ul class="menu">
                <li><a href="/ex/manager/manageUsers">유저 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/user/manageRoles">역할 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/user/managePermissions">권한 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/reports">보고서</a></li>
                <li><a href="${pageContext.request.contextPath}/manager/dashBoard">대시보드</a></li>
                <li><a href="${pageContext.request.contextPath}/settings">설정</a></li>
                <li><a href="${pageContext.request.contextPath}/report/reportPage">고객센터로 이동</a></li>
            </ul>
        </aside>
        <div class="content">
            Manager 페이지<br>
            매니저만 들어 올 수 있습니다.

            <form:form action="${pageContext.request.contextPath}/user/logout" method="POST">
                <input type="submit" value="로그아웃" />
           
            </form:form>
        </div>
    </div>
</main>
<%@ include file="../include/footer.jsp"%>
