package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.AuthoritiesDao;
import com.reservation.dto.AuthoritiesDto;

@Service
public class AuthoritiesServiceImpl implements IAuthoritiesService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(AuthoritiesDto dto) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.insert(dto);
	}

	@Override
	public void update(AuthoritiesDto dto) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.update(dto);
	}

	@Override
	public void delete(String email) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.delete(email);
	}

	@Override
	public ArrayList<AuthoritiesDto> selectAll() throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.selectAll();
	}

	@Override
	public AuthoritiesDto selectEmail(String email) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.selectEmail(email);
	}

}
