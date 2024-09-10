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

	
	// 0906 특정벤더의 모든 메인 이미지를 메인이미지가 아니게 변경
	@Override
	public void updateIsMainYToN(String email, String business_regi_num) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		dao.updateIsMainYToN(email, business_regi_num);
	}
	// 0906 특정벤더의 특정파일을 메인이미지로 변경
	@Override
	public void setMainImage(String email, String business_regi_num, String place_img_path) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		dao.setMainImage(email, business_regi_num, place_img_path);
	}
	// 0906 특정 벤더 특정 이미지 삭제
	@Override
	public void deleteImage(String place_img_path) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		dao.deleteImage(place_img_path);
	}
	// 0906 특정 벤더에게 대표 이미지가 있는지 확인  result type int
	@Override
	public int countMainImage(String email, String business_regi_num) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		return dao.countMainImage(email, business_regi_num);
	}
	// 0906 남아 있는 첫 번째 이미지를 대표 이미지로 설정 
	@Override
	public void setFirstImageAsMain(String email, String business_regi_num) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		dao.setFirstImageAsMain(email, business_regi_num);
	}
	
	@Override
	public BusinessPlaceImagePathDto selectMainImage(String email, String business_regi_num) throws Exception {
		BusinessPlaceImagePathDao dao = sqlSession.getMapper(BusinessPlaceImagePathDao.class);
		return dao.selectMainImage(email, business_regi_num);
		
	}

	
	
	
	
	
	
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
