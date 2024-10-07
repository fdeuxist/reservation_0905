package com.reservation.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import com.reservation.dto.ResultReviewsJoinDto;
import com.reservation.dto.SearchPlaceDto;

public interface ISearchPlaceService {

	public SearchPlaceDto selectOnePlace(String email, String business_regi_num) throws Exception;

	public ArrayList<SearchPlaceDto> selectAllVendorByBusinessType(String business_type) throws Exception;

	public ArrayList<SearchPlaceDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

	// 10 07 리뷰별점과 벤더정보를 조인한 데이터 결과값 셀렉트 Service
	public ArrayList<ResultReviewsJoinDto> joinReviewsAndVendor() throws Exception;

	
	

}