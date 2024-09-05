function initializeSearchSuggestions() {
    const $searchInput = $('#search-input');
    const $suggestions = $('<div class="search-suggestions" id="suggestions"></div>').hide().appendTo('.search-form');

    $searchInput.on('input', function() {
        const query = $searchInput.val();
        if (query.length > 0) {
            $.ajax({
                url: '/ex/searchSuggestions',
                method: 'GET',
                data: { query: query },
                success: function(response) {
                    console.log('Response:', response); // response 데이터 확인
                    if (Array.isArray(response)) {
                        const listItems = response.map(item => `<li>${item}</li>`).join('');
                        $suggestions.html(`<ul>${listItems}</ul>`).show();
                    } else {
                        console.error('응답 데이터 형식이 예상과 다릅니다.');
                    }
                },
                error: function() {
                    console.error('검색어 제안 로드에 실패했습니다.');
                }
            });
        } else {
            $suggestions.hide(); // 입력이 없으면 리스트 숨김
        }
    });

    // 리스트 항목 클릭 시 검색어 입력 필드에 값 추가
    $suggestions.on('click', 'li', function() {
        $searchInput.val($(this).text());
        $suggestions.hide(); // 선택 후 리스트 숨김
    });

    // 검색폼 외부 클릭 시 리스트 숨김
    $(document).click(function(event) {
        if (!$(event.target).closest('.search-form').length) {
            $suggestions.hide();
        }
    });
}