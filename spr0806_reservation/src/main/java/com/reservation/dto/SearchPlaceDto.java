package com.reservation.dto;

public class SearchPlaceDto {

	// 장소 검색시 사용하는 뷰
	// users, vendor, business_place_info 3개 테이블을 join함 
	/*
	create view search_place as
	select 
	    u.email,
	    u.phone,
	    v.business_regi_num,
	    v.business_name,
	    v.basic_address,
	    v.detail_address,
	    v.business_type,
	    b.place_info
	from 
	    users u
	join 
	    vendor v on u.email = v.email
	join 
	    business_place_info b on v.email = b.email and v.business_regi_num = b.business_regi_num;
	    
	View SEARCH_PLACE이(가) 생성되었습니다.
	
	이름                널? 유형             
	----------------- -- -------------- 
	EMAIL                VARCHAR2(255)  
	PHONE                VARCHAR2(20)   
	BUSINESS_REGI_NUM    VARCHAR2(20)   
	BUSINESS_NAME        VARCHAR2(255)  
	BASIC_ADDRESS        VARCHAR2(255)  
	DETAIL_ADDRESS       VARCHAR2(255)  
	BUSINESS_TYPE        VARCHAR2(255)  
	PLACE_INFO           VARCHAR2(4000) 
	 */

	private String email;
	private String phone;
	private String business_regi_num;
	private String business_name;
	private String basic_address;
	private String detail_address;
	private String business_type;
	private String place_info;
	
	public String getEmail() {
		return email;
	}
	public String getPhone() {
		return phone;
	}
	public String getBusiness_regi_num() {
		return business_regi_num;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public String getBasic_address() {
		return basic_address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public String getBusiness_type() {
		return business_type;
	}
	public String getPlace_info() {
		return place_info;
	}
	@Override
	public String toString() {
		return "\nSearchPlaceDto [email=" + email + ", phone=" + phone + ", business_regi_num=" + business_regi_num
				+ ", business_name=" + business_name + ", basic_address=" + basic_address + ", detail_address="
				+ detail_address + ", business_type=" + business_type + ", place_info=" + place_info + "]";
	}
	public SearchPlaceDto() {}
	public SearchPlaceDto(String email, String phone, String business_regi_num, String business_name,
			String basic_address, String business_type, String place_info) {
		super();
		this.email = email;
		this.phone = phone;
		this.business_regi_num = business_regi_num;
		this.business_name = business_name;
		this.basic_address = basic_address;
		this.business_type = business_type;
		this.place_info = place_info;
	}
	
}
