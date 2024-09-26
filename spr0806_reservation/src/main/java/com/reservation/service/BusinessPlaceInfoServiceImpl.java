package com.reservation.service;


import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.BusinessPlaceInfoDao;
import com.reservation.dto.BusinessPlaceImagePathDto;
import com.reservation.dto.BusinessPlaceInfoDto;

@Service
public class BusinessPlaceInfoServiceImpl implements IBusinessPlaceInfoService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(@Param("email") String email, @Param("business_regi_num") String business_regi_num) throws Exception {
		BusinessPlaceInfoDao dao = sqlSession.getMapper(BusinessPlaceInfoDao.class);
		return dao.selectOneBusinessPlaceInfo(email, business_regi_num);
	}

	@Override
	public void insertMyBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception {
		BusinessPlaceInfoDao dao = sqlSession.getMapper(BusinessPlaceInfoDao.class);
		dao.insertMyBusinessPlaceInfo(dto);
	}
	
    //0903 vendor 전환시 insert되고 이후 update로만 관리하기 위해 만듬
    @Override
    public void updateMyBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception {
        BusinessPlaceInfoDao dao = sqlSession.getMapper(BusinessPlaceInfoDao.class);
        dao.updateMyBusinessPlaceInfo(dto);
    }
   
//	@Override
//	public BusinessPlaceInfoDto selectVendorBusinessPlaceInfo(BusinessPlaceInfoDto dto) throws Exception {
//
//		BusinessPlaceInfoDao businessDao = sqlSession.getMapper(BusinessPlaceInfoDao.class);
//		return businessDao.selectVendorBusinessPlaceInfo(dto);
//
//	}


}
