package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.SearchPlaceDto;

public interface ISearchPlaceService {

	public SearchPlaceDto selectOnePlace(String email, String business_regi_num) throws Exception;
	
	public ArrayList<SearchPlaceDto> selectAllVendorByBusinessType(String business_type) throws Exception;
	
	public ArrayList<SearchPlaceDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

}