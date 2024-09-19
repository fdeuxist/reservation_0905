<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@include file="../include/header.jsp"%>

<style>
/* 전체 레이아웃 스타일 */
main {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
	/* 격자 형태로 이미지 정렬 */
	gap: 10px;
}

.thumbnail-container img {
	max-width: 100%;
	max-height: 150px;
	object-fit: cover;
	background-color: #fff; /* 흰색 배경 */
	border: 1px solid #ddd; /* 기본 테두리 */
	border-radius: 4px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 이미지에 그림자 추가 */
	transition: transform 0.2s; /* 부드러운 확대 효과 */
}

.thumbnail-container img:hover {
	transform: scale(1.05); /* 마우스 오버 시 이미지 확대 */
}

.thumbnail-container .main-image {
	border: 2px solid #ff9800; /* 메인 이미지 테두리 색상 */
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
	left: 20px; /* 왼쪽 여백 */
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
</style>

<main>
<h2>등록한 이미지 리스트</h2>
<div id="image_list" class="thumbnail-container">
	<!-- 이미지 목록이 여기에 동적으로 삽입됩니다. -->
	<c:forEach var="image" items="${imageList}">
		<img src="${pageContext.request.contextPath}${image.place_img_path}"
			alt="등록 이미지"
			data-image-src="${image.place_img_path}" />
	</c:forEach>
</div>
</main>

<!-- Modal for image preview -->
<div id="imageModal" class="modal">
	<span class="modal-close">&times;</span> <img id="modalImage" src=""
		alt="확대 이미지" />
	<button id="deleteButton" class="modal-delete">삭제</button>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    const modal = $('#imageModal');
    const modalImage = $('#modalImage');
    const modalClose = $('.modal-close');
    const deleteButton = $('#deleteButton');
    
    modal.hide();

    // 썸네일 이미지 클릭 시 모달로 이미지 확대
    $('#image_list').on('click', 'img', function() {
        const src = '${pageContext.request.contextPath}' + $(this).data('image-src');
        console.log(src);
        modalImage.attr('src', src);
        modal.show();

        deleteButton.data('image-src', src);
    });

    // 모달 닫기
    modalClose.on('click', function() {
        modal.hide();
    });

    // 모달 배경 클릭 시 모달 닫기
    $(window).on('click', function(event) {
        if ($(event.target).is(modal)) {
            modal.hide();
        }
    });

    deleteButton.on('click', function() {
        let srcToDelete = $(this).data('image-src');
        if (srcToDelete.startsWith('${pageContext.request.contextPath}')) {
            srcToDelete = srcToDelete.replace('${pageContext.request.contextPath}', '');
        }
        console.log(srcToDelete);
        
        // AJAX 요청으로 서버에 이미지 삭제 요청
        $.ajax({
            url: '/ex/deleteImage',
            type: 'GET',
            data: {
                imagePath: srcToDelete
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    $('#image_list img').filter(function() {
                        return $(this).data('image-src') === srcToDelete;
                    }).remove();
                    modal.hide();
                } else {
                    alert('이미지 삭제에 실패했습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('서버 오류가 발생했습니다.');
            }
        });
    });
});

</script>