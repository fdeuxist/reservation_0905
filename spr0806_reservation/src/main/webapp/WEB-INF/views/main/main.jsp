<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<link rel="stylesheet" href="/ex/resources/css/mainStyle.css">
</head>
<body>
	<header>
		<div class="header-left">
			<a href="#" class="logo">A</a>
		</div>
		<div class="header-center">
			<form class="search-form" action ="/ex/my/search" method="GET">
				<input type="text" placeholder="검색어를 입력하세요..." id="search-input" name="query">
				<button type="submit">검색</button>
			</form>
			<div class="icon-buttons">
				<div class="icon">아이콘 1</div>
				<div class="icon">아이콘 2</div>
				<div class="icon">아이콘 3</div>
				<div class="icon">아이콘 3</div>
				<div class="icon">아이콘 3</div>
				<!-- 추가 아이콘을 여기서 추가하세요 -->
			</div>
		</div>
		<div class="header-right">
			<button class="menu-button">☰</button>
			<div id="dropdown-menu" class="dropdown-menu">
				<a href="/ex/my/myPage">마이 페이지</a> <a href="/ex/my/myCart">장바구니</a>
				<a href="/ex/my/myCoupon">쿠폰함</a> <a href="/ex/file/fileUpload">업체
					등록하러 가기</a>
			</div>
		</div>
	</header>

	<div class="content-container">
		<nav>
			<div class="slider-container">
				<div class="slider-wrapper">
					<div class="slider-item">
						<!-- <img src="/ex/resources/img/image1.jpg" alt="슬라이드 이미지 1"> -->
					</div>
					<div class="slider-item">
						<!-- <img src="/ex/resources/img/image2.jpg" alt="슬라이드 이미지 1"> -->
					</div>
					<div class="slider-item">
						<!-- <img src="/ex/resources/img/image3.jpg" alt="슬라이드 이미지 1"> -->
					</div>
					<!-- 추가 이미지가 있다면 여기에 삽입 -->
				</div>
			</div>
		</nav>
		<section>
			<h2>지도 서비스</h2>
			<button onclick="location.href='/ex/map/mapService'">지도 서비스로
				이동</button>
		</section>
		<section>
			<h2>공지사항</h2>
			<!-- 공지사항이 AJAX로 로드됩니다. -->
		</section>
		<aside>
			<h3>사용자 정보</h3>
			<!-- 사용자 정보가 AJAX로 로드됩니다. -->
		</aside>
	</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../resources/js/menuToggle.js"></script> <!-- 메뉴 토글 함수 정의 파일 -->
<script src="../resources/js/searchSubmit.js"></script>
<script src="../resources/js/searchSuggestions.js"></script>
<script src="../resources/js/loadData.js"></script>
<script src="../resources/js/callMainFuction.js"></script> <!-- 함수 호출 파일 -->
</body>
</html>
