$(function(){

	$("#test1").click(function (){
		$("#test1").text(emailVerified+" "+ passwordVerified+" "+ nameEntered+" "+ phoneVerified);
	});
	
	$(document).on("click", "#emailBtn", function(){ //[인증번호 발송] 버튼
		//alert($("#email").val())
		//alert($("#random").val())
		//emailBtn 인증번호 발송 버튼 누르면
		$("#checkEmail").prop('disabled', true); //이메일 중복 확인 버튼 숨기기
		$("#emailAuthBtn").prop('disabled', false); //이메일 인증 버튼 보이기
		$("#emailAuth").prop('disabled', false);//이메일 인증번호 입력칸 보이기
		$("#valid_email").html(""); //사용가능아이디 글자 지우기
		
		$.ajax({
			beforeSend: function(){
				//alert('메일전송시작');
				///loadingBarShow();
				$("#valid_email2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`메일 전송 시작`+
						  `</div>`);
			},
			type:"get",
			url: "/ex/createEmailCheck",	//UserRestController
		    data: {
		        email: $("#email").val(),
		        random: $("#random").val()
		    },
			success : function(data){
				///loadingBarHide();
				//alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
				$("#valid_email2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`인증번호가 발송되었습니다. 인증번호를 입력해주세요.`+
						  `</div>`);
			},
			error: function(data){
				alert("에러가 발생했습니다.");
				return false;
			}
		});
	});
	
	
 	//이메일 인증번호 입력 후 인증 버튼 클릭
	$(document).on("click", "#emailAuthBtn", function(){
		$.ajax({
			beforeSend: function(){
				///loadingBarShow();
				//alert('인증번호 확인 시작');
				$("#valid_email2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`인증번호 확인 시작.`+
						  `</div>`);
			},
			type:"get",
			url:"/ex/emailAuth",
			data:"authCode=" + $('#emailAuth').val() + "&random=" + $("#random").val(),
			success:function(data){
				if(data=="complete"){
					//alert("인증이 완료되었습니다.");
					$("#valid_email2").html(`<div class="alert-sm alert-info alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`인증이 완료되었습니다.`+
							  `</div>`);
					//
					$("#email").prop('readonly',true);
					$("#emailAuth").prop('readonly',true);
					$("#checkemail").prop('disabled', true);
					$("#emailBtn").prop('disabled', true);
					$("#emailAuthBtn").prop('disabled', true);
					$(".console").html("");

					$("#password").prop('disabled', false);
					$("#password2").prop('disabled', false);
					emailVerified = true;
					checkVerificationStatus();
				}else if(data == "false"){
					//alert("인증번호를 잘못 입력하셨습니다.")
					$("#valid_email2").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`인증번호를 잘못 입력하셨습니다.`+
							  `</div>`);
					emailVerified = false;
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