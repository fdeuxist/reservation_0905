package com.reservation.service;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.BusinessPlaceImagePathDao;
import com.reservation.dto.BusinessPlaceImagePathDto;

@Service
public class BusinessPlaceImagePathServiceImpl implements IBusinessPlaceImagePathService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<BusinessPlaceImagePathDto> selectAllMyBusinessPlaceImgPaths(
			@Param("email") String email, 
			@Param("business_regi_num") String business_regi_num) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		return dao.selectAllMyBusinessPlaceImgPaths(email, business_regi_num);
	}

	@Override
	public void insertMyBusinessPlaceImagePath(BusinessPlaceImagePathDto dto) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		dao.insertMyBusinessPlaceImagePath(dto);
	}

	

}
