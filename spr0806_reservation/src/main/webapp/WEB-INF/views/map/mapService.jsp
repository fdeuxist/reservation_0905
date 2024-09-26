<%--
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카카오맵 서비스</title>
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<link rel="stylesheet" href="/ex/resources/css/mapServiceStyle.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="app">
		<%--	헤더삭제 [양재하]
		<header class="header">
			<h1>어디로든 놀러가</h1>
		</header> --%>
		<div class="container">
			<div class="search-section">
				<div class="search-form">
					<input type="text" name="query" placeholder="업체를 검색하세요"
						class="search-input" id="searchInput" />
					<button type="button" class="search-button" id="searchButton">검색</button>
				</div>
				<ul class="search-results">
    <c:forEach var="result" items="${results}">
       
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
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 검색 결과 컨테이너를 선택
    const searchResultContainer = document.querySelector('.search-results');

    // 리스트 항목 클릭 이벤트
    searchResultContainer.addEventListener('click', function(event) {
        const item = event.target.closest('.search-result-item');

        // 리스트 항목 클릭 시의 동작
        if (item && !event.target.closest('.btn')) { // 버튼 클릭이 아닐 때만 동작
            const business_num = item.getAttribute('data-business-num');
            const email = item.getAttribute('data-email');

            // URL에 데이터 포함하여 페이지 이동
            const url = "/ex/member/businessplaceinfo?business_regi_num=" + escape(business_num) + "&email=" + escape(email);
            // 해당 URL로 페이지 이동
            window.location.href = url;
        }
    });

   
    });

    
</script>





</html>