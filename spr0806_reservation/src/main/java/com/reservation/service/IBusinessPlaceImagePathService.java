package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.BusinessPlaceImagePathDto;

public interface IBusinessPlaceImagePathService {

	public ArrayList<BusinessPlaceImagePathDto> selectAllMainAndNormalImage(
			@Param("email") String email, @Param("business_regi_num") String business_regi_num)
			throws Exception;
	
	public ArrayList<BusinessPlaceImagePathDto> selectAllNotMainImage( String email,
			String business_regi_num) throws Exception;
	
	// 0906 특정벤더의 모든 메인 이미지를 메인이미지가 아니게 변경
	public void updateIsMainYToN(@Param("email") String email, @Param("business_regi_num") String business_regi_num)
			throws Exception;

	// 0906 특정벤더의 특정파일을 메인이미지로 변경
	public boolean setMainImage(@Param("email") String email, @Param("business_regi_num") String business_regi_num,
			@Param("place_img_path") String place_img_path) throws Exception;

	// 0906 특정 벤더 특정 이미지 삭제
	public boolean deleteImage(String place_img_path) throws Exception;

	// 0906 특정 벤더에게 대표 이미지가 있는지 확인 result type int
	public int countMainImage(@Param("email") String email, @Param("business_regi_num") String business_regi_num)
			throws Exception;

	// 0906 남아 있는 첫 번째 이미지를 대표 이미지로 설정
	public void setFirstImageAsMain(@Param("email") String email, @Param("business_regi_num") String business_regi_num)
			throws Exception;

	public  BusinessPlaceImagePathDto selectMainImage(@Param("email") String email, @Param("business_regi_num") String business_regi_num)
			throws Exception;

	public ArrayList<BusinessPlaceImagePathDto> selectAllMyBusinessPlaceImgPaths(@Param("email") String email,
			@Param("business_regi_num") String business_regi_num) throws Exception;

	public void insertMyBusinessPlaceImagePath(BusinessPlaceImagePathDto dto) throws Exception;

	public BusinessPlaceImagePathDto selectImage(String place_img_path) throws Exception;


}
