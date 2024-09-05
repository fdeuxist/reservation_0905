package com.reservation.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.VendorUserDao;
import com.reservation.dto.VendorUserDto;

@Service
public class VendorUserServiceImpl implements IVendorUserService{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public VendorUserDto selectOneVendorEmailBusinessRegiNum(String email, String business_regi_num) throws Exception {
		VendorUserDao dao = sqlSession.getMapper(VendorUserDao.class);
		return dao.selectOneVendorEmailBusinessRegiNum(email, business_regi_num);
	}

	

}
