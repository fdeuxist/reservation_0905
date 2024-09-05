// Initialize the map
function initializeMap(containerId, centerCoords, zoomLevel) {
    const mapContainer = document.getElementById(containerId);
    const mapOption = {
        center: new kakao.maps.LatLng(centerCoords.lat, centerCoords.lng),
        level: zoomLevel
    };
    return new kakao.maps.Map(mapContainer, mapOption);
}

// Create a Geocoder instance
function createGeocoder() {
    if (kakao && kakao.maps && kakao.maps.services) {
        return new kakao.maps.services.Geocoder();
    } else {
        console.error('Kakao Maps API is not loaded or Geocoder is unavailable');
        return null;
    }
}

// Create a marker on the map
function createMarker(map, position) {
    return new kakao.maps.Marker({
        position: new kakao.maps.LatLng(position.lat, position.lng),
        map: map
    });
}

// Create an InfoWindow with the provided content
function createInfoWindow(content) {
    return new kakao.maps.InfoWindow({
        content: content,
        removable: true
    });
}

// Add a marker from an address
function addMarkerFromAddress(map, geocoder, address, name, imageUrl, markers) {
    if (geocoder) {
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                markers.push(marker);

                const safeName = encodeHTML(name);
                const safeImageUrl = encodeHTML(imageUrl);

                const infowindowContent = `
                    <div style="padding:5px; font-size:12px;">
                        <div style="margin-bottom:5px;">
                            <strong>${safeName}</strong>
                        </div>
                        <hr style="border:1px solid #ddd; margin:5px 0;">
                        <div>
                            <img src="${safeImageUrl}" style="width:100px; height:auto; display:block;">
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

// Clear all markers from the map
function clearMarkers(markers) {
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers.length = 0; // Clear the array
}

// Encode HTML to prevent XSS
function encodeHTML(str) {
    return (str || '').replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// AJAX search functionality
function searchMarkers(query, successCallback, errorCallback) {
    $.ajax({
        url: '/ex/searchMarkers',
        method: 'GET',
        data: { query: query },
        dataType: 'json',
        success: successCallback,
        error: errorCallback
    });
}
