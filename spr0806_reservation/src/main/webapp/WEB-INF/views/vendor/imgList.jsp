<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<div class="header-placeholder"></div>
<style>
/* 전체 레이아웃 스타일 */
main {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 40px; /* 아래쪽 여백 추가 */
}

h2 {
    color: #ff9800; /* 주황색 제목 */
    margin-bottom: 20px;
    font-size: 24px;
    text-align: center;
}

.thumbnail-container {
    display: grid;
    border: 2px solid #ddd; /* 전체 격자 테두리 */
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 10px;
    margin-bottom: 60px; /* 이미지 리스트와 드래그 앤 드롭 영역 간의 간격 */
}

.thumbnail-container img {
    max-width: 100%;
    max-height: 150px;
    object-fit: cover;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s;
}

.thumbnail-container img:hover {
    transform: scale(1.05); /* 마우스 오버 시 이미지 확대 */
}

.thumbnail-container .main-image {
    border: 2px solid #ff9800; /* 메인 이미지 테두리 색상 */
}

.thumbnail-container img.no-hover {
    pointer-events: none; /* 마우스 이벤트를 무시 */
    transform: none; /* 확대 효과 비활성화 */
}

.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    flex-direction: column; /* 추가 */
}

.modal img {
    max-width: 90%;
    max-height: 90%;
    margin: auto; /* 중앙 정렬을 위한 margin */
    position: relative; /* 위치 지정 */
}

.modal-delete {
    margin-top: 10px; /* 이미지와 버튼 사이 간격 */
    padding: 10px 20px;
    background-color: #ff0000; /* 빨간색 배경 */
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    position: absolute; /* 절대 위치 지정 */
    bottom: 20px; /* 아래쪽 여백 */
    right: 20px; /* 오른쪽 여백 */
}

.modal-delete:hover {
    background-color: #e60000; /* 마우스 오버 시 색상 변화 */
}

.modal-close {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 24px;
    color: white;
    cursor: pointer;
}

/* 드래그 앤 드롭 영역 스타일 */
.drop-area {
    border: 2px dashed #ddd;
    padding: 120px; /* 위아래 패딩을 늘림 */
    text-align: center;
    border-radius: 8px;
    background-color: #f9f9f9;
    cursor: pointer;
    margin-bottom: 10px; /* 드래그 앤 드롭 영역과 이미지 리스트 간의 간격 추가 */
    transition: background-color 0.3s;
    width: 60%; /* 좌우 폭을 줄임 */
    margin-left: auto; /* 중앙 정렬 */
    margin-right: auto; /* 중앙 정렬 */
}

.drop-area.dragover {
    background-color: #e0e0e0;
}

.image-item {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.set-main-btn {
    margin-top: 8px;
    padding: 5px 10px;
    background-color: #ff9800;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.set-main-btn:hover {
    background-color: #e68a00;
}
</style>

<main>
<h2>등록한 이미지 리스트</h2>
<div id="image_list" class="thumbnail-container">
	<!-- 이미지 목록이 여기에 동적으로 삽입됩니다. -->
	<c:forEach var="image" items="${imageList}">
		<div class="image-item">
			<!-- Base64로 인코딩된 이진 데이터를 이미지로 표시 -->
			<img src="data:image/jpeg;base64,${image.encodedImage}" alt="등록 이미지"
				data-image-src="${image.place_img_path}"
				class="${image.is_main == 'Y' ? 'main-image' : ''}" />
			<!-- 주황색 테두리 적용 -->
			<button class="set-main-btn" data-image-src="${image.place_img_path}">메인
				이미지로 설정</button>
		</div>
	</c:forEach>
</div>

<!-- 확인 버튼 추가 -->
<div class="text-center" style="margin-top: 30px;">
	<!-- 간격 조정 -->
	<button id="confirmButton" class="btn btn-primary">확인</button>
</div>
</main>

<!-- Modal for image preview -->
<div id="imageModal" class="modal">
	<span class="modal-close">&times;</span> <img id="modalImage" src=""
		alt="확대 이미지" />
	<button id="deleteButton" class="modal-delete">삭제</button>
</div>

<section id="uploadSection">
	<div id="dropArea" class="drop-area">
		<p>여기에 이미지를 드래그 앤 드롭하세요</p>
		<input type="file" id="fileInput" accept="image/*" multiple
			style="display: none;">
		<button id="uploadButton">이미지 선택</button>
	</div>
</section>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	const contextPath = '${pageContext.request.contextPath}';

	$(document).ready(function() {
		// 확인 버튼 클릭 이벤트
		$('#confirmButton').click(function() {
			// 이동할 페이지 URL
			const targetUrl = "/ex/vendor/mypage"; // 실제 이동할 URL로 수정
			window.location.href = targetUrl; // 페이지 이동
		});
	});
</script>
<script src="../resources/js/dragImg.js"></script>

