<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>
	<h4>update</h4>
	<form action="/ex/admin/authorities/update" method=post>
		이름<input type="text" name=email value="${dto.email }" > 
		권한<input type="text" name=authority value="${dto.authority }"> 
		<input type="submit" value="수정">
	</form>
</body>
</html>