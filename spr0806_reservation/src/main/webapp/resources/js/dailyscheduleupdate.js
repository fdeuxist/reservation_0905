	//해당벤더 해당일의 시간을 가져옴 
	var email = $("#vendorEmail").val();
	var businessRegiNum = $("#vendorBusiness_regi_num").val();
	var openDate = $("#selectedDate").val();
	
	var responseTimes;	//수정 전 시간 기준값
	var responseTimesNow;	//수정 완료 버튼 누를때의 시간값
	
	
	
	$(function() {
	
	//	$("#cancelSubmitBtn").prop("disabled", true);	//스케줄수정취소 클릭불가
	//	$("#updateSubmitBtn").prop("disabled", true);	//스케줄수정완료 클릭불가
		$("#cancelSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 취소 버튼 숨기기
	    $("#updateSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 완료 버튼 숨기기
		
		
	    // 서버에서 전달된 date 값을 JavaScript 변수로 가져옴
	    //var selectedDate = "${selectedDate}";
	    const timeButtonsContainer = $('#time-buttons');
	    
	    // 페이지 로딩 시 빈 슬롯 생성
	    createEmptyTimeSlots();
	
	    // 시간 슬롯을 초기화하고 빈 슬롯을 생성
	    function createEmptyTimeSlots() {
	        timeButtonsContainer.empty(); // 기존 슬롯 제거
	
	        for (let i = 0; i < 24; i++) {
	            var hour = i.toString().padStart(2, '0'); // i 값을 두 자리 숫자로 변환
	            timeButtonsContainer.append(`<div class="time-slot" data-value="0" >${hour}:00</div>`);
	            timeButtonsContainer.append(`<div class="time-slot" data-value="0" >${hour}:30</div>`);
	        }
	    };
	    
	
	
	    getTimeSlots();
	    
	    function getTimeSlots(){
	    	//alert(openDate)
	        $.ajax({
	            url: '/ex/vendorrest/scheduleselect',
	            method: 'POST',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify({
	                email: email,
	                business_regi_num: businessRegiNum,
	                open_date: openDate
	            }),
	            success: function(response) {
	                // 응답 처리
	                console.log(response);
	                responseTimes = response.dto.times;
	                drawTimeSlots(responseTimes);	//가져온 시간으로 버튼을 그림
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
	        });
	    }
	    
	    
	    function drawTimeSlots(times) { // 색칠만, 클릭이벤트 없음. 수정하기 눌러야 클릭이벤트 부여
	        createEmptyTimeSlots(); // 슬롯을 초기화
	        
	        const timeSlots = $('.time-slot');
	        
	        for (let i = 0; i < timeSlots.length; i++) {
	            const slotStatus = times.charAt(i); // times 문자열의 해당 위치에서 상태 가져오기
	
	            if (slotStatus === '1') {
	                $(timeSlots[i]).attr('data-value', '1').addClass('openX');
	            } else if (slotStatus === '0') {
	                $(timeSlots[i]).attr('data-value', '0').addClass('closeX');
	            } else if (slotStatus === '2') { // 이미 예약된 시간
	                $(timeSlots[i]).attr('data-value', '2').addClass('reservated');
	            }
	        }
	    }
	
	    
	    function editableTimeSlots(times) {
	        createEmptyTimeSlots(); // 슬롯을 초기화
	        
	        const timeSlots = $('.time-slot');
	        
	/*
	 * closeO     0 수정가능,   열지 않은 시간
	 * openO      1 수정가능,   예약 가능하게 오픈 해둔 시간
	 * closeX     0 수정 불가능, 열지 않은 시간
	 * openX      1 수정 불가능, 예약 가능하게 오픈 해둔 시간
	 * reservated 2 예약됨
	 */
	        for (let i = 0; i < timeSlots.length; i++) {
	            const slotStatus = times.charAt(i); // times 문자열의 해당 위치에서 상태 가져오기
	
	            if (slotStatus === '1') {
	                $(timeSlots[i])
	                    .attr('data-value', '1').addClass('openO').removeClass('openX')
	                    .on('click', function() {
	                        const currentValue = $(timeSlots[i]).attr('data-value');
	                        if (currentValue === '1') {
	                            $(timeSlots[i]).attr('data-value', '0').removeClass('openO').addClass('closeO');
	                        } else {
	                            $(timeSlots[i]).attr('data-value', '1').removeClass('closeO').addClass('openO');
	                        }
	                    });
	            } else if (slotStatus === '0') {
	                $(timeSlots[i])
	                    .attr('data-value', '0').addClass('closeO').removeClass('closeX')
	                    .on('click', function() {
	                        const currentValue = $(timeSlots[i]).attr('data-value');
	                        if (currentValue === '0') {
	                            $(timeSlots[i]).attr('data-value', '1').removeClass('closeO').addClass('openO');
	                        } else {
	                            $(timeSlots[i]).attr('data-value', '0').removeClass('openO').addClass('closeO');
	                        }
	                    });
	            } else if (slotStatus === '2') {
	                $(timeSlots[i])
	                    .attr('data-value', '2').addClass('reservated')
	                    .on('click', function() {
	                        alert("이미 예약된 시간입니다");
	                    });
	            }
	        }
	    }
	
	    
	    
	    
	    ////////확인용//////////
	    function getTimeValues() {
	        const timeSlots = $('.time-slot');
	        let timeValuesStr = '';
	
	        for (let i = 0; i < timeSlots.length; i++) {
	            timeValuesStr += $(timeSlots[i]).attr('data-value');
	        }
	        //console.log("timeValuesStr : " , timeValuesStr);
	        return timeValuesStr;
	    }
	
	    
	    $("#timesNow").click(function() {
	    	alert(getTimeValues());
	    });
	    ////////확인용//////////
	    
	
	    
	    
	    
	    
	    
	    
	    
	    // 스케줄 수정하기 버튼
	    $("#modifySubmitBtn").click(function() {
	    	//벤더는 이 페이지에 들어와있고 수정하기버튼을 누르기 전에 멤버가 예약을 해버리면 이 페이지의 Times 정보와 서버정보가 다른 문제 
	    	//다시말해서
	    	//벤더 수정페이지 진입 후 수정버튼 클릭 전 멤버 신규 예약 발생되고 벤더 스케줄 수정되면 이미 예약된 시간이 open 되는 문제
	    	//벤더 수정페이지 진입 후 수정버튼 클릭 전 멤버 신규 예약 발생되고 벤더 스케줄 수정 누르면 수정누름과 동시에 해당 벤더 해당 일 Times값을 새로 받아와서 문제 해결
	    	//alert(openDate)
	        $.ajax({
	            url: '/ex/vendorrest/scheduleselect',
	            method: 'POST',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify({
	                email: email,
	                business_regi_num: businessRegiNum,
	                open_date: openDate
	            }),
	            success: function(response) {
	                // 응답 처리
	            	console.log("responseTime 갱신 전 " ,responseTimes);
	                console.log(response);
	                responseTimes = response.dto.times;
	                console.log("responseTime 갱신 후 " ,responseTimes);
	                
	//              $("#modifySubmitBtn").prop("disabled", true);	//스케줄수정하기 클릭불가
	//            	$("#cancelSubmitBtn").prop("disabled", false);	//스케줄수정취소 클릭가능
	//            	$("#updateSubmitBtn").prop("disabled", false);	//스케줄수정완료 클릭가능
	                $("#modifySubmitBtn").addClass('hidden');	 // 스케줄 수정 버튼 숨기기
	            	$("#cancelSubmitBtn").removeClass('hidden'); // 스케줄 수정 취소 버튼 보이기
	                $("#updateSubmitBtn").removeClass('hidden'); // 스케줄 수정 완료 버튼 보이기
	                
	            	//alert(responseTimes)
	            	drawTimeSlots(responseTimes);
	            	editableTimeSlots(responseTimes);
	            	setStatus(0);	//예약불가하게 막기
	                
	                
	                
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
	        });
	    	
	    	
	    	
	    	
	    });
	
	    //수정취소하기버튼
	    $("#cancelSubmitBtn").click(function() {
	    	$("#modifySubmitBtn").removeClass('hidden');// 스케줄 수정 버튼 보이기
	    	$("#cancelSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 취소 버튼 숨기기
	        $("#updateSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 완료 버튼 숨기기
	    	drawTimeSlots(responseTimes);
	    	setStatus(1);	//예약가능하게 열기
	    });
	
	    //수정완료버튼
	    $("#updateSubmitBtn").click(function() {
	    	//이 버튼 누르면 현재 db에 예약발생값이 새로 생겨있는지 받아와서 비교 한 다음에 수정완료 처리 해야함
	    	$.ajax({
	            url: '/ex/vendorrest/scheduleselect',
	            method: 'POST',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify({
	                email: email,
	                business_regi_num: businessRegiNum,
	                open_date: openDate
	            }),
	            success: function(response) {
	                console.log(response);
	                responseTimesNow = response.dto.times;
	                if(responseTimesNow==responseTimes){	//지금받아온값과 페이지 들어올때의 값이 같은지 = 신규예약이발생하지는않았는지
	                	//시간 update하고 status 다시 돌리는 내용
	                	scheduleupdate(status)
	                	$("#modifySubmitBtn").removeClass('hidden');// 스케줄 수정 버튼 보이기
	                	$("#cancelSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 취소 버튼 숨기기
	                    $("#updateSubmitBtn").addClass('hidden'); // 초기 상태로 스케줄 수정 완료 버튼 숨기기
	                }else{
	                	//문제있다고 알리고 업데이트 취소처리
	                	console.log("문제있다")
	                }
	                	
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
	        });
	    	
	    	
	    });
	    
	    
	 // 서버에서 받아온 times 문자열을 기반으로 슬롯을 업데이트
	    function updateTimeSlots(times) {
	        createEmptyTimeSlots(); // 슬롯 초기화
	        
	        const timeSlots = $('.time-slot');
	        for (let i = 0; i < timeSlots.length; i++) {
	            const slotStatus = times.charAt(i); // times 문자열의 해당 위치에서 상태 가져오기
	
	            if (times.charAt(i) === '1') {
	            	$(timeSlots[i])
		                .attr('data-value', '1').addClass('selected') 
		                .on('click', function() {
		                    const currentValue = $(timeSlots[i]).attr('data-value');
		                    if (currentValue === '1') {
		                    	$(timeSlots[i]).attr('data-value', '0').removeClass('selected');
		                    } else {
		                    	$(timeSlots[i]).attr('data-value', '1').addClass('selected');
		                    }
	                    });
	            }else if (times.charAt(i) === '0') {
	            	$(timeSlots[i])
		            	.attr('data-value', '0').removeClass('selected') 
	                    .on('click', function() {
	                        const currentValue = $(timeSlots[i]).attr('data-value');
	                        if (currentValue === '0') {
	                        	$(timeSlots[i]).attr('data-value', '1').addClass('selected');
	                        } else {
	                        	$(timeSlots[i]).attr('data-value', '0').removeClass('selected');
	                        }
	                });
	            }else if (times.charAt(i) === '2') {	//이미예약된시간
	            	$(timeSlots[i]).attr('data-value', '2').addClass('reservated')
	            	
	            }
	            
	        }
	    }
	    
	    
	    function setStatus(status){	//수정하거나 완료할때 예약가능여부 토글하는 용도
	    	//alert(email+businessRegiNum+openDate+"aaaaaaaaaaaa")
	    	$.ajax({
	            url: '/ex/vendorrest/setStatus',
	            method: 'POST',
	            dataType: 'json',
	            //contentType: 'application/json; charset=utf-8',
	            data: {
	                email: email,
	                business_regi_num: businessRegiNum,
	                open_date: openDate,
	                times: responseTimes,
	                status_flag: status,
	            },
	            success: function(response) {
	                // 응답 처리
	                console.log(response);
	                //response로 현재 status가 open인지 close인지 알림
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
	        });
	    	
	    }
	    
	    //스케줄수정완료
	    function scheduleupdate(status){
	    	//alert(email+businessRegiNum+openDate+"aaaaaaaaaaaa")
	    	$.ajax({
	            url: '/ex/vendorrest/scheduleupdate',
	            method: 'POST',
	            dataType: 'json',
	            //contentType: 'application/json; charset=utf-8',
	            data: {
	                email: email,
	                business_regi_num: businessRegiNum,
	                open_date: openDate,
	                times: getTimeValues(),
	                status_flag: status,
	            },
	            success: function(response) {
	                // 응답 처리
	                console.log(response);
	                //response로 현재 status가 open인지 close인지 알림    	
	            	  drawTimeSlots(response.updateDto.times);	//가져온 시간으로 버튼을 그림
	            	  responseTimes = response.updateDto.times;
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch data:', error);
	            }
	        });
	    	
	    }
	    
	    
	    
	
	});