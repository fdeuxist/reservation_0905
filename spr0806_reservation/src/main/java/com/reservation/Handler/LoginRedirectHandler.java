package com.reservation.Handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.reservation.dto.UserDto;
import com.reservation.service.IUserService;

public class LoginRedirectHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private IUserService uService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// 로그인에 성공하면 이동하는 페이지
		List<String> roleNames=new ArrayList<String>();
		//권한들 읽어오기(로그인한 사람의)/roleNames에 추가 
		authentication.getAuthorities().forEach(authority ->{
			roleNames.add(authority.getAuthority());
			System.out.println("==role.authority=="+authority.getAuthority());
		});
		
		HttpSession session = request.getSession();
		// 로그인한 사용자의 이메일(ID) 가져오기
	    String email = authentication.getName();
		//String loginName = null;
/*
		try {
			UserDto dto = uService.selectEmail(email);
			loginName = dto.getName();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
*/				
        session.setAttribute("loginEmail", email);
        
     // Get user details from Authentication
        //Object principal = authentication.getPrincipal();
        //String name = null;
        
//        String strAuthority = null;
//		String[][] nergoority = { { "ROLE_MEMBER", "ROLE_VENDOR", "ROLE_MANAGER", "ROLE_ADMIN" },
//				  				  { "일반회원", "사업자회원", "매니저", "관리자" } };
        //String loginName = null;
    	
		//권한에 따라 페이지 이동
		if(roleNames.contains("ROLE_ADMIN")) {
	        //session.setAttribute("loginName", loginName);
	        session.setAttribute("loginAuthority", "관리자");
	        System.out.println("관리자 " + email);
			response.sendRedirect("/ex/admin/admin");
			return;
		}
		if(roleNames.contains("ROLE_MANAGER")) {
	        //session.setAttribute("loginName", loginName);
	        session.setAttribute("loginAuthority", "매니저");
	        System.out.println("매니저 " + email);
			response.sendRedirect("/ex/manager/mypage");
			return;
		}
		if(roleNames.contains("ROLE_VENDOR")) {
	        //session.setAttribute("loginName", loginName);
	        session.setAttribute("loginAuthority", "사업자회원");
	        System.out.println("사업자회원 " + email);
			response.sendRedirect("/ex/vendor/mypage"); //바꿈
			return;
		}
		if(roleNames.contains("ROLE_MEMBER")) {
	        //session.setAttribute("loginName", loginName);
	        session.setAttribute("loginAuthority", "일반회원");
	        System.out.println("일반회원 " + email);
			//response.sendRedirect("/ex/member/member");	//바꿈. 로그인시 등록되는 세션정보는 아래 링크 들어갈때 등록되게 수정함
			response.sendRedirect("/ex/member/mypage");
			return;
		}
	}

}
