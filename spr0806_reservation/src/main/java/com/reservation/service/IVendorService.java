package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.VendorDto;


public interface IVendorService {

//	public VendorDto selectOneVendorEmailBusinessRegiNum(String vendor_email, String business_regi_num);

	public void insert(VendorDto dto) throws Exception;
	
	public ArrayList<VendorDto> selectAll() throws Exception;

    public int checkEmail(String email) throws Exception;
    
	public VendorDto selectEmail(String email) throws Exception;
	
	public void update(VendorDto dto) throws Exception;
	
	public void delete(String email) throws Exception;

	public VendorDto selectBusiness_regi_num(String business_regi_num) throws Exception;

	public ArrayList<VendorDto> selectAllVendorByBusinessType(String business_type) throws Exception;
	
	public ArrayList<VendorDto> selectAllVendorByBasicAddress(String basic_address) throws Exception;

	//public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(String email, String businessRegiNum);
	
}
