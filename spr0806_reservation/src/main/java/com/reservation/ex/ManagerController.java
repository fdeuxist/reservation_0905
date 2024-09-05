package com.reservation.ex;

import java.util.ArrayList;
import java.util.Locale;

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
import com.reservation.service.IUserService;

@Controller
public class ManagerController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private IUserService uService;

	@Autowired
	private IBusinessPlaceInfoService bPIService;
	
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

	
	
	
	
	
}
