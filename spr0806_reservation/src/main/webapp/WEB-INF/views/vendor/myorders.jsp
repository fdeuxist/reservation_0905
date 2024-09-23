<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<%-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>  --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
<%-- 
.header-placeholder {
    height: 60px;   /* 헤더 높이와 동일하게 설정 */
}

.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center;
}

.orders-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.orders-table th,
.orders-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.orders-table th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.orders-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.orders-table tr:hover {
    background-color: #f1f1f1;
}

#pagination {
	font-size: 15px;
    margin-bottom: 60px;
    text-align: center;
}
--%>

body {
    background-color: #f4f4f4;
}
</style>
<div class="header-placeholder"></div>
<main>
    <div class="container text-center">
        <br><br><h1>예약 목록</h1><br>
        <table class="orders-table table text-center">
            <thead>
                <tr>
                    <th>예약주문 번호</th>
                    <th>예약 날짜</th>
                    <th>방문 예정 날짜</th>
                    <th>상태 : 
                    	<select id="statusSelect" name="status" onchange="statusChange()">
				            <option value="1">입금대기</option>
				            <option value="2">입금완료</option>
				            <option value="3">이용완료</option>
				            <option value="4">취소대기</option>
				            <option value="5">취소완료</option>
				            <option value="6">환불대기</option>
				            <option value="7">환불완료</option>
				        </select>
                    </th>
                </tr>
            </thead>
            <tbody id="tableBody">
            
            </tbody>
        </table>
    </div>
        <div id="pagination" class="text-center">aaaa</div>
        <div class="pb-5"></div>
</main>
<% String loginEmail = (String) session.getAttribute("loginEmail"); 
String loginBusinessRegiNum = (String) session.getAttribute("loginBusiness_regi_num");
String sessionPageNum = (String) session.getAttribute("sessionPageNum");
String sessionStatusNum = (String) session.getAttribute("sessionStatusNum"); %>

<script>

const statusSelect = document.getElementById("statusSelect");
var totalRow = 0;
var currentPage = 1; // 현재 페이지 설정
console.log("default totalRow " , totalRow)
console.log("default currentPage " , currentPage)


const loginEmail = '<%= loginEmail %>';
const loginBusinessRegiNum = '<%= loginBusinessRegiNum %>';
const sessionPageNum = '<%= sessionPageNum %>';
const sessionStatusNum = '<%= sessionStatusNum %>';

document.addEventListener("DOMContentLoaded", function() {
	
	
	if(sessionPageNum=="null"){ // ==null이 아니라 문자여서 =="null" 로 체크 해야함
		console.log("문자로 널이네")
		statusSelect.value = "2";
		currentPage = 1;
		statusChange()
	}else{	//null이 아니면orderinfo 한번 이상 들어갔다 나왔다는 것이니 세션에 있는 이전페이지였던 페이지번호와 주문상태번호를 가져옴
		console.log("before currentPage : " , currentPage , "sessionPageNum : ", sessionPageNum);
		console.log("before statusSelect.value : " , statusSelect.value , "sessionStatusNum : " , sessionStatusNum);
		currentPage = sessionPageNum;
		statusSelect.value = sessionStatusNum;
		console.log("after currentPage : " , currentPage);
		console.log("after statusSelect.value : " , statusSelect.value);
		statusChange()
	}
	
	
});

//console.log(loginEmail, " " , loginBusinessRegiNum)

console.log("default sessionPageNum " , sessionPageNum , "  sessionStatusNum  " , sessionStatusNum)

function statusChange() {	//주문상태 선택이 바뀌면 해당 상태에 맞는 주문들 갯수 받아옴
	//const statusSelect = document.getElementById("statusSelect");	//위로 뺌 
	console.log("[statusChange()] selected status : " + statusSelect.value);
    
    $.ajax({
        url: '/ex/vendorrest/countReservationRow',
        type: 'GET',
        data: { vendor_email: loginEmail,
        		business_regi_num: loginBusinessRegiNum,
        		status: statusSelect.value },
        dataType: 'json',
        success: function(data) {
            console.log("[statusChange()] return count (totalRow) ", data);	//주문 갯수
            totalRow = data;
            //currentPage = 1;
           	console.log("[statusChange()] totalRow, currentPage " , totalRow, " " , currentPage);
            reservationListPage(currentPage);	//해당 페이지의 주문 dto list 가져와서 테이블채우고 페이지버튼그림
            
           	//받아온 rownum을 기반으로 페이지네이션 버튼 그려주고 해당 버튼 누르면 
        	//createPagination(totalRow, currentPage);
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
}

function reservationListPage(pageNum) {	//해당 페이지의 주문 dto list 가져와서 테이블채우고 페이지버튼그림
	//console.log("reservationListPage() called")
	currentPage = pageNum;	//페이지버튼 눌렀을때 pageNum 값을 currentPage에 저장해줘야 뒤로가기 했을때 쓸 수 있다
    $.ajax({
        url: '/ex/vendorrest/reservationListPage',
        type: 'GET',
        data: { vendor_email: loginEmail,
        		business_regi_num: loginBusinessRegiNum,
        		status: statusSelect.value,
        		currPageNum: pageNum },
        dataType: 'json',
        success: function(data) {
            console.log("[reservationListPage(pageNum)] return list : ", data);
            updateReservationTable(data);			 //테이블 채우기
            currentPage = pageNum;
        	createPagination(totalRow, currentPage); //페이지 버튼 그리기
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
}

function updateReservationTable(orders) {	//테이블 채우기
	//console.log("updateReservationTable() called")
	//console.log(orders.length);;
    let tableBodyHtml = '';
    const statusTextArray = ['알수없음', '입금대기', '입금완료', '이용완료', '취소대기', '취소완료', '환불대기', '환불완료'];
    for(let i=0; i<orders.length; i++) {
    	let order = orders[i];
    	/*
    	<tr>
            <td><a href="/ex/vendor/orderinfo?reservationNumber=20240916011130741">20240916011130741</a></td>
            <td>2024-09-16</td>
            <td>2024-09-19</td>
            <td>입금완료</td>
        </tr>
    	*/
//      <td><a href="/ex/vendor/orderinfo?reservationNumber=` + order.reservation_number + `">` + order.reservation_number + `</a></td>
    	tableBodyHtml += `<tr>`+
    					`<td><a href="/ex/vendor/orderinfo?reservationNumber=` +
    					order.reservation_number + `&sn=` + statusSelect.value + 
    					`&pn=` + currentPage + `">` + order.reservation_number + `</a></td>` +
                        `<td>` + order.reservation_date + `</td>` +
                        `<td>` + order.reservation_use_date + `</td>` +
                        `<td>` + statusTextArray[order.status] + `</td>` +
                      	`</tr>`;
    	};

    document.getElementById("tableBody").innerHTML = tableBodyHtml;
}






function createPagination(totalRow, currentPage) { 	//페이지 버튼 그리기
	//console.log("createPagination() called")
	const totalPages = Math.ceil(totalRow / 10); // 페이지 수 계산. 페이지당 10줄 10으로 나눠서 소수점있으면 올림
	const currentGroup = Math.ceil(currentPage / 5); //현재 페이지 그룹 계산. 버튼을 5개씩 보여줄것이기때문에 5로 나눠서 소수점있으면 올림
	const startPage = (currentGroup - 1) * 5 + 1; //시작페이지가 될 
	const endPage = Math.min(startPage + 5 - 1, totalPages);

	//currentPage = pageNum;

	console.log("[createPagination(totalRow, currentPage)] totalPages currentGroup startPage endPage ", 
	        totalPages , " " , currentGroup , " ", startPage , " ", endPage)

	let paginationHtml = '<div class="btn-group">';

	// 첫페이지로 가기
	if (currentPage > 1) { //현재페이지가 1보다 크면 보여짐
	    paginationHtml += '<button class="btn btn-secondary btn-sm" onclick="reservationListPage(1)">처음 </button>';
	}

	// 이전 버튼
	if (currentPage > 1) {
	    paginationHtml += '<button class="btn btn-secondary btn-sm" onclick="reservationListPage(' + (currentPage - 1) + ')">이전 </button>';
	}

	//console.log("★★★★★★ currentPage " , currentPage , " , startPage " , startPage)
	// 페이지 버튼
	for (let i = startPage; i <= endPage; i++) {
	    if (i == currentPage) {
	        paginationHtml += '<button class="btn btn-secondary btn-sm" disabled>' + i + '</button>';
	    } else {
	        paginationHtml += '<button class="btn btn-secondary btn-sm" onclick="reservationListPage(' + i + ')">' + i + '</button>';
	    }
	}

	// 다음 버튼
	if (currentPage < totalPages) {
	    paginationHtml += '<button class="btn btn-secondary btn-sm" onclick="reservationListPage(' + (currentPage + 1) + ')">다음 </button>';
	}

	// 맨 끝 페이지로 가기
	if (currentPage < totalPages) { //현재페이지보다 끝페이지가 크면 보여짐
	    paginationHtml += '<button class="btn btn-secondary btn-sm" onclick="reservationListPage(' + totalPages + ')">맨끝</button>';
	}
	
	paginationHtml += '</div>';
	
	document.getElementById("pagination").innerHTML = paginationHtml;
	}











//a태그버전
/*
function createPagination(totalRow, currentPage) { 	//페이지 버튼 그리기

	const totalPages = Math.ceil(totalRow / 10); // 페이지 수 계산. 페이지당 10줄 10으로 나눠서 소수점있으면 올림
    const currentGroup = Math.ceil(currentPage / 5); //현재 페이지 그룹 계산. 버튼을 5개씩 보여줄것이기때문에 5로 나눠서 소수점있으면 올리
    const startPage = (currentGroup - 1) * 5 + 1; //시작페이지가 될 
    const endPage = Math.min(startPage + 5 - 1, totalPages);

    //currentPage = pageNum;
    
    console.log("[createPagination(totalRow, currentPage)] totalPages currentGroup startPage endPage ", 
    		totalPages , " " , currentGroup , " ", startPage , " ", endPage)
    
    let paginationHtml = '';

    // 첫페이지로 가기
    if (currentPage > 1) { //현재페이지가 1보다 크면 보여짐
        paginationHtml += '<a href="#" onclick="reservationListPage(1)">◀◀ </a>';
    }

    // 이전 버튼
    if (currentPage > 1) {
        paginationHtml += '<a href="#" onclick="reservationListPage(' + (currentPage - 1) + ')">◀ </a>';
    }

    // 페이지 버튼
    for (let i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            paginationHtml += '<span class="current-page">' + i + '</span>';
        } else {
            paginationHtml += '<a href="#" onclick="reservationListPage(' + i + ')">' + i + '</a>';
        }
    }

    // 다음 버튼
    if (currentPage < totalPages) {
        paginationHtml += '<a href="#" onclick="reservationListPage(' + (currentPage + 1) + ')">▶ </a>';
    }

    // 맨 끝 페이지로 가기
    if (currentPage < totalPages) { //현재페이지보다 끝페이지가 크면 보여짐
        paginationHtml += '<a href="#" onclick="reservationListPage(' + totalPages + ')">▶▶</a>';
    }

    document.getElementById("pagination").innerHTML = paginationHtml;
}
*/




</script>
<%@include file="/WEB-INF/views/include/footer.jsp"%>
