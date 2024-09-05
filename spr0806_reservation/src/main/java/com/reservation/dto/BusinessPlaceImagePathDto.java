package com.reservation.dto;

public class BusinessPlaceImagePathDto {
/*
 * create table business_place_image_path (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    place_img_path  varchar2(255)
    );
 */
	private String email;
	private String business_regi_num;
	private String place_img_path;

	public BusinessPlaceImagePathDto() {}
	
	public BusinessPlaceImagePathDto(String email, String business_regi_num, String place_img_path) {
		super();
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.place_img_path = place_img_path;
	}
	@Override
	public String toString() {
		return "BusinessPlaceImagePathDto [email=" + email + ", business_regi_num=" + business_regi_num
				+ ", place_img_path=" + place_img_path + "]";
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
	public String getPlace_img_path() {
		return place_img_path;
	}
	public void setPlace_img_path(String place_img_path) {
		this.place_img_path = place_img_path;
	}
	
	
	
}
