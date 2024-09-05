$(function() {
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'
    });

    const timeButtonsContainer = $('#time-buttons');
    
    // 처음 페이지 로딩 시 버튼 생성 (비워두기)
    createEmptyTimeSlots();

    // get 버튼 클릭 이벤트
    $("#getSubmitBtn").click(function() {
        let email = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let openDate = $("#datepicker").val();

        $.ajax({
            url: '/ex/userrest/scheduleselect',
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
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0" data-time="${hour}:00">${hour}:00</div>`);
            timeButtonsContainer.append(`<div class="time-slot unavailable" data-value="0" data-time="${hour}:30">${hour}:30</div>`);
        }
    }

    function updateTimeSlots(response) {
        // 먼저 슬롯을 초기화 (비우기)
        createEmptyTimeSlots();
        
        const times = response.times;

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
                    .css('background-color', '#CCCCCC') // 선택 불가 상태의 배경색 설정
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
