package com.reservation.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.reservation.dto.UserDto;

public interface UserDao {


	//0905 pw변경하기위해 계정찾는용도
	public UserDto selectEmailAndName(
			@Param("email") String email, 
			@Param("name") String name) throws Exception;
	public UserDto selectPhoneAndName(
			@Param("phone") String phone, 
			@Param("name") String name) throws Exception;
	//0905 찾은계정으로pw변경하는용도
	public void updatePwByEmailAndName(
			@Param("password") String password, 
			@Param("email") String email, 
			@Param("name") String name) throws Exception;
	public void updatePwByPhoneAndName(
			@Param("password") String password,
			@Param("phone") String phone, 
			@Param("name") String name) throws Exception;
	
	public void insert(UserDto dto) throws Exception;
	
	public ArrayList<UserDto> selectAll() throws Exception;

    public int checkEmail(String email) throws Exception;
    
    public int checkPhone(String phone) throws Exception;
    
	public UserDto selectEmail(String email) throws Exception;
	
	public UserDto selectPhone(String phone) throws Exception;
	
	public void update(UserDto dto) throws Exception;

	public void updateEnable(
			@Param("enable")Integer enable, 
			@Param("email")String email) throws Exception;

	public int disableAccount(String email) throws Exception;
	
	public void delete(String email) throws Exception;
	
	public void mUpdate(UserDto dto) throws Exception;
	
}
