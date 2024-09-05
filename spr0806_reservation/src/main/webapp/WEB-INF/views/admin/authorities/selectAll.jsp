<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

	<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
</style>
<script>
var result = '${msg}';

if (result == 'success') {
	alert("처리가 완료되었습니다.");
}
</script>
<div class="header-placeholder"></div>
<main>
  <table id='customers' width=100% border="1">
	<tr>
		<th style="width: 10px">email</th>
		<th style="width: 100px">authority</th>
	</tr>
	<c:forEach items="${list}" var="dto">	
		<tr>
			<td><a href="/ex/admin/authorities/selectEmail?email=${dto.email }">${dto.email }</a></td>
			<td>${dto.authority}</td>			
		</tr>
	</c:forEach>
    </table>
	<a href="/ex/admin/authorities/insert">추가</a>
	
</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>