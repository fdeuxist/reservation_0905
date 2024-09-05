package com.reservation.ex;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.AuthoritiesDto;
import com.reservation.service.IAuthoritiesService;

@Controller
public class AdminAuthoritiesController {
	
	@Autowired
	private IAuthoritiesService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminAuthoritiesController.class);
	
	@RequestMapping(value = "/admin/authorities/update", method = RequestMethod.GET)
	public String update(@ModelAttribute("dto") AuthoritiesDto dto) {
		System.out.println("AdminAuthoritiesController - /admin/authorities/update(get)");
		return "/admin/authorities/update";
	}
	@RequestMapping(value = "/admin/authorities/update", method = RequestMethod.POST)
	public String updateDB(AuthoritiesDto dto) throws Exception{
		System.out.println("AdminAuthoritiesController - /admin/authorities/update(post)");
		service.update(dto);
		return "redirect:/admin/authorities/selectAll";
	}
	
	@RequestMapping(value = "/admin/authorities/delete", method = RequestMethod.GET)
	public String delete(String email,RedirectAttributes rttr)throws Exception {
		System.out.println("AdminAuthoritiesController - /admin/authorities/delete");
		service.delete(email);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/admin/authorities/selectAll";
	}
	
	@RequestMapping(value = "/admin/authorities/selectEmail", method = RequestMethod.GET)
	public String selectName(String email, Model model) throws Exception {
		System.out.println("AdminAuthoritiesController - /admin/authorities/selectEmail");
		model.addAttribute("dto", service.selectEmail(email));
		return "/admin/authorities/selectEmail";
	}
	
	@RequestMapping(value = "/admin/authorities/selectAll", method = RequestMethod.GET)
	public String selectAll(Model model) throws Exception {
		System.out.println("AdminAuthoritiesController - /admin/authorities/selectEmail");
		model.addAttribute("list",service.selectAll());
		return "/admin/authorities/selectAll";
	}
	
	@RequestMapping(value = "/admin/authorities/insert", method = RequestMethod.GET)
	public String insert() {
		System.out.println("AdminAuthoritiesController - /admin/authorities/insert(get)");
		return "/admin/authorities/insert";
	}
	
	@RequestMapping(value = "/admin/authorities/insert", method = RequestMethod.POST)
	public String insertDB(AuthoritiesDto dto) throws Exception{
		System.out.println("AdminAuthoritiesController - /admin/authorities/insert(post)");
		service.insert(dto);
		return "redirect:/admin/authorities/selectAll";
	}
	
}