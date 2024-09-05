<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>데이터 입력</h4>
<form action="/ex/admin/user/insert" method="post">
	이메일:<input type="text" name="email"><br>
	비밀번호:<input type="text" name="password"><br>
	유저명:<input type="text" name="name"><br>
	전화번호:<input type="text" name="phone"><br>
	<input type="hidden" name="enable" value="1"><br>
	<input type="submit" value="등록"><br>
</form>
</body>
</html>