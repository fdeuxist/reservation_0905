package com.reservation.dto;

public class ReviewsDto {
/*
	create table reviews (
		    reservation_number varchar2(20) not null,   --예약(주문)번호 pk (년월일시분초ms)
		    review_date date,                           --리뷰작성 년월일
		    member_content varchar2(4000),              --회원 리뷰 내용
		    vendor_content varchar2(4000)              --사업자 답글 내용
		    );
*/
	private String reservation_number;
	private String review_date;
	private Integer star_point;
	private String member_content;
	private String vendor_content;

	public ReviewsDto() {}
	public ReviewsDto(String reservation_number, String review_date, Integer star_point, String member_content, String vendor_content) {
		super();
		this.reservation_number = reservation_number;
		this.review_date = review_date;
		this.star_point = star_point;
		this.member_content = member_content;
		this.vendor_content = vendor_content;
	}
	
	@Override
	public String toString() {
		return "\nReviewsDto [reservation_number=" + reservation_number + ", review_date=" + review_date + ", star_point="
				+ star_point + ", member_content=" + member_content + ", vendor_content=" + vendor_content + "]";
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
	public String getReview_date() {
		return review_date.substring(0, 10);
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date.substring(0, 10);
	}
	public String getMember_content() {
		return member_content;
	}
	public void setMember_content(String member_content) {
		this.member_content = member_content;
	}
	public String getVendor_content() {
		return vendor_content;
	}
	public void setVendor_content(String vendor_content) {
		this.vendor_content = vendor_content;
	}
	
	
}
