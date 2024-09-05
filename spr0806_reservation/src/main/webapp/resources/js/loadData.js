function loadNotices() {
    $.ajax({
        url: "/ex/notices", // 공지사항 데이터를 가져올 URL로 변경해야 함
        method: "GET",
        success: function(response) {
            $("section").html(response);
        },
        error: function() {
            alert("공지사항 로드에 실패했습니다.");
        }
    });
}

function loadUserInfo() {
    $.ajax({
        url: "/ex/userInfo", // 사용자 정보를 가져올 URL로 변경해야 함
        method: "GET",
        success: function(response) {
            $("aside").html(response);
        },
        error: function() {
            alert("사용자 정보 로드에 실패했습니다.");
        }
    });
}