package com.reservation.ex;

import java.util.ArrayList;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.UserDto;
import com.reservation.dto.VendorDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IUserService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;
import com.reservation.service.MailService;


@Controller
public class UserController {
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Autowired
	private IUserService uService;

	@Autowired
	private IVendorService vService;
	
	@Autowired
	private IVendorReservationService vRService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	

	@RequestMapping(value = "/user/main", method = RequestMethod.GET)
	public void main(HttpSession session, Model model) throws Exception {
		System.out.println("UserController - /user/main");
	}

	@RequestMapping(value = "/user/user", method = RequestMethod.GET)
	public String user(HttpSession session, Model model) throws Exception {
		System.out.println("UserController - /user/user");
		
		if(session.getAttribute("loginEmail")!=null) {
			String email = (String)session.getAttribute("loginEmail");
			if(session.getAttribute("loginName")==null) {
				session.setAttribute("loginName", uService.selectEmail(email).getName());
			}
		}
		
		return "/user/user";
	}
	
	/*
	@RequestMapping(value = "/user/emailcheck", method = RequestMethod.GET)
	public String userEmailCheck(String email, UserDto dto, RedirectAttributes rttr) throws Exception{
		System.out.println("UserController - /user/emailcheck");
		UserDto checkDto =null;
		checkDto = service.selectEmail(email);
		System.out.println("UserController - /user/emailcheck    input email : " + email + " , return dto : " + checkDto);
		if(checkDto == null) {
			rttr.addFlashAttribute("result", "true");
			System.out.println("result : true");
		}else {
			rttr.addFlashAttribute("result", "false");
			System.out.println("result : false");
		}
		return "/user/emailcheck";
	}
	*/
	
	
	@RequestMapping(value = "/user/error", method = RequestMethod.GET)
	public String userError(Locale locale, Model model) {
		System.out.println("UserController - /user/error");
		return "/user/error";
	}
	
	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) {
		System.out.println("UserController - /user/login");
		return "/user/login";
	}
	
	@RequestMapping(value = "/user/insert", method = RequestMethod.GET)
	public String userInsert(Locale locale, Model model) {
		System.out.println("UserController - /user/insert(get)");
		int ran = new Random().nextInt(900000) + 100000;
		model.addAttribute("random", ran);
		int ran2 = new Random().nextInt(900000) + 100000;
		model.addAttribute("randomp", ran2);
		return "/user/insert";
	}
	


	@RequestMapping(value = "/user/insert", method = RequestMethod.POST)
	public String insertDB(UserDto dto, RedirectAttributes rttr) throws Exception{
		System.out.println("UserController - /user/insert(post)");
		String encPassword = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(encPassword);
		uService.insert(dto); // 일반user 가입시 authorities role 자동으로 member 들어감 UserServiceImpl구현부. 트렌젝션 처리 o
		System.out.println(dto);
		return "redirect:/user/login?member";
	}

	@RequestMapping(value = "/user/insert_free", method = RequestMethod.GET)
	public String userInsertFree(Locale locale, Model model) {
		System.out.println("UserController - /user/insert_free(get)");
		return "/user/insert_free";
	}
	
	@RequestMapping(value = "/user/insert_free", method = RequestMethod.POST)
	public String insertDBFree(UserDto dto, RedirectAttributes rttr) throws Exception{
		System.out.println("UserController - /user/insert_free(post)");
		String encPassword = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(encPassword);
		uService.insert(dto); // 일반user 가입시 authorities role 자동으로 member 들어감 UserServiceImpl구현부. 트렌젝션 처리 o
		System.out.println(dto);
		return "redirect:/user/login?member";
	}
	
	@RequestMapping(value = "/user/insert_init", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> insertInit() throws Exception{
		System.out.println("UserController - /user/insert_init(GET)");
		ResponseEntity<String> entity=null;
		String encPw = passwordEncoder.encode("1111");
		
		String[] accounts = {"admin", "manager", "member1", "member2", "vendor1", "vendor2", "vendor3"};
		
		for(int i=0;i<accounts.length;i++) {
			uService.insert(new UserDto(accounts[i], encPw, "1", "1", 1));
		}
		
		entity = new ResponseEntity<String>("TEST account insert OK", HttpStatus.OK);
		return entity;
	}
	
/*
	@RequestMapping(value = "/user/scheduleselect", method = RequestMethod.GET)
	public String userScheduleselect(Locale locale, Model model) {
		System.out.println("UserController - /user/scheduleselect(get)");
		return "/user/scheduleselect";
	}
*/	
	//0905
	@RequestMapping(value = "/user/findMyAccount", method = RequestMethod.GET)
	public String userFindId(Locale locale, Model model) {
		System.out.println("UserController - /user/findMyAccount(get)");
		int ran = new Random().nextInt(900000) + 100000;
		model.addAttribute("random", ran);
		return "/user/findMyAccount";
	}
	
	
}
