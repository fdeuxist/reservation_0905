$(document).ready(function() {
    // 메인 이미지 설정 버튼 클릭 시 처리
    $('#image_list').on('click', '.set-main-btn', function() {
        const imageSrc = $(this).data('image-src');

        // AJAX 요청으로 서버에 메인 이미지 설정
        $.ajax({
            url: '/ex/setMainImage', // 메인 이미지 설정 서버 경로
            type: 'POST',
            data: {
                imagePath: imageSrc
            },
            success: function(response) {
                if (response.success) {
                    alert('메인 이미지가 설정되었습니다.');
                    // 메인 이미지에 스타일 적용
                    $('#image_list img').removeClass('main-image');
                    $(`#image_list img[data-image-src="${imageSrc}"]`).addClass('main-image');
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
