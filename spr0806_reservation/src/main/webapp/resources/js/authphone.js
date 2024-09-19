$(function(){
	$(document).on("click", "#phoneBtn", function(){ //[전화번호 인증번호 발송] 버튼
		//alert($("#phone").val())
		//alert($("#random").val())
		$.ajax({
			beforeSend: function(){
				alert('sms전송시작');
				///loadingBarShow();
			},
			type:"get",
			url: "/ex/createPhoneCheck",	//MessageController
		    data: {
		    	phone: $("#phone").val(),
		        random: $("#randomp").val()
		    },
			success : function(data){
				///loadingBarHide();
				alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
			},
			error: function(data){
				alert("에러가 발생했습니다.");
				return false;
			}
		});
	});
	
	/*
 	전화번호 인증번호 입력 후 인증 버튼 클릭 이벤트
	*/
	$(document).on("click", "#phoneAuthBtn", function(){
		$.ajax({
			beforeSend: function(){
				///loadingBarShow();
				alert('인증번호 확인 시작');
			},
			type:"get",
			url:"/ex/phoneAuth",
			data:"authCodep=" + $('#phoneAuth').val() + "&randomp=" + $("#randomp").val(),
			success:function(data){
				if(data=="complete"){
					alert("인증이 완료되었습니다.");
				}else if(data == "false"){
					alert("인증번호를 잘못 입력하셨습니다.")
				}
			},
			complete: function(data){
				console.log(data)
			},
			error:function(data){
				console.log(data)
				//alert("에러가 발생했습니다.");
			}
		});
		///loadingBarHide();
	});
});