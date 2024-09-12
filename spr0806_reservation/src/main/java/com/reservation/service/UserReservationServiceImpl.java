package com.reservation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.reservation.dao.UserReservationDao;
import com.reservation.dto.UserReservationDto;
//실제 구현부

@Service
public class UserReservationServiceImpl implements IUserReservationService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void newOrder(UserReservationDto dto) throws Exception {
		UserReservationDao dao = sqlSession.getMapper(UserReservationDao.class);
		dao.newOrder(dto);
	}

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
}
