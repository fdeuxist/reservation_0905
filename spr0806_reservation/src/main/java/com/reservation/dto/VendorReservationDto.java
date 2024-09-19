package com.reservation.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

public class VendorReservationDto {
	// 특정 사업자 특정 사업자의  어떤 날에 영업가능 시간대를 등록
	
/*
 * create table vendor_reservation (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    open_date date,                 --예약등록 년월일 (예약을 받겠다는)
    times varchar2(50),             --예약등록 시간48개단위
    status_flag varchar2(4)         --해당년월일 예약 비활성화(수정중,예약불가)/활성화(수정완료,예약가능)등 상태. 
    									수정중이라면 일반유저가 예약을 못함
    );
 */
	
	private String email;
	private String business_regi_num;
	
//	@DateTimeFormat(pattern="yyyy-MM-dd")
//	private LocalDateTime open_date;
	
	private String open_date;
	
	private String times;
	private String status_flag;
	
	

	public VendorReservationDto() {}
	
	
	public VendorReservationDto(String email, String business_regi_num, String open_date, String times,
			String status_flag) {
		super();
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.open_date = open_date.substring(0, 10);
		this.times = times;
		this.status_flag = status_flag;
	}
	@Override
	public String toString() {
		return "VendorReservationDto [email=" + email + ", business_regi_num=" + business_regi_num + ", open_date="
				+ open_date + ", times=" + times + ", status_flag=" + status_flag + "]";
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
	public String getOpen_date() {
		return open_date.substring(0, 10);
	}
	public void setOpen_date(String open_date) {
		this.open_date = open_date.substring(0, 10);
	}
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getStatus_flag() {
		return status_flag;
	}
	public void setStatus_flag(String status_flag) {
		this.status_flag = status_flag;
	}
	
	
	
	
	
	
	
	
	
	
	
}
