<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Manage User</title>

<!-- 헤더 관련 스타일링 -->
<link rel="stylesheet" href="/ex/resources/css/userListStyles.css">

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 서버에서 전달된 메시지를 자바스크립트 변수로 설정
        var msg = '<c:out value="${fn:escapeXml(msg)}" />';
        
        // 메시지가 존재하면 alert로 표시
        if (msg) {
            alert(msg);
        }

        // JavaScript로 행 클릭 시 링크로 이동
        const rows = document.querySelectorAll('table tbody tr');
        rows.forEach(row => {
            row.addEventListener('click', function() {
                window.location.href = this.dataset.href;
            });
        });
    });
</script>
</head>
<body>
    <main>
    <div class="container">
   
        <section class="content">
            <h1>유저 목록</h1>
            <table>
                <thead>
                    <tr>
                        <th>이메일</th>
                        <th>이름</th>
                        <th>전화번호</th>
                        <th>권한</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 유저 리스트가 여기에 출력됩니다. -->
                    <c:forEach var="user" items="${userList}">
                        <tr data-href="/ex/manager/selectUser?userEmail=${user.email}">
                            <td>${user.email}</td>
                            <td>${user.name}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:forEach var="role" items="${role}">
                                    <c:if test="${role.email eq user.email}">
                                        <c:out value="${role.authority}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
    </div>
    </main>
</body>
</html>

 