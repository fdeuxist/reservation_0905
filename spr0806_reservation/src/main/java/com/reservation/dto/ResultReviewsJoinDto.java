package com.reservation.dto;

public class ResultReviewsJoinDto {
	private Integer star_point;
	private String reservation_number;
	private String business_regi_num;
	private String vendor_phone;
	private String vendor_email;
	private String business_name;
	private String basic_address;
	private String detail_address;
	private double averagePoint=0;
	 private int reviewCount=0;
	 private String encodedImage = null;
	
	public ResultReviewsJoinDto() {}

	

	public ResultReviewsJoinDto(Integer star_point, String reservation_number, String business_regi_num,
			String vendor_phone, String vendor_email, String business_name, String basic_address, String detail_address,
			double averagePoint, int reviewCount, String encodedImage) {
		super();
		this.star_point = star_point;
		this.reservation_number = reservation_number;
		this.business_regi_num = business_regi_num;
		this.vendor_phone = vendor_phone;
		this.vendor_email = vendor_email;
		this.business_name = business_name;
		this.basic_address = basic_address;
		this.detail_address = detail_address;
		this.averagePoint = averagePoint;
		this.reviewCount = reviewCount;
		this.encodedImage = encodedImage;
	}



	public String getEncodedImage() {
		return encodedImage;
	}



	public void setEncodedImage(String encodedImage) {
		this.encodedImage = encodedImage;
	}



	public Integer getStar_point() {
		return star_point;
	}

	public void setStar_point(Integer star_point) {
		this.star_point = star_point;
	}

	public String getReservation_number() {
		return reservation_number;
	}

	public void setReservation_number(String reservation_number) {
		this.reservation_number = reservation_number;
	}

	public String getBusiness_regi_num() {
		return business_regi_num;
	}

	public void setBusiness_regi_num(String business_regi_num) {
		this.business_regi_num = business_regi_num;
	}

	public String getVendor_phone() {
		return vendor_phone;
	}

	public void setVendor_phone(String vendor_phone) {
		this.vendor_phone = vendor_phone;
	}

	public String getVendor_email() {
		return vendor_email;
	}

	public void setVendor_email(String vendor_email) {
		this.vendor_email = vendor_email;
	}

	public String getBusiness_name() {
		return business_name;
	}

	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
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

	public double getAveragePoint() {
		return averagePoint;
	}

	public void setAveragePoint(double averagePoint) {
		this.averagePoint = averagePoint;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	

	
	
}
