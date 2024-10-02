$(document).ready(function() {
	
    
    $('.keyword-buttons button').on('click', function() {
        var query = $(this).data('query'); // data-query 값을 가져옵니다
        
        $.ajax({
            url: '/ex/keyWord', // 요청할 URL
            method: 'GET',
            data: { query: query }, // 서버로 전송할 데이터
            success: function(response) {
                var resultsContainer = $('.results');
                resultsContainer.empty(); // 이전 결과 삭제
                
                if (response.length > 0) {
                    response.forEach(function(item) {
                    	var resultHtml = 
                    	    '<a href="/ex/member/businessplaceinfo?email=' + encodeURIComponent(item.email) +
                    	    '&business_regi_num=' + encodeURIComponent(item.business_regi_num) +
                    	    '" class="result-item">' +
                    	        '<img src="../resources/imgs/image1.jpg" alt="' + item.business_name + '">' +
                    	        '<div class="info">' +
                    	            '<h4>' + item.business_name + '</h4>' +
                    	            '<p>' + item.basic_address + '</p>' +
                    	        '</div>' +
                    	    '</a>';
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
    
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('.keyword-buttons button').forEach(function(button) {
            button.addEventListener('click', function() {
                var query = this.getAttribute('data-query');
                window.location.href = '/ex/search?query=' + encodeURIComponent(query);
            });
        });
    });
    
    
    // 엔터키 입력 감지
    $(document).on('keydown', function(event) {
        if (event.key === 'Enter') {
            performSearch();
        }
    });

    // 검색 수행 함수
    function performSearch() {
        // input 요소에서 값 가져오기
        var query = $(".search-container input[name='query']").val().trim();
        
        if (query) { // 쿼리 값이 비어 있지 않은 경우에만 요청
            $.ajax({
                url: '/ex/miniSearch',
                method: 'GET',
                data: { query: query },
                success: function(response) {
                    var resultsContainer = $('.results');
                    var resultHtml = '';

                    if (response.length > 0) {
                        response.forEach(function(item) {
                            resultHtml += 
                            	 '<a href="/ex/member/businessplaceinfo?email=' + encodeURIComponent(item.email) +
                         	    '&business_regi_num=' + encodeURIComponent(item.business_regi_num) +
                         	    '" class="result-item">' +
                         	        '<img src="../resources/imgs/image1.jpg" alt="' + item.business_name + '">' +
                         	        '<div class="info">' +
                         	            '<h4>' + item.business_name + '</h4>' +
                         	            '<p>' + item.basic_address + '</p>' +
                         	        '</div>' +
                         	    '</a>';
                        });
                        resultsContainer.html(resultHtml);
                    } else {
                        resultsContainer.html('<p>검색 결과가 없습니다.</p>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('검색 요청 오류:', xhr.responseText);
                    alert('검색에 실패했습니다.');
                }
            });
        } else {
            alert('검색어를 입력하세요.');
        }
    }
    
  
  
    
});
