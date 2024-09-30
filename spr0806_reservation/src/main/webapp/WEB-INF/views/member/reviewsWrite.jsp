<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="header-placeholder"></div>
<main>

이름 : ${sessionScope.loginName}<br>
이메일 : ${sessionScope.loginEmail}<br>
예약주문번호 ${reservationNumber} 의 이용후기를 작성 하는 페이지


<div>
		<h3>comments</h3>
	</div>
</body>
<div>
	<div>
		작성자 : <input type="text" id="newReplyWriter"  value="${sessionScope.loginName}" readonly/>
	</div>
	<br>
	<div>
		내용 : <input type="text" id="newReplyText" />
	</div>
	<br>
	<button id="replyAddBtn">댓글 등록</button>
	<br>
</div>
<ul id="replies"></ul>
<div class="pagination"></div>

<!-- Mod 버튼 댓글이 달려있지 않으면 display:none 상태이다 -->
<div id='modDiv' style="display: none">
	<div class="modal-title"></div>
	<div>
		내용 : <input type='text' id='modContent'>
	</div>
	<div>
		<button type="button" id="replyModBtn">수정</button>
		<button type="button" id="replyDelBtn">삭제</button>
		<button type="button" id="closeBtn">창 닫기</button>
	</div>
</div>
<div id='reReplyMod' style="display: none">
	<div class="re-modal-title"></div>
	<div>
		작성자 : <input type='text' id='reReplyName'>
	</div>
	<div>
		내용 : <input type='text' id='reReplyText'>
	</div>
	<div>
		<button type="button" id="reReplyAddBtn">등록</button>
		<button type="button" id="reReplyCloseBtn">창 닫기</button>
	</div>
</div>

<script>

var page=1;
$(document).ready(function() {
	var fObject=$(".form");
	console.log(fObject);
	getPageList(page);
	
	/*댓글 등록 완료 후 실행*/
	function getPageList(page){
		console.log("Current page:", page);
		$.ajax({
			type: 'GET',
			url: '/ex/replies/page/'+page,
			dataType: 'json',
			success: function(data) {
				console.log(data);
				var str="";				
				$(data.list).each(function() {
					var indent=this.rIndent*30;
					str+="<div data-rId='"+this.rId+"' class='replyLi' style='margin-left:" + indent + "px'>"+
					 	 //this.rId+" : "+
					 	 "<span class='reply-writer'>" + this.writer + "</span><br>" +  // 작성자를 별도 태그로 감싸기
           				"<span class='reply-content'>" + this.content + "</span><br>" +  // 내용을 별도 태그로 감싸기
						 //this.writer + "<br>"+	
						 //this.content +	"<br>"+				
				     	 "<button>수정/삭제</button></div>"+				     	 			     	
				     	 "<div data-rId='"+this.rId+"' class='reReplyLi' style='margin-left:" + indent + "px'>"+
				     	"<button>댓글</button></div>"	
				     	 "</div>"

				});
				$("#replies").html(str);
				
				var pagination="";
				if (data.pageMaker.prev) {
					pagination += "<a href='" + (data.pageMaker.startPage - 1) + "'> &laquo; </a>";
				}
	            for (var i = data.pageMaker.startPage; i <= data.pageMaker.endPage; i++) {
					var strClass = data.pageMaker.page == i ? 'class="active"' : '';
					pagination += "<a " + strClass + " href='" + i + "'>" + i + "</a>";
	            }
	            if (data.pageMaker.next) {
	            	pagination += "<a href='" + (data.pageMaker.endPage + 1) + "'> &raquo; </a>";
	            }
	            console.log(str)
	            $(".pagination").html(pagination);
			},
			error: function(xhr, status, error) {
				console.error("Error: ", error);
			}
		});
	}
	
	/*댓글 mod 수정/삭제 버튼 .on(click 이벤트시 replyLi button만 실행시켜라)*/
	$("#replies").on("click",".replyLi button",function(){
		var rId=$(this).parent().attr("data-rId");
		//var content=$(this).parent().text();
		var writer = $(this).siblings(".reply-writer").text(); // 작성자
   		 var content = $(this).siblings(".reply-content").text(); // 댓글 내용
		$(".modal-title").html(rId);
		$("#modContent").val(content);
		$("#modDiv").show("slow");
	})	
	
	/*댓글 창닫기 버튼*/
	$("#closeBtn").on("click",function(){
		$("#modDiv").hide("slow");
	})
	
	/*댓글 수정 버튼*/
	$("#replyModBtn").on("click",function(){
		
		var rId=$(".modal-title").html();
		var content = $("#modContent").val();
	
		$.ajax({
			type:'PUT',
			url:'/ex/replies/'+rId+'/update',
			headers:{
				"Content-Type":"application/json"
			},
			data:JSON.stringify({content:content}),
			dataType:'text',
			success:function(result){
				if(result=='SUCCESS'){
					alert("수정 되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(page);
				}
			}
		})
	})
	
	$("#replies").on("click",".reReplyLi button",function(){
		var rId=$(this).parent().attr("data-rId");
		$(".re-modal-title").html(rId);
		$("#reReplyMod").show("slow");
	})
	
	$("#reReplyCloseBtn").on("click",function(){
		$("#reReplyMod").hide("slow");
	})
	
	/*대댓글 등록 버튼*/
	$("#reReplyAddBtn").on("click",function(){	
		var rId=$(".re-modal-title").html();
		var writer=$("#reReplyName").val();
		var content=$("#reReplyText").val();
		
		$.ajax({
			type:'POST',
			url:'/ex/replies/'+rId + '/replies',
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			data:JSON.stringify({
			
				content:content,
				writer:writer,
				rId:rId,
			}),
			success:function(result){
				if(result == 'SUCCESS'){
					alert("댓글이 등록됐습니다.");
					$("#reReplyMod").hide("slow");
					getPageList(page);
				}
			},
			error: function(xhr, status, error) {
	        	console.error("Error: ", error);
	        }
		});
	});
	
	/*댓글 등록 버튼*/
	$("#replyAddBtn").on("click",function(){		
		var writer=$("#newReplyWriter").val();
		var content=$("#newReplyText").val();
		
		$.ajax({
			type:'POST',
			url:'/ex/replies/new',
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			data:JSON.stringify({
				
				content:content,
				writer:writer
			}),
			success:function(result){
				if(result == 'SUCCESS'){
					alert("댓글이 등록됐습니다.");
					getPageList(page);
				}
			},
			error: function(xhr, status, error) {
	        	console.error("Error: ", error);
	        }
		});
	});

	/*댓글 삭제 버튼*/
	$("#replyDelBtn").on("click",function(){
		var rId=$(".modal-title").html();
		$.ajax({
			type:'delete',
			url:'/ex/replies/'+rId+'/delete',
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			success:function(result){
				if(result=='SUCCESS'){
					alert("삭제 되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(page);
				}
			}
		})
	})
		
/* 	var fObject=$(".form");
	$(".pagination").on("click","a",function(event){
		event.preventDefault();
		page=$(this).attr("href");
		getPageList(page);
		
	})
	
	$(".btnList").on("click",function(){
		fObject.attr("method","get");
		fObject.attr("action","/ex/sboard/list");
		fObject.submit();
	})	
	
	$(".btnRemove").on("click",function(){
		fObject.attr("action","/ex/sboard/remove");
		fObject.submit();
	})
	
	$(".btnModify").on("click",function(){
		fObject.attr("method","get");
		fObject.attr("action","/ex/sboard/modify");
		fObject.submit();
	})
	
	$(".btnReply").on("click",function(){
		fObject.attr("method","get");	
		fObject.attr("action","/ex/sboard/writeRep");
		fObject.submit();
	})
	
	$(".btnLike").on("click",function(){
		fObject.attr("action","/ex/sboard/like");
		fObject.submit();
	})
	
	$(".btnDislike").on("click",function(){
		fObject.attr("action","/ex/sboard/dislike");
		fObject.submit();
	})
	 */
	
	//////////////////////////////////////////
	 var formObj = $("form[role='form']");
    
    var fObject=$(".form");
	$(".pagination").on("click","a",function(event){
		event.preventDefault();
		page=$(this).attr("href");
		getPageList(page);
		
	})

    $(".btn-warning").on("click", function() {
        formObj.attr("action", "/ex/reservation/update"); //modify
        formObj.attr("method", "get");
        formObj.submit();
    });

    $(".btn-danger").on("click", function() {
        formObj.attr("action", "/ex/reservation/remove");
        formObj.submit();
    });

    $(".btn-primary").on("click", function() {
        self.location = "/ex/reservation/listAll";
    });

/*     $(".btn-bLike").on("click", function() {
        formObj.attr("action", "/ex/board/bLike");
        formObj.attr("method", "get");
        formObj.submit();
    });
 */
    $(".btn-reply").on("click", function() {
        formObj.attr("action", "/ex/reply/reply");
        formObj.attr("method", "get");
        formObj.submit();
      
		});
	
});


</script>
<%--${sessionScope.loginAuthority}<br> --%>
</main>
<%@include file="/WEB-INF/views/include/footer.jsp"%>