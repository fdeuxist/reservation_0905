<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

.form-group input[type="text"], .form-group textarea, .form-group input[type="file"]
	{
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 16px;
	box-sizing: border-box;
}

.form-group input[type="submit"] {
	background-color: #ff9800; /* 주황색 버튼 */
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
	width: 100%;
	box-sizing: border-box;
	margin-top: 10px;
}

.form-group input[type="submit"]:hover {
	background-color: #e68900; /* 버튼 호버 색상 */
}

.info-box {
	background-color: #fff;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
	text-align: center;
}

.info-box h3 {
	color: #ff9800; /* 주황색 제목 */
	margin-bottom: 10px;
}

.info-box p {
	color: #555;
	font-size: 16px;
	margin: 5px 0;
}

.image_container, .thumbnail-container {
	border: 2px solid #ddd; /* 테두리 색상 */
	padding: 5px; /* 테두리와 이미지 사이 여백 */
	border-radius: 4px; /* 테두리 모서리 둥글게 */
	background-color: #fff; /* 배경색 */
	text-align: center; /* 이미지가 중앙에 위치하도록 */
}

.thumbnail-container {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.thumbnail-container img {
	max-width: 100px;
	max-height: 100px;
	object-fit: cover;
	border-radius: 4px;
	border: 1px solid #ddd; /* 썸네일 테두리 색상 */
	background-color: #f0f0f0; /* 기본 배경색 */
	cursor: pointer; /* 클릭 가능 표시 */
}

.default-image {
	width: 100px;
	height: 100px;
	background-color: #f0f0f0; /* 배경색 */
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 4px;
	border: 1px solid #ddd;
}

.default-image img {
	max-width: 80%;
	max-height: 80%;
}
</style>

<main>
<h2>샵 정보 등록/수정</h2>
<form:form method="post"
	action="${pageContext.request.contextPath}/vendor/shopinfo"
	modelAttribute="businessPlaceInfo" enctype="multipart/form-data">
	<div class="form-group">
		<label for="email">이메일:</label>
		<form:input path="email" id="email" readonly="true" />
	</div>
	<div class="form-group">
		<label for="business_regi_num">사업자 등록 번호:</label>
		<form:input path="business_regi_num" id="business_regi_num"
			readonly="true" />
	</div>
	<div class="form-group">
		<label for="place_info">자기 사업장 설명 소개:</label>
		<form:textarea path="place_info" id="place_info" rows="5" cols="40"></form:textarea>
	</div>
	<div class="form-group">
		<label for="main_image">대표 이미지(등록시 대표이미지 업데이트) *클릭시 제외됩니다.</label>
		<div id="main_image_container" class="image_container">
			<div id="main_image_preview_container" class="default-image">
				<img id="main_image_preview"
					src="${pageContext.request.contextPath}/${mainImg.place_img_path != null ? mainImg.place_img_path : 'resources/imgs/noimage.jpg'}"
					alt="대표 이미지 미리보기" />
			</div>

		</div>
		<input type="file" id="main_image" name="mainImage" accept="image/*" />
	</div>
	<div class="form-group">
		<label for="multi_files">이미지 리스트에 저장하기 *클릭시 제외됩니다.</label>
		<div id="multi_files_container" class="thumbnail-container"></div>
		<input type="file" id="multi_files" name="multiFile" multiple
			accept="image/*" />
	</div>
	<input type="hidden" id="deleted_images" name="deletedImages" value="" />
	<!-- 숨겨진 필드 추가 -->
	<div class="form-group">
		<input type="submit" value="저장" />
	</div>
</form:form> <!-- 정보 박스 --> <!-- <div class="info-box"> --> <!-- 	<h3>사용자 정보</h3> -->
<%-- 	<p>${sessionScope.loginName}</p> --%> <%-- 	<p>${sessionScope.loginEmail}</p> --%>
<%-- 	<p>${sessionScope.loginAuthority}</p> --%> <!-- </div> --> </main>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    const defaultImageURL = '${pageContext.request.contextPath}/resources/imgs/noimage.jpg'; // 기본 이미지 URL
    const mainImageInput = document.getElementById('main_image');
    const mainImagePreview = document.getElementById('main_image_preview');
    const multiFilesInput = document.getElementById('multi_files');
    const multiFilesContainer = document.getElementById('multi_files_container');
    const deletedImagesInput = document.getElementById('deleted_images');
    
    let deletedImages = [];

    // 초기 이미지 설정 (기존 대표 이미지가 있는 경우)
    const existingImageSrc = mainImagePreview.src;
    if (existingImageSrc === defaultImageURL) {
        mainImagePreview.src = defaultImageURL; // 기본 이미지로 설정
    }

    // 대표 이미지 미리보기 및 클릭 시 삭제 기능
    mainImageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                mainImagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // 메인 이미지 클릭 시 삭제
    mainImagePreview.addEventListener('click', function() {
        if (confirm('대표 이미지를 삭제하시겠습니까?')) {
            mainImagePreview.src = defaultImageURL; // 기본 이미지로 변경
            mainImageInput.value = ''; // 파일 입력 필드 초기화
        }
    });

    // 부수 이미지 미리보기 및 클릭 시 삭제 기능
    multiFilesInput.addEventListener('change', function(event) {
        const files = event.target.files;
        multiFilesContainer.innerHTML = ''; // 기존 썸네일 제거

        if (files.length === 0) {
            const defaultImg = document.createElement('img');
            defaultImg.src = defaultImageURL;
            multiFilesContainer.appendChild(defaultImg);
            return;
        }

        Array.from(files).forEach(file => {
            const reader = new FileReader();
            const img = document.createElement('img');
            
            reader.onload = function(e) {
                img.src = e.target.result;
            };
            reader.readAsDataURL(file);
            
            multiFilesContainer.appendChild(img);
        });
    });

    // 썸네일 클릭 시 삭제 요청 처리 및 UI 업데이트
    multiFilesContainer.addEventListener('click', function(event) {
        if (event.target.tagName === 'IMG') {
            if (confirm('이 이미지를 삭제하시겠습니까?')) {
                event.target.remove(); // UI에서 이미지 제거
                // 데이터베이스에서의 삭제 처리는 서버 측 코드에서 처리해야 함
            }
        }
    });
});

</script>


