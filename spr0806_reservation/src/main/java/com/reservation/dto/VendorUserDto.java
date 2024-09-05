package com.reservation.dto;

public class VendorUserDto {
	
	//join 조회용 아직 사용처 없음
	
	/*
	create table users(
    email varchar2(255),		-- pk, email(id)
    password varchar2(255),		--
    name varchar2(255),			--
    phone varchar2(20),			--
    enable integer default 1 not null 	-- 
    );
	create table vendor (
    email varchar2(255) not null,   --fk, email(id)
    business_regi_num varchar2(20), --사업자등록번호
    business_name varchar2(255),    --사업명(간판)
    zipcode varchar2(10),           --우편번호
    basic_address varchar2(255),    --기본주소
    detail_address varchar2(255),   --상세주소
    business_type varchar2(255)     --업종코드
    );
	*/

	private String email;
	private String password;
	private String name;
	private String phone;
	private int enable;
	private String business_regi_num;
	private String business_name;
	private String zipcode;
	private String basic_address;
	private String detail_address;
	private String business_type;
	
	
	

	public VendorUserDto() {}




	public VendorUserDto(String email, String password, String name, String phone, int enable, String business_regi_num,
			String business_name, String zipcode, String basic_address, String detail_address, String business_type) {
		super();
		this.email = email;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.enable = enable;
		this.business_regi_num = business_regi_num;
		this.business_name = business_name;
		this.zipcode = zipcode;
		this.basic_address = basic_address;
		this.detail_address = detail_address;
		this.business_type = business_type;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getPassword() {
		return password;
	}




	public void setPassword(String password) {
		this.password = password;
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




	public int getEnable() {
		return enable;
	}




	public void setEnable(int enable) {
		this.enable = enable;
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




	@Override
	public String toString() {
		return "VendorUserDto [email=" + email + ", password=" + password + ", name=" + name + ", phone=" + phone
				+ ", enable=" + enable + ", business_regi_num=" + business_regi_num + ", business_name=" + business_name
				+ ", zipcode=" + zipcode + ", basic_address=" + basic_address + ", detail_address=" + detail_address
				+ ", business_type=" + business_type + "]";
	}




	
	
	
	
	
	
	
	
	
}
