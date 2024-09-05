package com.reservation.dto;

public class cardObjDto {
//member/businessplaceinfo 에서 씀
	
	private String itemid;
    private Integer prices;
    private String servicedescription;
    private String servicename;
    private Integer time;
    

	public cardObjDto() {}
	public cardObjDto(String itemid, Integer prices, String servicedescription, String servicename, Integer time) {
		super();
		this.itemid = itemid;
		this.prices = prices;
		this.servicedescription = servicedescription;
		this.servicename = servicename;
		this.time = time;
	}
	@Override
	public String toString() {
		return "cardObjDto [itemid=" + itemid + ", prices=" + prices + ", servicedescription=" + servicedescription
				+ ", servicename=" + servicename + ", time=" + time + "]";
	}
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public Integer getPrices() {
		return prices;
	}
	public void setPrices(Integer prices) {
		this.prices = prices;
	}
	public String getServicedescription() {
		return servicedescription;
	}
	public void setServicedescription(String servicedescription) {
		this.servicedescription = servicedescription;
	}
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public Integer getTime() {
		return time;
	}
	public void setTime(Integer time) {
		this.time = time;
	}
	
	
	
	
	 
}
