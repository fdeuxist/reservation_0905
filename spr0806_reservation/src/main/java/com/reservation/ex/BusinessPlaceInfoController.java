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
public class BusinessPlaceInfoController {
   
   @Autowired
   private IAuthoritiesService service;
   
   private static final Logger logger = LoggerFactory.getLogger(BusinessPlaceInfoController.class);
   
   
   //Controller는 권한(=뷰페이지 폴더)별로 사용중이니
   //하겸님이 확인 후 삭제나 추가 의견 주세영
   
   
}