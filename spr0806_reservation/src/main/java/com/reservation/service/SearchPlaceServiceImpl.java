package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.SearchPlaceDao;
import com.reservation.dto.SearchPlaceDto;

@Service
public class SearchPlaceServiceImpl implements ISearchPlaceService{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<SearchPlaceDto> selectAllVendorByBusinessType(String business_type) throws Exception {
		SearchPlaceDao dao = sqlSession.getMapper(SearchPlaceDao.class);
		return dao.selectAllVendorByBusinessType(business_type);
	}

	@Override
	public ArrayList<SearchPlaceDto> selectAllVendorByBasicAddress(String basic_address) throws Exception {
		SearchPlaceDao dao = sqlSession.getMapper(SearchPlaceDao.class);
		return dao.selectAllVendorByBasicAddress(basic_address);
	}
	
		
}
