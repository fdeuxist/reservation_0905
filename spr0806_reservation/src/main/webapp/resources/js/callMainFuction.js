$(document).ready(function() {
    // 검색어 제안 기능
    initializeSearchSuggestions();

    // 메뉴 토글 기능
    initializeMenuToggle();


    // 검색폼 제출 처리
    initializeSearchFormSubmit();

    // 공지사항 및 사용자 정보 로드
    loadNotices();
    loadUserInfo();
});
