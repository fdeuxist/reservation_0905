package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.UserReservationDto;
import com.reservation.dto.VendorDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;

@RestController
public class VendorRestController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
	@Autowired
	private IVendorService vendorService;
	
	@Autowired
	private IBusinessPlaceInfoService businessPlaceInfo;
	
	@Autowired
	private IVendorReservationService vRService;

    @Autowired
    private IUserReservationService uRService;


    //0916 해당 사업자 주문상태에 따른 주문 갯수
    @RequestMapping(value = "/vendorrest/countReservationRow", method = RequestMethod.GET)
    public int countReservationRow(
    		@RequestParam("vendor_email") String vendor_email,
    		@RequestParam("business_regi_num") String business_regi_num,
    		@RequestParam("status") String status) throws Exception {
    	
    	int count = uRService.countVendorOrdersStatus(vendor_email, business_regi_num, status);
    	
    	logger.info("VendorRestController - /vendorrest/countReservationRow   " 
                + vendor_email + " " + business_regi_num + " status : " + status + " count : " + count);
    	
    	return count;
    }
    
    //0916 해당 사업자 주문상태에 따른 주문 리스트 (페이지)
    @RequestMapping(value = "/vendorrest/reservationListPage", method = RequestMethod.GET)
    public ArrayList<UserReservationDto> reservationListPage(
    		@RequestParam("vendor_email") String vendor_email,
    		@RequestParam("business_regi_num") String business_regi_num,
    		@RequestParam("status") String status,
    		@RequestParam("currPageNum") String currPageNum) throws Exception {
    	
    	ArrayList<UserReservationDto> list = uRService.selectAllVendorOrdersStatusAndPage(
    			vendor_email, business_regi_num, status, currPageNum);
    	
    	logger.info("VendorRestController - /vendorrest/reservationListPage   " 
                + vendor_email + " " + business_regi_num + " stats : " + status + " currPageNum : " + currPageNum + "\n list : " + list);
    	return list;
    }
    

    //0913    
    @RequestMapping(value = "/vendorrest/confirmCancel", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> confirmCancel(
            @RequestBody Map<String, Object> requestBody) throws Exception {
        String email = (String) requestBody.get("email");
        String reservationNumber = (String) requestBody.get("reservationNumber");
        String status = (String) requestBody.get("status");
        logger.info("VendorRestController - /vendorrest/confirmCancel   " 
            + email + " " + reservationNumber + " " + status);
        String updateStatus=null;
        
        if(status.equals("4")) {        //4취소대기
            updateStatus="5";            //5취소완료
        }else if(status.equals("6")) {    //6환불대기
            updateStatus="7";            //7환불완료
        }
        //uRService.changeOrdersStatus(updateStatus, reservationNumber);	//status만 돌림. 미사용
        uRService.cancelOrRefund(updateStatus, reservationNumber);
        UserReservationDto dto = uRService.selectOneMyOrder(reservationNumber);
        System.out.println(dto);
        Map<String, Object> response = new HashMap<>();
        response.put("message", "success");
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
	
	
	
	//0905 스케줄 수정관련 times 값 select용
	@RequestMapping(value = "/vendorrest/scheduleselect", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> vendorScheduleselect(@RequestBody VendorReservationDto dto, 
	        RedirectAttributes rttr) throws Exception {
	    System.out.println("VendorRestController - /vendorrest/scheduleselect");
	    
	    System.out.println(dto.toString());
	    
	    VendorReservationDto reservationDto = vRService.selectOneOneVendorsMyOneDayReservation(dto);

	    System.out.println(reservationDto.toString());
	    Map<String, Object> response = new HashMap<>();
	    response.put("message", "success");
	    response.put("dto", reservationDto);
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	//0905 스케줄 수정관련 times 값 update용
		@RequestMapping(value = "/vendorrest/scheduleupdate", method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> scheduleupdate(VendorReservationDto dto, 
				RedirectAttributes rttr) throws Exception{
			System.out.println("VendorRestController - /vendorrest/scheduleupdate " + dto);
			
			vRService.openDateTimesUpdate(dto);
	        //status 0이고 자기이메일 자기업자번호 자기날짜의것 time update해야함
	        
	        VendorReservationDto vrDto = 
	        		vRService.selectOneOneVendorsMyOneDayReservation(
	        				dto.getEmail(), dto.getBusiness_regi_num(), dto.getOpen_date());
	        System.out.println("update day : " + vrDto);
	        //vrDto로 해당 페이지 갱신시켜줘야됨
	        
			Map<String, Object> response = new HashMap<>();
		    response.put("message", "success");
		    response.put("updateDto", vrDto);
		    
		    return new ResponseEntity<>(response, HttpStatus.OK);
		}
	
	
	
	//0904 스케줄 수정관련 status_flag 전환용
	@RequestMapping(value = "/vendorrest/setStatus", method = RequestMethod.POST)
	public Map<String, String> setStatus(VendorReservationDto dto, 
			RedirectAttributes rttr) throws Exception{
		System.out.println("VendorRestController - /vendorrest/setStatus");
		/*
		String email = dto.getEmail();
		String business_regi_num = dto.getBusiness_regi_num();
		String open_date = dto.getOpen_date();
		
		System.out.println("Email: " + dto.getEmail());
        System.out.println("Business Registration Number: " + dto.getBusiness_regi_num());
        System.out.println("Open Date: " + dto.getOpen_date());
        System.out.println("Times: " + dto.getTimes());
        System.out.println("Status: " + dto.getStatus_flag());
        String status = dto.getStatus_flag();
        */
        // status 넘겨받은거로 변경하는 sql
        
        if(dto.getStatus_flag().equals("0")) {
        	//vRService.closeDay(email, business_regi_num, open_date);
        	vRService.closeDay(dto);
        }else if(dto.getStatus_flag().equals("1")) {
        	//vRService.openDay(email, business_regi_num, open_date);
        	vRService.openDay(dto);
        }
        
        VendorReservationDto vrDto = 
        		vRService.selectOneOneVendorsMyOneDayReservation(
        				dto.getEmail(), dto.getBusiness_regi_num(), dto.getOpen_date());
        System.out.println("result day : " + vrDto);
        
		Map<String, String> response = new HashMap<>();
		try {
			//uRService.newOrder(dto);
		    response.put("message", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    return response;
	}
    
	@RequestMapping(value = "/vendorrest/myonemonth", method = RequestMethod.GET)
	public List<VendorReservationDto> selectOneVendorsMyOneMonthReservation(
			@RequestParam String month, HttpSession session) throws Exception {
		System.out.println("VendorRestController - /vendorrest/myonemonth");
		
		String email = (String)session.getAttribute("loginEmail");
		String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
		String open_date = month;
		System.out.println(email + "   " + business_regi_num+"  " + open_date);
		List<VendorReservationDto> list = new ArrayList<>();
		list = vRService.selectAllOneVendorsMyOneMonthReservations(email, business_regi_num, open_date);
		
		return list;
	}
	
	
	
	
	
	@RequestMapping("/vendorrest/test")
	public BusinessPlaceInfoDto selectVendorBusinessPlaceInfo(String email, String business_regi_num) throws Exception {
		System.out.println("VendorRestController - /vendorrest/test");
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectTest("test1", "test2");
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectTest("vendor", "gsgs252511");
		email = "vendor";
		business_regi_num = "gsgs252511";
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectVendorBusinessPlaceInfo(email, business_regi_num);
		
		//return dto;
		return null;
	}
	
	
	
	
	
	@RequestMapping(value = "/vendorrest/emailcheck", method = RequestMethod.GET)
	public Map vendorEmailCheck(String email) {
		System.out.println("VendorRestController - /vendorrest/emailcheck " + email);
		
		Map<String, String> result = new HashMap<>();
		int count = -1;
		try {
			count = vendorService.checkEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("VendorRestController - /vendorrest/emailcheck    input email : " + email + " , return count : " + count);
		if(count == 0) {
			result.put("result", "true");
			System.out.println("result : true");
		}else {
			result.put("result", "false");
			System.out.println("result : false");
		}
		
		return result;
	}
	
	@RequestMapping(value = "/vendorrest/business_regi_numcheck", method = RequestMethod.GET)
	public Map vendorBusiness_regi_numCheck(String business_regi_num) {
		System.out.println("VendorRestController - /vendorrest/business_regi_numcheck " + business_regi_num);
		
		Map<String, String> result = new HashMap<>();
		VendorDto checkDto = null;
		try {
			checkDto = vendorService.selectBusiness_regi_num(business_regi_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("VendorRestController - /vendorrest/business_regi_numcheck    input business_regi_num : " + business_regi_num + " , return dto : " + checkDto);
		if(checkDto == null) {
			result.put("result", "true");
			System.out.println("result : true");
		}else {
			result.put("result", "false");
			System.out.println("result : false");
		}
		
		return result;
	}
	
	@RequestMapping("/vendorrest/selectall")
	public List<VendorDto> sendVendorList() throws Exception {
		System.out.println("VendorRestController - /vendorrest/selectall");
		List<VendorDto> list = new ArrayList<>();
		list = vendorService.selectAll();
		
		return list;
	}
	
	
	
	
	
	
	
	
}
