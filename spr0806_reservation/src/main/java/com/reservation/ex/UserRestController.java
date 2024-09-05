package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.UserDto;
import com.reservation.dto.UserReservationDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.MailService;

@RestController
public class UserRestController {
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private IVendorReservationService vRService;

	@Autowired
	private IUserReservationService uRService;

	@Autowired
	private MailService mailService;
	
	
	
	
	
	@RequestMapping(value = "/userrest/scheduleinsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> userScheduleInsert(@RequestBody UserReservationDto dto, 
			RedirectAttributes rttr){
		System.out.println("UserRestController - /userrest/scheduleinsert(post)");
		
		System.out.println(dto.toString());

		Map<String, String> response = new HashMap<>();
		try {
			uRService.newOrder(dto);
		    response.put("message", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    return response;
	}
	
	/*
	@RequestMapping(value = "/userrest/scheduleselect", method = RequestMethod.POST)
	@ResponseBody
	public VendorReservationDto userScheduleselectDB(@RequestBody VendorReservationDto dto, 
			RedirectAttributes rttr) throws Exception{
		System.out.println("UserRestController - /userrest/scheduleselect(post)");
		
		System.out.println(dto.toString());
		
		return vRService.selectOneVendorsReservation(dto);
	}
	*/
	
	@RequestMapping(value = "/userrest/scheduleselect", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> userScheduleselectDB(@RequestBody VendorReservationDto dto, 
	        RedirectAttributes rttr) throws Exception {
	    System.out.println("UserRestController - /userrest/scheduleselect(post)");
	    
	    System.out.println(dto.toString());
	    
	    VendorReservationDto reservationDto = vRService.selectOneVendorsReservation(dto);

	    System.out.println(reservationDto.toString());
	    Map<String, Object> response = new HashMap<>();
	    response.put("message", "success");
	    response.put("dto", reservationDto);
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}

	

	@RequestMapping(value = "/userrest/emailToName", method = RequestMethod.GET)
	public Map emailToName(String email) throws Exception {
		System.out.println("UserRestController - /emailToName " + email);
		
		Map<String, String> result = new HashMap<>();
		UserDto checkDto =null;
		try {
			checkDto = userService.selectEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("UserRestController - /userrest/emailToName    input email : " + email + " , return dto : " + checkDto);
		if(checkDto == null) {
			result.put("name", null);
			System.out.println("name : null");
		}else {
			result.put("name", checkDto.getName());
			System.out.println("name : " + checkDto.getName());
		}
		
		return result;
	}
	
	//이메일 중복 체크
	@RequestMapping(value = "/userrest/emailcheck", method = RequestMethod.GET)
	public Map userEmailCheck(String email)  {
		System.out.println("UserRestController - /userrest/emailcheck " + email);
		
		Map<String, String> result = new HashMap<>();
		UserDto checkDto =null;
		try {
			checkDto = userService.selectEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("UserRestController - /userrest/emailcheck    input email : " + email + " , return dto : " + checkDto);
		if(checkDto == null) {
			result.put("result", "true");
			System.out.println("result : true 중복이 아님");
		}else {
			result.put("result", "false");
			System.out.println("result : false 중복임");
		}
		
		return result;
	}

	//전화번호 중복 체크
		@RequestMapping(value = "/userrest/phonecheck", method = RequestMethod.GET)
		public Map userPhoneCheck(String phone)  {
			System.out.println("UserRestController - /userrest/phonecheck " + phone);
			
			Map<String, String> result = new HashMap<>();
			UserDto checkDto =null;
			try {
				checkDto = userService.selectPhone(phone);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("UserRestController - /userrest/phonecheck    input phone : " + phone + " , return dto : " + checkDto);
			if(checkDto == null) {
				result.put("result", "true");
				System.out.println("result : true 중복이 아님");
			}else {
				result.put("result", "false");
				System.out.println("result : false 중복임");
			}
			
			return result;
		}
		
	
	@RequestMapping("/userrest/selectall")
	public List<UserDto> sendUserList() throws Exception {
		System.out.println("UserRestController - /userrest/selectall ");
		List<UserDto> list = new ArrayList<>();
		list = userService.selectAll();
		
		return list;
	}

	@RequestMapping("/userrest/test/{email}")
	public ResponseEntity<UserDto> selectEmailTest(@PathVariable("email") String email) {
		System.out.println("UserRestController - /userrest/test ");
		ResponseEntity<UserDto> entity = null;
		try {
			entity = new ResponseEntity<>(userService.selectEmail(email), HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		//entity.getBody().getEmail()
		
		return entity;
	}
	
	
	
	
///////////이메일인증코드관련↓↓↓↓↓↓↓↓↓↓//////////////////////
	//						 createEmailCheck
	@RequestMapping(value = "/createEmailCheck", method = RequestMethod.GET)
	@ResponseBody
	public boolean emailauth(@RequestParam String email, @RequestParam int random, HttpServletRequest req) {
		// 이메일 인증
		System.out.println("uc /createEmailCheck");
		int ran = new Random().nextInt(900000) + 100000;
		HttpSession session = req.getSession(true);
		String authCode = String.valueOf(ran);
		session.setAttribute("authCode", authCode);
		session.setAttribute("random", random);
		String subject = "회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증 코드는 " + authCode + "입니다.");
		String sendEmailId = "everysreservation@gmail.com";
		return mailService.send(subject, sb.toString(), sendEmailId, email, null);
	}
	
	//						/emailAuth
	@RequestMapping(value="/emailAuth", method=RequestMethod.GET)	
	@ResponseBody
	public ResponseEntity<String> emailAuth(@RequestParam String authCode, @RequestParam String random,
			HttpSession session) {
		System.out.println("uc /emailAuth");
		String originalJoinCode = (String) session.getAttribute("authCode");
		String originalRandom = Integer.toString((int) session.getAttribute("random"));
		if (originalJoinCode.equals(authCode) && originalRandom.equals(random))
			return new ResponseEntity<String>("complete", HttpStatus.OK);
		else
			return new ResponseEntity<String>("false", HttpStatus.OK);
	}
	

///////////이메일인증코드관련↑↑↑↑↑↑↑↑↑↑↑//////////////////////
	
	
	
	
	
	
//
//	@RequestMapping("/userrest/test/{email}")
//	public ResponseEntity<UserDto> selectEmailTest(@PathVariable("email") String email) {
//		System.out.println("UserRestController - /userrest/test ");
//		ResponseEntity<UserDto> entity = null;
//		try {
//			entity = new ResponseEntity<>(userService.selectEmail(email), HttpStatus.OK);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//	}
	
}
