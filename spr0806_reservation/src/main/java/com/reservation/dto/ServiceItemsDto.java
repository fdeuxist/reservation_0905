package com.reservation.dto;

public class ServiceItemsDto {

	// (특정 사업장의 특정 사업자)가 제공하는 item에 대한 정보
	// item의 제공(시술/교육/서비스)시간과 가격과 판매가능상태 여부등

	/*
	create table service_items (
    item_id number not null,         --pk 
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20) not null, --사업자번호　 ┴ 복합키
    service_name varchar2(255),             --상품명
    service_description varchar2(255),      --설명
    required_time number,                   --제공(필요)시간 (몇칸짜리인지)
    service_price number,                   --가격
    item_status varchar2(10) default '1' not null                --item 상태, (사용가능 여부 등)  (1:사용, 0:미사용 등)
    );
	 */
	private String item_id;
	private String email;
	private String business_regi_num;
	private String service_name;
	private String service_description;
	private Integer required_time;
	private Integer service_price;
	private Integer item_status;

	public ServiceItemsDto() {
	}

	
	
	
	
	
	public ServiceItemsDto(String item_id, String email, String business_regi_num, String service_name,
			String service_description, Integer required_time, Integer service_price, Integer item_status) {
		super();
		this.item_id = item_id;
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.service_name = service_name;
		this.service_description = service_description;
		this.required_time = required_time;
		this.service_price = service_price;
		this.item_status = item_status;
	}











	@Override
	public String toString() {
		return "\nServiceItemsDto [item_id=" + item_id + ", email=" + email + ", business_regi_num=" + business_regi_num
				+ ", service_name=" + service_name + ", service_description=" + service_description + ", required_time="
				+ required_time + ", service_price=" + service_price + ", item_status=" + item_status + ", toString()="
				+ super.toString() + "]";
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

	public Integer getItem_status() {
		return item_status;
	}

	public void setItem_status(Integer item_status) {
		this.item_status = item_status;
	}

}
