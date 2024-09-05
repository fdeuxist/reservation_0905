<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>업체 등록</title>
<link rel="stylesheet" href="/ex/resources/css/uploadStyle.css">
</head>
<body>
	<div class="container">
		<h1>서비스 업체 등록</h1>
		<form action="/ex/file/updateItemInfo" method="post"
			enctype="multipart/form-data">

			<div class="form-group">
				<label for="item_id">아이템 ID:</label> <input type="text"
					name="item_id" id="item_id" required>
			</div>

			<div class="form-group">
				<label for="email">이메일:</label> <input type="email" name="email"
					id="email" required>
			</div>

			<div class="form-group">
				<label for="business_regi_num">사업자 등록 번호:</label> <input type="text"
					name="business_regi_num" id="business_regi_num" required>
			</div>

			<div class="form-group">
				<label for="service_name">서비스명:</label> <input type="text"
					name="service_name" id="service_name" required>
			</div>

			<div class="form-group">
				<label for="service_description">서비스 설명:</label>
				<textarea name="service_description" id="service_description"
					rows="4" required></textarea>
			</div>

			<div class="form-group">
				<label for="required_time">소요 시간 (분):</label> <input type="number"
					name="required_time" id="required_time" required>
			</div>

			<div class="form-group">
				<label for="price">가격 (원):</label> <input type="number" name="price"
					id="price" required>
			</div>

			<div class="form-group">
				<label for="item_status">아이템 상태:</label> <input type="text"
					name="item_status" id="item_status" required>
			</div>

			<div class="form-group">
				<label for="file">로고 또는 파일 업로드:</label> <input type="file"
					name="file" id="file">
				<p class="note">업로드할 파일은 최대 5MB 크기 제한이 있습니다.</p>
			</div>

			<input type="submit" value="등록">
		</form>
	</div>
</body>
</html>
