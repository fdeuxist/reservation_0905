<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<style>
    .hidden {
        display: none;
    }
</style>
<%@include file="../include/header.jsp"%>
<div class="header-placeholder"></div>
<main>
<h4>회원 정보로 비밀번호 변경하기</h4>
<%--
<form action="/ex/userrest/findMyAccount" id="userFindMyAccountForm" method="post">
    이메일과 이름으로 찾기:
    <input type="email" id="email" name="email" placeholder="가입했던 이메일을 적어주세요 example@domain.com" required><br>
    전화번호와 이름으로 찾기:<input type="text" id="phone" name="phone" placeholder="가입했던 전화번호를 적어주세요 01012345678" pattern="\d{11}" required><br>
    이름:<input type="text" name="name" value="${userDto.name}" readonly/><br>
    <input type="submit" value="찾기"><br>
</form>
--%>
<label>
    <input type="radio" name="searchType" value="email" checked> 이메일과 이름으로 찾기
</label><br>
<label>
    <input type="radio" name="searchType" value="phone"> 전화번호와 이름으로 찾기
</label>
<br>
<%--<div id="emailSection">이메일:<input type="email" id="email" name="email" placeholder="example@domain.com" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required></div> --%>
	<div id="emailSection">이메일:<input type="email" id="email" name="email" placeholder="example@domain.com" required></div>
	<div id="phoneSection">전화번호:<input type="text" id="phone" name="phone" placeholder="01012345678" pattern="\d{11}" required></div>
	이름:<input type="text" name="name" id="name"/><br>
	<input type="hidden" id="random" value="${random }" />
    <input type="button" id="findMyAccountBtn" value="찾기">
    <div id="txtDiv"><%-- 안내메시지 --%></div>
    <div id="authSection">인증번호:<input type="text" id="authCodeInput" name="authCodeInput" placeholder="132456" pattern="\d{6}" required><input type="button" id="confirmBtn" value="입력"></div>
</main>
<script type="text/javascript">
$(document).ready(function() {
    const findMyAccountBtn = $('#findMyAccountBtn');
    const emailSection = $('#emailSection');
    const phoneSection = $('#phoneSection');
    const authSection = $('#authSection');
    const radioButtons = $('input[name="searchType"]'); //<input>중에 name이 searchType인것 
    
    toggleSections();
    authSection.addClass('hidden');
    function toggleSections() {
        if ($('input[name="searchType"]:checked').val() === 'email') {
            emailSection.removeClass('hidden');
            phoneSection.addClass('hidden');
            authSection.addClass('hidden');
        } else {
            emailSection.addClass('hidden');
            phoneSection.removeClass('hidden');
            authSection.addClass('hidden');
        }
        findMyAccountBtn.removeClass('hidden');
        $('#txtDiv').html('');
    }
    
    radioButtons.change(toggleSections);

    findMyAccountBtn.on('click', function() {	//찾기버튼
    	var email = $('#email').val();
    	var phone = $('#phone').val();
    	var name = $('#name').val();
    	var random = $("#random").val();
    	var findtype = $('input[name="searchType"]:checked').val();
    	$('#authCodeInput').val("");
    	
    	findMyAccountBtn.addClass('hidden');
    	authSection.removeClass('hidden');
        console.log(email, phone, name, random, findtype);

        if(findtype=='email'){
        	url = "/ex/findPWByEmailAndName";	//UserRestController
        	//$('#txtDiv').text('입력된 이메일에 전송된 인증번호를 입력해주세요.');
        }else if(findtype=='phone'){
        	url = "/ex/findPWByPhoneAndName";	//MessageController
        	//$('#txtDiv').text('입력된 전화번호에 전송된 인증번호를 입력해주세요.');
        }
        var resultString = ["이메일,이름과 일치하는 정보가 없습니다.",
        						"입력된 이메일에 전송된 인증번호를 입력해주세요.",
        						"전화번호,이름과 일치하는 정보가 없습니다.",
        						"입력된 전화번호에 전송된 인증번호를 입력해주세요."];
		$('#txtDiv').text("입력된 정보로 조회중입니다.");
        $.ajax({
			beforeSend: function(){
				//alert('메일전송시작');
				///loadingBarShow();
			},
			type:"get",
			url: url,
		    data: {
		        email: email,
		        phone: phone,
		        name: name,
		        findtype: findtype,
		        random: random
		    },
			success : function(data){
				console.log("???")
				console.log(data);//이거봐야됨
				$('#txtDiv').text(resultString[data.result]);
				if(data.result==0||data.result==2){
					//console.log("없다")
					//console.log(data.result)
					findMyAccountBtn.removeClass('hidden');
			    	authSection.addClass('hidden');
				}else if(data.result==1||data.result==3){
					//console.log("있다")
					//console.log(data.result)
					findMyAccountBtn.addClass('hidden');
			    	authSection.removeClass('hidden');
				}
				///loadingBarHide();
				//찾기기준으로있다없다 있으면입력해라 없으면없다 
				//alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
			},
			error: function(data){
				alert("에러가 발생했습니다.");
				return false;
			}
		});
    });
    

	//버튼을누르고 complete면 비번이바뀌게해야됨
	$(document).on("click", "#confirmBtn", function(){	//인증번호 입력버튼
    	var email = $('#email').val();
    	var phone = $('#phone').val();
    	var name = $('#name').val();
    	var random = $("#random").val();
    	var findtype = $('input[name="searchType"]:checked').val();
    	
        authSection.addClass('hidden');
        findMyAccountBtn.removeClass('hidden');
        
        if(findtype=='email'){
        	url = "/ex/findPWByEmailAndNameAuth";	//UserRestController
        }else if(findtype=='phone'){
        	url = "/ex/findPWByPhoneAndNameAuth";	//MessageController
        }
        
		$.ajax({
			beforeSend: function(){
				///loadingBarShow();
				//alert('인증번호 확인 시작');
			},
			type:"get",
			url: url,
			data:"authCode=" + $('#authCodeInput').val() + 
			"&random=" + $("#random").val() +
			"&email=" + $("#email").val() +
			"&phone=" + $("#phone").val() +
			"&name=" + $("#name").val(),
			success:function(data){
				/*
				if(data=="complete"){
					//alert("비밀번호를 인증번호로 변경하였습니다.");
		        	$('#txtDiv').text('비밀번호를 인증번호로 변경하였습니다. 로그인하여 비밀번호를 변경해주세요.');
				}else if(data == "false"){
					//alert("인증번호를 잘못 입력하셨습니다.")
					$('#txtDiv').text('인증번호를 잘못 입력하였습니다.');
				}
				*/
				if(data=="false"){
					//alert("비밀번호를 인증번호로 변경하였습니다.");
					$('#txtDiv').text('인증번호를 잘못 입력하였습니다.');
		        	
				}else {
					//alert("인증번호를 잘못 입력하셨습니다.")
					$('#txtDiv').text('이메일 [' + data + ']의 비밀번호를 전송된 인증번호로 변경하였습니다. 로그인하여 비밀번호를 변경해주세요.');
				}
			},
			complete: function(data){
				console.log(data)
				console.log(data.responseText)
				console.log(data.statusText)
				if(data.status==400){
					console.log('400!!!!!!')
				}
			},
			error:function(data){
				console.log(data)
				//alert("에러가 발생했습니다.");
			}
		});
		///loadingBarHide();
	});
    
    
});
</script>
<%@include file="../include/footer.jsp"%>