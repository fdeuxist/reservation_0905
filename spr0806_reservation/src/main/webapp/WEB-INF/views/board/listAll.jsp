<%--<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<link rel="stylesheet" href="../resources/css/styles.css">--%><%-- ← 경로에 styles.css파일이 없어서 주석에 포함(삭제)함 이 하 공용 헤더 추가 [양재하]--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
/* General Styles */
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
}

/* Header Styles board     header용 css 주석처리함 [양재하]*/
/*.header {
	background-color: #333; *//* Black background for the header */
/*	color: #fff;
	padding: 10px 0;
	position: fixed;
	width: 100%;
	top: 0;
	left: 0;
	z-index: 1000;
}

.header-content {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 20px;
}*/

.logo {
	font-size: 24px;
}

.nav-menu a {
	color: #fff;
	text-decoration: none;
	margin: 0 10px;
}

.nav-menu a:hover {
	text-decoration: underline;
}

/* Main Container Styles */
.main-container {
	display: flex;
	margin-top: 0px; /* To avoid overlap with fixed header */
}			/* 60에서 0으로 수정함 [양재하]*/

.sidebar {
	width: 250px;
	background-color: #333; /* Black background for the sidebar */
	color: #fff;
	padding: 15px;
}

.side-content {
	margin-bottom: 20px;
}

.head {
	background-color: #444; /* Dark gray for the head */
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 20px;
}

.head h1 {
	margin: 0;
	font-size: 20px;
}

.sidebar a {
	color: #fff;
	text-decoration: none;
	display: block;
	margin: 5px 0;
}

.sidebar a:hover {
	text-decoration: underline;
}

/* Content Styles */
.content {
	flex: 1;
	padding: 20px;
	background-color: #fff;
}

.row {
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f4f4f4;
}

.btn-container {
	text-align: right;
}

button {
	padding: 10px 15px;
	background-color: #333; /* Dark button color */
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #555; /* Lighter button color on hover */
}

/* Footer Styles */
footer {
	background-color: #333; /* Black background for the footer */
	color: #fff;
	text-align: center;
	padding: 10px 0;
	position: fixed;
	width: 100%;
	bottom: 0;
	left: 0;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	var result = '${msg}';
	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}
	if (result== 'like') {
		alert("좋아요가 +1 되었습니다.")
	}
	if (result== 'disLike') {
		alert("싫어요가 +1 되었습니다.")
	}
	$(document).ready(function(){
		$(".btn").on("click", function(){
			location.href="/ex/board/register"
		});
		$('#searchBtn').on("click",function(event){
			  alert("listAll"+'${boardVo.makePage(1)}'
					  +'&searchType='+$("select option:selected").val()
					  +"&keyword="+$('#keywordInput').val());
			  
			  window.location.href= "listAll"+'${boardVo.makePage(1)}'
			  +'&searchType='+$("select option:selected").val()
			  +"&keyword="+$('#keywordInput').val();
	  })
	  $('.writeBtn').on("click",function(event){
		  location.href="/ex/board/register";
	  });
		$('#newBtn').on("click",function(event){
		  self.location="register";
	  });
	});
		  
</script>
</head>
<body>
<%--	board용 헤더 주석처리함
	<header class="header">
		<div class="header-content">
			<div class="logo">MyWebSite</div>
			<nav class="nav-menu">
				<a href="/ex/board/listAll">All Category</a> 
				<c:forEach items="${category}" var="item">
					<a href="/ex/board/listAll?bGroupKind=${item}&categoryType=${item}">${item}</a>
				</c:forEach>
				<!-- Add more menu items here -->
			</nav>
		</div>
	</header>
--%>
	<div class="main-container">
		<div class="sidebar">
			<div class="side-content">
				<a href="/ex/board/listAll" class="right">All Category</a><br>
				<c:forEach items="${category}" var="item">
					<a href="/ex/board/listAll?bGroupKind=${item}&categoryType=${item}">${item}</a>
					<br>
				</c:forEach>
			</div>
		</div>

		<div class="content">
		<c:if test = "${empty param.bGroupKind }">
		<h1>게시판</h1>
		</c:if>
		<c:if test = "${not empty param.bGroupKind }">
			<h1>${param.bGroupKind }</h1>
		</c:if>
			<div class="row">
				<table>
					<div>
						<select name="searchType">
							<option value="----"<c:out value="${boardVo.searchType eq '----'? 'selected':'' }"/>>----</option>
							<option value="카테고리" <c:out value="${boardVo.searchType eq '카테고리'? 'selected':'' }"/>>카테고리</option>
							<option value="작성자" <c:out value="${boardVo.searchType eq '작성자'? 'selected':'' }"/>>작성자</option>
						</select>
						<!-- input 에 text를 입력하면 value로 설정된 pageMaker에 keyword의 값이 id 값으로 들어간다.
						입력 값이  쿼리 스트링에 들어간다. -->
						<input type="text" name="keyword" id="keywordInput" value="${boardVo.keyword }">
						<button id="searchBtn">검색하기</button>
						<button id="newBtn">새글</button>
					</div>
					<tr>
						<th>카테고리</th>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성 시간</th>
						<th>조회수</th>
						<th>좋아요</th>
						<th>싫어요</th>
						<th>그룹 종류</th>
						<th>단계</th>
						<th style="width: 60px">bIndent</th>
					</tr>
					<c:forEach items="${list}" var="boardDto">
						<tr>
							<td>${boardDto.bGroupKind}</td>
							<td>${boardDto.bId}</td>
							<td>
								<c:forEach begin="1" end="${boardDto.bIndent }">&nbsp;&nbsp;&nbsp;</c:forEach>
								<c:if test="${boardDto.bIndent!=0 }">re:</c:if>
								<a href="/ex/board/read?bId=${boardDto.bId}">${boardDto.bTitle }</a>
							</td>
							<td>${boardDto.bName}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardDto.bWriteTime }"/></td>
							<td>${boardDto.bHit}</td>
							<td>${boardDto.bLike}</td>
							<td>${boardDto.bDislike}</td>
							<td>${boardDto.bGroup}</td>
							<td>${boardDto.bStep}</td>
							<td>${boardDto.bIndent }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="btn-container">
				<button id="btn-create" onclick="location.href='/ex/board/register'">글쓰기</button>
				<div class="pagination">
				<c:if test="${boardVo.page !=1}">
					<a href='listAll${boardVo.makeSearch(1)}'>&lt;&lt;&lt;</a>
				</c:if>
				<!-- 앞의 page 모양을 클릭하면 pageMaker.startPage에 -1을 처리해준다. -->
				<c:if test="${boardVo.prev }">
					<a href='listAll${boardVo.makeSearch(boardVo.startPage-1)}'>&lt;&lt;</a>
				</c:if>
				<c:if test="${boardVo.page !=1 }">
					<a href ='listAll${boardVo.makeSearch(boardVo.page-1)}'>&lt;</a>
				</c:if>
				<c:forEach begin="${boardVo.startPage}" end="${boardVo.endPage}" var="idx">
			        <c:set var="pageUrl" value="listAll${boardVo.makePage(idx)}"/>
			        <c:if test="${not empty boardVo.bGroupKind}">
			            <c:set var="pageUrl" value="${pageUrl}&categoryType=${boardVo.bGroupKind}"/>
			        </c:if>
			        <a href="${pageUrl}" <c:out value="${boardVo.page == idx ? 'class=active' : '' }"/>>
			            ${idx}
			        </a>
			    </c:forEach>
				<c:if test="${boardVo.page != boardVo.totalEndPage}">
	    		<a href='listAll${boardVo.makeSearch(boardVo.page+1)}'>&gt;</a>
		    	</c:if>
		    	<c:if test="${boardVo.next }">
		    		<a href='listAll${boardVo.makeSearch(boardVo.endPage+1)}'>&gt;&gt;</a>
		    	</c:if>
		    	<c:if test="${boardVo.page != boardVo.totalEndPage}">
		    		<a href='listAll${boardVo.makeSearch(boardVo.totalEndPage)}'>&gt;&gt;&gt;</a>
		    	</c:if>
			</div>
			</div>
		</div>
	</div>

	<%@include file="../include/footer.jsp"%>
</body>
</html>
