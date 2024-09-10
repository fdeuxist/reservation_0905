package com.reservation.dto;


import java.util.ArrayList;

import com.reservation.dto.BusinessPlaceImagePathDto;

public class VendorAndImageListDto {
	private ArrayList<VendorDto> vendorList;
	private ArrayList<BusinessPlaceImagePathDto> mainImageList;

	public VendorAndImageListDto() {}

	public VendorAndImageListDto(ArrayList<VendorDto> vendorList, ArrayList<BusinessPlaceImagePathDto> mainImageList) {
		super();
		this.vendorList = vendorList;
		this.mainImageList = mainImageList;
	}

	public ArrayList<VendorDto> getVendorList() {
		return vendorList;
	}

	public void setVendorList(ArrayList<VendorDto> vendorList) {
		this.vendorList = vendorList;
	}

	public ArrayList<BusinessPlaceImagePathDto> getMainImageList() {
		return mainImageList;
	}

	public void setMainImageList(ArrayList<BusinessPlaceImagePathDto> mainImageList) {
		this.mainImageList = mainImageList;
	};
	
	
	
	
}
