$(function() {
	/*
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'
    });
    */
	
    $('#nextStepBtn').prop('disabled', true);	//다음단계 버튼 처음에는 누르지 못함

    const timeButtonsContainer = $('#time-buttons');
    const reservationBtn = $('#reservationSubmitBtn');
    const selectedTimeText = $('#selectedTime');	// HH:mm
	var timeValues = [];	//0101 48개
    
    // 처음 페이지 로딩 시 버튼 생성 (비워두기)
    createEmptyTimeSlots();

    //get버튼안에있던내용
    let email = $("#vendor_email").val();
    let businessRegiNum = $("#business_regi_num").val();
    let openDate = $("#selected_date").val();

    $.ajax({
        url: '/ex/memberrest/mscheduleselect',
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
            console.log(response.message);
            console.log(response.dto);
            updateTimeSlots(response.dto);
        },
        error: function(xhr, status, error) {
            console.error('Failed to fetch data:', error);
        }
    });

    function selectedTimeSlotValues(){
    	timeValues = [];
    	
    	const timeSlots = $('.time-slot');	//class가 time-slot인것들을 선택
    	
        for (let i = 0; i < timeSlots.length; i++) {
            let value = $(timeSlots[i]).attr('data-value');	// 0 or 1
            timeValues.push(value);			//47개의 0과 1개의 1
        }

        $("#timevalues").val(timeValues.join(''));
        $("#times").val(timeValues.join(''));
        console.log(timeValues.join(''));
    }
    
    function createEmptyTimeSlots() {
        // 기존 슬롯 제거
        timeButtonsContainer.empty();
        
        // 새로운 슬롯 생성
        for (let i = 0; i < 24; i++) {
            let hour = i.toString().padStart(2, '0'); // i 값을 두 자리 숫자로 변환
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:00</div>`);	// unavailable, 0
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:30</div>`);	// 으로 초기화
        }
    }

    function updateTimeSlots(dto) {
        createEmptyTimeSlots();	// 처음 페이지 로딩 시 버튼 생성 (비워두기)
        
        const times = dto.times;
        const timeSlots = $('.time-slot').get(); // jQuery객체를 자바스크립트 배열로 변환
        
        for (let i = 0; i < timeSlots.length; i++) {	//0~47
            let slotStatus = times.charAt(i); // times 문자열의 해당 위치에서 상태 가져오기

            if (slotStatus === '1') {
            	$(timeSlots[i])
                    .removeClass('unavailable')
                    .addClass('available')
                    .attr('data-value', '0')
                    .on('click', function() {
                        let currentValue = $(timeSlots[i]).attr('data-value');
                        if (currentValue === '0') {
                        	// 현재 클릭된 버튼을 선택된 상태로 만듬
                        	$(timeSlots[i]).attr('data-value', '1');
                        	selectedTimeText.val($(timeSlots[i]).text());	// HH:mm
                        	$("#times_hhmm").val($(timeSlots[i]).text());	// HH:mm
                        	
                        	// 다른 버튼들의 선택을 해제
                            for (let j = 0; j < timeSlots.length; j++) {
                                if (i !== j) { // 클릭한 버튼이 아닌 경우
                                    $(timeSlots[j]).attr('data-value', '0').removeClass('selected');
                                }
                            }
                            
                            $('#nextStepBtn').prop('disabled', false);
                        } else {
                        	// 현재 클릭된 버튼을 선택되지 않은 상태로 만듬
                        	$(timeSlots[i]).attr('data-value', '0');
                        	selectedTimeText.val("");
                            $('#nextStepBtn').prop('disabled', true);
                        }
                        $(timeSlots[i]).toggleClass('selected');
                        selectedTimeSlotValues();	//#timevalues에 선택된 시간 0101값 기록
                        
                    });
            } else {
            	$(timeSlots[i])
                    .removeClass('available')
                    .addClass('unavailable')
                    .attr('data-value', '0')
                    .off('click');  // 클릭 불가 상태로 설정
            }
        }
    }

    
    
});


