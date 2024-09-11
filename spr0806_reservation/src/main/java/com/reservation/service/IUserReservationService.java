package com.reservation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.reservation.dto.UserReservationDto;

public interface IUserReservationService {
	
	public void newOrder(UserReservationDto dto) throws Exception;
	public void tryCancelOrder(String reservation_number) throws Exception;
	public ArrayList<UserReservationDto> selectAllMyOrders(String user_email) throws Exception;
	public UserReservationDto selectOneMyOrder(String reservation_number) throws Exception;
	public void changeOrdersStatus(String status, String reservation_number) throws Exception;
	
	
	//대시보드 관련 기능 만든이:오규원 추가일자:0905
	public int countEmail() throws Exception;
	public int countVendorName(String vendor_name) throws Exception;
	public int countBasicAddress(String basic_address) throws Exception;
	public int countDetailAddress(String detail_address) throws Exception;
	public int countServiceName(String service_name) throws Exception;
	public List<Map<String,Object>> countTimeshhmm() throws Exception;
	public List<Map<String,Object>> sumServicePrice() throws Exception;
	public List<Map<String,Object>> countReservationDate() throws Exception;
}
