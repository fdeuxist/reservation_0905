package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.UserDto;

public interface IUserService {
	
	public void insert(UserDto dto) throws Exception;
	
	public ArrayList<UserDto> selectAll() throws Exception;

	public UserDto selectEmail(String email) throws Exception;
	
	public UserDto selectPhone(String phone) throws Exception;
	
	public void update(UserDto dto) throws Exception;

	public void updateEnable(Integer enable, String email) throws Exception;
	
	public void delete(String email) throws Exception;
}
