package com.reservation.dto;

import java.util.Arrays;

public class BusinessPlaceInfoDto {
	// (특정 사업장 특정 사업자)의 업소 소개
	
	
/*수정전
 * create table business_place_info (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    place_info varchar2(4000),      --업소 소개
    img_path0  varchar2(255),       --이미지 저장 경로
    img_path1  varchar2(255),
    img_path2  varchar2(255),
    img_path3  varchar2(255),
    img_path4  varchar2(255),
    img_path5  varchar2(255),
    img_path6  varchar2(255),
    img_path7  varchar2(255),
    img_path8  varchar2(255),
    img_path9  varchar2(255)
    );
    
    수정후
    
	create table business_place_info (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    place_info varchar2(4000)      --업소 소개
    );
 */
	
	//사업장정보   email, business_regi_num 복합키 fk
	
	private String email;
	private String business_regi_num;
	private String place_info;
	
	

	public BusinessPlaceInfoDto() {}
	
	
	
	
	public BusinessPlaceInfoDto(String email, String business_regi_num, String place_info) {
		super();
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.place_info = place_info;
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
	public String getPlace_info() {
		return place_info;
	}
	public void setPlace_info(String place_info) {
		this.place_info = place_info;
	}




	@Override
	public String toString() {
		return "BusinessPlaceInfoDto [email=" + email + ", business_regi_num=" + business_regi_num + ", place_info="
				+ place_info + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
