<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카카오맵 서비스</title>
<link rel="stylesheet" href="/ex/resources/css/mapServiceStyle.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="app">
		<header class="header">
			<h1>어디로든 놀러가</h1>
		</header>
		<div class="container">
			<div class="search-section">
				<div class="search-form">
					<input type="text" name="query" placeholder="업체를 검색하세요"
						class="search-input" id="searchInput" />
					<button type="button" class="search-button" id="searchButton">검색</button>
				</div>
				<ul class="search-results">
					<!-- 검색 결과가 여기에 추가됩니다 -->
					<c:forEach var="result" items="${results}">
						<li class="search-result-item"><strong>${result.business_name}</strong><br>
							${result.basic_address}<br> <!-- 버튼은 검색 후 결과가 있을 때만 표시됩니다 -->
							<img src="${result.place_image_url}"
							alt="${result.business_name}"
							style="width: 100px; height: auto; margin-top: 5px;"> <!-- 위치보기 버튼 추가 -->
							<button class="find-button"
								data-address="${result.basic_address}"
								data-name="${result.business_name}"
								data-image-url="${result.place_image_url}">위치보기</button></li>
					</c:forEach>
				</ul>
			</div>
			<div id="map" class="map"></div>
		</div>
	</div>
	<script type="text/javascript"
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c665e334713bdbedf11d514849fcb54b&libraries=services,clusterer,drawing"></script>
	<script src="../resources/js/mapUtils.js"></script>
	<script src="../resources/js/mapMain.js"></script>

</body>
</html>