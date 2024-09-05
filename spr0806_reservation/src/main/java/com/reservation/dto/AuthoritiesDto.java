package com.reservation.dto;

public class AuthoritiesDto {
	//회원들에 대한 권한 정보
	//ROLE_ANONYMOUS,	//비회원(로그인 안한상태) 
	//ROLE_MEMBER, 		//일반회원
	//ROLE_VENDOR, 		//사업자회원
	//ROLE_MANAGER, 	//매니저
	//ROLE_ADMIN		//관리자
	// 1) 회원가입을 하면 ROLE_MEMBER 권한.
	// 2) 사업자회원 가입을 하면 
	//    해당 Authorities 테이블의 해당 email을 가진 authority가
	//    ROLE_MEMBER에서 ROLE_VENDOR로 update됨
	// 3) MANAGER 권한은 ADMIN이 특정 email에 대해 MANAGER 권한으로 update 해줌
	// 4) ADMIN 권한은 sql developer에서 update 해야 함
	
	private String email;
	private String authority;
	
	public AuthoritiesDto() {}
	
	public AuthoritiesDto(String email, String authority) {
		super();
		this.email = email;
		this.authority = authority;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAuthority() {
		return authority;
	}
	
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	@Override
	public String toString() {
		return "AuthoritiesDto [email=" + email + ", authority=" + authority + "]";
	}
	
	
	
	
}