<%--<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title> 주석처리 후 공용 헤더 추가함 [양재하] --%>

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
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        background-color: #f4f4f4; /* Light gray background for the entire page */
    }
/*	   header용 css 주석처리함 [양재하]*/
/*    .head {
        background-color: #000; *//* Black background */
/*        color: #fff; *//* White text color */
/*        padding: 15px;
        text-align: center;
        border-bottom: 2px solid #333;
    }
    .head-title{
    	color: white;
    	text-align: left;
    }*/
    .main {
        display: flex;
    }
    /* Sidebar Styles */
.side {
	width: 250px;
	background-color: #333; /* 사이드바 배경색: 검정색 */
	color: #fff; /* 텍스트 색상: 흰색 */
	padding: 15px;
}

.side a {
	color: #fff; /* 링크 색상: 흰색 */
	text-decoration: none;
	display: block;
	margin: 5px 0;
}

.side a:hover {
	text-decoration: underline; /* 호버 시 밑줄 추가 */
}
    .row1 {
        flex: 3;
        padding: 20px;
        background-color: #eee; /* Slightly darker gray for the form background */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1, h2 {
        margin: 0 0 15px;
        color: #333;
    }
    form {
        max-width: 600px;
        margin: 0 auto;
    }
    form input[type="text"],
    form textarea,
    form select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    form textarea {
        resize: vertical;
    }
    form input[type="submit"] {
        background-color: #4CAF50; /* Green background for submit button */
        border: none;
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    form input[type="submit"]:hover {
        background-color: #45a049; /* Darker green on hover */
    }
</style>
</head>
<body>
<%--
    <div class="head">
        <h1 class ="head-title">My Website</h1>
    </div>
    --%>
    <div class="main">
        <div class="side">
            <a href="/ex/board/listAll">All Category</a>
        </div>
        <div class="row1"> <%--class에 사용되는 row는 부트스트랩 예약어이기때문에 row1로 수정하고 위의 css도 row1로 수정함 [양재하] --%>
            <h1>새 글쓰기</h1>
            <form action="/ex/board/register" method="post">
                <h2>제목</h2>
                <input type="text" name="bTitle" placeholder="제목 입력">
                <h2>카테고리</h2>
                <select name="bGroupKind">
                    <option value="공지사항">공지사항</option>
                    <option value="자유게시판">자유게시판</option>
                </select>
                <h2>내용</h2>
                <textarea name="bContent" rows="8" placeholder="내용을 입력하세요."></textarea>
                <h2>작성자</h2>
                <input type="text" name="bName" placeholder="작성자" 
                	value="${sessionScope.loginName}(${sessionScope.loginAuthority})" readonly>
                <input type="submit" value="글쓰기">	<%--작성자 이름을 로그인 이름,권한으로 고정함 [양재하]--%>
            </form>
        </div>
    </div>
</body>
</html>
