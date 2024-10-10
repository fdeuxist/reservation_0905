<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>모두의 예약</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
.search-suggestions {
    position: absolute; /* 부모 요소에 상대적으로 위치 */
    background-color: rgba(255, 255, 255, 0.95); /* 약간 투명한 흰색 */
    border: 1px solid #ccc;
    border-top: none; /* 위쪽 경계선 없애기 */
    border-radius: 0 0 5px 5px; /* 아래쪽 모서리만 둥글게 */
    max-height: 150px; /* 최대 높이 조정 */
    overflow-y: auto; /* 스크롤 가능 */
    z-index: 1000; /* 다른 요소 위에 표시 */
    width: 100%; /* 검색창 너비와 동일하게 설정 */
    left: 0; /* 부모 요소 기준 왼쪽 맞춤 */
    top: calc(100% + 2px); /* 검색창 바로 아래에 위치하도록 조정 */
    display: none; /* 기본적으로 숨김 */
}

.search-suggestions ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.search-suggestions li {
    padding: 8px; /* padding 조정 */
    cursor: pointer;
    color: #000000; /* 폰트 색깔을 검은색으로 설정 */
}

.search-suggestions li:hover {
    background-color: #e0e0e0; /* 마우스 오버 시 배경색 변경 */
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/main">모두의 예약</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navb">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between text-light" id="navb">
            <form class="form-inline my-2 my-lg-0 mx-auto position-relative" id="searchForm">
                <select name="searchBy" id="searchBy" class="form-control">
                    <option value="business_name">업체명</option>
                    <option value="business_type">업종</option>
                    <option value="basic_address">주소</option>
                </select>
                <input class="form-control mr-sm-2" type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력하세요">
                
                <!-- 검색 제안 요소를 검색폼 안에 배치 -->
                <div class="search-suggestions" id="suggestions"></div>

                <button class="btn btn-info my-2 my-sm-0" type="button" id="searchBtn">검색</button>
            </form>
            
            
            
            <c:choose>
			    <c:when test="${sessionScope.loginName == null}">
			        <div class="text-right">
			            <a href="/ex/user/login" class="text-decoration-none text-reset"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
			            <br>
			            <a href="/ex/user/insert" class="text-decoration-none text-reset"><i class="fa-solid fa-users"></i>회원가입</a>
			        </div>
			    </c:when>
			</c:choose>
			        <div class="text-right">
						    <sec:authorize access="hasRole('ROLE_MEMBER')">
						        <a href="${pageContext.request.contextPath}/member/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 마이페이지</a>
						        <br><a href="/ex/user/logout" class="text-decoration-none text-reset"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
						    </sec:authorize>
						    <sec:authorize access="hasRole('ROLE_VENDOR')">
						        <a href="${pageContext.request.contextPath}/vendor/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 마이페이지</a>
						        <br><a href="/ex/user/logout" class="text-decoration-none text-reset"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
						    </sec:authorize>
						    <sec:authorize access="hasRole('ROLE_MANAGER')">
						        <a href="${pageContext.request.contextPath}/manager/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 매니저 페이지</a>
						        <br><a href="/ex/user/logout" class="text-decoration-none text-reset"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
						    </sec:authorize>
						    <sec:authorize access="hasRole('ROLE_ADMIN')">
						        <a href="${pageContext.request.contextPath}/admin/selectAll" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 관리자 페이지</a>
						        <br><a href="/ex/user/logout" class="text-decoration-none text-reset"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
						    </sec:authorize>
			        </div>
            
            
            
            
            
            
            
            
            
        </div>
    </nav>

	<script>
	$(document).ready(function() {
	    function submitForm(){
	        var searchBy = $("#searchBy").val();
	        var searchKeyword = $("#searchKeyword").val();
	        console.log("searchBy : " + searchBy + " \nsearchKeyword : " + searchKeyword);
	        $("#searchForm").attr("action", "/ex/member/searchp");
	        $("#searchForm").submit();
	    }
	    
	    $("#searchBtn").click(function() {
	        submitForm();
	    });

	    $("#searchKeyword").keypress(function(event) {
	        if (event.which === 13) {
	            event.preventDefault();
	            submitForm();
	        }
	    });

	    function initializeSearchSuggestions() {
	        const $searchInput = $('#searchKeyword'); // 검색 입력 필드
	        const $suggestions = $('#suggestions'); // 자동완성 리스트

	        $searchInput.on('input', function() {
	            const query = $searchInput.val(); // 입력된 쿼리
	            if (query.length > 0) {
	                $.ajax({
	                    url: '/ex/searchSuggestions',
	                    method: 'GET',
	                    data: { query: query },
	                    success: function(response) {
	                        console.log('Response:', response); // 응답 데이터 확인
	                        if (Array.isArray(response) && response.length > 0) {
	                            $suggestions.empty(); // 이전 항목 제거

	                            const $ul = $('<ul></ul>'); // ul 요소 생성
	                            response.forEach(item => {
	                                const $li = $('<li></li>').text(item); // li 요소 생성 및 텍스트 설정
	                                $ul.append($li); // ul에 li 추가
	                            });

	                            $suggestions.html($ul).show(); // ul을 suggestions에 추가 후 보여줌
	                        } else {
	                            $suggestions.hide(); // 응답이 비어있거나 배열이 아닐 경우 숨김
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
	            $searchInput.val($(this).text()); // 선택한 값을 입력 필드에 설정
	            $suggestions.hide(); // 선택 후 리스트 숨김
	        });

	        // 검색폼 외부 클릭 시 리스트 숨김
	        $(document).click(function(event) {
	            if (!$(event.target).closest('#searchForm').length) {
	                $suggestions.hide();
	            }
	        });
	    }

        // 자동완성 초기화 호출
        initializeSearchSuggestions();
    });
	</script>
	<input type="hidden" id="loginEmail" value="${sessionScope.loginEmail}">
	<input type="hidden" id="loginName" value="${sessionScope.loginName}">
	<input type="hidden" id="loginPhone" value="${sessionScope.loginPhone}">
<%--<c:choose>
    <c:when test="${sessionScope.loginAuthority == '사업자회원'}">
        <input type="hidden" id="loginBusiness_regi_num" value="${sessionScope.loginBusiness_regi_num}">
    </c:when>
</c:choose>--%>
    <sec:authorize access="hasRole('ROLE_VENDOR')">
        <input type="hidden" id="loginBusiness_regi_num" value="${sessionScope.loginBusiness_regi_num}">
    </sec:authorize>
	</div>
	</header>
	<!-- <img src="../resources/imgs/fwr.jpg"></img> -->
	<!-- 
loginName: <div id="loginName">${sessionScope.loginName}</div><br><br><br>
loginEmail: <div id="loginEmail">${sessionScope.loginEmail }</div>
<br><br>
authority: ${sessionScope.loginAuthority }
<br><br>
<br><br> -->
	<!-- 
<c:forEach var="authority" items="${authorities}">
    <li>${authority.authority}</li>
</c:forEach>
 -->
	<%--
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
 --%>
