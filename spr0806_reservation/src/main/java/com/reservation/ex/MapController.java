package com.reservation.ex;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.PlaceDetailDto;
import com.reservation.dto.VendorAndImageListDto;
import com.reservation.dto.VendorDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IMapService;

// 만든이 김하겸
// 해당 컨트롤러는 카카오맵 api 관련 네비게이션 기능 처리에 관련된 컨트롤러이며 비동기 컨트롤러로 화면전환없이 데이터를 주고 받는 컨트롤러입니다.
@Controller
public class MapController {

	@Autowired
	private IMapService service;
	
	@Autowired
	private IBusinessPlaceImagePathService biService;
	@RequestMapping(value = "/map/mapService", method = RequestMethod.GET)
	public void mapService() {

	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@RequestParam("query") String keyword) {
		// 1. 먼저 입점업체들을 selectAll 한뒤 업체리스트에 담는다
		// 2. 이 키워드를 가지고 업체리스트와 대조해 키워드가 포함된 업체 이름들을 추출한다.
		// 3. 그 추출한 업체리스트를 다시 화면에 전달해 결과창에 나열한다.
		// 4. 업체 주소를 기반으로 좌표로 변환해 해당 좌표에 대한 마커를 찍는다.
		// 5. (될수있으면) 업체이름을 이용해 db에 접속해 업체 대표 사진을 마커위에 기재한다.
		return null;
	}

	// recontroller에 넣을경우 변환 가능
	// db에 업체관련 정보에 대한 접속 필요
	@GetMapping("/searchMarkers")
	@ResponseBody
	public VendorAndImageListDto getMarkers(@RequestParam(value = "query", required = false) String query) throws Exception {
	    if (query != null) {
	        query = query.trim(); // 앞뒤 공백 제거
	    }

	    ArrayList<VendorDto> vendorList = service.selectPlace(query);
	    ArrayList<BusinessPlaceImagePathDto> mainImageList = new ArrayList<>();

	    System.out.println("검색어 전달받음: " + query);

	    for (VendorDto vendor : vendorList) {
	        System.out.println(vendor.getBusiness_regi_num());
	        System.out.println(vendor.getBusiness_name());
	        System.out.println(vendor.getBasic_address());
	        BusinessPlaceImagePathDto mainImg = biService.selectMainImage(vendor.getEmail(), vendor.getBusiness_regi_num());
	        mainImageList.add(mainImg);
	    }

	    System.out.println("Type of markerList: " + mainImageList.getClass().getName());

	    // VendorAndImageListDto 객체 생성 및 반환
	    return new VendorAndImageListDto(vendorList, mainImageList);
	}

	
	


	// recontroller에 넣을경우 변환 가능
	@GetMapping("/getMarkers")
	@ResponseBody
	public List<Map<String, Object>> getMarkers() throws Exception {
		// 여기에 실제 데이터베이스에서 업체 정보를 가져오는 로직이 필요합니다.
		// 여기서는 예제 데이터로 대체합니다.
		List<Map<String, Object>> markerList = new ArrayList<>();

		Map<String, Object> marker1 = new HashMap<>();
		marker1.put("name", "Store A");
		marker1.put("lat", 37.4911);
		marker1.put("lng", 126.7221);
		markerList.add(marker1);
		System.out.println("maker1 추가");
		Map<String, Object> marker2 = new HashMap<>();
		marker2.put("name", "Store B");
		marker2.put("lat", 37.4922);
		marker2.put("lng", 126.7231);
		markerList.add(marker2);
		System.out.println("maker2 추가");
		return markerList;
	}

}
