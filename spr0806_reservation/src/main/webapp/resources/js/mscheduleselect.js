$(function() {
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'
    });
    
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
    //get버튼안에있던내용
    
    // get 버튼 클릭 이벤트, 안씀
    $("#getSubmitBtn").click(function() {
    	selectedTimeSlotValues();
    });

    function selectedTimeSlotValues(){
    	timeValues = [];
    	
    	//class가 time-slot인것들을 선택
        const timeSlots = $('.time-slot').toArray();

        for (let i = 0; i < timeSlots.length; i++) {
            let value = $(timeSlots[i]).attr('data-value');
            timeValues.push(value);
        }

        $("#timevalues").val(timeValues.join(''));
        $("#times").val(timeValues.join(''));
//        alert(timeValues.join(''));
        
    }
    
    function createEmptyTimeSlots() {
        // 기존 슬롯 제거
        timeButtonsContainer.empty();
        
        // 새로운 슬롯 생성
        for (let i = 0; i < 24; i++) {
            let hour = i.toString().padStart(2, '0'); // i 값을 두 자리 숫자로 변환
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:00</div>`);
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:30</div>`);
        }
    }

    function updateTimeSlots(dto) {
        // 처음 페이지 로딩 시 버튼 생성 (비워두기)
        createEmptyTimeSlots();
        
        const times = dto.times;
        const timeSlots = $('.time-slot').get(); // jQuery 객체를 일반 배열로 변환

        for (let i = 0; i < timeSlots.length; i++) {
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

    
    
    //////////////////////////////////////////////////////////////////////

    $("#reservationSubmitBtn").click(function() {
    	/*
    	 insert into user_reservation values ( 
	#{reservation_number}, #{user_email}, #{user_phone},
    #{vendor_email}, #{business_regi_num}, #{vendor_phone},
    #{zipcode}, #{basic_address}, #{detail_address},
    #{reservation_date}, #{reservation_use_date}, #{times}, 
    #{total_service_name}, #{total_service_price}, #{total_required_time},
    #{user_request_memo}, '1')
    	 */

//        let selectedItemsDto = $("#selectedItemsDto").val();
//        console.log("Raw JSON string from hidden input:", selectedItemsDto);  // 원본 문자열 출력

//        try {
//            let selectedItems = JSON.parse(selectedItemsDto);
//            console.log("Parsed JSON object:", selectedItems);  // 파싱된 객체 출력
//        } catch (error) {
//            console.error("JSON parsing error:", error.message);
//        }

    	console.log(selectedItemsDto)
    	//let selectedItems = JSON.parse(selectedItemsDto);

    	//console.log(selectedItems)
    	
    	let userEmail = $("#loginEmail").val();
    	let userPhone = $("#loginPhone").val();
        //let vendorEmail = selectedItems.email;
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let reservationDate = $("#selectedDate").val();
        let serviceName = "testserviceName";	//미사용가능성큼 
        let servicePrice = 99999;				//미사용가능성큼 토탈가격?
        let cardObjDto = "";	//넘겨받아야됨
        let zipcode = "12345";
        let basicAddress = "testBasicAddress";
        let detailAddress = "testdetailAddress";
    	
        
        
    	console.log(vendorEmail)
    	
    	
    })
    
    $("#postSubmitBtn").click(function() {	//테스트용, 사라질 예정
        let timeValues = [];

        $('.time-slot').each(function() {
            timeValues.push($('.time-slot').attr('data-value'));
        });

        let userEmail = $("#loginEmail").val();
        let vendorEmail = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let reservationDate = $("#datepicker").val();
        let serviceName = "testserviceName";
        let servicePrice = 99999;
        let zipcode = "12345";
        let basicAddress = "testBasicAddress";
        let detailAddress = "testdetailAddress";

        let reservationNumber = generateReservationNumber();
        //alert(reservationNumber)
        alert(timeValues.join(''))
/*
        $.ajax({
            url: '/ex/userrest/scheduleinsert',
            method: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                reservation_number: reservationNumber,
                user_email: userEmail,
                vendor_email: vendorEmail,
                business_regi_num: businessRegiNum,
                reservation_date: reservationDate,
                times: timeValues.join(''),  // 48자리 문자열로 변환
                service_name: serviceName,
                service_price: servicePrice,
                zipcode: zipcode,
                basic_address: basicAddress,
                detail_address: detailAddress
            }),
            success: function(response) {
            	console.log(response)
                alert('예약이 성공적으로 등록되었습니다!');
            },
            error: function(xhr, status, error) {
                console.error('예약 등록 실패:', error);
            }
        });
*/
    });

    function generateReservationNumber() {
        let now = new Date();
        return now.getFullYear().toString() + 
               (now.getMonth() + 1).toString().padStart(2, '0') + 
               now.getDate().toString().padStart(2, '0') + 
               now.getHours().toString().padStart(2, '0') + 
               now.getMinutes().toString().padStart(2, '0') + 
               now.getSeconds().toString().padStart(2, '0') + 
               now.getMilliseconds().toString().padStart(3, '0');
    }
    
    
    
});



/*
$(function() {
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'
    });

    const timeButtonsContainer = $('#time-buttons');
    
    // 처음 페이지 로딩 시 버튼 생성 (비워두기)
    createEmptyTimeSlots();

    // get 버튼 클릭 이벤트
    $("#getSubmitBtn").click(function() {
        //let openDate = $("#datepicker").val();

        let email = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let openDate = $("#selectedDate").val();

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
    });

    function createEmptyTimeSlots() {
        // 기존 슬롯 제거
        timeButtonsContainer.empty();
        
        // 새로운 슬롯 생성
        for (let i = 0; i < 24; i++) {
            let hour = i.toString().padStart(2, '0'); // i 값을 두 자리 숫자로 변환
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:00</div>`);
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0">${hour}:30</div>`);
        }
    }

    function updateTimeSlots(dto) {
    	// 처음 페이지 로딩 시 버튼 생성 (비워두기)
        createEmptyTimeSlots();
        
        const times = dto.times;

        $('.time-slot').each(function(index) {
            const slotStatus = times.charAt(index); // times 문자열의 해당 위치에서 상태 가져오기
            if (slotStatus === '1') {
                $(this)
                    .removeClass('unavailable')
                    .addClass('available')
                    .attr('data-value', '0') 
                    .on('click', function() {
                        const currentValue = $(this).attr('data-value');
                        if (currentValue === '0') {
                            $(this).attr('data-value', '1');
                        } else {
                            $(this).attr('data-value', '0');
                        }
                        $(this).toggleClass('selected');
                    });
            } else {
                $(this)
                    .removeClass('available')
                    .addClass('unavailable')
                    .attr('data-value', '0')
                    .off('click');  // 클릭 불가 상태로 설정
            }
        });



    }
    
    
    //////////////////////////////////////////////////////////////////////
    
    

    $("#postSubmitBtn").click(function() {
        let timeValues = [];

        $('.time-slot').each(function() {
            timeValues.push($(this).attr('data-value'));
        });

        let userEmail = $("#loginEmail").val();
        let vendorEmail = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let reservationDate = $("#datepicker").val();
        let serviceName = "testserviceName";
        let servicePrice = 99999;
        let zipcode = "12345";
        let basicAddress = "testBasicAddress";
        let detailAddress = "testdetailAddress";

        let reservationNumber = generateReservationNumber();
        //alert(reservationNumber)
        //alert(timeValues.join(''))

        $.ajax({
            url: '/ex/userrest/scheduleinsert',
            method: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                reservation_number: reservationNumber,
                user_email: userEmail,
                vendor_email: vendorEmail,
                business_regi_num: businessRegiNum,
                reservation_date: reservationDate,
                times: timeValues.join(''),  // 48자리 문자열로 변환
                service_name: serviceName,
                service_price: servicePrice,
                zipcode: zipcode,
                basic_address: basicAddress,
                detail_address: detailAddress
            }),
            success: function(response) {
            	console.log(response)
                alert('예약이 성공적으로 등록되었습니다!');
            },
            error: function(xhr, status, error) {
                console.error('예약 등록 실패:', error);
            }
        });
        
    });

    function generateReservationNumber() {
        let now = new Date();
        return now.getFullYear().toString() + 
               (now.getMonth() + 1).toString().padStart(2, '0') + 
               now.getDate().toString().padStart(2, '0') + 
               now.getHours().toString().padStart(2, '0') + 
               now.getMinutes().toString().padStart(2, '0') + 
               now.getSeconds().toString().padStart(2, '0') + 
               now.getMilliseconds().toString().padStart(3, '0');
    }
    
    
    
    
    
    
    
    
    
});
*/