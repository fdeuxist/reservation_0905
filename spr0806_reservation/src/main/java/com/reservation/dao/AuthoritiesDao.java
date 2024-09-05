package com.reservation.dao;

import java.util.ArrayList;

import com.reservation.dto.AuthoritiesDto;

public interface AuthoritiesDao {

	public void insert(AuthoritiesDto dto) throws Exception;

	public void updateAuthorityAsVendor(AuthoritiesDto dto) throws Exception;
	
	public ArrayList<AuthoritiesDto> selectAll() throws Exception;

	public AuthoritiesDto selectEmail(String email) throws Exception;
	
	public void update(AuthoritiesDto dto) throws Exception;
	
	public void delete(String email) throws Exception;
	
}
