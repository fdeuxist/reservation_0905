package com.reservation.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.UserReservationDto;

public interface UserReservationDao {

	public void newOrder(UserReservationDto dto) throws Exception;
	
	//0906 vendor가 취소요청 들어온거 승인해줄때 씀 주문번호의 status가4인것을 5로
	public void cancelOrderConfirm(String reservation_number) throws Exception;
	
	//0906 0906 member가 이용완료처리할때 씀 주문번호의 status를 3으로
	public void orderCompleted(String reservation_number) throws Exception;
	
    //0916 vendor myorder 상태별 주문, 페이지적용 count
    public int countVendorOrdersStatus(@Param("vendor_email") String vendor_email,
            @Param("business_regi_num") String business_regi_num,
            @Param("status") String status) throws Exception;    

    //0916 vendor myorder 상태별 주문, 페이지적용
    public ArrayList<UserReservationDto> selectAllVendorOrdersStatusAndPage(
            @Param("vendor_email") String vendor_email,
            @Param("business_regi_num") String business_regi_num,
            @Param("status") String status,
            @Param("currPageNum") String currPageNum) throws Exception;    
    
    
    //0913 vendor my order용
    public ArrayList<UserReservationDto> selectAllVendorOrdersNotInStatus(
            @Param("vendor_email") String vendor_email,
            @Param("business_regi_num") String business_regi_num,
            @Param("status") String status) throws Exception;    
    public void changeOrdersStatus(
            @Param("status") String status, @Param("reservation_number") String reservation_number) throws Exception;
    
	
    public void tryCancelOrder(String reservation_number) throws Exception;
	public ArrayList<UserReservationDto> selectAllMyOrders(String user_email) throws Exception;
	public UserReservationDto selectOneMyOrder(String reservation_number) throws Exception;
	
	
	
	//대시보드 관련 기능 만든이:오규원 추가일자:0905
		public int countEmail() throws Exception;
		public int countVendorName(String vendor_name) throws Exception;
		public int countBasicAddress(String basic_address) throws Exception;
		public int countDetailAddress(String detail_address) throws Exception;
		public List<Map<String,Object>> countServiceName() throws Exception;
		public List<Map<String,Object>> countTimeshhmm() throws Exception;
		public List<Map<String,Object>> sumServicePrice() throws Exception;
}
