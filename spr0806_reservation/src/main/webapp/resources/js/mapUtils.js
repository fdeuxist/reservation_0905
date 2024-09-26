function initializeMap(containerId, centerCoords, zoomLevel) {
    const mapContainer = document.getElementById(containerId);
    const mapOption = {
        center: new kakao.maps.LatLng(centerCoords.lat, centerCoords.lng),
        level: zoomLevel
    };
    return new kakao.maps.Map(mapContainer, mapOption);
}

function createGeocoder() {
    if (kakao && kakao.maps && kakao.maps.services) {
        return new kakao.maps.services.Geocoder();
    } else {
        console.error('Kakao Maps API is not loaded or Geocoder is unavailable');
        return null;
    }
}

function createMarker(map, position) {
    return new kakao.maps.Marker({
        position: new kakao.maps.LatLng(position.lat, position.lng),
        map: map
    });
}

function createInfoWindow(content) {
    return new kakao.maps.InfoWindow({
        content: content,
        removable: true
    });
}

function addMarkerFromAddress(map, geocoder, address, name, imageUrl, markers,detail,phone) {
    if (geocoder) {
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                markers.push(marker);

                // Base64 이미지와 경로 이미지를 구분
                let imgSrc;
                if (imageUrl && imageUrl.startsWith('data:image/')) {
                    // Base64 인코딩된 이미지 그대로 사용
                    imgSrc = imageUrl;
                } else if (imageUrl) {
                    // 경로 이미지에만 경로 추가
                    imgSrc = `../resources/imgs/${encodeHTML(imageUrl)}`;
                } else {
                    // 이미지가 없을 때 기본 이미지 설정
                    imgSrc = "../resources/imgs/noimage.jpg";
                }

                const infowindowContent = `
                    <div style="padding:5px; font-size:12px; max-width:150px;">
                        <div style="margin-bottom:5px;">
                            <strong>${encodeHTML(name)}</strong>
                        </div>
                        
                        <p class="card-text">
                            <i class="fa-solid fa-phone"></i> ${encodeHTML(phone)}<br>
                            <i class="fa-solid fa-map-location-dot"></i> ${encodeHTML(address)}${encodeHTML(detail)}<br>
                        </p>
                        <hr style="border:1px solid #ddd; margin:5px 0;">
                        <div>
                            <img src="${base64Image}" style="width:100px; height:auto; display:block;">
                        </div>
                    </div>
                `;
                const infowindow = createInfoWindow(infowindowContent);

                kakao.maps.event.addListener(marker, 'mouseover', function() {
                    infowindow.open(map, marker);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                });

                map.setCenter(coords);
            } else {
                console.error('주소 변환 실패:', address);
            }
        });
    } else {
        console.error('Geocoder instance is not available');
    }
}




function clearMarkers(markers) {
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers.length = 0; // Clear the array
}

function encodeHTML(str) {
    return (str || '').replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

function searchMarkers(query, successCallback, errorCallback) {
    $.ajax({
        url: '/ex/searchMarkers',
        method: 'GET',
        data: { query: query },
        dataType: 'json',
        success: successCallback,
        error: function(xhr, status, error) {
            console.error('Error fetching markers:', status, error);
            if (errorCallback) errorCallback(xhr, status, error);
        }
    });
}