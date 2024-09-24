<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@include file="../include/header.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}
#container444 {
    display: grid;
    grid-template-columns: 4fr 4fr 4fr;
}
#container282 {
    display: grid;
    grid-template-columns: 2fr 8fr 2fr;
}
.hidden {
    display: none;
}
</style>
<div class="header-placeholder"></div>

<main>

<div class="container mt-3">

<div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">

  
  <ul class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ul>
  
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="../resources/imgs/noimage.jpg" alt="noimage" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="../resources/imgs/fwr.jpg" alt="fwr" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="../resources/imgs/main1.jpg" alt="hair shop" width="1100" height="500">
    </div>
  </div>
  
  <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#myCarousel" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
  
</div>

</div>
	<div class="text-center mt-5">
	
        <div class="m-3"><a href="/ex/user/login" class="text-decoration-none text-reset"><i class="fa-solid fa-right-to-bracket"></i>로그인</a></div>
        <div class="m-3"><a href="/ex/user/insert" class="text-decoration-none text-reset"><i class="fa-solid fa-users"></i>회원가입</a></div>
    </div>



</main>
<script>
$(document).ready(function() {
    $('#findIdBtn').click(function() {
    	window.location.href = 'findMyAccount';
    });
    $('#memberJoinBtn').click(function() {
    	window.location.href = 'insert';
    });
});

</script>
<%@include file="../include/footer.jsp"%>