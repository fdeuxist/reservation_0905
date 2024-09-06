package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dao.AuthoritiesDao;
import com.reservation.dao.UserDao;
import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.UserDto;
//실제 구현부

@Service
public class UserServiceImpl implements IUserService {
	@Autowired
	private SqlSession sqlSession;

	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void insert(UserDto dto) throws Exception {
		UserDao uDao=sqlSession.getMapper(UserDao.class);
		uDao.insert(dto);
		AuthoritiesDao aDao = sqlSession.getMapper(AuthoritiesDao.class);
		AuthoritiesDto aDto = new AuthoritiesDto(dto.getEmail(), "ROLE_MEMBER");
		//int a=10/0;
		aDao.insert(aDto);
	}

	@Override
	public void update(UserDto dto) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.update(dto);
	}

	@Override
	public void updateEnable(Integer enable, String email) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.updateEnable(enable, email);
	}
	
	@Override
	public void delete(String email) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.delete(email);
	}

	@Override
	public ArrayList<UserDto> selectAll() throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		return dao.selectAll();
	}

	@Override
	public UserDto selectEmail(String email) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		return dao.selectEmail(email);
	}

	@Override
	public UserDto selectPhone(String phone) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		return dao.selectPhone(phone);
	}

	@Override
	public void mUpdate(UserDto dto) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		 dao.mUpdate(dto);
		
	}



}
