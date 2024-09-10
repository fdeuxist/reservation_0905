document.addEventListener('DOMContentLoaded', function() {
    if (typeof kakao === 'undefined') {
        console.error('Kakao Maps API is not loaded.');
        return;
    }

    kakao.maps.load(function() {
        const map = initializeMap('map', { lat: 37.4911, lng: 126.7221 }, 3);
        const geocoder = createGeocoder();
        const markers = [];

        function performSearch() {
            const query = document.getElementById('searchInput').value.trim();

            if (query) {
                searchMarkers(query, function(data) {
                    if (Array.isArray(data)) {
                        clearMarkers(markers);
                        const searchResults = document.querySelector('.search-results');
                        searchResults.innerHTML = ''; // Clear previous results

                        data.forEach(function(markerData) {
                            // Ensure the image URL is valid and if not, use a default image
                            const imageUrl = markerData.place_img_path !== 'No image available'
                                ? markerData.place_img_path
                                : '/resources/imgs/noimage.jpg'; // Default image URL

                            addMarkerFromAddress(map, geocoder, markerData.basic_address, markerData.business_name, imageUrl, markers);

                            searchResults.innerHTML += `
                                <li class="search-result-item">
                                    <strong>${encodeHTML(markerData.business_name)}</strong><br>
                                    ${encodeHTML(markerData.basic_address)}<br> 
                                    <img src="..${encodeHTML(imageUrl)}" alt="${encodeHTML(markerData.business_name)}" style="width:100px; height:auto; margin-top:5px;">
                                    <button class="find-button" data-address="${encodeHTML(markerData.basic_address)}" data-name="${encodeHTML(markerData.business_name)}" data-image-url="${encodeHTML(imageUrl)}">위치보기</button>
                                </li>
                            `;
                        });
                        document.querySelectorAll('.find-button').forEach(button => {
                            button.style.display = 'block';
                        });
                    } else {
                        console.error('해당 검색어에 대한 업체가 존재하지 않습니다.');
                    }
                }, function(xhr, status, error) {
                    console.error('Error fetching markers:', status, error);
                });
            } else {
                alert('검색어를 입력해 주세요.');
            }
        }

        document.getElementById('searchButton').addEventListener('click', function() {
            performSearch();
        });

        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                performSearch();
            }
        });

        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('find-button')) {
                const address = event.target.dataset.address;
                const name = event.target.dataset.name;
                const imageUrl = event.target.dataset.imageUrl;

                geocoder.addressSearch(address, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        const coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                        map.setCenter(coords);
                        clearMarkers(markers);
                        const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                        markers.push(marker);

                        const infowindowContent = `
                            <div style="padding:5px; font-size:12px;">
                                <div style="margin-bottom:5px;">
                                    <strong>${encodeHTML(name)}</strong>
                                </div>
                                <hr style="border:1px solid #ddd; margin:5px 0;">
                                <div>
                                    <img src="..${encodeHTML(imageUrl)}" style="width:100px; height:auto; display:block;">
                                </div>
                            </div>
                        `;
                        const infowindow = createInfoWindow(infowindowContent);
                        infowindow.open(map, marker);
                    } else {
                        console.error('주소 변환 실패:', address);
                    }
                });
            }
        });

        function addMarkerFromAddress(map, geocoder, address, name, imageUrl, markers) {
            if (geocoder) {
                geocoder.addressSearch(address, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                        markers.push(marker);

                        const infowindowContent = `
                            <div style="padding:5px; font-size:12px;">
                                <div style="margin-bottom:5px;">
                                    <strong>${encodeHTML(name)}</strong>
                                </div>
                                <hr style="border:1px solid #ddd; margin:5px 0;">
                                <div>
                                    <img src="..${encodeHTML(imageUrl)}" style="width:100px; height:auto; display:block;">
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

        kakao.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
            const latlng = mouseEvent.latLng;
            const marker = createMarker(map, { lat: latlng.getLat(), lng: latlng.getLng() });
            markers.push(marker);

            kakao.maps.event.addListener(marker, 'click', function() {
                marker.setMap(null);
                markers = markers.filter(m => m !== marker);
            });
        });
    });
});
