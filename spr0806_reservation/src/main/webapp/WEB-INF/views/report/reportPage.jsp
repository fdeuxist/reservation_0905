<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객센터</title>
<link rel="stylesheet" href="../resources/css/styles.css">
<style>
/* General Styles */
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #f4f9fd; /* 연한 파란색 배경 */
	color: #333; /* 기본 글씨 색상 */
}

/* Header Styles */
.header {
	background-color: #2a4d69; /* 파란색 헤더 */
	color: #fff;
	padding: 20px 0;
	position: fixed;
	width: 100%;
	top: 0;
	left: 0;
	z-index: 1000;
	text-align: center;
}

.header-content {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 20px;
}

.logo {
	font-size: 26px;
	font-weight: bold;
}

.nav-menu a {
	color: #fff;
	text-decoration: none;
	margin: 0 15px;
	font-size: 16px;
}

.nav-menu a:hover {
	text-decoration: underline;
}

/* Main Container Styles */
.main-container {
	display: flex;
	margin-top: 80px; /* 헤더와의 간격을 위해 여백 추가 */
}

/* Sidebar Styles */
.sidebar {
	width: 250px;
	background-color: #2a4d69; /* 사이드바도 파란색으로 */
	color: #fff;
	padding: 15px;
}

.sidebar a {
	color: #fff;
	text-decoration: none;
	display: block;
	margin: 10px 0;
	padding: 10px;
	border-radius: 5px;
	background-color: #3e6791;
}

.sidebar a:hover {
	background-color: #1c3a57;
}

/* Content Styles */
.content {
	flex: 1;
	padding: 30px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.content h1 {
	color: #2a4d69;
	margin-bottom: 20px;
}

.row {
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: left;
	font-size: 14px;
}

th {
	background-color: #e7eef2;
	color: #333;
	font-weight: bold;
}

td a {
	color: #2a4d69;
	text-decoration: none;
}

td a:hover {
	text-decoration: underline;
}

button {
	padding: 12px 20px;
	background-color: #2a4d69;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

button:hover {
	background-color: #1c3a57;
}

.btn-container {
	text-align: right;
	margin-top: 20px;
}

/* Footer Styles */
footer {
	background-color: #2a4d69;
	color: #fff;
	text-align: center;
	padding: 15px 0;
	position: fixed;
	width: 100%;
	bottom: 0;
	left: 0;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	var result = '${msg}';
	if (result == 'success') {
		alert("요청이 정상적으로 처리되었습니다.");
	}
	$(document).ready(function(){
		$(".btn").on("click", function(){
			location.href="/ex/board/register"
		});
		$('#searchBtn').on("click",function(event){
			  alert("검색 중: " + $('#keywordInput').val());
			  window.location.href= "listAll"+'${boardVo.makePage(1)}'
			  +'&searchType='+$("select option:selected").val()
			  +"&keyword="+$('#keywordInput').val();
	  });
	  $('.writeBtn').on("click",function(event){
		  location.href="/ex/board/register";
	  });
	});
		  
</script>
</head>
<body>
	<header class="header">
		<div class="header-content">
			<div class="logo">고객센터</div>
			<nav class="nav-menu">
				<a href="/ex/board/listAll">게시판</a>
				<!-- 필요한 경우 여기에 추가 메뉴를 넣을 수 있습니다 -->
			</nav>
		</div>
	</header>

	<div class="main-container"> 
		<div class="sidebar">
			<a href="/ex/board/listAll">게시판</a>
			<!-- 사이드바에서 추가로 필요한 메뉴가 있으면 여기에 추가합니다 -->
		</div>

		<div class="content">
			<h1>고객 문의 목록</h1>
			<div class="row">
				<table>
					<div>
						<select name="searchType">
							<option value="제목">제목</option>
+							<option value="작성자">작성자</option>
						</select>
						<input type="text" name="keyword" id="keywordInput" value="${boardVo.keyword}">
						<button id="searchBtn">검색하기</button>
					</div>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성 시간</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${list}" var="boardDto">
						<tr>
							<td>${boardDto.bId}</td>
							<td><a href="/ex/board/read?bId=${boardDto.bId}">${boardDto.bTitle }</a></td>
							<td>${boardDto.bName}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardDto.bWriteTime }"/></td>
							<td>${boardDto.bHit}</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div class="btn-container">
				<button id="btn-create" onclick="location.href='/ex/board/register'">글쓰기</button>
			</div>
		</div>
	</div>

	<%@include file="../include/footer.jsp"%>
</body>
</html>

