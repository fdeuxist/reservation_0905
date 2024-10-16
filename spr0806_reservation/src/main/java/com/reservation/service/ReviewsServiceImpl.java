package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.reservation.dao.ReviewsDao;
import com.reservation.dto.ReviewsDto;
//실제 구현부

@Service
public class ReviewsServiceImpl implements IReviewsService {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ReviewsDto> selectFiveLatestReviews(String vendor_email, String business_regi_num) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		return dao.selectFiveLatestReviews(vendor_email, business_regi_num);
	}

	@Override
	public void insert(String reservation_number, Integer star_point, String member_content) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		dao.insert(reservation_number, star_point, member_content);
	}

	@Override
	public void insert(ReviewsDto dto) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		dao.insert(dto);
	}
	
	@Override
	public void update(String reservation_number, Integer star_point, String member_content) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		dao.update(reservation_number, star_point, member_content);
	}

	@Override
	public void update(ReviewsDto dto) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		dao.update(dto);
	}

	@Override
	public ReviewsDto isReviewExist(String reservation_number) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		return dao.isReviewExist(reservation_number);
	}


	@Override
	public ArrayList<ReviewsDto> vendorMustCommentList(String vendor_email, String business_regi_num) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		return dao.vendorMustCommentList(vendor_email, business_regi_num);
	}


	@Override
	public void vendorUpdateComment(String vendor_content, String reservation_number) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		dao.vendorUpdateComment(vendor_content, reservation_number);
	}


	@Override
	public ReviewsDto selectOne(String reservation_number) throws Exception {
		ReviewsDao dao = sqlSession.getMapper(ReviewsDao.class);
		return dao.selectOne(reservation_number);
	}


}
