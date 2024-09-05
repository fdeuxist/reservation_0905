package com.reservation.dto;

import java.sql.Timestamp;

public class PlaceDetailDto {
	
	private int id;
	private String place_name;
	private String place_address;
	private String place_image_url;
	private Timestamp created_at;
	private Timestamp updated_at;
	
	public PlaceDetailDto() {};
	
	public PlaceDetailDto(int id, String place_name, String place_address, String place_image_url, Timestamp created_at,
			Timestamp updated_at) {
		super();
		this.id = id;
		this.place_name = place_name;
		this.place_address = place_address;
		this.place_image_url = place_image_url;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getPlace_address() {
		return place_address;
	}
	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}
	public String getPlace_image_url() {
		return place_image_url;
	}
	public void setPlace_image_url(String place_image_url) {
		this.place_image_url = place_image_url;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
	
	
}
