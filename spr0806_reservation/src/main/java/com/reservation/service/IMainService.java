package com.reservation.service;

import java.util.ArrayList;

import com.reservation.dto.MainDto;

public interface IMainService {
	public ArrayList<MainDto> select() throws Exception;
	public void insert(MainDto dto) throws Exception;
	public void update (MainDto dto) throws Exception;
	public String match (MainDto dto) throws Exception;
	public void delete(MainDto dto) throws Exception; 
	public MainDto getInfo(String id) throws Exception;
	
	
}
