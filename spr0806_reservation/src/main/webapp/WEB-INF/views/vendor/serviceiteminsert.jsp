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
<style>
body {
    margin: 0;
    background-color: #f4f4f4;
}
</style>
<%--
<style>
/* 전반적인 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    margin-top: 30px; /* 폼 상단 여백을 추가하여 제목과의 간격 조정 */
}

/* 메인 컨텐츠 스타일 */
main {
    padding: 20px;
    max-width: 800px; /* 최대 너비 설정 */
    margin: 0 auto; /* 중앙 정렬 */
    background-color: #fff; /* 배경색 */
    border-radius: 8px; /* 모서리 둥글게 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    box-sizing: border-box; /* 패딩과 테두리를 포함한 너비 계산 */
}

/* 제목 스타일 */
main h2 {
    color: #333;
    font-size: 1.5em;
    text-align: center; /* 제목 중앙 정렬 */
    margin-top: 30px; /* 폼 상단 여백을 추가하여 제목과의 간격 조정 */
}

/* 폼 스타일 */
#formDiv {
    padding: 20px;
    background-color: #fafafa; /* 폼 배경색 */
    border-radius: 8px; /* 폼 모서리 둥글게 */
    border: 1px solid #ddd; /* 폼 테두리 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 폼 그림자 */
}

form {
    display: flex;
    flex-direction: column;
}

form div {
    margin-bottom: 15px; /* 입력 필드 간의 간격 */
}

label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px; /* 레이블과 입력 필드 간의 간격 */
}

form input[type="text"],
form input[type="number"],
form select,
form textarea {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box; /* 패딩과 테두리를 포함한 너비 계산 */
}

form textarea {
    resize: vertical; /* 세로로만 크기 조절 가능 */
}

form button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin-top: 10px; /* 버튼과 입력 필드 간의 간격 */
}

form button:hover {
    background-color: #0056b3;
}

</style>
 --%>
<main>

<%--
    <br><h2>샵 메뉴(상품) 등록</h2><br>
    <!--selectAllMyItems  목록  -->
    
    <div id=formDiv>
    <form:form action="${pageContext.request.contextPath}/vendor/serviceiteminsert" method="post" modelAttribute="serviceItems">
    <div>
        <label for="service_name">상품명:</label>
        <form:input path="service_name" id="service_name" required="true"/>
    </div>
    <div>
        <label for="service_description">설명:</label>
        <form:textarea path="service_description" id="service_description" rows="3" required="true"/>
    </div>
    <div>
        <label for="required_time">필요 시간 (30분단위):</label>
        <form:input path="required_time" id="required_time" type="number" required="true"/>
    </div>
    <div>
        <label for="service_price">가격:</label>
        <form:input path="service_price" id="service_price" type="text" required="true"/>
    </div>
    <div>
        <label for="item_status">상태:</label>
        <form:select path="item_status" id="item_status" required="true">
            <form:option value="1" label="사용 가능"/>
            <form:option value="0" label="사용 불가"/>
        </form:select>
    </div>
    <button type="submit">등록</button>
</form:form>
 --%>

<script>
var result = '${msg}';
console.log(result);
if (result == 'success') {
	alert("등록되었습니다.");
    window.location.href = '/ex/vendor/serviceitemselectAll';
	
}
</script>

    <%-- selectAllMyItems  목록  --%>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div id="formDiv" class="col-md-6 mt-4">
            <form:form action="${pageContext.request.contextPath}/vendor/serviceiteminsert" method="post" modelAttribute="serviceItems">
            
    <br><h3 class="text-center">서비스 항목 등록</h3><br>
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
                        <form:option value="1" label="공개"/>
                        <form:option value="0" label="비공개"/>
                    </form:select>
                </div>
                <button type="submit" class="btn btn-primary btn-block">등록</button>
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