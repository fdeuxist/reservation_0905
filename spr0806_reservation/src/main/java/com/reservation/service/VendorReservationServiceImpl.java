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

	@Override
	public VendorReservationDto selectOneVendorsReservation(VendorReservationDto dto)
			throws Exception {
		VendorReservationDao vDao = sqlSession.getMapper(VendorReservationDao.class);
		return vDao.selectOneVendorsReservation(dto);
	}

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   


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
