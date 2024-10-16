package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.ReviewsDto;

public interface IReviewsService {
	
	//해당업체 최신 리뷰 5개 조회
	public ArrayList<ReviewsDto> selectFiveLatestReviews(String vendor_email, String business_regi_num) throws Exception;
	
	//멤버 리뷰작성
	public void insert(String reservation_number,
			Integer star_point,
			String member_content) throws Exception;
	public void insert(ReviewsDto dto) throws Exception;

	//멤버 리뷰수정
	public void update(String reservation_number,
			Integer star_point,
			String member_content) throws Exception;
	public void update(ReviewsDto dto) throws Exception;

	public ReviewsDto selectOne(String reservation_number) throws Exception;
	
	//리턴이 null이면 댓글 작성 , dto면 수정창 보여주기
	public ReviewsDto isReviewExist(String reservation_number) throws Exception;
	
	//vendor가 답글 달아야 할 목록
	public ArrayList<ReviewsDto> vendorMustCommentList(
			String vendor_email, 
			String business_regi_num) throws Exception;
	
	//벤더가 update로 답글 달기
	public void vendorUpdateComment(String vendor_content, String reservation_number) throws Exception;

}