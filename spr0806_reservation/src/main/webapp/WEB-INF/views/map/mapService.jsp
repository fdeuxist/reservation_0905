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
    // 이벤트 위임: 부모 요소에 이벤트 리스너를 등록
    const searchResultContainer = document.querySelector('.search-results');

    searchResultContainer.addEventListener('click', function(event) {
        const item = event.target.closest('.search-result-item');
        
        if (item) {
            // li 요소의 data-* 속성에서 데이터를 가져옴
           const business_num = item.getAttribute('data-business-num');
            const businessName = item.getAttribute('data-name');
            const businessAddress = item.getAttribute('data-address');
            const imageUrl = item.getAttribute('data-image-url');
            const email = item.getAttribute('data-email');
            console.log("Email2:",email);
            console.log("Business Number2:", business_num);
            // 예시: URL에 데이터 포함하여 페이지 이동 (GET 파라미터 사용)
            const url = "/ex/member/businessplaceinfo?business_regi_num=" + escape(business_num) + "&email=" + escape(email);

            // 해당 URL로 페이지 이동
            window.location.href = url;
        }
    });
});


</script>
</html>