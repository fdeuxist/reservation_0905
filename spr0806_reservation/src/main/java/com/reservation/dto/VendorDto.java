package com.reservation.dto;

public class VendorDto {
	/*
	create table vendor (
	    email varchar2(255) not null,
	    business_regi_num varchar2(20),
	    business_name varchar2(255),
	    zipcode varchar2(10),
	    basic_address varchar2(255),
	    detail_address varchar2(255),
	    business_type varchar2(255)
	    );
	*/
	
	private String email;
	private String business_regi_num;
	private String business_name;
	private String zipcode;
	private String basic_address;
	private String detail_address;
	private String business_type;
	
	
	

	public VendorDto() {}
	
	public VendorDto(String email, String business_regi_num, String business_name, String zipcode, String basic_address,
			String detail_address, String business_type) {
		super();
		this.email = email;
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
		return "VendorDto [email=" + email + ", business_regi_num=" + business_regi_num + ", business_name="
				+ business_name + ", zipcode=" + zipcode + ", basic_address=" + basic_address + ", detail_address="
				+ detail_address + ", business_type=" + business_type + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
}
