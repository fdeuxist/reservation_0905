package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.VendorReservationDto;

public interface IVendorReservationService {
   
   public void insert(VendorReservationDto dto) throws Exception;
   
   public VendorReservationDto selectAllEnableVendorsReservation(
         String email, String business_regi_num) throws Exception;
   

   public VendorReservationDto selectOneVendorsReservation(
         VendorReservationDto dto) throws Exception;
   
   
	// 특정 벤더가 특정 한 달을 조회해서 자기가 예약을 등록한 날이 있는 날짜 리스트를 볼 때 씀
	public ArrayList<VendorReservationDto> selectAllOneVendorsMyOneMonthReservations(
			String email, String business_regi_num, String open_date) throws Exception;
	//														'YYYY-MM'
	
	// 특정 벤더가 특정 날짜 안에 등록한 시간을 볼 때 씀
	public VendorReservationDto selectOneOneVendorsMyOneDayReservation(
					String email, String business_regi_num, String open_date) throws Exception;
	// 																'YYYY-MM-DD'
   
   
	// 멤버가 특정 벤더 한 달을 조회해서 예약이 가능한 날(status_flag=1)이 있는 날짜 리스트를 볼 때 씀 
	public ArrayList<VendorReservationDto> selectAllOneVendorsYourOneMonthReservations(
			String email, String business_regi_num, String open_date) throws Exception;
	//														'YYYY-MM'
   
   
   

   //=====↓↓↓↓↓↓↓↓↓↓↓↓↓======0813오규원===========
   
   public VendorReservationDto selectAllVendorsReservation(String email, String business_regi_num) throws Exception;
   
   public void closeDay( String email, String business_regi_num, String open_date) throws Exception;
   
   public void openDay(String email, String business_regi_num, String open_date) throws Exception;
   
   public void openDateTimesUpdate (String times, String email, String business_regi_num,String  open_date) throws Exception;
   

   //=====↑↑↑↑↑↑↑↑↑↑↑↑↑======0813오규원===========


}
