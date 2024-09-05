package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dto.ReservationItemsDto;
import com.reservation.dao.ReservationItemsDao;

@Service
public class ReservationServiceImpl implements IReservationItemsService{

	@Autowired
	private SqlSession sqlSession;

	//신규주문 발생시 주문내역에 선택된 item들을 저장해둔 것을 주문번호로 조회함. 주문정보 상세내역 조회시에 사용
	@Override
	public ArrayList<ReservationItemsDto> selectAllOneOrderItems(String reservation_number) throws Exception {
		ReservationItemsDao dao = sqlSession.getMapper(ReservationItemsDao.class);
		return dao.selectAllOneOrderItems(reservation_number);
	}
	
	
	//신규 주문 발생시 주문내역에 선택된 item들이 주문번호와 함께 저장됨 3개구매면 3줄 insert
	@Override
	public void insert(ReservationItemsDto dto) throws Exception {
		ReservationItemsDao dao = sqlSession.getMapper(ReservationItemsDao.class);
		dao.insert(dto);
	}
	
	
	
}
