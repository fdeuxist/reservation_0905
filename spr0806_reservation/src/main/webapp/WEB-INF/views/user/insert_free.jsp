<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}
#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}
#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}
.hidden {
/*    display: none;*/
}
</style>
<div class="header-placeholder"></div>
<main>

<div class="header-placeholder"></div>
<main>
<h4>데이터 입력</h4>
<form action="/ex/user/insert_free" method="post">
	이메일:<input type="text" id="email" name="email" required><br>
	비밀번호:<input type="text" id="password" name="password" maxlength="20" value="1111"/><br>
	이름:<input type="text" name="name" value="1"><br>
	전화번호:<input type="text" id="phone" name="phone"  value="1">
	<input type="hidden" name="enable" value="1"><br>
	<input type="submit" value="등록"><br>
</form>
</main>



</main>



<%@include file="../include/footer.jsp"%>
