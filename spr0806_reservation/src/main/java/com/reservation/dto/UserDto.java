package com.reservation.dto;

public class UserDto {
	//회원정보
	
	
	
	private String email;
	private String password;
	private String name;
	private String phone;
	private Integer enable;
	
	

	public UserDto() {}
	public UserDto(String email, String password, String name, String phone, Integer enable) {
		super();
		this.email = email;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.enable = enable;
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
	public Integer getEnable() {
		return enable;
	}
	public void setEnable(int enable) {
		this.enable = enable;
	}
	
	@Override
	public String toString() {
		return "UserDto [email=" + email + ", password=" + password + ", name=" + name + ", phone=" + phone
				+ ", enable=" + enable + "]";
	}
	

}