<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>
<h4>UPDATE</h4>
<form action="/ex/admin/user/update" method="post">
	이메일:<input type="text" name="email" value="${dto.email }"><br>
	비밀번호:<input type="text" name="password" value="${dto.password }"><br>
	유저명:<input type="text" name="name" value="${dto.name }"><br>
	전화번호:<input type="text" name="phone" value="${dto.phone }"><br>
	<input type="hidden" name="enable" value="${dto.enable}"><br>
	<input type="submit" value="수정"><br>
</form>
</body>
</html>