package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
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

/*
 @RestController를 사용하면 @ResponseBody가 기본적으로 적용되므로, 
 컨트롤러 클래스에서 @RestController를 선언하면 
 해당 클래스의 메서드에 별도로 @ResponseBody를 붙일 필요가 없습니다.
그러나 @Controller를 사용하고 메서드 단위에서 JSON 응답을 반환하고자 한다면, 
그 메서드에 @ResponseBody를 붙여야 합니다.
 */

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
	
	@Autowired
    PasswordEncoder passwordEncoder;

	private static final Logger logger = LoggerFactory.getLogger(VendorController.class);
	
	
	@RequestMapping(value = "/userrest/scheduleinsert", method = RequestMethod.POST)
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
	public VendorReservationDto userScheduleselectDB(@RequestBody VendorReservationDto dto, 
			RedirectAttributes rttr) throws Exception{
		System.out.println("UserRestController - /userrest/scheduleselect(post)");
		
		System.out.println(dto.toString());
		
		return vRService.selectOneVendorsReservation(dto);
	}
	*/
	
	@RequestMapping(value = "/userrest/scheduleselect", method = RequestMethod.POST)
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
			int checkEmail = -1;
			try {
				checkEmail = userService.checkEmail(email);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("UserRestController - /userrest/emailcheck    input email : " 
						+ email + " , checkEmail return val : " + checkEmail);
			if(checkEmail == 0) {
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
			int checkPhone = -1;
			try {
				checkPhone = userService.checkPhone(phone);
				System.out.println("checkPhone : " + checkPhone);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("UserRestController - /userrest/phonecheck    input phone : " 
						+ phone + " , checkPhone return val : " + checkPhone);
			if(checkPhone == 0) {
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
	
//0905 email,name으로 password 찾기 인증코드 보내서 맞으면 인증코드로 pw변경해주기	
	@RequestMapping(value = "/findPWByEmailAndName", method = RequestMethod.GET)
	public Map<String, Object> findPWByEmailAndName(
			@RequestParam String email,
			@RequestParam String phone,
			@RequestParam String name, 
			@RequestParam String findtype, 
			@RequestParam int random, HttpServletRequest req) throws Exception {
		// 이메일 인증
		System.out.println("userrest/findPWByEmailAndName " + email + " " + phone + " " + name + " " + findtype + " " + random);
		
		UserDto dto = userService.selectEmailAndName(email, name);
		Map<String, Object> response = new HashMap<>();
		if(dto==null) {
			//email과이름으로 정보를 찾을 수 없다고 알림
			response.put("result","0");
		}else if(dto.getEmail().equals(email) && dto.getName().equals(name)) {
			//email인증번호발송
			int ran = new Random().nextInt(900000) + 100000;
			HttpSession session = req.getSession(true);
			String authCode = String.valueOf(ran);
			session.setAttribute("authCode", authCode);
			session.setAttribute("random", random);
			String subject = "회원정보로 비밀번호 변경하기 인증 코드 발급 안내 입니다.";
			StringBuilder sb = new StringBuilder();
			sb.append("귀하의 인증 코드는 " + authCode + "입니다.");
			String sendEmailId = "everysreservation@gmail.com";
			//response.put("message", authCode);
			System.out.println("귀하의 인증 코드는 " + authCode + "입니다.");
			response.put("message", mailService.send(subject, sb.toString(), sendEmailId, email, null));
			//                 보내졌으면 true
			response.put("result","1");
		}
		return response;
	}
	
	//0905 email,name으로 password 찾기 인증코드 보내서 맞으면 인증코드로 pw변경해주기	
	@RequestMapping(value="/findPWByEmailAndNameAuth", method=RequestMethod.GET)	
	public ResponseEntity<String> findPWByEmailAndNameAuth(
			@RequestParam String authCode, 
			@RequestParam String random,
			@RequestParam String email,
			@RequestParam String name,
			HttpSession session) throws Exception {
		System.out.println("uc /findPWByEmailAndNameAuth " + authCode);
		
		if (session.getAttribute("random") == null) {
			//400!!!
		    return new ResponseEntity<String>("false", HttpStatus.BAD_REQUEST);
		}
		
		String originalJoinCode = (String) session.getAttribute("authCode");
		String originalRandom = Integer.toString((int) session.getAttribute("random"));
		if (originalJoinCode.equals(authCode) && originalRandom.equals(random)) {
			
			String encPassword = passwordEncoder.encode(authCode);
			userService.updatePwByEmailAndName(encPassword, email, name);
			
			//UserDto dto = userService.selectEmailAndName(email, name);
			//System.out.println(dto);
			
			return new ResponseEntity<String>(email, HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("false", HttpStatus.OK);
		}
	}
	//0905 phone,name으로 password 찾기 인증코드 보내서 맞으면 인증코드로 pw변경해주기	
  	@RequestMapping(value="/findPWByPhoneAndNameAuth", method=RequestMethod.GET)	
  	public ResponseEntity<String> findPWByPhoneAndNameAuth(
  			@RequestParam String authCode, 
  			@RequestParam String random,
  			@RequestParam String phone,
  			@RequestParam String name,
  			HttpSession session) throws Exception {
  		System.out.println("uc /findPWByPhoneAndNameAuth " + authCode);
  		String originalJoinCode = (String) session.getAttribute("authCode");
  		String originalRandom = Integer.toString((int) session.getAttribute("random"));
  		if (originalJoinCode.equals(authCode) && originalRandom.equals(random)) {
  			String encPassword = passwordEncoder.encode(authCode);
  			userService.updatePwByPhoneAndName(encPassword, phone, name);
  			
  			UserDto dto = userService.selectPhoneAndName(phone, name);
  			System.out.println(dto);
  			
  			return new ResponseEntity<String>(dto.getEmail(), HttpStatus.OK);
  		} else {
  			return new ResponseEntity<String>("false", HttpStatus.OK);
  		}
  	}	
	
	
///////////이메일인증코드관련↓↓↓↓↓↓↓↓↓↓//////////////////////
	//						 createEmailCheck
  	@RequestMapping(value = "/createEmailCheck", method = RequestMethod.GET)
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
		logger.info("귀하의 인증 코드는 " + authCode + "입니다.");
		String sendEmailId = "everysreservation@gmail.com";
		return mailService.send(subject, sb.toString(), sendEmailId, email, null);
	}
	
	//						/emailAuth
	@RequestMapping(value="/emailAuth", method=RequestMethod.GET)	
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
	
///////////전화번호 인증코드관련↓↓↓↓↓↓↓↓↓↓//////////////////////
//					 createPhoneCheck 은 MessageController에 있음

//					/phoneAuth
@RequestMapping(value="/phoneAuth", method=RequestMethod.GET)	
public ResponseEntity<String> phoneAuth(@RequestParam String authCodep, @RequestParam String randomp,
		HttpSession session) {
	System.out.println("uc /phoneAuth " + authCodep);
	String originalJoinCode = (String) session.getAttribute("authCodeP");
	String originalRandom = Integer.toString((int) session.getAttribute("randomP"));
	if (originalJoinCode.equals(authCodep) && originalRandom.equals(randomp)) 
		return new ResponseEntity<String>("complete", HttpStatus.OK);
	else
		return new ResponseEntity<String>("false", HttpStatus.OK);
}

///////////전화번호 인증코드관련↑↑↑↑↑↑↑↑↑↑↑//////////////////////
	
	
	
	
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
