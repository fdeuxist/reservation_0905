package com.reservation.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.BusinessPlaceInfoDto;
import com.reservation.dto.VendorDto;
import com.reservation.dto.VendorReservationDto;
import com.reservation.service.IBusinessPlaceInfoService;
import com.reservation.service.IVendorReservationService;
import com.reservation.service.IVendorService;

@RestController
public class VendorRestController {

	@Autowired
	private IVendorService vendorService;
	
	@Autowired
	private IBusinessPlaceInfoService businessPlaceInfo;
	
	@Autowired
	private IVendorReservationService vRService;
	

	@RequestMapping(value = "/vendorrest/myonemonth", method = RequestMethod.GET)
	public List<VendorReservationDto> selectOneVendorsMyOneMonthReservation(
			@RequestParam String month, HttpSession session) throws Exception {
		System.out.println("VendorRestController - /vendorrest/myonemonth");
		
		String email = (String)session.getAttribute("loginEmail");
		String business_regi_num = (String)session.getAttribute("loginBusiness_regi_num");
		String open_date = month;
		System.out.println(email + "   " + business_regi_num+"  " + open_date);
		List<VendorReservationDto> list = new ArrayList<>();
		list = vRService.selectAllOneVendorsMyOneMonthReservations(email, business_regi_num, open_date);
		
		return list;
	}
	
	
	
	
	
	@RequestMapping("/vendorrest/test")
	public BusinessPlaceInfoDto selectVendorBusinessPlaceInfo(String email, String business_regi_num) throws Exception {
		System.out.println("VendorRestController - /vendorrest/test");
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectTest("test1", "test2");
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectTest("vendor", "gsgs252511");
		email = "vendor";
		business_regi_num = "gsgs252511";
		//BusinessPlaceInfoDto dto = businessPlaceInfo.selectVendorBusinessPlaceInfo(email, business_regi_num);
		
		//return dto;
		return null;
	}
	
	
	
	
	
	@RequestMapping(value = "/vendorrest/emailcheck", method = RequestMethod.GET)
	public Map vendorEmailCheck(String email) {
		System.out.println("VendorRestController - /vendorrest/emailcheck " + email);
		
		Map<String, String> result = new HashMap<>();
		VendorDto checkDto = null;
		try {
			checkDto = vendorService.selectEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("VendorRestController - /vendorrest/emailcheck    input email : " + email + " , return dto : " + checkDto);
		if(checkDto == null) {
			result.put("result", "true");
			System.out.println("result : true");
		}else {
			result.put("result", "false");
			System.out.println("result : false");
		}
		
		return result;
	}
	
	@RequestMapping(value = "/vendorrest/business_regi_numcheck", method = RequestMethod.GET)
	public Map vendorBusiness_regi_numCheck(String business_regi_num) {
		System.out.println("VendorRestController - /vendorrest/business_regi_numcheck " + business_regi_num);
		
		Map<String, String> result = new HashMap<>();
		VendorDto checkDto = null;
		try {
			checkDto = vendorService.selectBusiness_regi_num(business_regi_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("VendorRestController - /vendorrest/business_regi_numcheck    input business_regi_num : " + business_regi_num + " , return dto : " + checkDto);
		if(checkDto == null) {
			result.put("result", "true");
			System.out.println("result : true");
		}else {
			result.put("result", "false");
			System.out.println("result : false");
		}
		
		return result;
	}
	
	@RequestMapping("/vendorrest/selectall")
	public List<VendorDto> sendVendorList() throws Exception {
		System.out.println("VendorRestController - /vendorrest/selectall");
		List<VendorDto> list = new ArrayList<>();
		list = vendorService.selectAll();
		
		return list;
	}
	
	
	
	
	
	
	
	
}
