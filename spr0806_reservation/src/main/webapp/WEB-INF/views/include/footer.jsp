<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<footer>
<c:choose>
<c:when test="${sessionScope.loginAuthority == '일반회원'}">
	<p>&copy; 2024  Every's Reservation.  All rights reserved.   <a href="../member/membertovendor">사업자 회원 전환</a></p>
</c:when>
<c:otherwise>
	<p>&copy; 2024  Every's Reservation.  All rights reserved.</p>
</c:otherwise>
</c:choose>
</footer>
</body>
</html>
