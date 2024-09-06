package com.reservation.ex;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ReportController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	

	@RequestMapping(value = "/report/reportPage", method = RequestMethod.GET)
	public void reportPage(Locale locale, Model model, HttpSession session) {
	
		
	}

	
	
	
}
