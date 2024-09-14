package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reservation.dto.SelectedItemsDto;
import com.reservation.dto.UserReservationDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.dto.cardObjDto;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;

@RestController
public class MemberRestController {
	
	@Autowired
	private IUserService uService;

	@Autowired
	private IVendorService vService;
	
	@Autowired
	private IVendorReservationService vRService;
	
    @Autowired
    private IUserReservationService uRService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	//0913    
    @RequestMapping(value = "/memberrest/orderCompleted", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> orderCompleted(
            @RequestBody Map<String, Object> requestBody) throws Exception {
        //String email = (String) requestBody.get("email");
        String reservationNumber = (String) requestBody.get("reservationNumber");
        String status = (String) requestBody.get("status");
        logger.info("MemberRestController - /memberrest/orderCompleted   " 
            + reservationNumber + " " + status);
        
        uRService.changeOrdersStatus("3", reservationNumber);//status를3이용완료로
        //UserReservationDto dto = uRService.selectOneMyOrder(reservationNumber);
        //System.out.println(dto);
        Map<String, Object> response = new HashMap<>();
        response.put("message", "success");
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
//0902	
    @RequestMapping(value = "/memberrest/tryCancel", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> tryCancel(
            @RequestBody Map<String, Object> requestBody) throws Exception {
        String email = (String) requestBody.get("email");
        String reservationNumber = (String) requestBody.get("reservationNumber");
        String status = (String) requestBody.get("status");
        logger.info("MemberRestController - /memberrest/tryCancel   " 
            + email + " " + reservationNumber + " " + status);
        
        //예약취소sql
        if(status.equals("1")||status.equals("2")) {//1입금대기 2입금완료
            uRService.tryCancelOrder(reservationNumber);//status를4취소대기로
        }
        //UserReservationDto dto = uRService.selectOneMyOrder(reservationNumber);
        //dto model에 담아서 수정된 페이지 보여줘야됨
        Map<String, Object> response = new HashMap<>();
        response.put("message", "success");
        //response.put("dto", reservationDto);
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    

	@RequestMapping(value = "/memberrest/mscheduleselect", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> memberScheduleselectDB(@RequestBody VendorReservationDto dto, 
	        RedirectAttributes rttr) throws Exception {
	    System.out.println("MemberRestController - /memberrest/mscheduleselect(post)");
	    
	    System.out.println(dto.toString());
	    
	    VendorReservationDto reservationDto = vRService.selectOneVendorsReservation(dto);

	    System.out.println(reservationDto.toString());
	    Map<String, Object> response = new HashMap<>();
	    response.put("message", "success");
	    response.put("dto", reservationDto);
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	
	
	
	

	@RequestMapping(value = "/memberrest/youronemonth", method = RequestMethod.GET)
	public List<VendorReservationDto> selectOneVendorsMyOneMonthReservation(
			@RequestParam String month, HttpSession session) throws Exception {
		System.out.println("MemberRestController - /memberrest/youronemonth");
		SelectedItemsDto dto = (SelectedItemsDto) session.getAttribute("selectedItemsDto");
		
		String email = dto.getEmail();
		String business_regi_num = dto.getBusiness_regi_num();
		
		String open_date = month;	//폼에서 넘어옴
		System.out.println(email + "   " + business_regi_num+"  " + open_date);
		List<VendorReservationDto> list = new ArrayList<>();
		list = vRService.selectAllOneVendorsYourOneMonthReservations(email, business_regi_num, open_date);
		
		//mMonthlySchedule()에서
        //session.setAttribute("selectedItemsDto", dto);
        //session.setAttribute("myPick", cardObjDtos);
		//저장해둔거 기억
		return list;
	}
	
	
	
	
	@RequestMapping(value = "/memberrest/mmonthlyschedule", method = RequestMethod.POST)
    public Map<String, Object> mMonthlySchedule(@RequestBody SelectedItemsDto dto, 
    		Model model, HttpSession session) throws Exception {
        logger.info("MemberRestController - /memberrest/mmonthlyschedule   dto " + dto);
        System.out.println("dto.getTotalRequiredTime()   " + dto.getTotalRequiredTime());
        System.out.println("dto.getTotalServicePrice()   " + dto.getTotalServicePrice());
        System.out.println("dto.getEmail()   " + dto.getEmail());
        System.out.println("dto.getBusiness_regi_num()   " + dto.getBusiness_regi_num());
        //System.out.println("dto.getSubItems().size()   " + dto.getSubItems().size());
        //System.out.println("dto.getSubItems().get(0)   " + dto.getSubItems().get(0));
        
        //세션에 그냥 저장(toString된 문자열)
        session.setAttribute("selectedItemsDto", dto);	//mbusinessplaceinfo.js에서 넘어온 'data'
        
        
//        data = {	//SelectedItemsDto
//                email: email,
//                business_regi_num: businessRegiNum,
//                totalRequiredTime: totRequiredTimes,
//                totalServicePrice: totServicePrices,
//                selectedItems: selectedItemIdsAry	//cardObjDto
//            };
        
     // List 내용 출력
        List<cardObjDto> cardObjDtos = dto.getSelectedItems();
        session.setAttribute("myPick", null);
        session.setAttribute("myPick", cardObjDtos);
    	//String myPickServiceNames = "";
    	
    	List<String> serviceNames = new ArrayList<>();
    	// 항목을 추가하는 로직
    	for (cardObjDto card : cardObjDtos) {
    	    serviceNames.add(card.getServicename());
    	}
    	// 모든 항목을 쉼표로 구분하여 연결
    	String myPickServiceNames = String.join(", ", serviceNames);
    	
        if (cardObjDtos != null) {
            for (cardObjDto item : cardObjDtos) {
                System.out.println(item.toString());
            }
        } else {
            //System.out.println("null");
            //왜널?배열인데 리스트로 받아서? dto가 정확히일치하지않아서? -> dto 필드 정확히 일치시켜주니 잘 됨
        }
        session.setAttribute("myPickServiceNames", myPickServiceNames);
        //dto.getSubItems().size()
        //session.setAttribute("vendorList", vendorList);
        System.out.println("myPickServiceNames : " + myPickServiceNames);
        Map<String, Object> response = new HashMap<>();
        response.put("redirectUrl", "/ex/member/mmonthlyschedule");
        return response;
    }
}
