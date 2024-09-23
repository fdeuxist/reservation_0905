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
h3{
	color:#04AA6D;
	margin-left:5px;

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

<h3>모든 회원 보기, 권한수정/계정 정지</h3>
<form action="/ex/admin/accountSearch" method="get" class="search-form">
	<label for="searchBy">검색 기준:</label>
	<select name="searchBy" id="searchBy">
		<option value="email">email</option>
		<option value="name">name</option>
	</select>
	<input type="text" name="keyword" id="keyword" placeholder="검색어 입력">
	<input type="submit" value="검색">
</form>

<table id='customers' width=100% border="1">
<tr>
	<th style="width:110px">email</th>
	<th style="width:100px">name</th>
	<th style="width:100px">phone</th>
	<th style="width:30px">enabled</th>
	<th style="width:30px">authority</th>
	<th style="width:30px">business_regi_num</th>
	<th style="width:30px">business_name</th>
	<th style="width:30px">zipcode</th>
	<th style="width:30px">basic_address</th>
	<th style="width:30px">detail_address</th>
	<th style="width:30px">business_type</th>
</tr>
	<c:forEach items="${list }" var="dto">
		<tr>
			<td><a href="/ex/admin/update?email=${dto.email }">${dto.email }</a></td>
			<td>${dto.name }</td>
			<td>${dto.phone }</td>
			<td>${dto.enable }</td>
			<td>${dto.authority }</td>
			<td>${dto.business_regi_num }</td>
			<td>${dto.business_name }</td>
			<td>${dto.zipcode }</td>
			<td>${dto.basic_address }</td>
			<td>${dto.detail_address }</td>
			<td>${dto.business_type }</td>
		</tr>
	</c:forEach>
</table>

<br><br><br>

</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>