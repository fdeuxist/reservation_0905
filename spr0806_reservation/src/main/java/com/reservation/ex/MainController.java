package com.reservation.ex;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Base64;
import org.apache.ibatis.executor.ReuseExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.MainDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.dto.VendorDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IMainService;
import com.reservation.service.IMapService;
import com.reservation.service.IServiceItemsService;
import com.reservation.service.IVendorService;

//created by 김하겸
//해당 컨트롤러는 메인페이지 뷰에서 오는 요청을 처리

@Controller
public class MainController {

	@Inject
	private IMainService userService;

	@Autowired
	private IMapService service;

	@Autowired
	private IMapService mapService;
	@Autowired
	private IBusinessPlaceImagePathService ibpService;
	
	@Autowired
	private IServiceItemsService itemService;
	
	@Autowired
	private IVendorService vendorService;
	// getMapping으로 변환 필요
	@RequestMapping(value = "/my/myPage", method = RequestMethod.GET)
	public void myPage() {

	}

	@RequestMapping(value = "/main/main", method = RequestMethod.GET)
	public void mainPage() {

	}

	// getMapping으로 변환 필요
	@RequestMapping(value = "/my/myUpdate", method = RequestMethod.GET)
	public void myUpdate(@RequestParam("userId") String userId, Model model) {

		model.addAttribute("userId", userId);
		System.out.println("마이 페이지로 이동합니다.");

	}

	// getMapping으로 변환 필요
	@RequestMapping(value = "/my/myCoupon", method = RequestMethod.GET)
	public void myCoupon(Model model) {

		// 유저테이블을 타고 보유쿠폰 테이블에가서 쿠폰목록 받아오기
		System.out.println("쿠폰 페이지로 이동합니다.");

	}

	// getMapping으로 변환 필요
	@RequestMapping(value = "/my/myCart", method = RequestMethod.GET)
	public void myCart(Model model) {

		// 유저테이블을 타고 보유쿠폰 테이블에가서 쿠폰목록 받아오기
		System.out.println("장바구니 페이지로 이동합니다.");

	}
	
	@GetMapping("/radio1")
	@ResponseBody
	public Map<String, Object> radio(@RequestParam("time") int time, Model model) throws Exception {
	    System.out.println("필터입력값은 :" + time);

	    ArrayList<ServiceItemsDto> dtos = itemService.selectItemByTime(time);
	    HashSet<String> uniqueRegiNums = new HashSet<>();
	    ArrayList<VendorDto> vendorList = new ArrayList<>();
	    ArrayList<String> encodedImages = new ArrayList<>();
	    
	    for (ServiceItemsDto dto : dtos) {
	        String businessRegiNum = dto.getBusiness_regi_num();
	        
	        if (uniqueRegiNums.add(businessRegiNum)) {
	            VendorDto vendor = new VendorDto(dto.getEmail(), businessRegiNum, null, null, null, null, null);
	            System.out.println("등록된 사업자 번호: " + vendor.getBusiness_regi_num());
	            VendorDto vendorDto = vendorService.selectBusiness_regi_num(vendor.getBusiness_regi_num());
	            vendorList.add(vendorDto);
	        } else {
	            System.out.println("중복된 사업자 번호: " + businessRegiNum + "는 건너뜀");
	        }
	    }
	    
	    for (VendorDto dto : vendorList) {
	        BusinessPlaceImagePathDto img = ibpService.selectMainImage(dto.getEmail(), dto.getBusiness_regi_num());
	        if (img != null && img.getFile_data() != null) {
	            String encodedImage = Base64.getEncoder().encodeToString(img.getFile_data());
	            encodedImages.add(encodedImage);
	        } else {
	            encodedImages.add(null); // 기본 이미지나 에러 이미지 처리
	        }
	    }
	    
	    // 응답 데이터로 Map 사용
	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("results", vendorList);
	    responseMap.put("encodedImages", encodedImages);
	    
	    return responseMap; // Map 반환
	}

	// 검색폼 처리 관련 메서드
	@RequestMapping(value = "/my/search", method = RequestMethod.GET)
	public String search(@RequestParam("query") String query, Model model) throws Exception {
	    System.out.println("검색어는  " + query);
	    
	    // 검색어에 해당하는 업체 목록을 가져옴
	    ArrayList<VendorDto> results = mapService.selectPlace(query);
	    ArrayList<String> encodedImages = new ArrayList<>(); // 인코딩된 이미지 리스트 초기화

	    // 각 업체의 메인 이미지를 가져와서 인코딩
	    for (VendorDto dto : results) {
	        BusinessPlaceImagePathDto img = ibpService.selectMainImage(dto.getEmail(), dto.getBusiness_regi_num());
	        if (img != null && img.getFile_data() != null) {
	            // 이진 데이터를 Base64로 인코딩
	            String encodedImage = Base64.getEncoder().encodeToString(img.getFile_data());
	            System.out.println(encodedImage);
	            encodedImages.add(encodedImage);
	        } else {
	            // 기본 이미지나 에러 이미지 처리
	            encodedImages.add(null);
	        }
	    }
	    for(String dto:encodedImages) {
	    	System.out.println(dto);
	    }
	    for (VendorDto dto : results) {
	        System.out.println(dto.getBusiness_name());
	    }
	    
	    model.addAttribute("query", query);
	    model.addAttribute("results", results);
	    model.addAttribute("encodedImages", encodedImages); // 인코딩된 이미지 리스트 추가
	    
	    return "/main/search";
	}

	@GetMapping("/miniSearch")
	@ResponseBody
	public ArrayList<VendorDto> miniSearch(@RequestParam("query") String query) throws Exception {
		System.out.println("미니서치 쿼리값 :" + query);
		ArrayList<VendorDto> dtos = mapService.selectPlace(query);
		for (VendorDto dto : dtos) {
			System.out.println("키워드 검색 결과 리스트" + dto.getBusiness_name());
		}
		return dtos;
	}

	@GetMapping("/keyWord")
	@ResponseBody
	public ArrayList<VendorDto> resultKeword(@RequestParam("query") String query) throws Exception {
		System.out.println("쿼리값 :" + query);
		ArrayList<VendorDto> dtos = mapService.selectPlace(query);
		for (VendorDto dto : dtos) {
			System.out.println("키워드 검색 결과 리스트" + dto.getBusiness_name());
		}
		return dtos;
	}

	

	@GetMapping("/searchSuggestions")
	public ResponseEntity<List<String>> searchSuggestions(@RequestParam("query") String query) throws Exception {
		List<VendorDto> vendorDtos = service.selectPlace(query);

		List<String> businessNames = vendorDtos.stream().map(VendorDto::getBusiness_name).collect(Collectors.toList());

		return ResponseEntity.ok(businessNames);
	}
}
