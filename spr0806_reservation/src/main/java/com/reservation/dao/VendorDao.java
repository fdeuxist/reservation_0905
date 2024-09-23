package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.VendorDto;

public interface VendorDao {
	
	//public VendorDto selectOneVendorEmailBusinessRegiNum(String vendor_email, String business_regi_num);
	
	public void insert(VendorDto dto) throws Exception;
	
	public ArrayList<VendorDto> selectAll() throws Exception;

    public int checkEmail(String email) throws Exception;
    
	public VendorDto selectEmail(String email) throws Exception;
	
	public void update(VendorDto dto) throws Exception;
	
	public int delete(String email) throws Exception;

	public VendorDto selectBusiness_regi_num(String business_regi_num) throws Exception;

	public ArrayList<VendorDto> selectAllVendorByBusinessType(String business_type) throws Exception;
	
	public ArrayList<VendorDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

	//public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(@Param("email") String email, @Param("business_regi_num") String business_regi_num);
	
	
	//대시보드 관련 기능 만든이:오규원 추가일자:0905
	public int countBusinessType(String business_type)throws Exception;
	public String selectBusinessType(String business_regi_num)throws Exception;
}
