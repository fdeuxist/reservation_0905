// Ensure Kakao Maps API is fully loaded before executing code
kakao.maps.load(function() {
    // Initialize map and geocoder
    const map = initializeMap('map', { lat: 37.4911, lng: 126.7221 }, 3);
    const geocoder = createGeocoder();  // Create Geocoder instance
    const markers = [];


    // Add marker with info window for vendorInfo address on page load
    if (vendorInfo.address && geocoder) {
        addMarkerFromAddress(map, geocoder, vendorInfo.address, vendorInfo.businessName, vendorInfo.mainImg, markers);
    }
});
