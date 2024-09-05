<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인(비로그인) 페이지</title>
<link rel="stylesheet" href="/ex/resources/css/main2Style.css">
</head>
<body>
	<header>
		<div class="header-left">
			<a href="#" class="logo">A</a>
		</div>
		<div class="header-center">
			<form class="search-form">
				<input type="text" placeholder="검색어를 입력하세요...">
				<button type="submit">검색</button>
			</form>
			<div class="icon-buttons">
				<div class="icon">아이콘 1</div>
				<div class="icon">아이콘 2</div>
				<div class="icon">아이콘 3</div>
				<div class="icon">아이콘 4</div>
				<div class="icon">아이콘 5</div>
				<!-- 추가 아이콘을 여기서 추가하세요 -->
			</div>
		</div>
		<div class="header-right">
			<div id="login-buttons" style="display: flex;">
				<a href="ex/main/login" class="login-button">로그인</a> <a href="ex/main/join"
					class="login-button">회원가입</a>
			</div>
			<button id="dropdown-button" class="menu-button"
				onclick="toggleMenu()" style="display: none;">☰</button>
			<div id="dropdown-menu" class="dropdown-menu">
				<a href="/ex/my/myPage">마이 페이지</a> <a href="/ex/my/myCart">장바구니</a>
				<a href="/ex/my/myCoupon">쿠폰함</a>
			</div>
		</div>
		<input type="hidden" id="login-status" value="false" />
		<!-- 로그인이 되어 있는지 여부를 설정 -->
	</header>
	<div class="content-container">
		<nav>
			<div class="slider-container">
				<div class="slider-wrapper">
					<div class="slider-item">
						<img src="image1.jpg" alt="슬라이드 이미지 1">
					</div>
					<div class="slider-item">
						<img src="image2.jpg" alt="슬라이드 이미지 2">
					</div>
					<div class="slider-item">
						<img src="image3.jpg" alt="슬라이드 이미지 3">
					</div>
					<!-- 추가 이미지가 있다면 여기에 삽입 -->
				</div>
			</div>
		</nav>
		<section>
			<h2>공지사항</h2>
			<div class="notice">
				<a href="#">공지사항 제목 1</a>
			</div>
			<div class="notice">
				<a href="#">공지사항 제목 2</a>
			</div>
			<div class="notice">
				<a href="#">공지사항 제목 3</a>
			</div>
			<!-- 추가 공지사항이 있다면 여기에 삽입 -->
		</section>
		<aside>
			<h3>사용자 정보</h3>
			<div class="user-info">
				<p>이름: 사용자 이름</p>
				<p>이메일: user@example.com</p>
				<p>가입일: YYYY-MM-DD</p>
				<!-- 추가 사용자 정보가 있다면 여기에 삽입 -->
			</div>
		</aside>
	</div>
</body>
</html>
