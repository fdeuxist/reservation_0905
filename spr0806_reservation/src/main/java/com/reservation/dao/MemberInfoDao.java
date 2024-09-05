package com.reservation.dao;

import java.util.ArrayList;

import com.reservation.dto.MemberInfoDto;

public interface MemberInfoDao {

	public ArrayList<MemberInfoDto> selectAll() throws Exception;

	public ArrayList<MemberInfoDto> selectAllEmailList(String email) throws Exception;

	public ArrayList<MemberInfoDto> selectAllNameList(String name) throws Exception;

	public MemberInfoDto selectEmail(String email) throws Exception;
	
	public void memberEnableAuthorityUpdate(MemberInfoDto dto) throws Exception;
}
