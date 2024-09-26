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

    // 1. 이미지 썸네일 클릭 시 모달로 이미지 확대 (이진 데이터를 서버에서 가져옴)
    $('#image_list').on('click', 'img', function() {
        console.log("Clicked image:", this); // 클릭한 이미지 요소 확인
        const imageId = $(this).data('image-src'); // 이미지 ID 가져오기
        console.log("imageSrc:", imageId); // 여기서 확인

        // 서버에 이미지 ID를 통해 이진 데이터를 요청
        $.ajax({
            url: '/ex/getImageData',  // 이진 데이터를 가져오는 서버 경로
            type: 'GET',
            data: {
                imageId: imageId // 이미지 ID를 서버로 보냄
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    const base64ImageData = response.base64ImageData; // 서버로부터 받은 Base64 인코딩된 이미지 데이터
                    const imageSrc = `data:image/jpeg;base64,${base64ImageData}`; // Base64 데이터로 이미지 URL 생성

                    modalImage.attr('src', imageSrc); // 모달에 이미지를 설정
                    modal.show();

                    deleteButton.data('image-id', imageId); // 삭제 버튼에 이미지 ID를 저장
                } else {
                    alert('이미지를 가져오는 데 실패했습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('서버 오류가 발생했습니다.');
            }
        });
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
        let imageSrc = $(this).data('image-id'); // 삭제할 이미지 ID 가져오기
        console.log(imageSrc);
        // 서버로 이미지 삭제 요청
        $.ajax({
            url: '/ex/deleteImage',
            type: 'GET',
            data: {
                imagePath: imageSrc // 이미지 경로를 서버로 전송
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 삭제된 이미지 및 관련 요소를 모두 제거
                    $('#image_list .image-item').filter(function() {
                        return $(this).find('img').data('image-src') === imageSrc; // 경로로 필터링
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

    // 3. 이미지 업로드 (기존 코드와 동일)
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
        const imageId = $(this).data('image-src'); // 데이터 속성에서 이미지 ID 가져오기

        $.ajax({
            url: '/ex/setMainImage',
            type: 'POST',
            data: {
                imagePath: imageId // 이미지 ID를 서버로 전송
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 다른 이미지에서 'main-image' 클래스를 제거하고 선택한 이미지에 추가
                    $('#image_list img').removeClass('main-image');
                    $(`#image_list img[data-image-src='${imageId}']`).addClass('main-image');
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

