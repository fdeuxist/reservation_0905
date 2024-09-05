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

    $('.time-slot').click(function() {
        $(this).toggleClass('selected');
    });

    $('#submitBtn').click(function() {
        const selectedDate = $("#datepicker").val();

        let result = '';
        $('.time-slot').each(function() {
            if ($(this).hasClass('selected')) {
                result += '1';
            } else {
                result += '0';
            }
        });


        $.ajax({
            type: 'POST',
            url: '/ex/vendor/scheduleinsert',
            data: {
                date: selectedDate,
                timeSlots: result
            },
            success: function(response) {
            	console.log(response)
                alert('등록완료');
                $('#submitBtn').prop('disabled', true);
            },
            error: function(xhr, status, error) {
                alert('데이터 전송에 실패했습니다: ' + error);
            }
        });
    });
    

    $("#datepicker").click(function() {
    	// alert($(this).val());
    })
    //사업자 id
    //사업자 번호
    //날짜
    //시간문자열
    //초기화된 예약가능여부
});

