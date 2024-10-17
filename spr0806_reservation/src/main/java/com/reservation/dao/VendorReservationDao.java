package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.VendorReservationDto;

public interface VendorReservationDao {

	public void insert(VendorReservationDto dto) throws Exception;

	public VendorReservationDto selectAllEnableVendorsReservation(String email, String business_regi_num)
			throws Exception;

	//0906 overloading 컬럼 직접 넣어주기 위해 오버로딩함   특정 벤더 특정 일이 영업중인지 체크하기 위해 사용
	public VendorReservationDto selectOneVendorsReservation(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num, 
			@Param("open_date") String open_date) throws Exception;
	public VendorReservationDto selectOneVendorsReservation(VendorReservationDto dto) throws Exception;

	
	
	
	// 특정 벤더가 특정 한 달을 조회해서 자기가 예약을 등록한 날이 있는 날짜 리스트를 볼 때 씀
	public ArrayList<VendorReservationDto> selectAllOneVendorsMyOneMonthReservations(
			@Param("email") String email,
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date) throws Exception;
	//									'YYYY-MM'
	
	// 특정 벤더가 특정 날짜 안에 등록한 시간을 볼 때 씀
	public VendorReservationDto selectOneOneVendorsMyOneDayReservation(VendorReservationDto dto) throws Exception;
	public VendorReservationDto selectOneOneVendorsMyOneDayReservation(
			@Param("email") String email,
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date) throws Exception;
	// 									'YYYY-MM-DD'

	
	// 멤버가 특정 벤더 한 달을 조회해서 예약이 가능한 날(status_flag=1)이 있는 날짜 리스트를 볼 때 씀 
		public ArrayList<VendorReservationDto> selectAllOneVendorsYourOneMonthReservations(
				@Param("email") String email,
				@Param("business_regi_num") String business_regi_num,
				@Param("open_date") String open_date) throws Exception;
		//									'YYYY-MM'
	   
		   
	//0903 newOrder로 인한 vendor time update
	public void newOrderOpenDateTimesUpdate(
			@Param("times") String times,
			@Param("email") String email,
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date)
			throws Exception;
	
	//취소나 환불로 인한 vendor time update
	public void timeUpdateDueToCancelOrRefund(
			@Param("times") String times,
			@Param("email") String email,
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date)
			throws Exception;
	
	//0904 overloading status 수정용
	public void closeDay(VendorReservationDto dto) throws Exception;
	public void openDay(VendorReservationDto dto) throws Exception;
	//0905 overloading times 수정용 (vendor가 자기 일일 스케줄 수정하기 위함)
	public void openDateTimesUpdate(VendorReservationDto dto) throws Exception;
	
	
	
	// =====↓↓↓↓↓↓↓↓↓↓↓↓↓======0813오규원===========

	public VendorReservationDto selectAllVendorsReservation(String email, String business_regi_num) throws Exception;

	public void closeDay(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date) throws Exception;

	public void openDay(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date) throws Exception;

	public void openDateTimesUpdate(
			@Param("times") String times,
			@Param("email") String email,
			@Param("business_regi_num") String business_regi_num,
			@Param("open_date") String open_date)
			throws Exception;

	// =====↑↑↑↑↑↑↑↑↑↑↑↑↑======0813오규원===========

}
