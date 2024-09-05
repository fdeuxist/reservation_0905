package com.reservation.dao;

import java.util.ArrayList;

import com.reservation.dto.ReservationItemsDto;

public interface ReservationItemsDao {
	
	public ArrayList<ReservationItemsDto> selectAllOneOrderItems(String reservation_number) throws Exception;
	
	public void insert(ReservationItemsDto dto) throws Exception;
	
}
