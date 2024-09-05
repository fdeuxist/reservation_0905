package com.reservation.dto;

public class MemberInfoDto {
	//0829 UserDto VendorDto AuthoritiesDto
	//admin 권한으로 전체 계정의 권한을 조회,수정 (권한부여/계정정지등)하기 위한 목적으로 만듬
//	select u.email, u.name, u.phone, u.enable, 
//	    a.authority, 
//	    v.business_regi_num, v.business_name, v.zipcode, 
//	    v.basic_address, v.detail_address, v.business_type 
//	from users u 
//	left join authorities a on u.email = a.email
//	left join vendor v on u.email = v.email;
	
	private String email;
	private String name;
	private String phone;
	private Integer enable;
	
	private String authority;
	
	private String business_regi_num;
	private String business_name;
	private String zipcode;
	private String basic_address;
	private String detail_address;
	private String business_type;

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
	
	
	public MemberInfoDto() {}

	public MemberInfoDto(String email, String name, String phone, Integer enable, String authority,
			String business_regi_num, String business_name, String zipcode, String basic_address, String detail_address,
			String business_type) {
		super();
		this.email = email;
		this.name = name;
		this.phone = phone;
		this.enable = enable;
		this.authority = authority;
		this.business_regi_num = business_regi_num;
		this.business_name = business_name;
		this.zipcode = zipcode;
		this.basic_address = basic_address;
		this.detail_address = detail_address;
		this.business_type = business_type;
	}
	
	@Override
	public String toString() {
		return "MemberInfoDto [email=" + email + ", name=" + name + ", phone=" + phone + ", enable=" + enable
				+ ", authority=" + authority + ", business_regi_num=" + business_regi_num + ", business_name="
				+ business_name + ", zipcode=" + zipcode + ", basic_address=" + basic_address + ", detail_address="
				+ detail_address + ", business_type=" + business_type + "]";
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Integer getEnable() {
		return enable;
	}
	public void setEnable(Integer enable) {
		this.enable = enable;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getBusiness_regi_num() {
		return business_regi_num;
	}
	public void setBusiness_regi_num(String business_regi_num) {
		this.business_regi_num = business_regi_num;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getBasic_address() {
		return basic_address;
	}
	public void setBasic_address(String basic_address) {
		this.basic_address = basic_address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getBusiness_type() {
		return business_type;
	}
	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}
	
	

}
