<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Manage User</title>
    <link rel="stylesheet" href="header.css"> <!-- 헤더 관련 스타일링 -->
    <link rel="stylesheet" href="/ex/resources/css/userListStyles.css"> <!-- 유저 리스트 관련 스타일링 -->
</head>
<body>
    <main>
        <div class="container">
            <aside class="sidebar">
                <ul>
                    <li><a href="ManageUser.jsp">유저 목록</a></li>
                    <!-- 추가적인 사이드바 항목들 -->
                </ul>
            </aside>
            <section class="content">
                <h1>유저 목록</h1>
                <table>
                    <thead>
                        <tr>
                            <th>이메일</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 유저 리스트가 여기에 출력됩니다. -->
                        <c:forEach var="user" items="${userList}">
                            <tr>
                            <a href="UserManagementPage.jsp?userId=${user.email}">
                                <td>${user.email}</td>
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                              </a>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
</body>
</html>
