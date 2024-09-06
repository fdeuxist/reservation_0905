<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>게시판</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        background-color: #f4f4f4; /* Light gray background for the entire page */
    }
    .head {
        background-color: #000; /* Black background */
        color: #fff; /* White text color */
        padding: 15px;
        text-align: center;
        border-bottom: 2px solid #333;
    }
    .head-title{
    	color: white;
    	text-align: left;
    }
    .main {
        display: flex;
        margin: 20px;
    }
    .side {
        flex: 1;
        padding: 10px;
        background-color: #ddd; /* Light gray background */
        border-right: 2px solid #bbb;
    }
    .side a {
        text-decoration: none;
        color: #333;
        font-size: 18px;
        display: block;
        padding: 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .side a:hover {
        background-color: #bbb; /* Darker gray on hover */
    }
    .row {
        flex: 3;
        padding: 20px;
        background-color: #eee; /* Slightly darker gray for the form background */
        border-radius: 5px;
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
    <div class="head">
        <h1 class ="head-title">My Website</h1>
    </div>
    
    <div class="main">
        <div class="side">
            <a href="/ex/board/listAll">All Category</a>
        </div>
        <div class="row">
            <h1>새 답글쓰기</h1>
            <form action="/ex/board/reply" method="post">
            	<input type="hidden" name="bId" value='${boardDto.bId }'>
                <h2>제목</h2>
                <input type="text" name="bTitle" placeholder="제목 입력">
                <h2>카테고리</h2>
               	<input type="text" name="bGroupKind" value='${boardDto.bGroupKind }' readonly="readonly">
                <h2>내용</h2>
                <textarea name="bContent" rows="8" placeholder="내용을 입력하세요."></textarea>
                <h2>작성자</h2>
                <input type="text" name="bName" placeholder="작성자">
                <input type="hidden" name='bGroup' value="${boardDto.bGroup}">
				<input type="hidden" name='bStep' value="${boardDto.bStep}">
				<input type="hidden" name='bIndent' value="${boardDto.bIndent}">
                <input type="submit" value="글쓰기">
            </form>
        </div>
    </div>
</body>
</html>
