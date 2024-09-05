package com.reservation.ex;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

	@ModelAttribute		//@ControllerAdvice와 @ModelAttribute를 함께 사용하면, 애플리케이션 전체에서 공통으로 사용되는 모델 속성을 한 곳에서 관리할 수 있다
    public void globalAddAttributes(Model model) {
		//페이지가 갱신될때마다 작업이 이루어짐
		/*
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            String email = authentication.getName(); // 사용자 ID 또는 이름
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities(); // 사용자 역할
            model.addAttribute("loginEmail", email);
            //model.addAttribute("authorities", authorities);
            
         // 권한에 따른 메시지 출력
            String[][] nergoority = { {"ROLE_MEMBER", "ROLE_VENDOR", "ROLE_MANAGER", "ROLE_ADMIN"},
            						  {"일반회원", 	  "사업자회원",	 "매니저",		 "관리자"		 } };
            for (GrantedAuthority authority : authorities) {
                String role = authority.getAuthority();

                for(int i=0;i<nergoority.length;i++) {
                	if(nergoority[0][i].equals(role)) {
                		System.out.println(nergoority[0][i] + "        " + nergoority[1][i]);
                		model.addAttribute("authority", nergoority[1][i]);

                        System.out.println("GlobalControllerAdvice   addAttributes - loginEmail : [" + email + "] authorities : " + nergoority[0][i] + "  " + nergoority[1][i]);
                	}else {
                		System.out.println(i + " ?? " + role);
                	}
                }
         */      
                
//                switch (role) {
//                    case "ROLE_MEMBER":
//                        System.out.println("일반회원");
//                        model.addAttribute("authorities", "일반회원");
//                        break;
//                    case "ROLE_VENDOR":
//                        System.out.println("사업자회원");
//                        model.addAttribute("authorities", "사업자회원");
//                        break;
//                    case "ROLE_MANAGER":
//                        System.out.println("매니저");
//                        model.addAttribute("authorities", "매니저");
//                        break;
//                    case "ROLE_ADMIN":
//                        System.out.println("관리자");
//                        model.addAttribute("authorities", "관리자");
//                        break;
//                    default:
//                        System.out.println("알 수 없는 권한: " + role);
//                        break;
//                }
//                
//                
//                
//            }
//
//            //System.out.println("GlobalControllerAdvice   addAttributes - loginEmail : [" + email + "] authorities : " + authorities);
//        }
    }
}
