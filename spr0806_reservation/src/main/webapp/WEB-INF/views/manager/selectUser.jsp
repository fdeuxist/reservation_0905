<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유저 관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* 사이드바 스타일 */
/* 사이드바 스타일 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    display: flex; /* Flexbox 사용으로 가로 배치 */
    width: 100%;
}

nav.sidebar {
    width: 250px; /* 사이드바 너비 */
    background-color: #f4f4f4;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

nav.sidebar h2 {
    font-size: 22px;
    margin-bottom: 30px;
}

nav.sidebar ul {
    list-style-type: none;
    padding: 0;
}

nav.sidebar ul li {
    margin-bottom: 20px;
}

nav.sidebar ul li a {
    text-decoration: none;
    color: #007bff;
    font-size: 18px;
    display: block;
    padding: 10px 0;
}

nav.sidebar ul li a:hover {
    text-decoration: underline;
}

.content {
    flex-grow: 1; /* 남은 공간을 채우기 */
    padding: 30px; /* 콘텐츠의 패딩을 늘려 크기 증가 */
    background-color: #fff;
}

/* 동적 콘텐츠 스타일 */
#dynamicContent {
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

/* 유저 정보 수정 및 탈퇴 폼 스타일 */
#editProfileContent, #deleteUserContent, #userPostsContent {
    padding: 30px; /* 폼의 패딩을 늘려 크기 증가 */
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #f9f9f9;
    margin-top: 20px;
    max-width: 500px; /* 폼 최대 너비 증가 */
    margin: auto; /* 폼을 중앙 정렬 */
}

#editProfileForm, #deleteUserForm {
    display: flex;
    flex-direction: column;
    gap: 15px; /* 요소 간 간격 */
}

#editProfileForm .form-group, #deleteUserForm .form-group {
    display: flex;
    flex-direction: column;
}

#editProfileForm label, #deleteUserForm label {
    font-weight: bold;
    margin-bottom: 5px;
}

#editProfileForm input, #deleteUserForm input {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

/* 버튼 스타일 */
#editProfileForm button, #deleteUserForm button, #cancelDelete {
    background-color: #007bff;
    color: white;
    padding: 6px 10px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    width: 120px; /* 버튼 너비 유지 */
}

#editProfileForm button:hover, #deleteUserForm button:hover, #cancelDelete:hover {
    background-color: #0056b3;
}

/* 유저 탈퇴 버튼 스타일 */
#deleteUserForm button[type="submit"] {
    background-color: #dc3545;
    padding: 6px 10px;
    width: 120px; /* 유저 탈퇴 버튼의 너비 유지 */
}

#deleteUserForm button[type="submit"]:hover {
    background-color: #c82333;
}

/* 취소 버튼 스타일 */
#cancelDelete {
    background-color: #6c757d;
    width: 100px; /* 취소 버튼의 너비 유지 */
    padding: 6px 10px;
    margin-top: 10px; /* 삭제 버튼과의 간격 추가 */
}

#cancelDelete:hover {
    background-color: #5a6268;
}

/* 유저의 글 목록 테이블 스타일 */
#userPostsContent table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

#userPostsContent th, #userPostsContent td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
}

#userPostsContent th {
    background-color: #007bff;
    color: white;
}

#userPostsContent tr:nth-child(even) {
    background-color: #f9f9f9;
}

#userPostsContent tr:hover {
    background-color: #f1f1f1;
}

</style>
</head>
<body>
	<div class="container">
		<nav class="sidebar">
			<h2>관리자 옵션 목록</h2>
		
			<ul>
				<li><a href="#" data-action="editProfile">유저 정보 수정</a></li>
				<li><a href="#" data-action="deleteUser">유저 계정 정지</a></li>
				<li><a href="#" data-action="userPosts">유저가 쓴 글 목록 보기</a></li>
				
			</ul>
		</nav>
		<div class="content">
			<!-- 동적으로 로드되는 콘텐츠가 이곳에 표시됩니다. -->
			<div id="dynamicContent">원하는 기능을 선택해 주세요.</div>
		</div>
	</div>

	<script>
	$(document).ready(function() {
		var userEmail = "${user.email}"; // JSP에서 변수를 JavaScript로 전달

		$('nav.sidebar a').on('click', function(e) {
			e.preventDefault(); // 링크의 기본 동작을 막습니다.
			var action = $(this).data('action'); // 클릭된 링크의 action 데이터 값을 가져옵니다.

			// AJAX 요청을 보냅니다.
			$.ajax({
				url: '/ex/getContent', // 서버의 엔드포인트
				method: 'GET',
				data: {
					action: action,
					userEmail: userEmail // JSP에서 전달받은 email 변수 사용
				},
				success: function(response) {
					$('#dynamicContent').html(response); // 서버에서 받은 응답으로 콘텐츠를 업데이트합니다.
				},
				error: function() {
					$('#dynamicContent').html('오류가 발생했습니다.'); // 오류 발생 시 메시지 표시
				}
			});
		});
	});
	</script>
</body>
</html>
