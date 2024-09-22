$(function(){
	$(document).on("click", "#phoneBtn", function(){ //[전화번호 인증번호 발송] 버튼
		//alert($("#phone").val())
		//alert($("#random").val())
		$("#phoneAuthBtn").prop('disabled', false);	//전화번호 인증 버튼 보이기
		$("#phoneAuth").prop('disabled', false);//전화번호 인증번호 입력칸 보이기
		$.ajax({
			beforeSend: function(){
				//alert('sms전송시작');
				///loadingBarShow();
				$("#valid_phone2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`인증번호가 전송 시작.`+
						  `</div>`);
			},
			type:"get",
			url: "/ex/createPhoneCheck",	//MessageController
		    data: {
		    	phone: $("#phone").val(),
		        random: $("#randomp").val()
		    },
			success : function(data){
				///loadingBarHide();
				//alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
				$("#valid_phone2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`인증번호가 발송되었습니다. 인증번호를 입력해주세요.`+
						  `</div>`);
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

		phoneVerified = false;
		$.ajax({
			beforeSend: function(){
				///loadingBarShow();
				//alert('인증번호 확인 시작');
				$("#valid_phone2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`인증번호 확인 시작.`+
						  `</div>`);
			},
			type:"get",
			url:"/ex/phoneAuth",
			data:"authCodep=" + $('#phoneAuth').val() + "&randomp=" + $("#randomp").val(),
			success:function(data){
				if(data=="complete"){
					//alert("인증이 완료되었습니다.");
					$("#valid_phone2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`인증이 완료되었습니다.`+
							  `</div>`);
					//$("#email").prop('readonly',true);
					//$("#emailAuth").prop('readonly',true);
					//$("#checkemail").prop('disabled', true);
					//$("#emailBtn").prop('disabled', true);
					//$("#emailAuthBtn").prop('disabled', true);
					$(".consolep").html("");
					//$("#submit").prop('disabled', false);

					phoneVerified = true;
					checkVerificationStatus();
				}else if(data == "false"){
					//alert("인증번호를 잘못 입력하셨습니다.");
					$("#valid_phone2").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`인증번호를 잘못 입력하셨습니다.`+
							  `</div>`);
					//$("#submit").prop('disabled', true);
					checkVerificationStatus();
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