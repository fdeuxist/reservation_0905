window.onload = function() {
            document.getElementById('postcodeBtn').addEventListener('click', openDaumPostcode);
        };

        
// 참고사이트 https://newehblog.tistory.com/25
        
        
var element_layer = document.getElementById('layer');

// 주소 검색 닫아주기
function closeDaumPostcode() {
    // iframe을 넣은 element를 안 보이게 한다.
    element_layer.style.display = 'none';
}

// 주소 검색 열어주기
function openDaumPostcode(userZipCode, userFirstAddr, userSecondAddr) {
    new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data); 
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById('basic_address').value = data.address;
            document.getElementById('detail_address').focus();
            element_layer.style.display = 'none';
        },
        width: '100%',
        height: '100%'
    }).embed(element_layer);
    element_layer.style.display = 'block';
    initLayerPosition();
}

// 팝업창 세부 설정
function initLayerPosition() {
    var width = 300; // 우편번호 서비스가 들어갈 element의 width
    var height = 460; // 우편번호 서비스가 들어갈 element의 height
    var borderWidth = 5; // 샘플에서 사용하는 border의 두께

    // 위에서 선언한 값들을 실제 element에 넣는다.
    element_layer.style.width = width + 20 + 'px';
    element_layer.style.height = height + 20 + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
}
