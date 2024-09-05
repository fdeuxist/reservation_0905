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

<h3>update</h3>

<form action="/ex/admin/updateDB" method="post">
	이메일:<input type="text" name="email" id="email" value="${dto.email }" readonly><br>
	유저명:<input type="text" name="name" id="name" value="${dto.name }" readonly><br>
	전화번호:<input type="text" name="phone" id="phone" value="${dto.phone }" readonly><br>
	사용여부:<!-- <input type="text" name="enable" id="enable" value="${dto.enable}"><br> -->
	<select name="enable" id="enable">
	    	<option value="" disabled>Select a enable</option>
		    <option value="0" <c:if test="${dto.enable == '0'}">selected</c:if>>0</option>
		    <option value="1" <c:if test="${dto.enable == '1'}">selected</c:if>>1</option>
		</select><br>
	권한:<select name="authority" id="authority">
	    	<option value="" disabled>Select a authority</option>
		    <option value="ROLE_MEMBER" <c:if test="${dto.authority == 'ROLE_MEMBER'}">selected</c:if>>ROLE_MEMBER</option>
		    <option value="ROLE_VENDOR" <c:if test="${dto.authority == 'ROLE_VENDOR'}">selected</c:if>>ROLE_VENDOR</option>
		    <option value="ROLE_MANAGER" <c:if test="${dto.authority == 'ROLE_MANAGER'}">selected</c:if>>ROLE_MANAGER</option>
		    <option value="ROLE_ADMIN" <c:if test="${dto.authority == 'ROLE_ADMIN'}">selected</c:if>>ROLE_ADMIN</option>
		</select><br>
	사업자번호:<input type="text" name="business_regi_num" id="business_regi_num" value="${dto.business_regi_num }" readonly><br>
	사업명:<input type="text" name="business_name" id="business_name" value="${dto.business_name }" readonly><br>
	우편번호:<input type="text" name="zipcode" id="zipcode" value="${dto.zipcode }" readonly><br>
	기본주소:<input type="text" name="basic_address" id="basic_address" value="${dto.basic_address }" readonly><br>
	상세주소:<input type="text" name="detail_address" id="detail_address" value="${dto.detail_address }" readonly><br>
	사업종류:<input type="text" name="business_type" id="business_type" value="${dto.business_type }" readonly><br>
	
	<input type="submit" value="수정"><br>
</form>

<!-- <a href="/ex/admin/user/insert">입력</a> -->
</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>