package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.IMainDao;
import com.reservation.dto.MainDto;

@Service
public class MainServiceimpl implements IMainService {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public ArrayList<MainDto> select() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(MainDto dto) throws Exception {
		IMainDao dao = sqlSession.getMapper(IMainDao.class);
		dao.insert(dto);
		
	}

	@Override
	public void update(MainDto dto) throws Exception {
	 IMainDao dao = sqlSession.getMapper(IMainDao.class);
	 dao.update(dto);
		
	}

	@Override
	public String match(MainDto dto) throws Exception {
		IMainDao dao = sqlSession.getMapper(IMainDao.class);
		return dao.match(dto);
	}

	@Override
	public void delete(MainDto dto) throws Exception {
		IMainDao dao = sqlSession.getMapper(IMainDao.class);
		 dao.delete(dto);
		
	}

	@Override
	public MainDto getInfo(String id) throws Exception {
		IMainDao dao= sqlSession.getMapper(IMainDao.class);
		return dao.getInfo(id);
	}

	
}
