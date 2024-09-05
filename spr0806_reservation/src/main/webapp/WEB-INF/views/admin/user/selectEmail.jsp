<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<title>Home</title>
	<script>
	 var result = '${msg}';
		if (result == 'success') {
			alert("처리가 완료되었습니다.");
		}
	</script>
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
</head>
<body>
<h3>상세 데이터 보기</h3>
<table id='customers' width=100% border="1">
<tr>
	<th style="width:10px">선택</th>
	<th style="width:200px">email</th>
	<th style="width:200px">password</th>
	<th style="width:200px">name</th>
	<th style="width:200px">phone</th>
	<th style="width:200px">enable</th>
</tr>
	
		<tr>
			<td><a href="/ex/admin/user/delete?email=${dto.email}">삭제</a></td>
			<td>${dto.email}</td>
			<td>${dto.password}</td>
			<td>${dto.name}</td>
			<td>${dto.phone}</td>
			<td>${dto.enable}</td>
		</tr>
	
</table>
<a href='/ex/admin/user/update?email=${dto.email}&password=${dto.password}&name=${dto.name}&phone=${dto.phone}&enable=${dto.enable}'>수정</a>
<a href="/ex/admin/user/selectAll">전체 데이터</a>
</body>
</html>