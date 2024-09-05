package com.reservation.ex;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.reservation.dto.MainDto;
import com.reservation.dto.VendorDto;
import com.reservation.service.IMainService;
import com.reservation.service.IMapService;
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

	// 검색폼 처리 관련 메서드
	@RequestMapping(value = "/my/search", method = RequestMethod.GET)
	public String search(@RequestParam("query") String query, Model model) throws Exception {
		System.out.println("검색어는  " + query);
		// 검색 폼에서 입력받은 쿼리로 게시판 관련 db에서 검색키워드가 포함된 글들을 추출해냄
		ArrayList<VendorDto> results = mapService.selectPlace(query);
		// userService.selectSearch(query);와 같은 로직으로 db에 접속해 해당 쿼리를 포함한 글들을 추출
		// board 관련 기능이 완료됐을때 구현
		for (VendorDto dto : results) {
			System.out.println(dto.getBusiness_name());

		}

		model.addAttribute("results", results);
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

	// 공지사항 노출 폼
	@GetMapping("/ex/notices")
	public ArrayList<String> getNotices() {
		// 예시 공지사항 (실제 응용 프로그램에서는 데이터베이스에서 공지사항을 불러옴)
		ArrayList<String> notices = new ArrayList<>();
		notices.add("공지사항 1: 시스템 점검 안내");
		notices.add("공지사항 2: 신규 기능 업데이트");
		notices.add("공지사항 3: 서비스 이용 안내");

		return notices;
	}

	// 회원정보 노출 폼
	@GetMapping("/ex/userInfo")
	public Map<String, String> getUserInfo() {
		// 예시 사용자 정보 (실제 응용 프로그램에서는 사용자 정보를 데이터베이스에서 가져옴)
		Map<String, String> userInfo = new HashMap<>();
		userInfo.put("name", "홍길동");
		userInfo.put("email", "hong@example.com");
		userInfo.put("joinDate", "2023-01-01");

		return userInfo;
	}

	@GetMapping("/searchSuggestions")
	public ResponseEntity<List<String>> searchSuggestions(@RequestParam("query") String query) throws Exception {
		List<VendorDto> vendorDtos = service.selectPlace(query);

		List<String> businessNames = vendorDtos.stream().map(VendorDto::getBusiness_name).collect(Collectors.toList());

		return ResponseEntity.ok(businessNames);
	}
}
