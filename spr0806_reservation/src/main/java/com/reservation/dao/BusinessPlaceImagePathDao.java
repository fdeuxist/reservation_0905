package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.BusinessPlaceImagePathDto;

public interface BusinessPlaceImagePathDao {
	
	public ArrayList<BusinessPlaceImagePathDto> selectAllMyBusinessPlaceImgPaths(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num) throws Exception;
	
	public void insertMyBusinessPlaceImagePath(BusinessPlaceImagePathDto dto) throws Exception;
	
	
	
}
