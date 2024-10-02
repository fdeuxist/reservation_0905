<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/ex/resources/css/mainSearch.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css"
	rel="stylesheet">
<title>검색 결과 페이지</title>
</head>
<body>
	<!-- Header -->

	<!-- Main Content -->
	<div class="content">

		<div class="filters">
			<h3>필터 섹션</h3>
			<!-- 키워드 버튼들 -->
			<div class="sort-filters">
				<label for="sortOption">정렬:</label> <select id="sortOption">
					<option value="reviewCount">리뷰 많은 순</option>
					<option value="highRating">평점 높은 순</option>
					<option value="lowRating">평점 낮은 순</option>
					<option value="lowPrice">가격 낮은 순</option>
					<option value="highPrice">가격 높은 순</option>
				</select>
			</div>
			<div>
				<input type="radio" name="radio-filter" id="radio1"> <label
					for="radio1">30분 메뉴</label>
			</div>
			<div>
				<input type="radio" name="radio-filter" id="radio2"> <label
					for="radio2">1시간 메뉴</label>
			</div>
			<div class="keyword-buttons">
				<button type="button" data-query="GS">#GS</button>
				<button type="button" data-query="의원">#동내의원</button>
				<button type="button" data-query="GS">#1+1</button>
				<button type="button" data-query="CU">#see u 캠페인</button>
				<button type="button" data-query="이마트">#장보기</button>
				<button type="button" data-query="이마트">#ㅇㅇ</button>

			</div>
			<div class="container">
				<div class="slider-wrapper">
					<div id="priceSlider"></div>
					<!-- noUiSlider가 생성될 div -->
					<div id="slider"></div>
					
				</div>

				<!-- 가격 설정 완료 버튼 추가 -->
				<button id="setPriceButton">가격 설정 완료</button>
			</div>

		</div>

		<!-- Results -->
		<div class="results">
			<c:forEach var="item" items="${results}" varStatus="status">

				<a
					href="/ex/member/businessplaceinfo?email=${item.email}&business_regi_num=${item.business_regi_num}"
					class="result-item"> <c:set var="index" value="${status.index}" />
					<c:choose>
						<c:when
							test="${not empty encodedImages[index] && encodedImages[index] != 'null'}">
							<img src="data:image/jpeg;base64,${encodedImages[index]}"
								alt="${item.business_name}">

						</c:when>
						<c:otherwise>
							<img src="../resources/imgs/noimage.jpg" alt="기본 이미지">
							<!-- 기본 이미지 경로 -->
						</c:otherwise>
					</c:choose>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
	<script src="../resources/js/mainSearch.js"></script>
	<script>
	$(document).ready(function() {
	    $('#radio1').on("click", function() {
	        var time = 1; // 보내고자 하는 time 값 설정

	        $.ajax({
	            url: '/ex/radio1', // 컨트롤러 URL
	            method: 'GET',
	            data: { time: time }, // 전송할 데이터
	            success: function(response) {
	                var resultsContainer = $('.results');
	                resultsContainer.empty(); // 이전 결과 삭제

	                if (response.results.length > 0) {
	                    // 검색 결과 출력
	                    response.results.forEach(function(item, index) {
	                        var encodedImage = response.encodedImages[index];
	                        var resultHtml = '<a href="/ex/member/businessplaceinfo?email=' + 
	                            encodeURIComponent(item.email) + 
	                            '&business_regi_num=' + 
	                            encodeURIComponent(item.business_regi_num) + 
	                            '" class="result-item">' + 
	                            '<div class="info">' + 
	                            '<h4>' + item.business_name + '</h4>' + 
	                            '<p><i class="fas fa-map-marker-alt"></i> ' + item.basic_address + '</p>' + 
	                            '<p><i class="fas fa-phone"></i> ' + item.email + '</p>' + 
	                            '</div>';

	                        if (encodedImage) {
	                            resultHtml += '<img src="data:image/jpeg;base64,' + encodedImage + '" alt="' + item.business_name + '">';
	                        } else {
	                            resultHtml += '<img src="../resources/imgs/noimage.jpg" alt="기본 이미지">';
	                        }

	                        resultHtml += '</a>';
	                        resultsContainer.append(resultHtml);
	                    });
	                } else {
	                    resultsContainer.html('<p>검색 결과가 없습니다.</p>');
	                }
	            },
	            error: function() {
	                alert('검색에 실패했습니다.');
	            }
	        });
	    });

	    var slider = document.getElementById('slider');

	    // noUiSlider 초기화
	    noUiSlider.create(slider, {
	        start: [3000, 50000], // 시작 값 (최소값과 최대값)
	        connect: true, // 슬라이더 연결 여부 (true면 슬라이더 두 점 사이가 색칠됨)
	        range: {
	            'min': 3000,  // 슬라이더 최소값
	            'max': 50000 // 슬라이더 최대값
	        },
	        step: 1000, // 값이 변경되는 단위
	        tooltips: [true, true], // 각 핸들에 툴팁을 추가
	        format: {
	            to: function(value) {
	                return Math.round(value) + '원'; // 출력 형식 설정
	            },
	            from: function(value) {
	                return Number(value.replace('원', '')); // 입력 형식 변환
	            }
	        }
	    });

	  

	    // 가격 설정 완료 버튼 클릭 시 최소값, 최대값을 Ajax로 전송
	    $('#setPriceButton').on('click', function() {
	        var priceRange = slider.noUiSlider.get(); // 현재 슬라이더 값 가져오기 (배열 형태)
	        var minPrice = priceRange[0].replace('원', ''); // 최소값
	        var maxPrice = priceRange[1].replace('원', ''); // 최대값

	        // Ajax 요청
	        $.ajax({
	            url: '/ex/setPrice', // 서버의 엔드포인트
	            method: 'GET', // 또는 'POST'
	            data: {
	                minPrice: minPrice,
	                maxPrice: maxPrice
	            },
	            success: function(response) {
	                // 서버에서 받은 데이터를 처리
	                console.log('검색 결과:', response);
	                var resultsContainer = $('.results');
	                resultsContainer.empty(); // 이전 결과 삭제

	                if (response.results.length > 0) {
	                    // 검색 결과 출력
	                    response.results.forEach(function(item, index) {
	                        var encodedImage = response.encodedImages[index];
	                        var menuName = response.menuNames[index];
	                        var lowestPrice = response.lowestPrices[index];
	                        
	                        var resultHtml = '<a href="/ex/member/businessplaceinfo?email=' + 
	                            encodeURIComponent(item.email) + 
	                            '&business_regi_num=' + 
	                            encodeURIComponent(item.business_regi_num) + 
	                            '" class="result-item">' + 
	                            '<div class="info">' + 
	                            '<h4>' + item.business_name + '</h4>' + 
	                            '<p><i class="fas fa-map-marker-alt"></i> ' + item.basic_address + '</p>' + 
	                            '<p><i class="fas fa-phone"></i> ' + item.email + '</p>' + 
	                            '<p><i class="fas fa-money-bill-wave"></i> ' + menuName + ' - ' + lowestPrice.toLocaleString() + '원부터~</p>' + // 메뉴 이름과 가격 추가
	                            '</div>';
	                        
	                        if (encodedImage) {
	                            resultHtml += '<img src="data:image/jpeg;base64,' + encodedImage + '" alt="' + item.business_name + '">';
	                        } else {
	                            resultHtml += '<img src="../resources/imgs/noimage.jpg" alt="기본 이미지">';
	                        }

	                        resultHtml += '</a>';
	                        resultsContainer.append(resultHtml);
	                    });
	                } else {
	                    resultsContainer.html('<p>검색 결과가 없습니다.</p>');
	                }
	            },
	            
	            error: function() {
	                alert('가격 설정에 실패했습니다.');
	            }
	        });
	    });

	    // 정렬 옵션 변경 시 처리
	    document.getElementById('sortOption').addEventListener('change', function() {
	        const selectedOption = this.value;

	        // 선택한 필터 옵션에 따라 데이터 정렬 처리
	        switch (selectedOption) {
	            case 'reviewCount':
	                console.log('리뷰 많은 순으로 정렬');
	                break;
	            case 'highRating':
	                console.log('평점 높은 순으로 정렬');
	                break;
	            case 'lowRating':
	                console.log('평점 낮은 순으로 정렬');
	                break;
	            case 'lowPrice':
	                console.log('가격 낮은 순으로 정렬');
	                break;
	            case 'highPrice':
	                console.log('가격 높은 순으로 정렬');
	                break;
	        }
	    });
	});

	</script>
</body>
</html>
