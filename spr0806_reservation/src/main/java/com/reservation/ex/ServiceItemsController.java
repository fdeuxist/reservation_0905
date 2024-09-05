package com.reservation.ex;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.AuthoritiesDto;
import com.reservation.dto.ImageDto;
import com.reservation.dto.ServiceItemsDto;
import com.reservation.service.IAuthoritiesService;
import com.reservation.service.IServiceItemsService;

@Controller
public class ServiceItemsController {

   @Autowired
   private IServiceItemsService itemService;

   private static final Logger logger = LoggerFactory.getLogger(ServiceItemsController.class);

   @RequestMapping(value = "/file/fileUpload", method = RequestMethod.GET)
   public String UploadPage() {
      return "/file/fileUpload";

   }


   @RequestMapping(value = "/file/updateDB", method = RequestMethod.POST)
   public String updateDB(ServiceItemsDto dto) {

      //itemService.
      return "file/upload_ok";

   }
   
 //1. pom.xml에 해당 코드 추가
//	<dependency>
//		<groupId>commons-fileupload</groupId>
//		<artifactId>commons-fileupload</artifactId>
//		<version>1.3.3</version>
//   </dependency>
//   <dependency>
//   	<groupId>commons-io</groupId>
//   	<artifactId>commons-io</artifactId>
//   	<version>2.6</version>
//   </dependency>
//2. root-context.xml에  해당 빈객체 추가
//	<bean id="multipartResolver"
//			class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
//			<!-- 최대 업로드 크기 (10MB) -->
//			<property name="maxUploadSize" value="10485760" /> <!-- 10 * 1024 * 1024 -->
//			<!-- 최대 메모리 크기 (1MB) -->
//			<property name="maxInMemorySize" value="1048576" /> <!-- 1 * 1024 * 1024 -->
//	</bean>
	@RequestMapping(value = "/file/updateItemInfo", method = RequestMethod.POST)
	public String fileUpload(@RequestParam("file") MultipartFile file, @ModelAttribute ServiceItemsDto dto)
			throws Exception {
		String fileRealName = file.getOriginalFilename();
		long size = file.getSize();
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."));
		// 향후 프로젝트 이미지 파일에 맞는 파일경로로 수정해야됨
		String uploadFolder = "C:\\groot\\upload";
		UUID uuid = UUID.randomUUID();
		String uniqueName = uuid.toString().split("-")[0];
		String newFileName = uniqueName + fileExtension;
		//자신의 하드에 파일 생성 
		File saveFile = new File(uploadFolder + "\\" + newFileName);
		System.out.println(fileRealName);
		try {
			file.transferTo(saveFile);

			// DTO 객체 생성 및 데이터 설정
			ImageDto imgDto = new ImageDto();
			imgDto.setFileName(fileRealName);
			imgDto.setFileType(fileExtension);
			imgDto.setFilePath(uploadFolder + "\\" + newFileName);
			imgDto.setFileSize((int) size);
			imgDto.setUpload_time(new Date());
			imgDto.setImage_data(file.getBytes());

			// MyBatis를 통해 데이터베이스에 저장
			itemService.insertItemImg(imgDto);
			itemService.insertMyItem(dto);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "file/upload_ok";
	}

}