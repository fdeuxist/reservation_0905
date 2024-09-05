package com.reservation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.PlaceDetailDto;
import com.reservation.dto.VendorDto;

public interface IMapService {
	public ArrayList<VendorDto> selectPlace(String query) throws Exception;

}
