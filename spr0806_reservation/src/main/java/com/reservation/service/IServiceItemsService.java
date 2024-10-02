package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.ImageDto;
import com.reservation.dto.ServiceItemsDto;

public interface IServiceItemsService {
	
	public ArrayList<ServiceItemsDto> selectAllYourItems(String email, String business_regi_num) throws Exception;

	public void insertMyItem(ServiceItemsDto dto) throws Exception;
	
	public ArrayList<ServiceItemsDto> selectAllMyItems(String email, String business_regi_num) throws Exception;

	public ServiceItemsDto selectOneItem(String item_id) throws Exception;
	
	public int updateMyItem(ServiceItemsDto dto) throws Exception;
	
	public void deleteMyItem(String email, String business_regi_num) throws Exception;
	public void insertItemImg(ImageDto dto) throws Exception;
	public ArrayList<ServiceItemsDto> selectItemByTime(int time) throws Exception;
	
	public ArrayList<ServiceItemsDto> selectAll() throws Exception;
}


