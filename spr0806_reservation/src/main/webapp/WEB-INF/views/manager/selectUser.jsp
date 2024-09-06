<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유저 관리</title>
<link rel="stylesheet" href="styles.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
}

.container {
	display: flex;
	width: 100%;
}

nav.sidebar {
	width: 200px;
	background-color: #f4f4f4;
	padding: 15px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

nav.sidebar h2 {
	font-size: 18px;
	margin-bottom: 20px;
}

nav.sidebar ul {
	list-style-type: none;
	padding: 0;
}

nav.sidebar ul li {
	margin-bottom: 10px;
}

nav.sidebar ul li a {
	text-decoration: none;
	color: #007bff;
	display: block;
}

nav.sidebar ul li a:hover {
	text-decoration: underline;
}

.content {
	flex-grow: 1;
	padding: 20px;
	background-color: #fff;
}

#dynamicContent {
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
}
</style>
</head>
<body>
	<div class="container">
		<nav class="sidebar">
			<h2>관리자 옵션 목록</h2>
		
			<ul>
				<li><a href="#" data-action="editProfile">유저 정보 수정</a></li>
				<li><a href="#" data-action="deleteUser">유저 탈퇴</a></li>
				<li><a href="#" data-action="userPosts">유저가 쓴 글 목록 보기</a></li>
				<li><a href="#" data-action="userInquiries">문의 사항</a></li>
			</ul>
		</nav>
		<div class="content">
			<!-- 동적으로 로드되는 콘텐츠가 이곳에 표시됩니다. -->
			<div id="dynamicContent">내용을 선택해 주세요.</div>
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
