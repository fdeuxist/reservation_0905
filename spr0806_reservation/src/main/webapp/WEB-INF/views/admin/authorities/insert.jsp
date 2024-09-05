<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>insert</title>
</head>
<body>
<form action="/ex/admin/authorities/insert" method="post">
유저이메일<input type="text" name="email">
권한 <input type="text" name="authority">
<input type="submit" value="전송">
</form>

</body>
</html>
