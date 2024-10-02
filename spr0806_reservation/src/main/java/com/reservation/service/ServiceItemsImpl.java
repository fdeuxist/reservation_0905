package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.ServiceItemsDao;
import com.reservation.dto.ImageDto;
import com.reservation.dto.ServiceItemsDto;

@Service
public class ServiceItemsImpl implements IServiceItemsService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<ServiceItemsDto> selectAllYourItems(String email, String business_regi_num) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.selectAllYourItems(email, business_regi_num);
	}
	
	@Override
	public void insertMyItem(ServiceItemsDto dto) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		dao.insertMyItem(dto);
	}

	@Override
	public ArrayList<ServiceItemsDto> selectAllMyItems(String email, String business_regi_num) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.selectAllMyItems(email, business_regi_num);
	}

	@Override
	public ServiceItemsDto selectOneItem(String item_id) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.selectOneItem(item_id);
	}
	
	@Override
	public int updateMyItem(ServiceItemsDto dto) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.updateMyItem(dto);
	}

	@Override
	public void deleteMyItem(String email, String business_regi_num) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		dao.deleteMyItem(email, business_regi_num);
	}

	@Override
	public void insertItemImg(ImageDto dto) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		dao.insertItemImg(dto);
	}

	@Override
	public ArrayList<ServiceItemsDto> selectItemByTime(int time) throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.selectItemByTime(time);
	}

	@Override
	public ArrayList<ServiceItemsDto> selectAll() throws Exception {
		ServiceItemsDao dao = sqlSession.getMapper(ServiceItemsDao.class);
		return dao.selectAll();
	}


}
