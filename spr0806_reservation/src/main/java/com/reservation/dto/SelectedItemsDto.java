package com.reservation.dto;

import java.util.List;

public class SelectedItemsDto {
	//member/businessplaceinfo 에서 씀
	
	private String email;
    private String business_regi_num;
    private Integer totalRequiredTime;
    private Integer totalServicePrice;
    private List<cardObjDto> selectedItems;
    
    
    public SelectedItemsDto() {}
    
	public SelectedItemsDto(String email, String business_regi_num, Integer totalRequiredTime,
			Integer totalServicePrice, List<cardObjDto> selectedItems) {
		super();
		this.email = email;
		this.business_regi_num = business_regi_num;
		this.totalRequiredTime = totalRequiredTime;
		this.totalServicePrice = totalServicePrice;
		this.selectedItems = selectedItems;
	}
	@Override
	public String toString() {
		return "SelectedItemsDto [email=" + email + ", business_regi_num=" + business_regi_num + ", totalRequiredTime="
				+ totalRequiredTime + ", totalServicePrice=" + totalServicePrice + ", selectedItems=" + selectedItems
				+ "]";
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBusiness_regi_num() {
		return business_regi_num;
	}
	public void setBusiness_regi_num(String business_regi_num) {
		this.business_regi_num = business_regi_num;
	}
	public Integer getTotalRequiredTime() {
		return totalRequiredTime;
	}
	public void setTotalRequiredTime(Integer totalRequiredTime) {
		this.totalRequiredTime = totalRequiredTime;
	}
	public Integer getTotalServicePrice() {
		return totalServicePrice;
	}
	public void setTotalServicePrice(Integer totalServicePrice) {
		this.totalServicePrice = totalServicePrice;
	}
	public List<cardObjDto> getSelectedItems() {
		return selectedItems;
	}
	public void setSelectedItems(List<cardObjDto> selectedItems) {
		this.selectedItems = selectedItems;
	}
	

	
	
	
	
	
	
	
}
