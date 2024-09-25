
$(document).ready(function() {
	const images = document.querySelectorAll('.thumbnail-container img');
    const modal = $('#imageModal');
    const modalImage = $('#modalImage');
    const modalClose = $('.modal-close');
    const deleteButton = $('#deleteButton');
   

    modal.hide();
    images.forEach((img) => {
        // 데이터 속성에서 is_main 값을 확인
        const isMain = img.dataset.isMain; // 데이터 속성에서 가져온다고 가정
        if (isMain === 'Y') {
            img.classList.add('main-image'); // 주황색 테두리 추가
        }
    });
    // 1. 이미지 썸네일 클릭 시 모달로 이미지 확대
    $('#image_list').on('click', 'img', function() {
        const src = contextPath + $(this).data('image-src');
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

    // 2. 이미지 삭제 버튼 클릭 시
    deleteButton.on('click', function() {
        let srcToDelete = $(this).data('image-src');
        if (srcToDelete.startsWith(contextPath)) {
            srcToDelete = srcToDelete.replace(contextPath, '');
        }

        // 서버로 이미지 삭제 요청
        $.ajax({
            url: '/ex/deleteImage', // URL을 확인하세요.
            type: 'GET',
            data: {
                imagePath: srcToDelete
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 삭제된 이미지 및 관련 요소를 모두 제거
                    $('#image_list .image-item').filter(function() {
                        return $(this).find('img').data('image-src') === srcToDelete;
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

    // 3. 이미지 업로드
    const dropArea = $('#dropArea');
    const fileInput = $('#fileInput');

    // 파일을 드래그 앤 드롭으로 업로드하는 기능
    dropArea.on('dragover', function(e) {
        e.preventDefault();
        e.stopPropagation();
        dropArea.addClass('dragover');
    });

    dropArea.on('dragleave', function(e) {
        e.preventDefault();
        e.stopPropagation();
        dropArea.removeClass('dragover');
    });

    dropArea.on('drop', function(e) {
        e.preventDefault();
        e.stopPropagation();
        dropArea.removeClass('dragover');
        
        const files = e.originalEvent.dataTransfer.files;
        handleFiles(files);
    });

    // 파일 선택 버튼 클릭 시 파일 선택 기능
    $('#uploadButton').on('click', function() {
        fileInput.click();
    });

    fileInput.on('change', function() {
        const files = fileInput[0].files;
        handleFiles(files);
    });

    // 파일 처리 함수 (서버로 전송)
    function handleFiles(files) {
        const formData = new FormData();
        for (let i = 0; i < files.length; i++) {
            formData.append('images', files[i]);
        }

        // 서버로 AJAX 요청 (이미지 업로드 처리)
        $.ajax({
            url: '/ex/uploadImages', // 이미지 업로드 서버 경로
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('이미지 업로드 성공!');
                // 업로드 후 이미지 목록 갱신 등 필요한 후속 작업
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('이미지 업로드 실패!');
            }
        });
    }

    // 4. 메인 이미지로 설정
    $('#image_list').on('click', '.set-main-btn', function() {
        const srcToSetMain = $(this).data('image-src');

        $.ajax({
            url: '/ex/setMainImage',
            type: 'POST',
            data: {
                imagePath: srcToSetMain
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 다른 이미지에서 'main-image' 클래스를 제거하고 선택한 이미지에 추가
                    $('#image_list img').removeClass('main-image');
                    $(`#image_list img[data-image-src='${srcToSetMain}']`).addClass('main-image');
                } else {
                    alert('메인 이미지 설정에 실패했습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('서버 오류가 발생했습니다.');
            }
        });
    });
});
