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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.MainDto;
import com.reservation.dto.ResultReviewsJoinDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.dto.VendorDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IMainService;
import com.reservation.service.IMapService;
import com.reservation.service.ISearchPlaceService;
import com.reservation.service.IServiceItemsService;
import com.reservation.service.IVendorService;
import java.util.*;
import java.util.stream.Collectors;

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
	private ISearchPlaceService reviewService;

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

	@GetMapping("/setPrice")
	@ResponseBody
	public Map<String, Object> setPrice(@RequestParam("minPrice") double minPrice,
	        @RequestParam("maxPrice") double maxPrice, Model model) throws Exception {
	    System.out.println("필터 가격설정값은 " + minPrice + " ~ " + maxPrice);

	    // ServiceItemsDto에서 중복된 업장의 최저가를 저장하기 위한 Map (key: Business_regi_num, value: ServiceItemsDto)
	    Map<String, ServiceItemsDto> lowestPriceMap = new HashMap<>();
	    ArrayList<ServiceItemsDto> dtos = itemService.selectAll();
	    
	    // 중복 업장의 최저가와 메뉴 이름 저장
	    for (ServiceItemsDto dto : dtos) {
	        if (dto.getService_price() >= minPrice && dto.getService_price() <= maxPrice) {
	            String busNum = dto.getBusiness_regi_num();
	            
	            // 해당 업장이 이미 Map에 저장되어 있는지 확인
	            if (lowestPriceMap.containsKey(busNum)) {
	                // 저장된 값과 현재 가격 비교, 더 낮은 가격으로 갱신
	                if (dto.getService_price() < lowestPriceMap.get(busNum).getService_price()) {
	                    lowestPriceMap.put(busNum, dto);
	                }
	            } else {
	                // 처음 들어온 업장은 Map에 저장
	                lowestPriceMap.put(busNum, dto);
	            }
	        }
	    }

	    // 최종적으로 추출된 VendorDto와 이미지 목록, 최저가와 메뉴 이름을 위한 리스트
	    ArrayList<VendorDto> vendorList = new ArrayList<>();
	    ArrayList<String> encodedImages = new ArrayList<>();
	    ArrayList<Integer> lowestPrices = new ArrayList<>();
	    ArrayList<String> menuNames = new ArrayList<>();

	    // 중복 제거 및 최저가 추출 후, 해당 업장의 정보를 vendorList에 추가
	    for (ServiceItemsDto lowestDto : lowestPriceMap.values()) {
	        VendorDto vendorDto = vendorService.selectBusiness_regi_num(lowestDto.getBusiness_regi_num());
	        if (vendorDto != null) {
	            vendorList.add(vendorDto);
	            
	            // 최저가와 메뉴 이름 저장
	            lowestPrices.add(lowestDto.getService_price());
	            menuNames.add(lowestDto.getService_name());

	            // 이미지 처리
	            BusinessPlaceImagePathDto img = ibpService.selectMainImage(vendorDto.getEmail(), vendorDto.getBusiness_regi_num());
	            if (img != null && img.getFile_data() != null) {
	                String encodedImage = Base64.getEncoder().encodeToString(img.getFile_data());
	                encodedImages.add(encodedImage);
	            } else {
	                encodedImages.add(null); // 기본 이미지나 에러 이미지 처리
	            }
	        }
	    }

	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("results", vendorList);
	    responseMap.put("encodedImages", encodedImages);
	    responseMap.put("lowestPrices", lowestPrices);
	    responseMap.put("menuNames", menuNames);

	    System.out.println("컨트롤러 작업 완료");
	    return responseMap;

	}


	// 검색폼 처리 관련 메서드
	@CrossOrigin(origins = "http://localhost:3000")
	@RequestMapping(value = "/my/search", method = RequestMethod.GET)
	public String search(@RequestParam("query") String query, Model model) throws Exception {
	    System.out.println("검색어는  " + query);
	    // 검색어에 해당하는 업체 목록을 가져옴
	    ArrayList<VendorDto> results = mapService.selectPlace(query);
	    ArrayList<String> encodedImages = new ArrayList<>(); // 인코딩된 이미지 리스트 초기화
	    ArrayList<ResultReviewsJoinDto> starDto = reviewService.joinReviewsAndVendor();
	    Map<String, List<ResultReviewsJoinDto>> groupedByBusiness = new HashMap<>();
	    
	    for (ResultReviewsJoinDto dto : starDto) {
	        String businessRegiNum = dto.getBusiness_regi_num(); // business_regi_num 추출

	        // 그룹화된 Map에 business_regi_num이 없으면 새로운 리스트 추가
	        groupedByBusiness.computeIfAbsent(businessRegiNum, k -> new ArrayList<>()).add(dto);
	    }		

	    List<ResultReviewsJoinDto> uniqueBusinessList = new ArrayList<>();
	    for (Map.Entry<String, List<ResultReviewsJoinDto>> entry : groupedByBusiness.entrySet()) {
	        String businessRegiNum = entry.getKey();
	        List<ResultReviewsJoinDto> reviews = entry.getValue();

	        // star_point 값의 합계와 평균 계산
	        double totalStarPoints = 0;
	        for (ResultReviewsJoinDto review : reviews) {
	            totalStarPoints += review.getStar_point(); // star_point 값 더하기
	        }

	        // 평균 계산
	        double averageStarPoint = totalStarPoints / reviews.size();

	        // 전화번호와 상세 주소 가져오기 (첫 번째 리뷰에서 가져옴)
	        String vendorPhone = reviews.get(0).getVendor_phone();
	        String detailAddress = reviews.get(0).getDetail_address();
	        int reviewCount = reviews.size();

	        // 새로운 Dto 생성 후 평균 별점, 전화번호, 상세 주소 설정
	        ResultReviewsJoinDto averagedDto = new ResultReviewsJoinDto();
	        averagedDto.setBusiness_regi_num(businessRegiNum);
	        averagedDto.setAveragePoint(averageStarPoint);
	        averagedDto.setVendor_phone(vendorPhone); // 전화번호 설정
	        averagedDto.setDetail_address(detailAddress); // 상세 주소 설정
	        averagedDto.setReviewCount(reviewCount);

	        // 중복되지 않도록 uniqueBusinessList에 추가
	        uniqueBusinessList.add(averagedDto);
	    }

	    // 결과 출력 (확인용)
	    for (ResultReviewsJoinDto dto : uniqueBusinessList) {
	        System.out.println("Business_regi_num: " + dto.getBusiness_regi_num() + ", 평균 별점: " + dto.getAveragePoint()
	                + ", 전화번호: " + dto.getVendor_phone() + ", 상세 주소: " + dto.getDetail_address());
	    }

	    // 각 업체의 메인 이미지를 가져와서 인코딩
	    for (VendorDto dto : results) {
	        BusinessPlaceImagePathDto img = ibpService.selectMainImage(dto.getEmail(), dto.getBusiness_regi_num());
	        if (img != null && img.getFile_data() != null) {
	            // 이진 데이터를 Base64로 인코딩
	            String encodedImage = Base64.getEncoder().encodeToString(img.getFile_data());
	            //System.out.println(encodedImage);
	            encodedImages.add(encodedImage);
	        } else {
	            // 기본 이미지나 에러 이미지 처리
	            encodedImages.add(null);
	        }
	    }

	    model.addAttribute("dtos", uniqueBusinessList);
	    model.addAttribute("star", starDto);
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

	@GetMapping("/sort")
	@ResponseBody
	public List<ResultReviewsJoinDto> sortVendors(@RequestParam("sortOption") String sortOption) throws Exception {
	    // 리뷰와 업체 정보를 가져옵니다.
	    List<ResultReviewsJoinDto> starDto = reviewService.joinReviewsAndVendor();
	    Map<String, List<ResultReviewsJoinDto>> groupedByBusiness = new HashMap<>();

	    // business_regi_num으로 리뷰를 그룹화합니다.
	    for (ResultReviewsJoinDto dto : starDto) {
	        String businessRegiNum = dto.getBusiness_regi_num(); // business_regi_num 추출
	        groupedByBusiness.computeIfAbsent(businessRegiNum, k -> new ArrayList<>()).add(dto);
	    }

	    List<ResultReviewsJoinDto> uniqueBusinessList = new ArrayList<>();
	    for (Map.Entry<String, List<ResultReviewsJoinDto>> entry : groupedByBusiness.entrySet()) {
	        String businessRegiNum = entry.getKey();
	        List<ResultReviewsJoinDto> reviews = entry.getValue();

	        // star_point 값의 합계와 평균 계산
	        double totalStarPoints = reviews.stream().mapToDouble(ResultReviewsJoinDto::getStar_point).sum();
	        double averageStarPoint = totalStarPoints / reviews.size();

	        // 전화번호, 상세 주소 및 기타 정보 가져오기 (첫 번째 리뷰에서 가져옴)
	        String vendorPhone = reviews.get(0).getVendor_phone();
	        String detailAddress = reviews.get(0).getDetail_address();
	        String vendorEmail = reviews.get(0).getVendor_email();
	        String basic_address = reviews.get(0).getBasic_address();
	        String business_name = reviews.get(0).getBusiness_name();
	        int reviewCount = reviews.size();

	        // 새로운 Dto 생성 후 평균 별점, 전화번호, 상세 주소 설정
	        ResultReviewsJoinDto averagedDto = new ResultReviewsJoinDto();
	        averagedDto.setBusiness_regi_num(businessRegiNum);
	        averagedDto.setAveragePoint(averageStarPoint);
	        averagedDto.setVendor_phone(vendorPhone); // 전화번호 설정
	        averagedDto.setDetail_address(detailAddress); // 상세 주소 설정
	        averagedDto.setReviewCount(reviewCount);
	        averagedDto.setVendor_email(vendorEmail);
	        System.out.println(vendorEmail);
	        averagedDto.setBasic_address(basic_address);
	        averagedDto.setBusiness_name(business_name);

	        // 업체의 메인 이미지를 가져와서 인코딩 후 averagedDto에 추가
	        BusinessPlaceImagePathDto img = ibpService.selectMainImage(vendorEmail, businessRegiNum);
	        if (img != null && img.getFile_data() != null) {
	            // 이진 데이터를 Base64로 인코딩
	            String encodedImage = Base64.getEncoder().encodeToString(img.getFile_data());
	            averagedDto.setEncodedImage(encodedImage); // 인코딩된 이미지를 averagedDto에 추가
	        } else {
	            // 기본 이미지나 에러 이미지 처리
	            averagedDto.setEncodedImage(null);
	        }

	        // 중복되지 않도록 uniqueBusinessList에 추가
	        uniqueBusinessList.add(averagedDto);
	    }

	    // 정렬 로직 처리
	    switch (sortOption) {
	        case "reviewCount":
	            uniqueBusinessList.sort(Comparator.comparingInt(ResultReviewsJoinDto::getReviewCount).reversed());
	            break;
	        case "highRating":
	            uniqueBusinessList.sort(Comparator.comparingDouble(ResultReviewsJoinDto::getAveragePoint).reversed());
	            break;
	        case "lowRating":
	            uniqueBusinessList.sort(Comparator.comparingDouble(ResultReviewsJoinDto::getAveragePoint));
	            break;
	        case "lowPrice":
	            // uniqueBusinessList.sort(Comparator.comparingDouble(ResultReviewsJoinDto::getLowestPrice)); // getLowestPrice 메서드가 필요함
	            break;
	        case "highPrice":
	            // uniqueBusinessList.sort(Comparator.comparingDouble(ResultReviewsJoinDto::getLowestPrice).reversed()); // getLowestPrice 메서드가 필요함
	            break;
	        default:
	            break; // 기본 처리
	    }

	    // 결과 출력 (확인용)
	    for (ResultReviewsJoinDto dto : uniqueBusinessList) {
	        System.out.println("Business_regi_num: " + dto.getBusiness_regi_num() + 
	                           ", 평균 별점: " + dto.getAveragePoint() +
	                           ", 전화번호: " + dto.getVendor_phone() + 
	                           ", 상세 주소: " + dto.getDetail_address() +
	                           ", 인코딩된 이미지: " + dto.getEncodedImage());
	    }

	    // 정렬된 리스트를 JSON 형태로 반환
	    return uniqueBusinessList; 
	}
	@GetMapping("/searchSuggestions")
	public ResponseEntity<List<String>> searchSuggestions(@RequestParam("query") String query) throws Exception {
		List<VendorDto> vendorDtos = service.selectPlace(query);

		List<String> businessNames = vendorDtos.stream().map(VendorDto::getBusiness_name).collect(Collectors.toList());

		return ResponseEntity.ok(businessNames);
	}
	
	

}
