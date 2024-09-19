$(function(){
	$(document).on("click", "#emailBtn", function(){ //[인증번호 발송] 버튼
		//alert($("#email").val())
		//alert($("#random").val())
		$.ajax({
			beforeSend: function(){
				alert('메일전송시작');
				///loadingBarShow();
			},
			type:"get",
			url: "/ex/createEmailCheck",	//UserRestController
		    data: {
		        email: $("#email").val(),
		        random: $("#random").val()
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
	
	
 	//이메일 인증번호 입력 후 인증 버튼 클릭
	$(document).on("click", "#emailAuthBtn", function(){
		$.ajax({
			beforeSend: function(){
				///loadingBarShow();
				alert('인증번호 확인 시작');
			},
			type:"get",
			url:"/ex/emailAuth",
			data:"authCode=" + $('#emailAuth').val() + "&random=" + $("#random").val(),
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