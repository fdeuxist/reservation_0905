package com.reservation.ex;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.UserDto;
import com.reservation.service.IUserService;

@Controller
public class AdminUserController {
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Autowired
	private IUserService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);
	
	
	@RequestMapping(value = "/admin/user/update", method = RequestMethod.GET)
	public String update(@ModelAttribute("dto") UserDto dto) {
		System.out.println("AdminUserController - /admin/user/update(get)");
		return "/admin/user/update";
	}
	
	@RequestMapping(value = "/admin/user/update", method = RequestMethod.POST)
	public String updateDB(UserDto dto,RedirectAttributes rttr) throws Exception{
		System.out.println("AdminUserController - /admin/user/update(post)");
		String encPassword = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(encPassword);
		service.update(dto);
		System.out.println(dto);
		rttr.addFlashAttribute("msg","success");
		
		return "redirect:/admin/user/selectAll";
	}
	
	@RequestMapping(value = "/admin/user/delete", method = RequestMethod.GET)
	public String delete(String email,RedirectAttributes rttr) throws Exception{
		System.out.println("AdminUserController - /admin/user/delete");
		service.delete(email);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/admin/user/selectAll";
	}
	
	@RequestMapping(value = "/admin/user/selectEmail", method = RequestMethod.GET)
	public String selectName(String email,Model model) throws Exception{
		System.out.println("AdminUserController - /admin/user/selectEmail");
		model.addAttribute("dto", service.selectEmail(email));
		return "/admin/user/selectEmail";
	}
	
	@RequestMapping(value = "/admin/user/selectAll", method = RequestMethod.GET)
	public String selectAll(Model model) throws Exception{
		System.out.println("AdminUserController - /admin/user/selectAll");
		model.addAttribute("list", service.selectAll());
		return "/admin/user/selectAll";
	}
	
	@RequestMapping(value = "/admin/user/insert", method = RequestMethod.GET)
	public String insert() {
		System.out.println("AdminUserController - /admin/user/insert(get)");
		return "/admin/user/insert";
	}
		
	@RequestMapping(value = "/admin/user/insert", method = RequestMethod.POST)
	public String insertDB(UserDto humanDto,RedirectAttributes rttr) throws Exception{
		System.out.println("AdminUserController - /admin/user/insert(post)");
		String encPassword = passwordEncoder.encode(humanDto.getPassword());
		humanDto.setPassword(encPassword);
		service.insert(humanDto);
		System.out.println(humanDto);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/admin/user/selectAll";
	}
}
