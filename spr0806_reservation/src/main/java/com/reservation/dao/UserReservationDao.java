package com.reservation.dao;

import java.util.ArrayList;

import com.reservation.dto.UserReservationDto;

public interface UserReservationDao {

	public void newOrder(UserReservationDto dto) throws Exception;
	public void tryCancelOrder(String reservation_number) throws Exception;
	public ArrayList<UserReservationDto> selectAllMyOrders(String user_email) throws Exception;
	public UserReservationDto selectOneMyOrder(String reservation_number) throws Exception;
	public void changeOrdersStatus(String status, String reservation_number) throws Exception;
	
}
