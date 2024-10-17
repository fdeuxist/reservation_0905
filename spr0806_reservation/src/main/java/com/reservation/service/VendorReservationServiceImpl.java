package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.VendorReservationDao;
import com.reservation.dto.VendorReservationDto;

@Service
public class VendorReservationServiceImpl implements IVendorReservationService{
   
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(VendorReservationDto dto) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		vDao.insert(dto);   //영업'일','시' 추가
	}

   
   
	// 특정 벤더가 특정 한 달을 조회해서 자기가 예약을 등록한 날이 있는 날짜 리스트를 볼 때 씀  'YYYY-MM'
	@Override
	public ArrayList<VendorReservationDto> selectAllOneVendorsMyOneMonthReservations(
			String email, String business_regi_num, String open_date) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectAllOneVendorsMyOneMonthReservations(email, business_regi_num, open_date);
	}



	// 특정 벤더가 특정 날짜 안에 등록한 시간을 볼 때 씀  'YYYY-MM-DD'
	@Override
	public VendorReservationDto selectOneOneVendorsMyOneDayReservation(
			VendorReservationDto dto) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectOneOneVendorsMyOneDayReservation(dto);
	}
	
	@Override
	public VendorReservationDto selectOneOneVendorsMyOneDayReservation(
			String email, String business_regi_num, String open_date) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectOneOneVendorsMyOneDayReservation(email, business_regi_num, open_date);
	}


	// 멤버가 특정 벤더 한 달을 조회해서 예약이 가능한 날(status_flag=1)이 있는 날짜 리스트를 볼 때 씀 
	@Override
	public ArrayList<VendorReservationDto> selectAllOneVendorsYourOneMonthReservations(
			String email, String business_regi_num, String open_date) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectAllOneVendorsYourOneMonthReservations(email, business_regi_num, open_date);
	}

	@Override
	public VendorReservationDto selectAllEnableVendorsReservation(String email, String business_regi_num)
			throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectAllEnableVendorsReservation(email, business_regi_num);
	}


	//0906 overloading 컬럼 직접 넣어주기 위해 오버로딩함   특정 벤더 특정 일이 영업중인지 체크하기 위해 사용
	@Override
	public VendorReservationDto selectOneVendorsReservation(
			String email, String business_regi_num, String open_date)
			throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectOneVendorsReservation(email, business_regi_num, open_date);
	}
	
	@Override
	public VendorReservationDto selectOneVendorsReservation(VendorReservationDto dto)
			throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectOneVendorsReservation(dto);
	}

	//0903	newOrder로 인한 vendor time update
	@Override
    public void newOrderOpenDateTimesUpdate(String times, String email, String business_regi_num, String open_date)
           throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.newOrderOpenDateTimesUpdate(times, email, business_regi_num, open_date);
    }
	
	//취소나 환불로 인한 vendor time update
	@Override
    public void timeUpdateDueToCancelOrRefund(String times, String email, String business_regi_num, String open_date)
           throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.timeUpdateDueToCancelOrRefund(times, email, business_regi_num, open_date);
    }
	
	
	
	
	
	
	
	
	
	//0904 overloading status 수정용
	@Override
	public void closeDay(VendorReservationDto dto) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.closeDay(dto);
	}
	@Override
	public void openDay(VendorReservationDto dto) throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.openDay(dto);
	}
	//0905 overloading times 수정용 (vendor가 자기 일일 스케줄 수정하기 위함)
	@Override
    public void openDateTimesUpdate(VendorReservationDto dto) throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.openDateTimesUpdate(dto);
    }
	
	//0905 vendor가 자기 일일 스케줄 수정하기위해 조회할때. status 상관 없이 조회 하기 위함
//	@Override
//	public VendorReservationDto selectOneVendorsMyReservation(VendorReservationDto dto)
//			throws Exception {
//		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
//		return vDao.selectOneVendorsMyReservation(dto);
//	}
	
   
   
   
   
   
   
   
   
   
   
   
   
   
   


    //=====↓↓↓↓↓↓↓↓↓↓↓↓↓======0813오규원===========
   
    @Override
    public VendorReservationDto selectAllVendorsReservation(String email, String business_regi_num) throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        return vDao.selectAllVendorsReservation(email, business_regi_num);
    }


    @Override
    public void closeDay(String email, String business_regi_num, String open_date) throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.closeDay(email, business_regi_num, open_date);
    }


    @Override
    public void openDay(String email, String business_regi_num, String open_date) throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.openDay(email, business_regi_num, open_date);
    }


    @Override
    public void openDateTimesUpdate(String times, String email, String business_regi_num, String open_date)
           throws Exception {
        VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
        vDao.openDateTimesUpdate(times, email, business_regi_num, open_date);
    }
    //=====↑↑↑↑↑↑↑↑↑↑↑↑↑======0813오규원===========



      
      
}
