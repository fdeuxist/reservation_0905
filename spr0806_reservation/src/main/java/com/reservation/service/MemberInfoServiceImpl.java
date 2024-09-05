package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dao.AuthoritiesDao;
import com.reservation.dao.MemberInfoDao;
import com.reservation.dao.UserDao;
import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.MemberInfoDto;

@Service
public class MemberInfoServiceImpl implements IMemberInfoService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<MemberInfoDto> selectAll() throws Exception {
		MemberInfoDao dao = sqlSession.getMapper(MemberInfoDao.class);
		return dao.selectAll();
	}

	@Override
	public ArrayList<MemberInfoDto> selectAllEmailList(String email) throws Exception {
		MemberInfoDao dao = sqlSession.getMapper(MemberInfoDao.class);
		return dao.selectAllEmailList(email);
	}

	@Override
	public ArrayList<MemberInfoDto> selectAllNameList(String name) throws Exception {
		MemberInfoDao dao = sqlSession.getMapper(MemberInfoDao.class);
		return dao.selectAllNameList(name);
	}
	
	@Override
	public MemberInfoDto selectEmail(String email) throws Exception {
		MemberInfoDao dao = sqlSession.getMapper(MemberInfoDao.class);
		return dao.selectEmail(email);
	}
	
	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void memberEnableAuthorityUpdate(MemberInfoDto dto) throws Exception {
		UserDao udao = sqlSession.getMapper(UserDao.class);
		AuthoritiesDao adao = sqlSession.getMapper(AuthoritiesDao.class);
		udao.updateEnable(dto.getEnable(), dto.getEmail());
		AuthoritiesDto adto = new AuthoritiesDto(); 
		adto.setAuthority(dto.getAuthority());
		adto.setEmail(dto.getEmail());
		adao.update(adto);
	}

}
