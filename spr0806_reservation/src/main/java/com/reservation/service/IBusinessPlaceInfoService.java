package com.reservation.service;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.BusinessPlaceInfoDto;

public interface IBusinessPlaceInfoService {
	
	
	public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num) throws Exception;
	
	public void insertMyBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception;
	
    //0903 vendor 전환시 insert되고 이후 update로만 관리하기 위해 만듬
    public void updateMyBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception;
	
	
	
	
	
	
	
	
	//public BusinessPlaceInfoDto selectVendorBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception;
	
	
}
