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

                            const phone = markerData.phone; // Phone number from markerData
                            addMarkerFromAddress(map, geocoder, markerData.basic_address, markerData.business_name, imageUrl, markers, markerData.detail, phone);

                            const searchResultItem = document.createElement('li');
                            searchResultItem.className = 'search-result-item';
                            searchResultItem.setAttribute('data-email', encodeHTML(markerData.email));
                            searchResultItem.setAttribute('data-business-num', encodeHTML(markerData.business_num));
                            searchResultItem.setAttribute('data-address', encodeHTML(markerData.basic_address));
                            searchResultItem.setAttribute('data-name', encodeHTML(markerData.business_name));
                            searchResultItem.setAttribute('data-image-url', encodeHTML(markerData.place_img_path));
                            searchResultItem.setAttribute('data-phone', encodeHTML(markerData.phone));
                            searchResultItem.innerHTML = `
                                <strong>${encodeHTML(markerData.business_name)}</strong><br>
                                <i class="fa-solid fa-map-location-dot"></i> ${encodeHTML(markerData.basic_address)}<br>
                                <i class="fa-solid fa-phone"></i> ${encodeHTML(markerData.phone)}<br>
                                <img src="${encodeHTML(markerData.place_img_path)}" alt="${encodeHTML(markerData.business_name)}" style="width:100px; height:auto; margin-top:5px;">
                                <button class="find-button" 
                                        data-address="${encodeHTML(markerData.basic_address)}" 
                                        data-name="${encodeHTML(markerData.business_name)}" 
                                        data-image-url="${encodeHTML(markerData.place_img_path)}" 
                                        data-phone="${encodeHTML(markerData.phone)}">지도에서 보기</button>
                            `;

                            // 버튼 클릭 이벤트 리스너 추가
                            const button = searchResultItem.querySelector('.find-button'); // 버튼을 querySelector로 가져옴
                            button.addEventListener('click', function(event) {
                                event.stopPropagation(); // 클릭 이벤트 전파 방지
                                const address = searchResultItem.dataset.address;
                                const name = searchResultItem.dataset.name;
                                const base64Image = searchResultItem.dataset.imageUrl;
                                const phone = searchResultItem.dataset.phone;

                                geocoder.addressSearch(address, function(result, status) {
                                    if (status === kakao.maps.services.Status.OK) {
                                        const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                                        map.setCenter(coords);
                                        clearMarkers(markers);
                                        const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                                        markers.push(marker);

                                        //const infowindowContent = `
                                        //    <div style="padding:5px; font-size:12px; max-width:150px;">
                                        //        <strong>${encodeHTML(name)}</strong><br>
                                        //        <i class="fa-solid fa-phone"></i> ${encodeHTML(phone)}<br>
                                        //        <i class="fa-solid fa-map-location-dot"></i> ${encodeHTML(address)}<br>
                                        //        <img src="${base64Image}" style="width:100px; height:auto; display:block;">
                                        //    </div>
                                        //`;//★★★★★★★★★★★★★★★★★★★
                                        
                                        const infowindowContent = `
                                        <div style="padding:5px; font-size:12px; max-width:150px;">
                                        <strong>${encodeHTML(name)}</strong><br>
                                        <i class="fa-solid fa-phone"></i> ${encodeHTML(phone)}<br>
                                        <i class="fa-solid fa-map-location-dot"></i> ${encodeHTML(address)}<br>
                                        <div class="d-flex justify-content-center">
                                            <img src="${base64Image}" style="width:100px; height:auto; display:block;">
                                        </div>
                                    </div>`;

                                        
                                        

                                        const infowindow = createInfoWindow(infowindowContent);
                                        infowindow.open(map, marker);
                                    } else {
                                        console.error('주소 변환 실패:', address);
                                    }
                                });
                            });

                            // 버튼을 searchResultItem에 추가
                            searchResultItem.appendChild(button);

                            // 검색 결과 컨테이너에 추가
                            searchResults.appendChild(searchResultItem);
                        });
                    }
                });
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


        function addMarkerFromAddress(map, geocoder, address, name, base64Image, markers, detail, phone) {
            if (geocoder) {
                geocoder.addressSearch(address, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        const marker = createMarker(map, { lat: result[0].y, lng: result[0].x });
                        markers.push(marker);

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
