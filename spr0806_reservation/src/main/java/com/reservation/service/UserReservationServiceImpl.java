package com.reservation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

import com.reservation.dao.UserReservationDao;
import com.reservation.dto.UserReservationDto;
//실제 구현부
import com.reservation.dto.VendorReservationDto;

@Service
public class UserReservationServiceImpl implements IUserReservationService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private IVendorReservationService vRService;

	//0913 vendor my order용
    @Override
    public ArrayList<UserReservationDto> selectAllVendorOrdersNotInStatus(
            String vendor_email, String business_regi_num, String status) throws Exception {
        UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
        return dao.selectAllVendorOrdersNotInStatus(vendor_email, business_regi_num, status);
    }
    
    //0916 vendor myorder 상태별 주문, 페이지적용 count
	@Override
	public int countVendorOrdersStatus(String vendor_email, String business_regi_num, String status) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countVendorOrdersStatus(vendor_email, business_regi_num, status);
	}

	//0916 vendor myorder 상태별 주문, 페이지적용
	@Override
	public ArrayList<UserReservationDto> selectAllVendorOrdersStatusAndPage(String vendor_email,
			String business_regi_num, String status, String currPageNum) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.selectAllVendorOrdersStatusAndPage(vendor_email, business_regi_num, status, currPageNum);
	}
    
    

	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void cancelOrRefund(String status, String reservation_number) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		
		//주문번호로 해당 주문건 찾기
		UserReservationDto urDto = dao.selectOneMyOrder(reservation_number);
		
		//해당 주문건에서 벤더 정보 (벤더의 해당 예약일)찾기 
		VendorReservationDto vrDto = new VendorReservationDto();	
		vrDto.setEmail(urDto.getVendor_email());
		vrDto.setBusiness_regi_num(urDto.getBusiness_regi_num());
		vrDto.setOpen_date(urDto.getReservation_use_date());
		
		vrDto = vRService.selectOneOneVendorsMyOneDayReservation(vrDto);
		System.out.println("cancelOrRefund vrDto : " + vrDto);
		
		String vendorTime = vrDto.getTimes();
        int position = vendorTime.indexOf('2');	//'2'가 몇번째에 있는지
		char[] timeChars = vendorTime.toCharArray(); 
		//'000000000000000000001020001010101010101010000000' 를 char 배열로 전환
        timeChars[position] = '0';	//'2'가 있는 위치를 '0'으로 변경
        vendorTime = String.valueOf(timeChars);//char배열을 다시 string으로
        vRService.timeUpdateDueToCancelOrRefund(vendorTime,vrDto.getEmail(),vrDto.getBusiness_regi_num(),vrDto.getOpen_date());
        
		dao.changeOrdersStatus(status, reservation_number);
		//해당일시 주문2인거 0으로 변경해줘야함 - 완료
		
	}
	
	//0903 new
	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void newOrder(UserReservationDto dto) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		
		VendorReservationDto inputvdto = new VendorReservationDto();
		inputvdto.setEmail(dto.getVendor_email());	//예약정보를 토대로 사업자의 해당 일의 오픈시간을 가져옴
		inputvdto.setBusiness_regi_num(dto.getBusiness_regi_num());
		inputvdto.setOpen_date(dto.getReservation_use_date());
		VendorReservationDto resultvdto = vRService.selectOneVendorsReservation(inputvdto);
		//System.out.println("b result : " + resultvdto);	//수정중이면널
		
		String vendorTime = resultvdto.getTimes();
        String selectTime = dto.getTimes();
        int position = selectTime.indexOf('1');
        char[] timeChars = vendorTime.toCharArray();
        timeChars[position] = '2';
        String remainingVendorTime = String.valueOf(timeChars);
//	        System.out.println("b : " + vendorTime);			//before
//	        System.out.println("r : " + selectTime);			//reservationTime
//	        System.out.println("a : " + remainingVendorTime);	//after
		dao.newOrder(dto);
        
        vRService.newOrderOpenDateTimesUpdate(remainingVendorTime,
        							dto.getVendor_email(),
        							dto.getBusiness_regi_num(),
        							dto.getReservation_use_date());
        
        resultvdto = vRService.selectOneVendorsReservation(inputvdto);
        //↑★예약중에 벤더가 예약불가로 막은거 어떻게 되는지 체크해봐야함
		//System.out.println("a result : " + resultvdto);
		
		
		
		
	}
	
	//0903 bak
//	@Override
//	public void newOrder(UserReservationDto dto) throws Exception {
//		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
//		dao.newOrder(dto);
//	}

	@Override
	public void tryCancelOrder(String reservation_number) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		dao.tryCancelOrder(reservation_number);
	}

	@Override
	public ArrayList<UserReservationDto> selectAllMyOrders(String user_email) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.selectAllMyOrders(user_email);
	}

	@Override
	public UserReservationDto selectOneMyOrder(String reservation_number) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.selectOneMyOrder(reservation_number);
	}

	
	@Override
	public void changeOrdersStatus(String status, String reservation_number) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		dao.changeOrdersStatus(status, reservation_number);
	}

	


	
	
	//대시보드 관련 기능 만든이:오규원 추가일자:0905

	@Override
	public int countEmail() throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countEmail();
	}

	@Override
	public int countVendorName(String vendor_name) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countVendorName(vendor_name);
	}

	@Override
	public int countBasicAddress(String basic_address) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countBasicAddress(basic_address);
	}

	@Override
	public int countDetailAddress(String detail_address) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countDetailAddress(detail_address);
	}

	@Override
	public List<Map<String,Object>> countServiceName() throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countServiceName();
	}

	@Override
	public List<Map<String,Object>> countTimeshhmm() throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.countTimeshhmm();
	}

	@Override
	public List<Map<String,Object>> sumServicePrice() throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		return dao.sumServicePrice();
	}

	@Override
	public void cancelOrderConfirm(String reservation_number) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void orderCompleted(String reservation_number) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
