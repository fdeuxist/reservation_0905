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
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}
#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}
#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}
.hidden {
    display: none;
}
</style>
<div class="header-placeholder"></div>
<main>
<div class="container">
            <h4 class="text-center mt-3 mb-4">비밀번호 찾기</h4>
        
            <div class="form-group">
                <input type="radio" name="searchType" value="email" id="radio1" checked>
                <label for="radio1">이메일과 이름으로 찾기</label>
            </div>
            <div class="form-group">
                <input type="radio" name="searchType" value="phone" id="radio2">
                <label for="radio2">전화번호와 이름으로 찾기</label>
            </div>
            <div class="form-group" id="emailSection">
                <label for="email">이메일:</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com" required>
            </div>
            <div class="form-group" id="phoneSection">
                <label for="phone">전화번호:</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="01012345678" pattern="\d{11}" required>
            </div>
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" class="form-control" name="name" id="name"/>
            </div>
            <button type="button" class="btn btn-secondary" id="findMyAccountBtn">찾기</button>
            
            <div id="txtDiv"><%-- 안내메시지 --%></div>
            
            <div class="form-group">
                <label for="authCodeInput">인증번호:</label>
                <input type="text" class="form-control" id="authCodeInput" name="authCodeInput" placeholder="132456" pattern="\d{6}" required>
                <div id="txtDiv2"><%-- 안내메시지 --%></div>
            </div>
            
            <button type="button" class="btn btn-secondary" id="confirmBtn">입력</button>
        
            <input type="hidden" id="random" value="${random}">

</main>
<script type="text/javascript">
$(document).ready(function() {
    const findMyAccountBtn = $('#findMyAccountBtn');
    const emailSection = $('#emailSection');
    const phoneSection = $('#phoneSection');
    const authSection = $('#authSection');
    const radioButtons = $('input[name="searchType"]'); //<input>중에 name이 searchType인것 
    
    toggleSections();
    //authSection.addClass('hidden');
    
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
		//$('#txtDiv').text("입력된 정보로 조회중입니다.");
		$("#txtDiv").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
				`입력된 정보로 조회중입니다.`+
				  `</div>`);
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
				//$('#txtDiv').text(resultString[data.result]);
				$("#txtDiv").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
						resultString[data.result]+
						  `</div>`);
				
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
					//$('#txtDiv').text('인증번호를 잘못 입력하였습니다.');
					$("#txtDiv2").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`인증번호를 잘못 입력하였습니다.`+
							  `</div>`);
		        	
				}else {
					//alert("인증번호를 잘못 입력하셨습니다.")
					//$('#txtDiv').text('이메일 [' + data + ']의 비밀번호를 전송된 인증번호로 변경하였습니다. 로그인하여 비밀번호를 변경해주세요.');
					$("#txtDiv2").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`이메일 [` + data + `]의 비밀번호를 전송된 인증번호로 변경하였습니다. 로그인하여 비밀번호를 변경해주세요.`+
							  `</div>`);
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