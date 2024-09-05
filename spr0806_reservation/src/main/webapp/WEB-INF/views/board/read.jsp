<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	var bId = "${boardDto.bId}";
	var page = 1;
	$(document).ready(function(){
		var formObj=$(".form");
		console.log(formObj);
		getPageList(page);
		
	function getPageList(page) {
		$.ajax({
			type : 'GET',
			url : '/ex/replies/' + bId + '/' + page,
			dataType : 'json',
			success : function(data) {
			console.log(data);
			var str = "";
			$(data.list).each(function() {
				var indent = this.rIndent * 30;
				str += "<div data-rId='"+this.rId+"' class='replyLi' style='margin-left:"+indent+"px'>"
				+ this.rId + ":"
				+ this.rName
				+ "<br>"
				+ this.rContent
				+ "<br><button>수정/삭제</button></div>"
				+ "<div data-rId='"+this.rId+"' class='reReplyLi' style='margin-left:"+indent+"px'>"
				+ "<button>댓글</button></div>"
			});
			$("#replies").html(str);
				var pagination = "";
				if (data.pageMaker.prev) {
					pagination += "<a href='"
							+ (data.pageMaker.startPage - 1)
							+ "'> &laquo; </a>";
				}
				for (var i = data.pageMaker.startPage; i <= data.pageMaker.endPage; i++) {
					var strClass = data.pageMaker.page == i ? 'class="active"'
							: '';
					pagination += "<a" + strClass + " href='" + i + "'>"
							+ i + "</a>";
				}
				if (data.pageMaker.next) {
					pagination += "<a href='"
							+ (data.pageMaker.endPage + 1)
							+ "'>&raquo; </a>";
				}
				console.log(str)
				$(".pagination").html(pagination);
				},
				error : function(xhr, status, error) {
					console.error("Error: ", error);
				}
		});
		}
		/* 댓글 mod 수정/삭제 버튼 .on(click 이벤트시 replyLi button만 실행시켜라) */
		$("#replies").on("click",".replyLi button",function() {
			var rId = $(this).parent().attr(
					"data-rId");
			var rContent = $(this).parent()
					.text();
			$(".modal-title").html(rId);
			$("#modContent").val(rContent);
			$("#modDiv").show("slow");
		});
		/* 댓글 창닫기 버튼 */
		$("#closeBtn").on("click", function() {
			$("#modDiv").hide("slow");
		});
		/* 댓글 수정 버튼 */
		$("#replyModBtn").on("click", function() {
			var rId = $(".modal-title").html();
			var rContent = $("#modContent").val();

			$.ajax({
				type : 'PUT',
				url : '/ex/replies/' + rId,
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					rContent : rContent
				}),
				dataType : 'text',
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("수정되었습니다.");
						$("#modDiv").hide("slow");
						getPageList(page);
					}
				}
			});
		});
		$("#replies").on("click",".reReplyLi button",function() {
			var rId = $(this).parent().attr("data-rId");
			$(".re-modal-title").html(rId);
			$("#reReplyMod").show("slow");
		})

		$("#reReplyCloseBtn").on("click", function() {
			$("#reReplyMod").hide("slow");
		})

		/* 대댓글 등록버튼 */
		$("#reReplyAddBtn").on("click", function() {
			var rId = $(".re-modal-title").html();
			var rName = $("#reReplyName").val();
			var rContent = $("#reReplyText").val();

			$.ajax({
				type : 'POST',
				url : '/ex/replies/' + rId,
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : 'text',
				data : JSON.stringify({
					bId : bId,
					rContent : rContent,
					rName : rName,
					rId : rId,
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("댓글이 등록됐습니다.");
						$("#reReplyMod").hide("slow");
						getPageList(page);
					}
				},
				error : function(xhr, status, error) {
					console.error("Error: ", error);
				}
			});
		});
		/* 댓글 등록 버튼 */
		$("#replyAddBtn").on("click", function() {
			var rName = $("#newReplyWriter").val();
			var rContent = $("#newReplyText").val();

			$.ajax({
				type : 'POST',
				url : '/ex/replies',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : "text",
				data : JSON.stringify({
					bId : bId,
					rContent : rContent,
					rName : rName
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("댓글이 등록됐습니다.");
						getPageList(page);
					}
				},
				error : function(xhr, status, error) {
					console.error("Error: ", error);
				}
			});
		});

		/* 댓글삭제 버튼 */
		$("#replyDelBtn").on("click", function() {
			var rId = $(".modal-title").html();
			$.ajax({
				type : 'delete',
				url : '/ex/replies/' + rId,
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : 'text',
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getPageList(page);
					}
				}
			});
		});
		
	$(".pagination").on("click", "a", function(event) {
		event.preventDefault();
		page = $(this).attr("href");
		getPageList(page);
	});
	$(".btn-update").on("click",function(){
		formObj.attr("action","/ex/board/modify?");
		formObj.attr("method","get");
		formObj.submit();
	});
	$(".btn-delete").on("click",function(){
		formObj.attr("action","/ex/board/remove");
		formObj.attr("method","get");
		formObj.submit();
	});
	$(".btn-list").on("click",function(){
		self.location="/ex/board/listAll";
	});
	$(".btn-like").on("click",function(){
		formObj.attr("action","/ex/board/like");
		formObj.attr("method","get");
		formObj.submit();
	});
	$(".btn-dislike").on("click",function(){
		formObj.attr("action","/ex/board/dislike");
		formObj.attr("method","get");
		formObj.submit();
	});
	
	$(".btn-reply").on("click", function(){
		formObj.attr("action", "/ex/board/reply");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
	})
</script>
<style>
#modDiv, #reReplyMod {
		width: 400px;
		height: 150px;
		background-color: gray;
		position: fixed;
		top: 20%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
}
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #f4f4f4; /* 배경색: 연한 회색 */
}

/* Header Styles */
.head {
	background-color: #333; /* 헤더 배경색: 검정색 */
	color: #fff; /* 텍스트 색상: 흰색 */
	padding: 10px;
	text-align: center;
}

.head-title {
	margin: 0;
	font-size: 24px; /* 제목 폰트 크기 */
}

/* Main Container Styles */
.main {
	display: flex;
	margin: 20px auto;
	max-width: 1200px; /* 중앙 정렬 및 최대 폭 설정 */
}

/* Sidebar Styles */
.side {
	width: 250px;
	background-color: #333; /* 사이드바 배경색: 검정색 */
	color: #fff; /* 텍스트 색상: 흰색 */
	padding: 15px;
}

.side a {
	color: #fff; /* 링크 색상: 흰색 */
	text-decoration: none;
	display: block;
	margin: 5px 0;
}

.side a:hover {
	text-decoration: underline; /* 호버 시 밑줄 추가 */
}

/* Content Styles */
.content {
	flex: 1;
	padding: 20px;
	background-color: #fff; /* 콘텐츠 배경색: 흰색 */
	border-radius: 5px; /* 테두리 둥글게 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
}

h1 {
	font-size: 28px;
	margin-bottom: 20px;
}

h2 {
	font-size: 20px;
	margin-bottom: 10px;
}

input[type="text"], textarea {
	width: 100%; /* 전체 너비 사용 */
	padding: 10px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 색상 */
	border-radius: 5px; /* 모서리 둥글게 */
	background-color: #f4f4f4; /* 배경색: 연한 회색 */
}

textarea {
	resize: none; /* 크기 조절 비활성화 */
}

/* Button Container Styles */
.btn-container {
	text-align: left;
	margin-top: 20px;
}

button {
	padding: 10px 20px; /* 버튼 안쪽 여백 */
	background-color: #333; /* 버튼 배경색: 검정색 */
	color: #fff; /* 버튼 텍스트 색상: 흰색 */
	border: none; /* 테두리 제거 */
	border-radius: 5px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 포인터 커서 */
	margin: 5px; /* 버튼 간격 */
}

button:hover {
	background-color: #555; /* 호버 시 버튼 배경색: 어두운 회색 */
}
</style>
</head>
<body>
	<div class="head">
		<h1 class="head-title">my WebSite</h1>
	</div>
	<div class="main">
	
		<div class="side">
			<a href="/ex/board/listAll" class="right">All Category</a><br>
			<c:forEach items="${category}" var="item">
				<a href="/ex/board/listAll?bGroupKind=${item }">${item}</a>
				<br>
			</c:forEach>
		</div>
		<div class="content">
			<form class="form" method="post">
				<input type='hidden' name='bId' value="${boardDto.bId}">
				<input type='hidden' name='page' value="${pageMaker.page }">
				<input type='hidden' name='perPageNum' value="${pageMaker.perPageNum }">
				<input type='hidden' name='searchType' value="${pageMaker.searchType }">
				<input type='hidden' name='keyword' value="${pageMaker.keyword }">
			</form>
			<h1>게시글</h1>

			<br>
			<h2>
				글 제목<input type="text" style="width: 100%" name='bTitle' 
				value='${boardDto.bTitle }' readonly="readonly">
			</h2>
			<br>
			<h2>
				카테고리 <input type="text" style="width: 100%" name='bGroupKind'
					value='${boardDto.bGroupKind }' readonly="readonly">
			<br>
			<h2>
				내용
				<textarea style="width: 100%" name="bContent" rows="3"
					readonly="readonly">${boardDto.bContent}</textarea>
			</h2>
			<br>

			<h2>
				작성자<input type="text" name="bName" style="width: 100%" 
				value='${boardDto.bName }' readonly="readonly">
			</h2>
			<c:if test="${not empty boardDto.bUpdateTime}">
				<h2>
					수정된 날짜 <input type="text" style="width: 100%" name='bUpdateTime'
						value="${boardDto.bUpdateTime}" readonly="readonly">
				</h2>
			</c:if>
			<div class="btn-container">
				<button type="submit" class="btn-update">수정</button>
				<button type="submit" class="btn-delete">삭제</button>
				<button type="submit" class="btn-list">전체글 보기</button>
				<button type="submit" class="btn-like">좋아요</button>
				<button type="submit" class="btn-dislike">싫어요</button>
				<button type="submit" class="btn-reply">답글</button>
			</div>
			<!-- 댓글입력창 -->
			<h2>Reply</h2>
			<div>
				<div>
					작성자: <input type="text" id="newReplyWriter" />
				</div>
				<br>
				<div>
					내용: <input type="text" id="newReplyText" />
				</div>
				<br>
				<button id="replyAddBtn">댓글등록</button>
				<br>
			</div>

			<ul id="replies"></ul>
			<div class="pagination"></div>
			<!-- Mod 버튼 댓글이 달려있지 않으면 display:none 상태이다. -->
			<div id='modDiv' style="display: none">
				<div class="modal-title"></div>
				<div>
					내용: <input type="text" id='modContent'>
				</div>
				<div>
					<button type="button" id="replyModBtn">수정</button>
					<button type="button" id="replyDelBtn">삭제</button>
					<button type="button" id="closeBtn">창닫기</button>
				</div>
			</div>
			<div id='reReplyMod' style="display: none">
				<div class="re-modal-title"></div>
				<div>
					작성자: <input type='text' id='reReplyName'>
				</div>
				<div>
					내용: <input type='text' id='reReplyText'>
				</div>
				<div>
					<button type='button' id='reReplyAddBtn'>등록</button>
					<button type='button' id='reReplyCloseBtn'>창 닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>