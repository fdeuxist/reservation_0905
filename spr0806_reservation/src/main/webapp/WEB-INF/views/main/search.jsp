<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/ex/resources/css/mainSearch.css">
<title>검색 결과 페이지</title>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<div class="logo">사이트 로고</div>
		<div class="search-container">
			<input type="text" name="query" placeholder="검색어를 입력하세요">
		</div>
		<div class="login-signup">
			<a href="/login">로그인</a> | <a href="/signup">회원가입</a>
		</div>
	</div>

	<!-- Main Content -->
	<div class="content">
		<!-- Filters -->
		<div class="filters">
			<h3>필터 섹션</h3>
			<!-- 키워드 버튼들 -->
			<div>
				<input type="checkbox" id="filter1"> <label for="filter1">필터
					1</label>
			</div>
			<div>
				<input type="checkbox" id="filter2"> <label for="filter2">필터
					2</label>
			</div>
			<div>
				<input type="radio" name="radio-filter" id="radio1"> <label
					for="radio1">라디오 1</label>
			</div>
			<div>
				<input type="radio" name="radio-filter" id="radio2"> <label
					for="radio2">라디오 2</label>
			</div>
			<div class="keyword-buttons">
				<button type="button" data-query="GS">#GS</button>
				<button type="button" data-query="의원">#동내의원</button>
				<button type="button" data-query="GS">#1+1</button>
				<button type="button" data-query="CU">#see u 캠페인</button>
				<button type="button" data-query="이마트">#장보기</button>
				<button type="button" data-query="이마트">#ㅇㅇ</button>
				<!-- 추가 버튼들... -->
			</div>
			<div class="container">
				<div class="slider-wrapper">
					<div class="min-value" id="minValue">0원</div>
					<input type="range" id="priceSlider" min="0" max="50000"
						value="20000" step="1000">
					<div class="max-value" id="maxValue">50,000원</div>
				</div>
				<div class="value-display">
					<span>가격 설정하기:</span> <span id="currentValue">20,000원</span>
				</div>
			</div>
		</div>

		<!-- Results -->
		<div class="results">
			<c:forEach var="item" items="${results}">
				<a
					href="/ex/member/businessplaceinfo?email=${item.email}&business_regi_num=${item.business_regi_num}"
					class="result-item"> <img src="../resources/imgs/image1.jpg"
					alt="${item.business_name}">
					<div class="info">
						<h4>${item.business_name}</h4>
						<p>${item.basic_address}</p>
					</div>
				</a>
			</c:forEach>
		</div>
	</div>

	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../resources/js/mainSearch.js"></script>
</body>
</html>
