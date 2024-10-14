<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@include file="../include/header.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div class="header-placeholder"></div>

<main> <%--name : ${vendorInfo.name } <br>

phone : ${vendorInfo.phone } <br>
business_name : ${vendorInfo.business_name } <br>
vendorInfo.zipcode : ${vendorInfo.zipcode } <br>
vendorInfo.basic_address : ${vendorInfo.basic_address } <br>
vendorInfo.detail_address : ${vendorInfo.detail_address } <br>
vendorInfo.business_type : ${vendorInfo.business_type } <br>
 --%>
 <%-- --%>
<%--
장소 정보<br>
<img src="${pageContext.request.contextPath}/${mainImg}" alt="메인 이미지"
	style="max-width: 200px; max-height: 200px;" /> <c:if
	test="${not empty placeInfo}">
	<table border="1">
		<tr>
			<th>Email</th>
			<td id="placeEmail">${placeInfo.email}</td>
		</tr>
		<tr>
			<th>Business Registration Number</th>
			<td id="placeRegiNum">${placeInfo.business_regi_num}</td>
		</tr>
		<tr>
			<th>Place Info</th>
			<td>${placeInfo.place_info}</td>
		</tr>
		<!-- 이미지 리스트가 비어있지 않은 경우 -->
		<c:if test="${not empty placeImagePathDtos}">
			<c:forEach var="dto" items="${placeImagePathDtos}" varStatus="status">
				<tr>
					<th>Image ${status.index + 1}</th>
					<td><img
						src="${pageContext.request.contextPath}/${dto.place_img_path}"
						alt="Image ${status.index + 1}"
						style="max-width: 200px; max-height: 200px;" /></td>
				</tr>
			</c:forEach>
			<!-- 이미지 리스트가 비어있는 경우 -->
		</c:if>
		<c:if test="${empty placeImagePathDtos}">
			<tr>
				<td colspan="2">이미지가 없습니다</td>
			</tr>
		</c:if>
	</table>
</c:if>
  --%>
<input type="hidden" id="placeEmail" value="${placeInfo.email}">
<input type="hidden" id="placeRegiNum" value="${placeInfo.business_regi_num}">

<c:if test="${not empty imageList}">
<div id="myCarousel" class="carousel slide" data-ride="false" style="width: 80%; margin: auto;"><%-- data-ride="carousel" data-interval="3000"> --%>
  <ul class="carousel-indicators">
	<c:forEach items="${imageList}" var="image" varStatus="status">
    	<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
	</c:forEach>
  </ul>
  <div class="carousel-inner">
	<c:forEach items="${imageList}" var="image" varStatus="status">
		    <div class="carousel-item">
		      <%--<img src="data:image/jpeg;base64,${image.encodedImage}" alt="${placeInfo.business_name}_${status.index}" width="1100" height="500">--%>
		      <img src="data:image/jpeg;base64,${image.encodedImage}" alt="${placeInfo.business_name}_${status.index}" class="d-block w-100 h-100" style="max-height: 500px; object-fit: contain;">
		    </div>
	</c:forEach>
  </div>
  <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#myCarousel" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>
</c:if>

<c:if test="${empty imageList}">
</c:if>



<div class="form-group" style="width: 70%; margin: 0 auto;">
    <div id="placeInfo" class="form-control-plaintext text-center mx-auto" style="white-space: pre-wrap; width: 100%;">
        ${placeInfo.place_info}
    </div>
</div>



<%--  안씀 
        <a href="<c:url value='/member/scheduleselect?email=${placeInfo.email}&business_regi_num=${placeInfo.business_regi_num}'/>">예약하기</a>
--%>




<div class="container mt-4">
    <div class="row">
        <c:forEach var="serviceItem" items="${serviceItems}" varStatus="status">
        <%--<label>--%>
		    <div class="col-md-4 mb-4">
		    <div class="card serviceItem-card" data-serviceItemId="${serviceItem.item_id }"
                     data-serviceName="${serviceItem.service_name }"
                     data-serviceDescription="${serviceItem.service_description }"
                     data-requiredTime="${serviceItem.required_time }"
                     data-servicePrice="${serviceItem.service_price }">
		      <div class="card-header">${serviceItem.service_name}</div>
		      <div class="card-body">${serviceItem.service_description}<br>
		      <div class="small text-right">소요 시간: 약 ${serviceItem.required_time * 30}분<br>
		      <div style="font-size: 1rem;">가격: ${serviceItem.service_price}원</div></div>
		      </div> 
		      <div class="card-footer"><label><input type="checkbox" class="item_idChkBox" id="item_idChkBox_${status.index}"
		                                 name="item_idChkBox" value="asdasdasd" /> 선택하기</label></div>
		    </div>
		    </div>
	    <%--</label>--%>
        </c:forEach>
    </div>
</div>



<%--
<div class="container mt-4">
    <div class="row">
        <c:forEach var="serviceItem" items="${serviceItems}" varStatus="status">
            <div class="col-md-4 mb-4">
                <div class="card serviceItem-card" data-serviceItemId="${serviceItem.item_id }"
                     data-serviceName="${serviceItem.service_name }"
                     data-serviceDescription="${serviceItem.service_description }"
                     data-requiredTime="${serviceItem.required_time }"
                     data-servicePrice="${serviceItem.service_price }">
                    <div class="card-header">${serviceItem.service_name}</div>
                    <div class="card-body">
                        ${serviceItem.service_description}<br>
                        <div class="small text-right">소요 시간: 약 ${serviceItem.required_time * 30}분<br>
                            <div style="font-size: 1rem;">가격: ${serviceItem.service_price}원</div>
                        </div>
                    </div> 
                    <div class="card-footer">
                        <input type="checkbox" class="item_idChkBox" id="item_idChkBox_${status.index}"
                               name="item_idChkBox" value="${serviceItem.item_id}" style="display: none;" />
                        <span class="btn btn-primary" onclick="document.getElementById('item_idChkBox_${status.index}').click();">선택하기</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
--%>




























<%--
<div class="serviceItem-container">
	<c:forEach var="serviceItem" items="${serviceItems }"
		varStatus="status">
		<div class="serviceItem-card"
			data-serviceItemId="${serviceItem.item_id }"
			data-serviceName="${serviceItem.service_name }"
			data-serviceDescription="${serviceItem.service_description }"
			data-requiredTime="${serviceItem.required_time }"
			data-servicePrice="${serviceItem.service_price }">
			<p>이름 : ${serviceItem.service_name }</p>
			<p>설명 : ${serviceItem.service_description }</p>
			<p>시간 : 약 ${serviceItem.required_time * 30}분</p>
			<p>가격 : ${serviceItem.service_price }원</p>
			<input type="checkbox" class="item_idChkBox" id="item_idChkBox"
				name="item_idChkBox" value="${serviceItem.item_id }" />
			<!-- <a href="productDetail.pdt?pdt_no=${productDto.pdt_no}">상세 보기</a>  -->
		</div>
	</c:forEach>
</div>
--%>
<input type="button" class="btn btn-primary d-block mx-auto" id="nextBtn" value="다음단계" /> <!-- 값 가져갈거 가격,시간,벤더이메일,사업자번호,선택된아이템id들 -->
<br>
<%--
data = { //SelectedItemsDto 다음페이지로 넘어가면서 세션에 저장 <br>
email: email, 벤더이메일 <br>
business_regi_num: businessRegiNum, 벤더사업자번호<br>
totalRequiredTime: totRequiredTimes, 선택된시간총합<br>
totalServicePrice: totServicePrices, 선택된가격총합<br>
selectedItems: selectedItemIdsAry //cardObjDto 선택한메뉴각각의정보객체배열<br>
};<br>

${sessionScope.loginName}<br>
${sessionScope.loginEmail}<br>
${sessionScope.loginAuthority}<br>
 --%>
</main>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c665e334713bdbedf11d514849fcb54b&libraries=services,clusterer,drawing"></script>
<script>



document.addEventListener("DOMContentLoaded", function() {
    // 첫 번째 <li> 요소 선택
    const firstIndicator = document.querySelector(".carousel-indicators li:first-child");
    
    // 'active' 클래스 추가
    if (firstIndicator) {
        firstIndicator.classList.add("active");
    }
    
	const firstCarouselItem = document.querySelector(".carousel-inner .carousel-item:first-child");
    
    // 'active' 클래스 추가
    if (firstCarouselItem) {
        firstCarouselItem.classList.add("active");
    }
});














	const vendorInfo = {
		address : '${vendorInfo.basic_address}', // 업체의 기본 주소
		businessName : '${vendorInfo.business_name}', // 업체명
		mainImg : '${pageContext.request.contextPath}' + '${mainImg}' // 이미지 경로
	};
	console.log('Vendor Info:', vendorInfo); // 객체가 제대로 정의되었는지 확인 -->
</script>
<div id="map" class="d-block mx-auto" style="width: 80%; height: 500px;"></div>
<script src="../resources/js/mapUtils.js"></script>
<script src="../resources/js/vendorMap.js"></script>
<script src="../resources/js/mbusinessplaceinfo.js"></script>
<%@include file="../include/footer.jsp"%>