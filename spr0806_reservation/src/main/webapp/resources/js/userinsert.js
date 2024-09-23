
	$(function() {
		const regExpEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		const regExpPhone = /^(010|016|017|019)\d{3,4}\d{4}$/;
		const regExpPassword = /^(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{4,20}$/;
		
		//비밀번호 검증
		$("#password").keyup(function (){
			passwordVerified = false;
               var pw1 = $("#password").val();
               if(!regExpPassword.test(pw1)){
                   $("#valid_pw").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`비밀번호는 4자 이상 20자 이하이어야 하며, 1개 이상의 특수문자(!@#$%^&*)를 포함해야 합니다.`+
					  `</div>`);
                   $("#valid_pw2").html("");
               } else {
                   $("#valid_pw").html("");
                   //$("#password2").css("background-color", "red");
               }
            pw2keyup();
   			checkVerificationStatus();
           });
		
		//비밀번호 검증
		$("#password2").keyup(function (){
			pw2keyup();
           });
		
		
		function pw2keyup(){
			passwordVerified = false;
            var pw1 = $("#password").val();
            var pw2 = $("#password2").val();
            if(pw1==pw2){
         	   $("#valid_pw2").html("");
                //$("#pwWarning").hide();
                //$("#password2").css("background-color", "white");

					$("#name").prop('disabled', false);
					passwordVerified = true;
            } else {
                //$("#pwWarning").show();
                //$("#pwWarning").html("입력된 비밀번호가 서로 다릅니다");
                //$("#password2").css("background-color", "red");
                $("#valid_pw2").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
							`입력된 비밀번호가 서로 다릅니다.`+
					  `</div>`);

//					$("#name").val("");
//					nameVerified = true;
					$("#name").prop('disabled', true);
            }
				checkVerificationStatus();
		}
		
		
		
		
		//이메일 검증
		$("#email").keyup(function (){
			var input_value = $("#email").val();
		//alert("input_value")
			console.log("email : " , input_value)
			if(!regExpEmail.test(input_value)){
				$("#valid_email").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
					`올바른 형식의 이메일을 입력해주세요.`+
					  `</div>`);
				$("#checkemail").prop('disabled', true);	//이메일 중복 확인 버튼 숨기기
				$(".console").html("");
				$("#emailAuthBtn").prop('disabled', true);	//인증번호 인증 버튼 숨기기
			}else{
				$("#valid_email").html("");
				$("#checkemail").prop('disabled', false);	//이메일 중복 확인 버튼 보이기
			}
			checkVerificationStatus();
		})
		
		//전화번호 검증과 이름 공란 검증
		$("#phone").keyup(function (){

			var phoneVerified = false;
			var input_value = $("#phone").val();
			var input_name = $("#name").val();
			

		//alert("input_value")
			console.log("phone : " , input_value)
			if(!regExpPhone.test(input_value)){
				$("#valid_phone").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
					`올바른 형식의 전화번호 입력해주세요.`+
					  `</div>`);
				$("#checkphone").prop('disabled', true);
				//$(".consolep").html("");
			}else{
				$("#valid_phone").html("");
				$("#checkphone").prop('disabled', false);
			}
			console.log("name val: " , input_name);
			if(input_name==""){
				$("#valid_name").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`이름이나 별명을 입력해주세요.`+
						  `</div>`);
			}else{
				$("#valid_name").html("");
			}				
			checkVerificationStatus();
		})
		
		$("#name").keyup(function (){
			nameEntered = false;
			var input_name = $("#name").val();
			$("#valid_name").html("");
			if(input_name==""){
				$("#valid_name").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
						`이름이나 별명을 입력해주세요.`+
						  `</div>`);
			}else if(input_name!=""){
				$("#phone").prop('disabled', false);
				nameEntered = true;
			}
			checkVerificationStatus();
		});
		
		
		$("#checkemail").click(function() {	//이메일중복확인
			var input_value = $("#email").val();
			/*
			// 사용자 입력값 얻어오기
			var input_value = $("#email").val();

			// 입력여부 검사. email 입력 없이 버튼을 누르면 alert
			if (!input_value) {
				alert("이메일을 입력하세요.");
				$("#email").focus();	//입력 커서 포커스
				return false;//기본이벤트 막음 
			}
			*/
			var url = "/ex/userrest/emailcheck";

			$.ajax({
			    url: '/ex/userrest/emailcheck', // 이메일 중복 체크
		        type: 'GET', // HTTP 메서드
		        data: {
		            email: input_value // 서버로 보낼 파라미터
		        },
		        success: function(response) {
		        	console.log(response);
		            // 서버에서 반환된 JSON 데이터를 파싱
		            var result = response.result;
		            console.log(result);
		            // result가 "true"인지 "false"인지 판단하여 사용자에게 메시지 표시
		            if (result === "true") {
		                //$(".console").html("<span style='color:blue'>사용할 수 있는 아이디입니다.</span>");
		                
		                $(".console").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
		    					`사용할 수 있는 이메일(아이디)입니다.`+
		    					  `</div>`);
		    				$("#emailBtn").prop('disabled', false);
		    				//$("#emailAuthBtn").prop('disabled', true);
		    			//	$(".console").html("");
		    			//	$("#checkemail").prop('disabled', true);
		                
		            } else if (result === "false") {
		                //$(".console").html("<span style='color:red'>사용할 수 없는 아이디입니다.</span>");
		            	$(".console").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
		    					`사용할 수 없는 이메일(아이디)입니다.`+
		    					  `</div>`);
		    				//$("#emailBtn").prop('disabled', true);
		    				//$("#emailAuthBtn").prop('disabled', true);
		                
		            } else {
		                $(".console").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
		                
		            }
					checkVerificationStatus();
		        },
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패: ", status, error);
		            $(".console").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
		        }
		    });
		});

		
	});
	

	//$("#cancelSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 취소 버튼 숨기기
    //$("#updateSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 완료 버튼 숨기기
			
		$("#checkphone").click(function() {

			var phoneVerified = false;
			var input_value = $("input[name='phone']").val();
	
			if (!input_value) {
				alert("전화번호를 입력하세요.");
				$("input[name='phone']").focus();/*focus()는 선택시 활성화되는것*/
				return false;//기본이벤트 막음 
			}
			
		$.ajax({
	        url: '/ex/userrest/phonecheck', // 전화번호 중복 체크
	        type: 'GET', // HTTP 메서드
	        data: {
	            phone: input_value // 서버로 보낼 파라미터
	        },
	        success: function(response) {
	        	console.log(response);
	            // 서버에서 반환된 JSON 데이터를 파싱
	            var result = response.result;
	            console.log(result);
	            // result가 "true"인지 "false"인지 판단하여 사용자에게 메시지 표시
	            if (result === "true") {
	                //$(".consolep").html("<span style='color:blue'>사용할 수 있는 전화번호입니다.</span>");
	            	$("#valid_phone").html(`<div class="alert-sm alert-primary alert-dismissible p-1" style="font-size: 0.75rem;">`+
	    					`사용할 수 있는 전화번호입니다.`+
	    					  `</div>`);
	            	$("#phoneBtn").prop('disabled',false);	//전화번호인증번호발송 버튼 보이기
	            } else if (result === "false") {
	                //$(".consolep").html("<span style='color:red'>사용할 수 없는 전화번호입니다.</span>");
	            	$("#valid_phone").html(`<div class="alert-sm alert-danger alert-dismissible p-1" style="font-size: 0.75rem;">`+
	    					`사용할 수 없는 전화번호입니다.`+
	    					  `</div>`);
	            	$("#phoneBtn").prop('disabled',true);	//전화번호인증번호발송 버튼 숨기기
	            } else {
	                //$(".consolep").html("<span style='color:gray'>알 수 없는 결과입니다.</span>");
	            }
				checkVerificationStatus();
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패: ", status, error);
	            //$(".consolep").html("<span style='color:red'>서버 요청에 실패했습니다.</span>");
	        }
	    });

});