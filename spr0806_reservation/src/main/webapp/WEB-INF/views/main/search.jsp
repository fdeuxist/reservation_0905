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
<title>검색 결과 페이지</title>
</head>
<body>
	<!-- Header -->

	<!-- Main Content -->
	<div class="content">

		<div class="filters">
			<h3>필터 섹션</h3>
			<!-- 키워드 버튼들 -->
			<div>
				<input type="checkbox" id="filter1"> <label for="filter1">편의점
				</label>
			</div>
			<div>
				<input type="checkbox" id="filter2"> <label for="filter2">병원</label>
			</div>
			<div>
				<input type="checkbox" id="filter3"> <label for="filter3">호텔</label>
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
	                        var resultHtml =
	                            '<a href="/ex/member/businessplaceinfo?email=' + encodeURIComponent(item.email) +
	                            '&business_regi_num=' + encodeURIComponent(item.business_regi_num) +
	                            '" class="result-item">' +
	                            '<div class="info">' +
	                            '<h4>' + item.business_name + '</h4>' +
	                            '<p><i class="fas fa-map-marker-alt"></i> ' + item.basic_address + '</p>' + // 주소 추가
	                            '<p><i class="fas fa-phone"></i> ' + item.email + '</p>' + // 전화번호 추가
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
	});
	</script>
</body>
</html>
