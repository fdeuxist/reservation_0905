package com.reservation.dao;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.VendorUserDto;

public interface VendorUserDao {
	
	//벤더 유저 조인 벤더 개인 정보 조회
	public VendorUserDto selectOneVendorEmailBusinessRegiNum(
	        @Param("email") String email, 
	        @Param("business_regi_num") String business_regi_num) throws Exception;

	
	
	
	
	
			
}
