package com.reservation.dto;

import java.util.Date;

public class ImageDto {
	
	private int id;
	private String fileName;
	private String fileType;
	private String filePath;
	private int fileSize;
	private Date upload_time;
	private byte[] image_data;
	
	public ImageDto() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public Date getUpload_time() {
		return upload_time;
	}

	public void setUpload_time(Date upload_time) {
		this.upload_time = upload_time;
	}

	public byte[] getImage_data() {
		return image_data;
	}

	public void setImage_data(byte[] image_data) {
		this.image_data = image_data;
	}

	public ImageDto(int id, String fileName, String fileType, String filePath, int fileSize, Date upload_time,
			byte[] image_data) {
		super();
		this.id = id;
		this.fileName = fileName;
		this.fileType = fileType;
		this.filePath = filePath;
		this.fileSize = fileSize;
		this.upload_time = upload_time;
		this.image_data = image_data;
	};
	
	
	
	
}
