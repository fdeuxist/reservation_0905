package com.reservation.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.MainDto;
import com.reservation.dto.PlaceDetailDto;
import com.reservation.dto.VendorDto;

public interface IMapDao {
	ArrayList<VendorDto> selectPlace(String query) throws Exception;
}
