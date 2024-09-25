<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"><%-- Font Awesome 아이콘 --%>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark" >
  <a class="navbar-brand" href="${pageContext.request.contextPath}/user/main">모두의 예약</a>
  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navb">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse justify-content-between text-light" id="navb">
  <%--
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="javascript:void(0)">Left Link 1</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="javascript:void(0)">Left Link 2</a>
      </li>
    </ul>
     --%>
    <form class="form-inline my-2 my-lg-0 mx-auto" id="searchForm">
      <select name="searchBy" id="searchBy" class="form-control">
      	  <option value="business_name">업체명</option>
          <option value="business_type">업종</option>
          <option value="basic_address">주소</option>
      </select>
      <input class="form-control mr-sm-2" type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력하세요">
      <button class="btn btn-info my-2 my-sm-0" type="button" id="searchBtn">검색</button>
    </form>
    <!--
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="javascript:void(0)">Right Link 1</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="javascript:void(0)">Right Link 2</a>
      </li>
    </ul>-->
    <!-- 로그인 상태에 따른 메뉴 표시 -->
        <%--<li> --%>
           <%--n${sessionScope.loginName},e${sessionScope.loginEmail},a${sessionScope.loginAuthority} --%> 
            <c:choose>
			    <c:when test="${sessionScope.loginName == null}">
			        <div class="text-right">
			            <a href="/ex/user/login" class="text-decoration-none text-reset"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
			            <br>
			            <a href="/ex/user/insert" class="text-decoration-none text-reset"><i class="fa-solid fa-users"></i>회원가입</a>
			        </div>
			    </c:when>
			    <c:otherwise>
			        <div class="text-right">
			            <%--${sessionScope.loginName}님 반갑습니다! <br> --%>
			            <c:choose>
			                <c:when test="${sessionScope.loginAuthority == '일반회원'}">
			                    <a href="${pageContext.request.contextPath}/member/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 마이페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '사업자회원'}">
			                    <a href="${pageContext.request.contextPath}/vendor/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 마이페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '매니저'}">
			                    <a href="${pageContext.request.contextPath}/manager/mypage" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 매니저 페이지</a>
			                </c:when>
			                <c:when test="${sessionScope.loginAuthority == '관리자'}">
			                    <a href="${pageContext.request.contextPath}/admin/selectAll" class="text-decoration-none text-reset"><i class="fas fa-user"></i> 관리자 페이지 </a>
			                </c:when>
			            </c:choose>
			            <br>
			            <a href="/ex/user/logout" class="text-decoration-none text-reset"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			        </div>
			    </c:otherwise>
			</c:choose>
        <%--</li> --%>
  </div>
</nav>

<script>

$(document).ready(function() {
	function submitForm(){
	    var searchBy = $("#searchBy").val(); //업종인지 주소인지
	    var searchKeyword = $("#searchKeyword").val(); // 텍스트 박스 내용
	    
//	    if(searchBy == "business_type"){	//업종
//	    	$("#searchForm").attr("action", "/ex/member/searchplacebt");	//업종
//	    }else if(searchBy =="basic_address"){	//주소
//	    	$("#searchForm").attr("action", "/ex/member/searchplaceba");	//주소
//	    }
//business_type
//basic_address
		
	    console.log("searchBy : " + searchBy + " \nsearchKeyword : " + searchKeyword);
    	$("#searchForm").attr("action", "/ex/member/searchp");
	    //alert("searchBy : " + searchBy + "\n searchKeyword : " + searchKeyword);
	    $("#searchForm").submit();
	}
	  $("#searchBtn").click(function() {
		  submitForm();
	  });
	  
	  $("#searchKeyword").keypress(function(event) {
	        if (event.which === 13) {
	            event.preventDefault();
	            //alert("keypressed "+event.which)
	            submitForm();
	        }
	    });
	  
	  
	});


</script>
<input type="hidden" id="loginEmail" value="${sessionScope.loginEmail}">
<input type="hidden" id="loginName" value="${sessionScope.loginName}">
<input type="hidden" id="loginPhone" value="${sessionScope.loginPhone}">
<c:choose>
	<c:when test="${sessionScope.loginAuthority == '사업자회원'}">
		<input type="hidden" id="loginBusiness_regi_num" value="${sessionScope.loginBusiness_regi_num}">
	</c:when>
</c:choose>
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
