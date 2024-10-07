package com.reservation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.SearchPlaceDao;
import com.reservation.dto.ResultReviewsJoinDto;
import com.reservation.dto.SearchPlaceDto;

@Service
public class SearchPlaceServiceImpl implements ISearchPlaceService{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public SearchPlaceDto selectOnePlace(String email, String business_regi_num) throws Exception {
		SearchPlaceDao dao = sqlSession.getMapper(SearchPlaceDao.class);
		return dao.selectOnePlace(email, business_regi_num);
	}

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

	@Override
	public ArrayList<ResultReviewsJoinDto> joinReviewsAndVendor() throws Exception {
		SearchPlaceDao dao = sqlSession. getMapper(SearchPlaceDao.class);
		return dao.joinReviewsAndVendor();
	}

	
	
		
}
