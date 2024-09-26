$(function() {
	var totalRequiredTime = 0;
	var totalServicePrices = 0;
    var selectedItemIdsAry = [];
    var chks = document.getElementsByClassName('item_idChkBox');
    var cards = document.getElementsByClassName('serviceItem-card');
    var nextBtn = document.getElementById('nextBtn');
    var data;
    
    nextBtn.disabled = totalRequiredTime <= 0;
    
    for(let i=0;i<chks.length;i++){
    	chks[i].addEventListener('click', () => {
    		var itemid = cards[i].dataset.serviceitemid; 
    		var time = parseInt(cards[i].dataset.requiredtime);
    		var prices = parseInt(cards[i].dataset.serviceprice);
    		var servicename = cards[i].dataset.servicename; 
    		var servicedescription =  cards[i].dataset.servicedescription;
    		var cardObj = {
    				itemid:itemid,
    				servicename:servicename,
    				servicedescription:servicedescription,
    				time:time,
    				prices:prices
    		}
    		console.log("cardObj : ",cardObj)
            //alert(value)
            if (chks[i].checked) {
            	totalRequiredTime += time;
            	totalServicePrices += prices;
            	//selectedItemIdsAry.push(chks[i].value);
            	selectedItemIdsAry.push(cardObj);
            } else {
            	totalRequiredTime -= time;
            	totalServicePrices -= prices;
            	//selectedItemIdsAry = selectedItemIdsAry.filter(id => id !== chks[i].value);
                selectedItemIdsAry = selectedItemIdsAry.filter(id => id.itemid !== cardObj.itemid);
            }
            
            if(totalRequiredTime>0){
            	nextBtn.disabled = false;  //nextBtn버튼보이기
            }else if(totalRequiredTime<=0){
            	nextBtn.disabled = true;  //nextBtn버튼숨기기
            }
            
            //nextBtn.disabled = totalRequiredTime <= 0;
            //var email = document.getElementById('placeEmail').innerText;
            //var businessRegiNum = document.getElementById('placeRegiNum').innerText;
            var email = $('#placeEmail').val();
            var businessRegiNum = $('#placeRegiNum').val();
            //let openDate = $("#datepicker").val();
            data = {	//SelectedItemsDto
                    email: email,
                    business_regi_num: businessRegiNum,
                    totalRequiredTime: totalRequiredTime,
                    totalServicePrice: totalServicePrices,
                    selectedItems: selectedItemIdsAry	//cardObjDto
                };
            console.log("data : " ,  data);
            //console.log("data : email: " + data.email + " reginum : " + data.business_regi_num + " req time: " + data.required_time + " price : " + data.service_price + " selected times : " + data.selected_items);
            //console.log('현재 총 시간 단위: ' + totalRequiredTime + ' 가격 : ' + totalServicePrices + ' ids : ' + selectedItemIdsAry);
    	})
    }

    $("#nextBtn").click(function() {
        console.log("data : " , data);

        $.ajax({
            url: '/ex/memberrest/mmonthlyschedule',	//이동페이지로
            method: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            success: function(response) {
                if (response.redirectUrl) {
                	console.log(response);
                    window.location.href = response.redirectUrl;
                }
            },
            error: function(xhr, status, error) {
                console.error('Failed to fetch data:', error);
            }
        });
    });

    //////////////////////////////////////////////////////////////////////
    
});



