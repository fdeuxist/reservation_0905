<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>답글쓰기</title>
    <!-- <link rel="stylesheet" type="text/css" href="../css/styles.css">-->
    <style>
    	body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.main {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.box-header {
    border-bottom: 2px solid #007BFF;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.box-title {
    margin: 0;
    font-size: 24px;
    color: #007BFF;
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
.form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

.form-group textarea {
    resize: vertical;
}

button.btn {
    display: inline-block;
    padding: 10px 15px;
    font-size: 16px;
    color: #fff;
    background-color: #007BFF;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button.btn:hover {
    background-color: #0056b3;
}
    </style>
</head>
<body>
<div class="main">

	<div class="box-header">
		<h1 class="box-title">답글쓰기</h1>
	</div>


<form role="form" action="/ex/reply/reply" method="post">
        <input type='hidden' name='bId' value="${boardDto.bId}"> 
        <div class="form-group">
            <label for="bGroupKind">카테고리</label>
            <input type="text" id="bGroupKind" name='bGroupKind' value="${boardDto.bGroupKind}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="bTitle">제목</label>
            <input type="text" id="bTitle" name='bTitle' placeholder="제목을 입력해 주세요">
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="8" placeholder="내용을 50자 이상 입력해 주세요."></textarea>
        </div>
        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" placeholder="작성자">
        </div>
        <button type="submit" class="btn">새글등록</button>
    </form>
</div>

<%@include file="../include/footer.jsp"%>
</body>
</html>