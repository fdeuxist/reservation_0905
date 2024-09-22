package com.reservation.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dao.AuthoritiesDao;
import com.reservation.dao.BusinessPlaceInfoDao;
import com.reservation.dao.VendorDao;
import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.VendorDto;

@Service
public class VendorServiceImpl implements IVendorService{
	
	@Autowired
	private SqlSession sqlSession;


//	@Override
//	public VendorDto selectOneVendorEmailBusinessRegiNum(String vendor_email, String business_regi_num) {
//		VendorDao dao = sqlSession.getMapper(VendorDao.class);
//		return dao.selectOneVendorEmailBusinessRegiNum(vendor_email, business_regi_num);
//	}
	
	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void insert(VendorDto dto) throws Exception {
		VendorDao vDao = sqlSession.getMapper(VendorDao.class);
		vDao.insert(dto);	//사업자회원정보 추가
		/*
		 insert into vendor (
			email,
			business_regi_num,
			business_name,
			zipcode,
			basic_address,
			detail_address,
			business_type)
		values (
			#{email}, 
			#{business_regi_num}, 
			#{business_name}, 
			#{zipcode}, 
			#{basic_address}, 
			#{detail_address}, 
			#{business_type}
		)
		 */
		AuthoritiesDao aDao = sqlSession.getMapper(AuthoritiesDao.class);
		AuthoritiesDto aDto = new AuthoritiesDto(dto.getEmail(), "ROLE_VENDOR");
		//int a=10/0;
		aDao.update(aDto); // update authorities set email=#{email}, authority='ROLE_VENDOR' where email=#{email}
        BusinessPlaceInfoDao bPIDao = sqlSession.getMapper(BusinessPlaceInfoDao.class);
        BusinessPlaceInfoDto bPIDto = 
                new BusinessPlaceInfoDto(dto.getEmail(),dto.getBusiness_regi_num(),"");
        bPIDao.insertMyBusinessPlaceInfo(bPIDto);
        //↑vendor 전환 가입시 무조건 사업장정보가 공란으로 등록되어
        //이후 insert,update 구분 없이 update로만 접근하면 됨
        //테스트해봐야함
	}

	@Override
	public ArrayList<VendorDto> selectAll() throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectAll();
	}

	@Override
	public int checkEmail(String email) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.checkEmail(email);
	}
	
	@Override
	public VendorDto selectEmail(String email) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectEmail(email);
	}

	@Override
	public void update(VendorDto dto) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		dao.update(dto);
	}

	@Override
	public void delete(String email) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		dao.delete(email);
	}

	@Override
	public VendorDto selectBusiness_regi_num(String business_regi_num) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectBusiness_regi_num(business_regi_num);
	}

	@Override
	public ArrayList<VendorDto> selectAllVendorByBusinessType(String business_type) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectAllVendorByBusinessType(business_type);
	}

	@Override
	public ArrayList<VendorDto> selectAllVendorByBasicAddress(String basic_address) throws Exception {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectAllVendorByBasicAddress(basic_address);
	}

	/*
	@Override
	public BusinessPlaceInfoDto selectOneBusinessPlaceInfo(String email, String business_regi_num) {
		VendorDao dao = sqlSession.getMapper(VendorDao.class);
		return dao.selectOneBusinessPlaceInfo(email, business_regi_num);
	}
*/
		
		
}
