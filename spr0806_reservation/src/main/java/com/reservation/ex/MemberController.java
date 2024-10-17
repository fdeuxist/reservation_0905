package com.reservation.ex;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.SearchPlaceDto;
import com.reservation.dto.SelectedItemsDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.dto.UserDto;
import com.reservation.dto.UserReservationDto;
import com.reservation.dto.VendorDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.dto.VendorUserDto;
import com.reservation.dto.cardObjDto;
import com.reservation.service.IBusinessPlaceImagePathService;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.ISearchPlaceService;
import com.reservation.service.IServiceItemsService;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;
import com.reservation.service.IVendorUserService;


@Controller
public class MemberController {

	@Autowired
	private ServletContext servletContext;
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Autowired
	private IUserService uService;
	
	@Autowired
	private IVendorService vService;
	
	@Autowired
	private IBusinessPlaceInfoService bPIService;
	
	@Autowired
	private IBusinessPlaceImagePathService bPIPService;
	
	@Autowired
	private IServiceItemsService sIService;

	@Autowired
	private IVendorUserService vUService;
	
    @Autowired
    private IUserReservationService uRService;

	@Autowired
	private IVendorReservationService vRService;

	@Autowired
	private ISearchPlaceService sPService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping(value = "/member/member", method = RequestMethod.GET)
	public String member(HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/member");
		//LoginRedirectHandler.java
		String email = (String)session.getAttribute("loginEmail");
		if(session.getAttribute("loginName")==null) {
			UserDto dto = uService.selectEmail(email);
			session.setAttribute("loginName", dto.getName());
			session.setAttribute("loginPhone", dto.getPhone());
			//위 2가지는 header.jsp에 숨겨져있어서 필요시 id로 접근가능
			//<input type="hidden" id="loginEmail" value="${sessionScope.loginEmail}">
			//<input type="hidden" id="loginName" value="${sessionScope.loginName}">
			//<input type="hidden" id="loginPhone" value="${sessionScope.loginPhone}">
			
		}
		
		return "/member/member";
	}
	
//0822
	@RequestMapping(value = "/member/update", method = RequestMethod.GET)
	public String memberUpdate(HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/update(get)");
		//select,set
		UserDto dto = uService.selectEmail((String)session.getAttribute("loginEmail"));
		model.addAttribute("userDto", dto);
		System.out.println(dto);
		return "/member/update";
	}
//0822
	@RequestMapping(value = "/member/update", method = RequestMethod.POST)
	public String memberUpdateDB(UserDto dto, HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/update(post)");
		String encPassword = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(encPassword);
		uService.update(dto);
		System.out.println(dto);
		return "redirect:/user/login?update";
	}
//0903
		@RequestMapping(value = "/member/delete", method = RequestMethod.POST)
		public String memberDelete(UserDto dto, HttpSession session, Model model) throws Exception {
			System.out.println("MemberController - /member/delete  " + dto);
			
			//uService.delete(dto.getEmail());
			
			uService.disableAccount(dto.getEmail());
			session.invalidate();
			return "redirect:/user/login?delete";
		}
//0829
	@RequestMapping(value = "/member/memberReservation", method = RequestMethod.POST)
	public String memberReservation(UserReservationDto dto, HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/memberReservation(post)");
		System.out.println(dto);
		VendorUserDto vUDto = vUService.selectOneVendorEmailBusinessRegiNum(dto.getVendor_email(),dto.getBusiness_regi_num());
		dto.setVendor_name(vUDto.getName());
		dto.setVendor_phone(vUDto.getPhone());
		dto.setBusiness_name(vUDto.getBusiness_name());
		dto.setZipcode(vUDto.getZipcode());
		dto.setBasic_address(vUDto.getBasic_address());
		dto.setDetail_address(vUDto.getDetail_address());
		model.addAttribute("dto", dto);
		System.out.println("model added dto : " + dto);
		return "/member/mreservationconfirm";
	}

//0831 0906수정중에러처리 0907예약 중 타멤버 선약 품절처리
	@RequestMapping(value = "/member/reservationComplete", method = RequestMethod.POST)
	public String reservationComplete(UserReservationDto dto, HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/reservationComplete(post) " + dto.getReservation_number());
		System.out.println("my" +dto.getTimes()); //000000000000000000000000000000000000010000000000
		VendorReservationDto isOpenDay = vRService.selectOneVendorsReservation(
				dto.getVendor_email(),
				dto.getBusiness_regi_num(),
				dto.getReservation_use_date());
		VendorReservationDto isPossible = null;
		if(isOpenDay!=null) {	//null이면 vendor가 스케줄 해당일을 비공개로 해둔상태
			System.out.println("ur" +isOpenDay.getTimes());
			String vendorTime = isOpenDay.getTimes();
			String selectTime = dto.getTimes();
	        int position = selectTime.indexOf('1');
	        char[] timeChars = vendorTime.toCharArray();
	        if(timeChars[position] != '1') {
	        	isOpenDay=null;
	        }else {
	        	isPossible = isOpenDay;
	        }
		}
		if(isPossible!=null) {
			uRService.newOrder(dto);
			model.addAttribute("dto", dto);
			model.addAttribute("result","예약이 완료되었습니다!");
		}else {
			model.addAttribute("dto", null);
			model.addAttribute("result","예약 과정에 문제가 생겼습니다 다시 시도해주세요.");
		}
		
		return "/member/reservationComplete";
	}

//0902
	//크로스 도메인 설정 
	@CrossOrigin(origins = "http://localhost:3000")
	@RequestMapping(value = "/member/mypage", method = RequestMethod.GET)
	public String myPage(UserReservationDto dto, HttpSession session, Model model) throws Exception {
		System.out.println("MemberController - /member/mypage");

		String email = (String)session.getAttribute("loginEmail");
		if(session.getAttribute("loginName")==null) {
			UserDto userDto = uService.selectEmail(email);
			session.setAttribute("loginName", userDto.getName());
			session.setAttribute("loginPhone", userDto.getPhone());
		}
		
		return "/member/mypage";
	}
	
//0902    
	@CrossOrigin(origins = "http://localhost:3000")
    @RequestMapping(value = "/member/myorders", method = RequestMethod.GET)
    public String myorders(HttpSession session, Model model) throws Exception {
        logger.info("MemberController - /member/myorders");
        ArrayList<UserReservationDto> myOrderList = 
                uRService.selectAllMyOrders(
                        (String)session.getAttribute("loginEmail"));
        model.addAttribute("myOrderList", myOrderList);
        return "/member/myorders";
    }
    
//0902    
    @RequestMapping(value = "/member/orderinfo", method = RequestMethod.GET)
    public String orderinfo(String reservationNumber, HttpSession session, Model model) throws Exception {
        logger.info("MemberController - /member/orderinfo");
        UserReservationDto myOrder = 
                 uRService.selectOneMyOrder(reservationNumber);
        logger.info("UserReservationDto : " + myOrder);
        model.addAttribute("myOrder", myOrder);
        return "/member/orderinfo";
    }
	
    @RequestMapping(value = "/member/reviewsWrite", method = RequestMethod.GET)
    public String reviewsWrite(String reservationNumber, HttpSession session, Model model) throws Exception {
        logger.info("MemberController - /member/reviewsWrite");
        model.addAttribute("reservationNumber", reservationNumber);
        //model.addAttribute("reservationNumber", reservationNumber);
        return "/member/reviewsWrite";
    }
    
    
	@RequestMapping(value = "/member/searchplace", method = RequestMethod.GET)
    public String searchplace(Model model, HttpSession session) throws Exception {
        logger.info("MemberController - /member/searchplace");
        
        // 세션에서 검색 결과를 가져옴
        List<VendorDto> vendorList = (List<VendorDto>) session.getAttribute("vendorList");
        
        // 검색 결과를 모델에 추가
        if (vendorList != null) {
            model.addAttribute("vendorList", vendorList);
            //session.removeAttribute("vendorList"); // 검색 결과 사용 후 세션에서 제거
        }
        //System.out.println("aaaaaaaaaaa   " + vendorList);
        
        return "member/searchplace";
    }
	
	@RequestMapping(value = "/member/searchplacebt", method = RequestMethod.POST)
    public String searchplaceDB1(@RequestParam("business_type") String businessType, Model model, HttpSession session) throws Exception {
        logger.info("MemberController - /member/searchplacebtype   business_type " + businessType);
        List<VendorDto> vendorList = vService.selectAllVendorByBusinessType(businessType);
        session.setAttribute("vendorList", vendorList);	//검색결과를 세션에 저장해두고
        return "redirect:searchplace";					//리다이렉트로 이동해야 뒤로가기 해도 문제가 없음
        
//        model.addAttribute("vendorList", vendorList);
//        return "member/searchplace";
    }
    
    @RequestMapping(value = "/member/searchplaceba", method = RequestMethod.POST)
    public String searchplaceDB2(@RequestParam("basic_address") String basicAddress, Model model, HttpSession session) throws Exception {
        logger.info("MemberController - /member/searchplacebaddr   basicAddress " + basicAddress);
        List<VendorDto> vendorList = vService.selectAllVendorByBasicAddress(basicAddress);
        session.setAttribute("vendorList", vendorList);	//검색결과를 세션에 저장해두고
        return "redirect:searchplace";					//리다이렉트로 이동해야 뒤로가기 해도 문제가 없음
    }
    

    @RequestMapping(value = "/member/searchp", method = RequestMethod.GET)
    public String searchplace(
            @RequestParam("searchBy") String searchBy,
            @RequestParam("searchKeyword") String searchKeyword, 
            Model model, 
            HttpSession session) {
        logger.info("MemberController - /member/searchp   searchBy : [{}] , searchKeyword : [{}]", searchBy, searchKeyword);
        session.setAttribute("spList", null);
        List<SearchPlaceDto> spList = null;
        	try {
        		if(searchBy.equals("business_type")) {
        			spList = sPService.selectAllVendorByBusinessType(searchKeyword);
                }else if(searchBy.equals("basic_address")) {
                	spList = sPService.selectAllVendorByBasicAddress(searchKeyword);
                }else if(searchBy.equals("business_name")) {
                	String encodedQuery = URLEncoder.encode(searchKeyword, "UTF-8");
                	return "redirect:/my/search?query=" + encodedQuery;
                }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        
        session.setAttribute("spList", spList); //검색결과를 세션에 저장해두고
        return "redirect:searchplace"; //리다이렉트로 이동해야 뒤로가기 해도 문제가 없음
    }

    

    @RequestMapping(value = "/member/mmonthlyschedule", method = RequestMethod.GET)
    public String mMonthlySchedule(Model model, HttpSession session) throws Exception {
    	logger.info("MemberController - /member/mmonthlyschedule");
    	
		return "member/mmonthlyschedule";
    	
    }
    
	@RequestMapping(value = "/member/mdailyschedule", method = RequestMethod.GET)
    public String DailySchedule(@RequestParam("date") String date, HttpSession session, Model model) {
		System.out.println("MemberController - /member/dailyschedule(get) selectedDate:" + date);
		
//		String email = (String)session.getAttribute("loginEmail");
//		String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
//		String open_date = (String)session.getAttribute("open_date");
		model.addAttribute("selectedDate", date);
		//System.out.println(date);
		return "/member/mdailyschedule";
    }
	
    @RequestMapping(value = "/member/businessplaceinfo", method = RequestMethod.GET)
    public String businessplaceinfo(
            @RequestParam("email") String email,
            @RequestParam("business_regi_num") String business_regi_num,
            Model model, HttpSession session) throws Exception {
    	logger.info("===========place info=========");
        logger.info("MemberController - /member/businessplaceinfo: email=" + email + ", business_regi_num=" + business_regi_num);
        SearchPlaceDto placeInfo;
		try {
			placeInfo = sPService.selectOnePlace(email, business_regi_num);
		
	        ArrayList<BusinessPlaceImagePathDto> imgList = 
	        		bPIPService.selectAllMainAndNormalImage(email, business_regi_num);
	        model.addAttribute("placeInfo", placeInfo);
	        System.out.println("model add placeInfo : " + placeInfo);
	        
	
		    ArrayList<Map<String, Object>> encodedImgList = new ArrayList<>();
		    for (BusinessPlaceImagePathDto dto : imgList) {
		        // 이진 데이터를 Base64로 인코딩
		        String encodedImage = Base64.getEncoder().encodeToString(dto.getFile_data());
		        
		        // 필요한 데이터와 인코딩된 이미지를 맵으로 묶음
		        Map<String, Object> imageMap = new HashMap<>();
		        imageMap.put("place_img_path", dto.getPlace_img_path());
		        imageMap.put("is_main", dto.getIs_main());
		        imageMap.put("encodedImage", encodedImage);  // 인코딩된 이미지 추가
		        
		        encodedImgList.add(imageMap);
		    }
	        
	        model.addAttribute("imageList", encodedImgList);
	        //System.out.println("model add imageList : " + encodedImgList);
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        /*
        BusinessPlaceInfoDto placeInfo = bPIService.selectOneBusinessPlaceInfo(email, business_regi_num);
        model.addAttribute("placeInfo", placeInfo);	//벤더 정보
        logger.info("model added placeInfo dto : {}", placeInfo);
        */
        /*
        ArrayList<BusinessPlaceImagePathDto> placeImagePathDtos = bPIPService.selectAllMyBusinessPlaceImgPaths(email, business_regi_num);
        BusinessPlaceImagePathDto mainImg = bPIPService.selectMainImage(email, business_regi_num);
        if (placeImagePathDtos != null && !placeImagePathDtos.isEmpty()) {
            // 리스트가 비어있지 않은 경우
            for (BusinessPlaceImagePathDto dto : placeImagePathDtos) {
                System.out.println(dto.getPlace_img_path());
            }
            
            model.addAttribute("mainImg", mainImg.getPlace_img_path());
            // 리스트를 모델에 추가
            model.addAttribute("placeImagePathDtos", placeImagePathDtos);
        } else {
            // 리스트가 비어있는 경우
            model.addAttribute("mainImg", "이미지가 없습니다"); // 메시지 설정         
        }
        */
        //벤더 정보 세션에 저장 주문성립시에 가져다 씀
        VendorUserDto vendorUserDto = vUService.selectOneVendorEmailBusinessRegiNum(email, business_regi_num);
        //VendorUserDto vendorUserDto = vUService.selectOne();
        session.setAttribute("vendorInfo", vendorUserDto);
        System.out.println("vendorInfo : " + vendorUserDto);
        
        List<ServiceItemsDto> serviceItems = sIService.selectAllYourItems(email, business_regi_num);
        model.addAttribute("serviceItems", serviceItems);
        logger.info("===========place info=========");
        return "member/businessplaceinfo";
    }
	

	@RequestMapping(value = "/member/mscheduleselect", method = RequestMethod.GET)
	public String memberScheduleselect(
			@RequestParam("date") String date,
	        Model model) {
		////////////
//        model.addAttribute("vendorEmail", email);
//        model.addAttribute("vendorBusiness_regi_num", business_regi_num);
		model.addAttribute("selectedDate", date);
		System.out.println("MemberController - /member/mscheduleselect(get)");
		return "/member/mscheduleselect";
	}
	
	@RequestMapping(value = "/member/mreservationconfirm", method = RequestMethod.GET)
	public String membermReservationConfirm(
	        Model model) {
		////////////
//        model.addAttribute("vendorEmail", email);
//        model.addAttribute("vendorBusiness_regi_num", business_regi_num);
		System.out.println("MemberController - /member/mreservationconfirm(get)");
		return "/member/mreservationconfirm";
	}
	
	

	
    @RequestMapping(value = "/member/membertovendor", method = RequestMethod.GET)    //member의 권한에서 vendor로 변환하려는것이기때문에 일단 MemberController에 넣어둠
	public String memberMembertovendor(Locale locale, Model model) {
		System.out.println("MemberController - /member/membertovendor(get)");
		return "/member/membertovendor";
	}
	
	
    @RequestMapping(value = "/member/membertovendor", method = RequestMethod.POST)    //member의 권한에서 vendor로 변환하는것이기때문에 일단 MemberController에 넣어둠
	public String memberMembertovendorDB(VendorDto dto, RedirectAttributes rttr, HttpSession session) throws Exception{
		System.out.println("MemberController - /member/membertovendor(post)");
		vService.insert(dto); 		// 일반member vendor전환시,  vendor table에  vendor 정보 insert되고  
		System.out.println(dto);	// authorities table에  ROLE_MEMBER가  ROLE_VENDOR 로 update 됨     VeendorServiceImpl구현부. 트렌젝션 처리 o
		session.invalidate();
		rttr.addAttribute("vendor",true);
        return "redirect:/user/login?vendor";
	}
	
	
	
	
	
}
