package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.UserDto;

public interface UserDao {

	public void insert(UserDto dto) throws Exception;
	
	public ArrayList<UserDto> selectAll() throws Exception;

	public UserDto selectEmail(String email) throws Exception;
	
	public UserDto selectPhone(String phone) throws Exception;
	
	public void update(UserDto dto) throws Exception;

	public void updateEnable(@Param("enable")Integer enable, @Param("email")String email) throws Exception;
	
	public void delete(String email) throws Exception;
	
}
