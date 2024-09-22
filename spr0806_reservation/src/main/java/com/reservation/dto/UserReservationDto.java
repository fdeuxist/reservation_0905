package com.reservation.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

public class UserReservationDto {
/*
 * 수정전
 * create table user_reservation (
    reservation_number varchar2(20) not null,   --예약(주문)번호 pk (년월일시분초ms)
    user_email varchar2(255) not null,          --유저이메일 fk (예악자)    (users)
    vendor_email varchar2(255) not null,        --사업자이메일 ┐                (vendor)
    business_regi_num varchar2(20),             --사업자번호　 ┴ 복합키 fk       (vendor)
    reservation_date date,                      --이용 예정 년월일
    times varchar2(50),                         --이용 예정 시간 48개단위
    service_name varchar2(255),                 --예약 당시 이용 예정 서비스 이름(service_items)
    service_price number,                       --예약 당시 이용 예정 서비스 가격(service_items)
    zipcode varchar2(10),                       --예약 당시 이용 예정 장소 우편번호(vendor)
    basic_address varchar2(255),                --예약 당시 이용 예정 장소 기본주소(vendor)
    detail_address varchar2(255),               --예약 당시 이용 예정 장소 상세주소(vendor)
    status varchar2(50)                         --주문 상태. 1입금대기/2입금완료/3이용완료/
                                                --       4이용자취소(회원요청,사업자승인필요)/
                                                --       5사업자취소(사업자요청,회원승인불필요)/6환불대기/7환불완료 등 상태
    );
    
    수정후
drop table user_reservation;
create table user_reservation (
    reservation_number varchar2(20) not null,   --예약(주문)번호 pk (년월일시분초ms)
    user_email varchar2(255) not null,          --유저이메일 fk (예악자)    (users)
    user_name varchar2(255) not null,           --유저이름 (예악자)         (users)
    user_phone  varchar2(20) not null,          --예약 당시 유저의 전화번호 (예악자)    (users)
    vendor_email varchar2(255) not null,        --사업자이메일 ┐                (vendor)
    business_regi_num varchar2(20),             --사업자번호　 ┴ 복합키 fk       (vendor)
    vendor_name  varchar2(255) not null,        --예약 당시 사업자의 이름 (사업자)    (vendor)
    vendor_phone  varchar2(20) not null,        --예약 당시 사업자의 전화번호 (사업자)    (vendor)
    business_name varchar2(255),                --예약 당시 사업명(간판) --추가
    zipcode varchar2(10),                       --예약 당시 이용 예정 장소 우편번호(vendor)
    basic_address varchar2(255),                --예약 당시 이용 예정 장소 기본주소(vendor)
    detail_address varchar2(255),               --예약 당시 이용 예정 장소 상세주소(vendor)
    reservation_date date,                      --예약 발생 년월일
    reservation_use_date date,                  --이용 예정 년월일
    times varchar2(50),                         --이용 예정 시간 48개단위
    times_hhmm varchar2(20),                    --이용 예정 시간 HH:mm   --추가
    total_service_name varchar2(4000),          --예약 당시 이용 예정 서비스 이름들(service_items)
    total_service_price number,                 --예약 당시 이용 예정 서비스 가격 총 합 (service_items)
    total_required_time number,                 --예약 당시 이용 예정 제공(필요)시간 총 합 (service_items)
    user_request_memo varchar2(4000),           --유저 요청사항 메모. 주문자와 방문자가 다를때 연락처를 적는다거나 기타 요청사항 등
    status varchar2(50)                         --주문 상태. 1입금대기/2입금완료/3이용완료/
                                                --       4이용자취소(회원요청,사업자승인필요)/
                                                --       5사업자취소(사업자요청,회원승인불필요)/6환불대기/7환불완료 등 상태
    );


 */
	
	private String reservation_number;
	private String user_email;
	private String user_phone;
	private String user_name;
	private String vendor_email;
	private String business_regi_num;
	
//	@DateTimeFormat(pattern="yyyy-MM-dd")
//	private LocalDateTime reservation_date;

	private String vendor_name;
	private String vendor_phone;
	private String business_name;	// 추가
	private String zipcode;
	private String basic_address;
	private String detail_address;
	
	private String reservation_date;
	private String reservation_use_date;
	private String times;
	private String times_hhmm;	// 추가
	
	private String total_service_name;
	private Integer total_service_price;
	private Integer total_required_time;
	private String user_request_memo;
	private String status;
	
	public UserReservationDto() {}

	public UserReservationDto(String reservation_number, String user_email, String user_phone, String user_name,
			String vendor_email, String business_regi_num, String vendor_name, String vendor_phone,
			String business_name, String zipcode, String basic_address, String detail_address, String reservation_date,
			String reservation_use_date, String times, String times_hhmm, String total_service_name,
			Integer total_service_price, Integer total_required_time, String user_request_memo, String status) {
		super();
		this.reservation_number = reservation_number;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_name = user_name;
		this.vendor_email = vendor_email;
		this.business_regi_num = business_regi_num;
		this.vendor_name = vendor_name;
		this.vendor_phone = vendor_phone;
		this.business_name = business_name;
		this.zipcode = zipcode;
		this.basic_address = basic_address;
		this.detail_address = detail_address;
        this.reservation_date = reservation_date.substring(0, 10);
        this.reservation_use_date = reservation_use_date.substring(0, 10);
		this.times = times;
		this.times_hhmm = times_hhmm;
		this.total_service_name = total_service_name;
		this.total_service_price = total_service_price;
		this.total_required_time = total_required_time;
		this.user_request_memo = user_request_memo;
		this.status = status;
	}

	@Override
	public String toString() {
		return "\nUserReservationDto [reservation_number=" + reservation_number + ", user_email=" + user_email
				+ ", user_phone=" + user_phone + ", user_name=" + user_name + ", vendor_email=" + vendor_email
				+ ", business_regi_num=" + business_regi_num + ", vendor_name=" + vendor_name + ", vendor_phone="
				+ vendor_phone + ", business_name=" + business_name + ", zipcode=" + zipcode + ", basic_address="
				+ basic_address + ", detail_address=" + detail_address + ", reservation_date=" + reservation_date
				+ ", reservation_use_date=" + reservation_use_date + ", times=" + times + ", times_hhmm=" + times_hhmm
				+ ", total_service_name=" + total_service_name + ", total_service_price=" + total_service_price
				+ ", total_required_time=" + total_required_time + ", user_request_memo=" + user_request_memo
				+ ", status=" + status + "]";
	}

	public String getReservation_number() {
		return reservation_number;
	}

	public void setReservation_number(String reservation_number) {
		this.reservation_number = reservation_number;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getVendor_email() {
		return vendor_email;
	}

	public void setVendor_email(String vendor_email) {
		this.vendor_email = vendor_email;
	}

	public String getBusiness_regi_num() {
		return business_regi_num;
	}

	public void setBusiness_regi_num(String business_regi_num) {
		this.business_regi_num = business_regi_num;
	}

	public String getVendor_name() {
		return vendor_name;
	}

	public void setVendor_name(String vendor_name) {
		this.vendor_name = vendor_name;
	}

	public String getVendor_phone() {
		return vendor_phone;
	}

	public void setVendor_phone(String vendor_phone) {
		this.vendor_phone = vendor_phone;
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

	public String getReservation_date() {
        return reservation_date.substring(0, 10);
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date.substring(0, 10);
	}

	public String getReservation_use_date() {
		return reservation_use_date.substring(0, 10);
	}

	public void setReservation_use_date(String reservation_use_date) {
		this.reservation_use_date = reservation_use_date.substring(0, 10);
	}

	public String getTimes() {
		return times;
	}

	public void setTimes(String times) {
		this.times = times;
	}

	public String getTimes_hhmm() {
		return times_hhmm;
	}

	public void setTimes_hhmm(String times_hhmm) {
		this.times_hhmm = times_hhmm;
	}

	public String getTotal_service_name() {
		return total_service_name;
	}

	public void setTotal_service_name(String total_service_name) {
		this.total_service_name = total_service_name;
	}

	public Integer getTotal_service_price() {
		return total_service_price;
	}

	public void setTotal_service_price(Integer total_service_price) {
		this.total_service_price = total_service_price;
	}

	public Integer getTotal_required_time() {
		return total_required_time;
	}

	public void setTotal_required_time(Integer total_required_time) {
		this.total_required_time = total_required_time;
	}

	public String getUser_request_memo() {
		return user_request_memo;
	}

	public void setUser_request_memo(String user_request_memo) {
		this.user_request_memo = user_request_memo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
	

	
	
}
