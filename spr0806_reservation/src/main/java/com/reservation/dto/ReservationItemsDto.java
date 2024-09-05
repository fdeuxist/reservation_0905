package com.reservation.dto;

public class ReservationItemsDto {
	/*
	-- 주문시 주문번호와 주문한 아이템의 id와 주문당시 아이템들의 데이터들이 복사저장되어 
	-- 이후 아이템들이 수정되어도 주문내역에는 영향이 없음
	-- 3개 예약했으면 3행 insert에 reservation_number 3개 다 같고 이하 내용은 각각 다름
	drop table reservation_item;
	create table reservation_item (
	    reservation_number varchar2(20) not null,   --주문번호 user_reservation fk
	    item_id number not null,                    --service_items              복사저장
	    email varchar2(255) not null,               --주문당시 사업자의 이메일      	   복사저장
	    business_regi_num varchar2(20) not null,    --주문당시 사업자의 사업자번호       	복사저장
	    service_name varchar2(255),                 --주문당시 서비스 이름(service_items)      복사저장
	    service_description varchar2(255),          --주문당시 설명 (service_items)           복사저장
	    required_time number,                       --주문당시 제공(필요)시간 (몇칸짜리인지)  	복사저장
    	service_price number,                       --주문당시 서비스 가격(service_items)   복사저장
	);
	*/
	
	
    private String reservation_number;
    private String item_id;
    private String email;
	private String business_regi_num;
	private String service_name;
	private String service_description;
	private Integer required_time;
	private Integer service_price;
	
	
	
	

	public ReservationItemsDto() {}
	
	
	public ReservationItemsDto(String reservation_number, String item_id, String email, String business_regi_num,
			String service_name, String service_description, Integer required_time, Integer service_price) {
		super();
		this.reservation_number = reservation_number;
		this.item_id = item_id;
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.service_name = service_name;
		this.service_description = service_description;
		this.required_time = required_time;
		this.service_price = service_price;
	}
	@Override
	public String toString() {
		return "ReservationItemDto [reservation_number=" + reservation_number + ", item_id=" + item_id + ", email="
				+ email + ", business_regi_num=" + business_regi_num + ", service_name=" + service_name
				+ ", service_description=" + service_description + ", required_time=" + required_time
				+ ", service_price=" + service_price + "]";
	}
	public String getReservation_number() {
		return reservation_number;
	}
	public void setReservation_number(String reservation_number) {
		this.reservation_number = reservation_number;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
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
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public String getService_description() {
		return service_description;
	}
	public void setService_description(String service_description) {
		this.service_description = service_description;
	}
	public Integer getRequired_time() {
		return required_time;
	}
	public void setRequired_time(Integer required_time) {
		this.required_time = required_time;
	}
	public Integer getService_price() {
		return service_price;
	}
	public void setService_price(Integer service_price) {
		this.service_price = service_price;
	}
	
	
	
	
	
}
