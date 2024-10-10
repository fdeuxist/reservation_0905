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
<main>
<style>
body {
    margin: 0;
    background-color: #f4f4f4;
}
</style>
<script>
var result = '${msg}';
console.log(result);
if (result == 'success') {
	alert("처리되었습니다.");
}
</script>

<div class="container-fluid">
    <div class="row justify-content-center">
        <div id="formDiv" class="col-md-6 mt-4">
            <form:form action="${pageContext.request.contextPath}/vendor/serviceitemupdate" method="post" modelAttribute="serviceItems">
            
    <br><h3 class="text-center">서비스 항목 수정</h3><br>
                    <form:input path="item_id" id="item_id" class="form-control" type="hidden" />
                <div class="form-group">
                    <label for="service_name">서비스 이름:</label>
                    <form:input path="service_name" id="service_name" class="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <label for="service_description">설명:</label>
                    <form:textarea path="service_description" id="service_description" placeholder="서비스에 대한 간략한 소개를 작성해주세요" rows="3" class="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <label for="required_time">필요 시간 (1당 30분단위):</label>
                    <form:input path="required_time" id="required_time" type="number" class="form-control" min="1" required="true"/>
                </div>
                <div class="form-group">
                    <label for="service_price">가격:</label>
                    <form:input path="service_price" id="service_price" type="number" class="form-control" min="1000" required="true"/>
                </div>
                <div class="form-group">
				    <label for="item_status">상태:</label>
				    <form:select path="item_status" id="item_status" class="form-control" required="true">
				        <form:option value="1">공개</form:option>
				        <form:option value="0">비공개</form:option>
				    </form:select>
				</div>
                <button type="submit" class="btn btn-primary btn-block">수정</button>
            </form:form>
        </div>
    </div>
</div>















</div>
</main>
<%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br> --%>
</main>
<%@include file="../include/footer.jsp"%>