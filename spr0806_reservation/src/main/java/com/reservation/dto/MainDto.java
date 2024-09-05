package com.reservation.dto;

import java.time.LocalDateTime;
import java.util.Date;
// 만든이: 김하겸
// 메인 홈페이지에 노출될 데이터 관련 필드값이며 메인홈페이지 객체에 대한 DTO입니다. 2024-08-13
import org.springframework.format.annotation.DateTimeFormat;

public class MainDto {
	private String u_id;
	private String u_name;
	private String u_password;
	private String u_gender;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime u_birthday;
	private String u_email;
	private String u_phone;
	private String u_address;
	
	public MainDto() {}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getU_name() {
		return u_name;
	}

	public void setU_name(String u_name) {
		this.u_name = u_name;
	}

	public String getU_password() {
		return u_password;
	}

	public void setU_password(String u_password) {
		this.u_password = u_password;
	}

	public String getU_gender() {
		return u_gender;
	}

	public void setU_gender(String u_gender) {
		this.u_gender = u_gender;
	}

	public LocalDateTime getU_birthday() {
		return u_birthday;
	}

	public void setU_birthday(LocalDateTime u_birthday) {
		this.u_birthday = u_birthday;
	}

	public String getU_email() {
		return u_email;
	}

	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public String getU_phone() {
		return u_phone;
	}

	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}

	public String getU_address() {
		return u_address;
	}

	public void setU_address(String u_address) {
		this.u_address = u_address;
	}

	@Override
	public String toString() {
		return "UserDto [u_id=" + u_id + ", u_name=" + u_name + ", u_password=" + u_password + ", u_gender=" + u_gender
				+ ", u_birthday=" + u_birthday + ", u_email=" + u_email + ", u_phone=" + u_phone + ", u_address="
				+ u_address + "]";
	}

	public MainDto(String u_id, String u_name, String u_password, String u_gender, LocalDateTime u_birthday, String u_email,
			String u_phone, String u_address) {
		super();
		this.u_id = u_id;
		this.u_name = u_name;
		this.u_password = u_password;
		this.u_gender = u_gender;
		this.u_birthday = u_birthday;
		this.u_email = u_email;
		this.u_phone = u_phone;
		this.u_address = u_address;
	}
	
	
	

}
