package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.ReviewsDto;

public interface ReviewsDao {
	
	//해당업체 최신 리뷰 5개 조회
	public ArrayList<ReviewsDto> selectFiveLatestReviews(
			@Param("vendor_email") String vendor_email, 
			@Param("business_regi_num") String business_regi_num) throws Exception;
	
	//멤버 리뷰작성
	public void insert(
					@Param("reservation_number")String reservation_number,
					@Param("star_point")Integer star_point,
					@Param("member_content")String member_content) throws Exception;
	public void insert(ReviewsDto dto) throws Exception;
	
	//멤버 리뷰수정
	public void update(
					@Param("reservation_number")String reservation_number,
					@Param("star_point")Integer star_point,
					@Param("member_content")String member_content) throws Exception;
	public void update(ReviewsDto dto) throws Exception;
	
	public ReviewsDto selectOne(String reservation_number) throws Exception;
	
	//리턴이 0이면 댓글 작성, 1이면 수정
	public ReviewsDto isReviewExist(String reservation_number) throws Exception;
	
	//vendor가 답글 달아야 할 목록
	public ArrayList<ReviewsDto> vendorMustCommentList(
			@Param("vendor_email") String vendor_email, 
			@Param("business_regi_num") String business_regi_num) throws Exception;
	
	//벤더가 update로 답글 달기
	public void vendorUpdateComment(
			@Param("vendor_content") String vendor_content, 
			@Param("reservation_number") String reservation_number) throws Exception;

	
}
