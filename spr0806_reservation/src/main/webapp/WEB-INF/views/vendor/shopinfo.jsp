<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main><br><br>
    샵 정보 등록/수정   벤더전환시 place_info가 무조건 공란으로 insert되어 이 페이지는 insert와 update 구분 없이 update만으로 처리
    <form:form method="post" action="${pageContext.request.contextPath}/vendor/shopinfo" modelAttribute="businessPlaceInfo">
        <div>
            <label for="email">이메일:</label>
            <form:input path="email" id="email" value="${sessionScope.loginEmail}" readonly="true"/>
        </div>
        <div>
            <label for="business_regi_num">사업자 등록 번호:</label>
            <form:input path="business_regi_num" id="business_regi_num" value="${sessionScope.loginBusiness_regi_num}" readonly="true"/>
        </div>
        <div>
            <label for="place_info">자기 사업장 설명 소개 :</label>
            <form:textarea path="place_info" id="place_info" rows="5" cols="40"></form:textarea>
        </div>
        <div>
            <input type="submit" value="저장"/>
        </div>
    </form:form>
    <br>
    <%-- 
    이미지등록
    <form:form method="post" action="${pageContext.request.contextPath}/vendor/shopimgpath" modelAttribute="businessPlaceImagePath">
        <div>
            <label for="email">이메일:</label>
            <form:input path="email" id="email" value="${sessionScope.loginEmail}" readonly="true"/>
        </div>
        <div>
            <label for="business_regi_num">사업자 등록 번호:</label>
            <form:input path="business_regi_num" id="business_regi_num" value="${sessionScope.loginBusiness_regi_num}" readonly="true"/>
        </div>
        <div>
            <label for="place_img_path">place_img_path :</label>
            <form:input path="place_img_path" id="place_img_path"/>
        </div>
        <div>
            <input type="submit" value="등록"/>
        </div>
    </form:form>
 --%>
${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
</main>

<%@include file="../include/footer.jsp"%>