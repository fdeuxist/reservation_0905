<%--<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 주석처리 후 공용 헤더 추가함 [양재하] --%>

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
	background-color: #f4f4f4; /* 배경색: 연한 회색 */
}

/* Header Styles */
.head {
	background-color: #333; /* 헤더 배경색: 검정색 */
	color: #fff; /* 텍스트 색상: 흰색 */
	padding: 10px;
	text-align: center;
}

.head-title {
	margin: 0;
	font-size: 24px; /* 제목 폰트 크기 */
}

/* Main Container Styles */
.main {
	display: flex;
	/*margin: 20px auto;  마진 삭제함 [양재하]*/
	max-width: 1200px; /* 중앙 정렬 및 최대 폭 설정 */
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

/* Content Styles */
.row1 {
	flex: 1;
	padding: 20px;
	background-color: #fff; /* 콘텐츠 배경색: 흰색 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
}

h1 {
	font-size: 28px;
	margin-bottom: 20px;
}

h2 {
	font-size: 20px;
	margin-bottom: 10px;
}

/* Form Elements */
input[type="text"], textarea, select {
	width: 100%; /* 전체 너비 사용 */
	padding: 10px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 색상 */
	border-radius: 5px; /* 모서리 둥글게 */
	background-color: #f4f4f4; /* 배경색: 연한 회색 */
	box-sizing: border-box; /* 패딩과 테두리를 포함한 전체 너비 계산 */
}

textarea {
	resize: none; /* 크기 조절 비활성화 */
}

/* Button Styles */
input[type="submit"] {
	padding: 10px 20px; /* 버튼 안쪽 여백 */
	background-color: #333; /* 버튼 배경색: 검정색 */
	color: #fff; /* 버튼 텍스트 색상: 흰색 */
	border: none; /* 테두리 제거 */
	border-radius: 5px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 포인터 커서 */
	margin-top: 10px; /* 버튼 상단 여백 */
}

input[type="submit"]:hover {
	background-color: #555; /* 호버 시 버튼 배경색: 어두운 회색 */
}
</style>
</head>
<body>
<%--
	<div class="head">
		<h1 class="head-title">My Website</h1>
	</div>--%>
	<div class="main">
		<div class="side">
			<a href="/ex/board/listAll">All Category</a>
		</div>
		<div class="row1">
			<h1>게시글 수정</h1>
			<form action="/ex/board/modify" method="post">
				<input type="hidden" name="bId" value='${boardDto.bId }'>
				<h2>글 제목<input type= "text" name="bTitle" value='${boardDto.bTitle }'></h2>
				<h2>카테고리<select name="bGroupKind">
					<option value="공지사항" ${boardDto.bGroupKind == '공지사항' ? 'selected' : ''}>공지사항</option>
                    <option value="자유게시판" ${boardDto.bGroupKind == '자유게시판' ? 'selected' : ''}>자유게시판</option>
					</select>
				</h2>
				<h2>글 내용<textarea name="bContent">${boardDto.bContent }</textarea></h2>
				<h2>작성자<input type= "text" name="bName" value='${boardDto.bName }' readonly="readOnly"></h2>
				<h2><input type= "submit" name="submit" value="수정"></h2>
			</form>
		</div>
	</div>
	<div class="footer">
	</div>
</body>
</html>