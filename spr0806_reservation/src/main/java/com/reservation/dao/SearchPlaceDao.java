package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.SearchPlaceDto;

public interface SearchPlaceDao {
	public SearchPlaceDto selectOnePlace(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num) throws Exception;
	
	public ArrayList<SearchPlaceDto> selectAllVendorByBusinessType(String business_type) throws Exception;
	
	public ArrayList<SearchPlaceDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

}
