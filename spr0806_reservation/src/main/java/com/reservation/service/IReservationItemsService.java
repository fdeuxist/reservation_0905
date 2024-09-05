package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.ReservationItemsDto;

public interface IReservationItemsService {
	
	public ArrayList<ReservationItemsDto> selectAllOneOrderItems(String reservation_number) throws Exception;
	
	public void insert(ReservationItemsDto dto) throws Exception;
	
}
