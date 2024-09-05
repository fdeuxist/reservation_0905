package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.VendorDto;

public interface VendorDao {
	
	
	public void insert(VendorDto dto) throws Exception;
	
	public ArrayList<VendorDto> selectAll() throws Exception;

	public VendorDto selectEmail(String email) throws Exception;
	
	public void update(VendorDto dto) throws Exception;
	
	public void delete(String email) throws Exception;

	public VendorDto selectBusiness_regi_num(String business_regi_num) throws Exception;

	public ArrayList<VendorDto> selectAllVendorByBusinessType(String business_type) throws Exception;
	
	public ArrayList<VendorDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

	public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(@Param("email") String email, @Param("business_regi_num") String business_regi_num);
	
}
