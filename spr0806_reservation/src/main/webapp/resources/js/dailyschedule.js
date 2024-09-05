$(function() {
    // 서버에서 전달된 date 값을 JavaScript 변수로 가져옴
    //var selectedDate = "${selectedDate}";
    const timeButtonsContainer = $('#time-buttons');
    
    // 페이지 로딩 시 빈 슬롯 생성
    createEmptyTimeSlots();

    // 시간 슬롯을 초기화하고 빈 슬롯을 생성하는 함수
    function createEmptyTimeSlots() {
        timeButtonsContainer.empty(); // 기존 슬롯 제거

        for (let i = 0; i < 24; i++) {
            var hour = i.toString().padStart(2, '0'); // i 값을 두 자리 숫자로 변환
            timeButtonsContainer.append(`<div class="time-slot" data-value="0" >${hour}:00</div>`);
            timeButtonsContainer.append(`<div class="time-slot" data-value="0" >${hour}:00</div>`);
        }
    }
    
    // get 버튼 클릭 이벤트
    $("#getSubmitBtn").click(function() {
        let email = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let openDate = $("#selectedDate").val();

        //alert(openDate)
        
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
                console.log(response);
                updateTimeSlots(response.dto.times);
            },
            error: function(xhr, status, error) {
                console.error('Failed to fetch data:', error);
            }
        });
    });


    // 서버에서 받아온 times 문자열을 기반으로 슬롯을 업데이트하는 함수
    function updateTimeSlots(times) {
        createEmptyTimeSlots(); // 슬롯을 초기화

        $('.time-slot').each(function(index) {
            const slotStatus = times.charAt(index); // times 문자열의 해당 위치에서 상태 가져오기

            if (slotStatus === '1') {
                $(this)
	                .attr('data-value', '1').addClass('selected') 
	                .on('click', function() {
	                    const currentValue = $(this).attr('data-value');
	                    if (currentValue === '1') {
	                        $(this).attr('data-value', '0').removeClass('selected');
	                    } else {
	                        $(this).attr('data-value', '1').addClass('selected');
	                    }
                    });
            }else if (slotStatus === '0') {
            	$(this)
	            	.attr('data-value', '0').removeClass('selected') 
                    .on('click', function() {
                        const currentValue = $(this).attr('data-value');
                        if (currentValue === '0') {
                            $(this).attr('data-value', '1').addClass('selected');
                        } else {
                            $(this).attr('data-value', '0').removeClass('selected');
                        }
                });
            }
        });
    }

    // post 버튼 클릭 이벤트
    $("#postSubmitBtn").click(function() {
        let timeValues = [];

        $('.time-slot').each(function() {
            timeValues.push($(this).attr('data-value'));
        });

        alert(timeValues.join(''))
        /*
        let userEmail = $("#loginEmail").val();
        let vendorEmail = $("#vendorEmail").val();
        let businessRegiNum = $("#vendorBusiness_regi_num").val();
        let reservationDate = selectedDate;
        let serviceName = "testserviceName";
        let servicePrice = 99999;
        let zipcode = "12345";
        let basicAddress = "testBasicAddress";
        let detailAddress = "testdetailAddress";

        let reservationNumber = generateReservationNumber();

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
                alert('예약이 성공적으로 등록되었습니다!');
            },
            error: function(xhr, status, error) {
                console.error('예약 등록 실패:', error);
            }
        });
        */
    });

    // 예약 번호를 생성하는 함수
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