package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.ImageDto;
import com.reservation.dto.ServiceItemsDto;

public interface ServiceItemsDao {

	public ArrayList<ServiceItemsDto> selectAllYourItems(
			@Param("email") String email, @Param("business_regi_num") String business_regi_num) throws Exception;

	public void insertMyItem(ServiceItemsDto dto) throws Exception;
	
	public ArrayList<ServiceItemsDto> selectAllMyItems(
			@Param("email") String email, @Param("business_regi_num") String business_regi_num) throws Exception;

	public ServiceItemsDto selectOneItem(String item_id) throws Exception;
	
	public int updateMyItem(ServiceItemsDto dto) throws Exception;
	
	public void deleteMyItem(String email, String business_regi_num) throws Exception;
	
	public void insertItemImg(ImageDto dto) throws Exception;
	
	public ArrayList<ServiceItemsDto> selectAll() throws Exception;
	
	
	//메뉴 소요시간에 따른 리스트 출력
	public ArrayList<ServiceItemsDto> selectItemByTime(int time) throws Exception;

	
	
}
