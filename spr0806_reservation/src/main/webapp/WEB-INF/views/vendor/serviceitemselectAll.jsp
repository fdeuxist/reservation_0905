<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/header.jsp"%>
<%@ page session="true" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<div class="header-placeholder"></div>
<style>
body {
    margin: 0;
    background-color: #f4f4f4;
}
</style>
<script>
var result = '${msg}';

if (result == 'success') {
	alert("처리가 완료되었습니다.");
}
</script>

<body>
        
<div class="container mt-5">
	<table width="80%" class="table table-striped text-center">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>필요시간(1당 30분단위)</th>
			<th>가격</th>
			<th>상태</th>
			<th>수정</th>
		</tr>
		<c:forEach items="${list }" var="dto">
			<tr>
				<td>${dto.item_id }</td>
				<td>${dto.service_name }</td>
				<td>${dto.required_time }</td>
				<td>${dto.service_price }</td>
				<td>
				    <c:choose>
				        <c:when test="${dto.item_status == 1}">공개</c:when>
				        <c:otherwise>비공개</c:otherwise>
				    </c:choose>
				</td>
				<td><a href="${pageContext.request.contextPath}/vendor/serviceitemupdate?item_id=${dto.item_id }" class="btn btn-warning">수정하기</a></td>
			</tr>
		</c:forEach>
	</table>
    <a href="${pageContext.request.contextPath}/vendor/serviceiteminsert" class="btn btn-primary">등록하기</a>
</div>
</main>
<%@include file="../include/footer.jsp"%>
