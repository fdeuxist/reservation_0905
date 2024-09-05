package com.reservation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.IMainDao;
import com.reservation.dao.IMapDao;
import com.reservation.dao.ServiceItemsDao;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.MainDto;
import com.reservation.dto.PlaceDetailDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.dto.VendorDto;

@Service
public class MapServiceImpl implements IMapService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<VendorDto> selectPlace(String query) throws Exception {
		IMapDao dao = sqlSession.getMapper(IMapDao.class);	
		System.out.println("서비스에서 전달받은 쿼리:"+query);
		return dao.selectPlace(query);
	}
	
	

	

}
