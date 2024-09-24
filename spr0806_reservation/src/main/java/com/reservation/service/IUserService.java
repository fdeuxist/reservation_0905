package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.UserDto;

public interface IUserService {

	//0905 pw변경하기위해 계정찾는용도
	public UserDto selectEmailAndName(String email, String name) throws Exception;
	public UserDto selectPhoneAndName(String phone, String name) throws Exception;
	//0905 찾은계정으로pw변경하는용도
	public void updatePwByEmailAndName(String password, String email, String name) throws Exception;
	public void updatePwByPhoneAndName(String password, String phone, String name) throws Exception;
	
	public void insert(UserDto dto) throws Exception;
	
	public ArrayList<UserDto> selectAll() throws Exception;
	
    public int checkEmail(String email) throws Exception;
    
    public int checkPhone(String phone) throws Exception;
    
	public UserDto selectEmail(String email) throws Exception;
	
	public UserDto selectPhone(String phone) throws Exception;
	
	public void update(UserDto dto) throws Exception;
	public void mUpdate(UserDto dto) throws Exception;

	public void updateEnable(Integer enable, String email) throws Exception;

	public int disableAccount(String email) throws Exception;
	
	public void delete(String email) throws Exception;
}
