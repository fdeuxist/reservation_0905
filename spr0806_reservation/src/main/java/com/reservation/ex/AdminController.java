package com.reservation.ex;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.MemberInfoDto;
import com.reservation.service.IAuthoritiesService;
import com.reservation.service.IMemberInfoService;
import com.reservation.service.IUserService;


@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private IUserService uService;
	
	@Autowired
	private IAuthoritiesService aService;
	
	@Autowired
	private IMemberInfoService mIService;
	
	@RequestMapping(value = "/admin/admin", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model) throws Exception {
		System.out.println("AdminController - /admin/admin");
		
		String email = (String)session.getAttribute("loginEmail");
		if(session.getAttribute("loginName")==null) {
			session.setAttribute("loginName", uService.selectEmail(email).getName());
		}
		
		return "/admin/admin";
	}
	
	

	@RequestMapping(value = "/admin/selectAll", method = RequestMethod.GET)
	public String selectAll(HttpSession session, Model model) throws Exception {
		System.out.println("AdminController - /admin/selectAll");
		ArrayList<MemberInfoDto> dto = null;
		dto = mIService.selectAll();
		System.out.println(dto);
		model.addAttribute("list", dto);
		return "/admin/selectAll";
	}
	
	@RequestMapping(value = "/admin/accountSearch", method = RequestMethod.GET)
	public String accountSearch(String searchBy, String keyword, HttpSession session, Model model) throws Exception {
		System.out.println("AdminController - /admin/accountSearch : " + searchBy + ", " + keyword);
		ArrayList<MemberInfoDto> dto = null;
		if(searchBy.equals("email")) {
			dto = mIService.selectAllEmailList(keyword);
		}else if (searchBy.equals("name")) {
			dto = mIService.selectAllNameList(keyword);
		}
		System.out.println(dto);
		ArrayList<MemberInfoDto> list = new ArrayList<>();
		model.addAttribute("list", dto);
		return "/admin/selectAll";
	}
	
	@RequestMapping(value = "/admin/update", method = RequestMethod.GET)
	public String update(String email, HttpSession session, Model model) throws Exception {
		System.out.println("AdminController - /admin/update");
		MemberInfoDto dto = null;
		dto = mIService.selectEmail(email);
		System.out.println(dto);
		model.addAttribute("dto", dto);
		return "/admin/update";
	}


	@RequestMapping(value = "/admin/updateDB", method = RequestMethod.POST)
	public String updateDB(String email, HttpSession session, Model model, MemberInfoDto dto,RedirectAttributes rttr) throws Exception {
		System.out.println("AdminController - /admin/updateDB");
		System.out.println(dto);
		
		mIService.memberEnableAuthorityUpdate(dto);
		
		model.addAttribute("dto", dto);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/admin/update?email="+email;
	}
	
	
	
	
	
	
}
