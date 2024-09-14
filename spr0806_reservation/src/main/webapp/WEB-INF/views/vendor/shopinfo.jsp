<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<style>
    /* 전체 레이아웃 스타일 */
    main {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        color: #ff9800; /* 주황색 제목 */
        margin-bottom: 20px;
        font-size: 24px;
        text-align: center;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    .form-group input[type="text"],
    .form-group textarea,
    .form-group input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
        box-sizing: border-box;
    }

    .form-group input[type="submit"] {
        background-color: #ff9800; /* 주황색 버튼 */
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
        box-sizing: border-box;
        margin-top: 10px;
    }

    .form-group input[type="submit"]:hover {
        background-color: #e68900; /* 버튼 호버 색상 */
    }

    .info-box {
        background-color: #fff;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
                text-align: center;
    }

    .info-box h3 {
        color: #ff9800; /* 주황색 제목 */
        margin-bottom: 10px;
    }

    .info-box p {
        color: #555;
        font-size: 16px;
        margin: 5px 0;
    }
</style>

<main>
    <h2>샵 정보 등록/수정</h2>
    <form:form method="post" action="${pageContext.request.contextPath}/vendor/shopinfo" modelAttribute="businessPlaceInfo" enctype="multipart/form-data">
        <div class="form-group">
            <label for="email">이메일:</label>
            <form:input path="email" id="email" readonly="true"/>
        </div>
        <div class="form-group">
            <label for="business_regi_num">사업자 등록 번호:</label>
            <form:input path="business_regi_num" id="business_regi_num" readonly="true"/>
        </div>
        <div class="form-group">
            <label for="place_info">자기 사업장 설명 소개:</label>
            <form:textarea path="place_info" id="place_info" rows="5" cols="40"></form:textarea>
        </div>
        <div class="form-group">
            <label for="main_image">대표 이미지:</label>
            <input type="file" id="main_image" name="mainImage"/>
        </div>
        <div class="form-group">
            <label for="multi_files">부수 이미지들:</label>
            <input type="file" id="multi_files" name="multiFile" multiple/>
        </div>
        <div class="form-group">
            <input type="submit" value="저장"/>
        </div>
    </form:form>
    
    <%--
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br> --%>
</main>

<%@include file="../include/footer.jsp"%>
        