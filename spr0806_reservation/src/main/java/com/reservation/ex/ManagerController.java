package com.reservation.ex;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.UserDto;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IUserReservationService;
import com.reservation.service.IUserService;

@Controller
public class ManagerController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private IUserService uService;

	@Autowired
	private IBusinessPlaceInfoService bPIService;

	//대시보드 기능 추가 만든이:오규원 추가일자:0906
	@Autowired
	private IUserReservationService userRService;
	
	@RequestMapping(value = "/manager/manager", method = RequestMethod.GET)
	public String manager(HttpSession session, Model model) throws Exception {
		System.out.println("ManagerController - /manager/manager");

		String email = (String)session.getAttribute("loginEmail");
		if(session.getAttribute("loginName")==null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		
		return "/manager/manager";
	}
	

	@RequestMapping(value = "/manager/manageUsers", method = RequestMethod.GET)
	public String manageUsers(HttpSession session, Model model) throws Exception {
		System.out.println("ManagerController - /manager/manager");

		String email = (String)session.getAttribute("loginEmail");
		if(session.getAttribute("loginName")==null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		ArrayList<UserDto> dtos = uService.selectAll();
		model.addAttribute("userList",dtos);
		
		return "/manager/manageUsers";
	}

	
	
	
	
	//대시보드 기능 추가 만든이:오규원 추가일자:0906
		@RequestMapping(value = "/manager/dashBoard", method = RequestMethod.GET)
		public String dashboard(Model model) throws Exception{
			List<Map<String,Object>> dtos =  userRService.sumServicePrice();
			model.addAttribute("dtos",dtos);
			List<Map<String,Object>> times =  userRService.countTimeshhmm();
			model.addAttribute("times",times);
			List<Map<String,Object>> serviceNames =  userRService.countServiceName();
			model.addAttribute("serviceNames",serviceNames);
			
			System.out.println("dashBoard...."+dtos);
			System.out.println("dashBoard...."+times);
			System.out.println("dashBoard...."+serviceNames);
			return "/manager/dashBoard";
		}
	
	
}
