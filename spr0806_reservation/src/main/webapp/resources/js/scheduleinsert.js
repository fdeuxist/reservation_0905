$(function() {
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'
    });

    
    
    
    
    const timeButtonsContainer = $('#time-buttons');
    for (let i = 0; i < 24; i++) {
        let hour = i.toString().padStart(2, '0');
        timeButtonsContainer.append(`<div class="time-slot" data-value="0" data-time="${i}:00">${i}:00</div>`);
        timeButtonsContainer.append(`<div class="time-slot" data-value="0" data-time="${i}:30">${i}:30</div>`);
    }

    
    
    let timeSlots = $('.time-slot');
    for (let i = 0; i < timeSlots.length; i++) {
        $(timeSlots[i]).click(function() {
            $(timeSlots[i]).toggleClass('selected');
        });
    }

    
    
    
    
    $('#submitBtn').click(function() {
        const selectedDate = $("#datepicker").val();
        
        if(selectedDate=='') {
        	alert('등록일을 먼저 선택해주세요')
        }else{
        	
        	

            let timeSlots = $('.time-slot'); 
            let result = '';

            for (let i = 0; i < timeSlots.length; i++) {
                if ($(timeSlots[i]).hasClass('selected')) {
                    result += '1';
                } else {
                    result += '0';
                }
            }


            $.ajax({
                type: 'POST',
                url: '/ex/vendor/scheduleinsert',
                data: {
                    date: selectedDate,
                    timeSlots: result
                },
                success: function(response) {
                	console.log(response)
                    alert("등록완료. '월별 스케줄 조회'로 이동합니다.");
                    //$('#submitBtn').prop('disabled', true);
                    window.location.href = '/ex/vendor/monthlyschedule';
                },
                error: function(xhr, status, error) {
                    alert('데이터 전송에 실패했습니다: ' + error);
                }
            });
        	
        	
        }
        	
    });
    

    
    
    $("#datepicker").change(function() {
    	 //alert($("#datepicker").val());
    })
    //사업자 id
    //사업자 번호
    //날짜
    //시간문자열
    //초기화된 예약가능여부
});

