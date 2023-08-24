<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Conv - Gifticon</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<style>
/* 퀵배너 영역 스타일 */
#quick-banner {
	position: fixed;
	top: 55%; /* 원하는 위치로 조정 */
	right: 150px; /* 원하는 위치로 조정 */
	transform: translateY(-50%);
	z-index: 9999;
}

#quick-banner a {
	display: block;
}

#quick-banner img {
	width: 400px; /* 퀵배너 이미지 크기 조정 */
	height: auto;
}

.cardDetail {
	display: none;
}

.cardNotice {
	display: none;
}

img.center-image {
	display: block; /* 인라인 요소를 블록 요소로 변경 */
	margin: 0 auto; /* 왼쪽과 오른쪽 여백을 "auto"로 설정하여 가로 가운데 정렬 dd*/
}
</style>



</head>

<body oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- Facilities Start -->
	<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">기프티콘</p>
<div class="row justify-content-center mt-1" style="min-height: 600px;">
		<div class="col-lg-8 col-xl-7 text-center">
			<div class="div_search mt-3">
				<form name="search"
					action="${pageContext.request.contextPath }/giftView" method="post">
					<input type="hidden" name="curPage" value="${searchVO.curPage}">
					<input type="hidden" name="rowSizePerPage"
						value="${searchVO.rowSizePerPage}"> &nbsp;&nbsp; <select
						id="id_searchCategory" name="searchCategory"
						style="width: 90px; height: 30px; font-size: 15px;"
						class="form-select">
						<option value="">편의점</option>
						<option value="C"
							${searchVO.searchCategory eq "C" ? "selected='selected'" : "" }>CU</option>
						<option value="G"
							${searchVO.searchCategory eq "G" ? "selected='selected'" : "" }>GS25</option>
						<option value="S"
							${searchVO.searchCategory eq "S" ? "selected='selected'" : "" }>세븐일레븐</option>
					</select>&nbsp;&nbsp;&nbsp; <select id="id_searchCategory2"
						name="searchCategory2"
						style="width: 110px; height: 30px; font-size: 15px;"
						class="form-select2">
						<option value="">전체</option>
						<option value="F"
							${searchVO.searchCategory2 eq "F" ? "selected='selected'" : "" }>식품</option>
						<option value="M"
							${searchVO.searchCategory2 eq "M" ? "selected='selected'" : "" }>모바일상품권</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" name="searchWord"
						value="${searchVO.searchWord}" size="30"
						placeholder="검색어를 입력해주세요."> &nbsp;&nbsp;&nbsp;&nbsp;
					<button type="submit" id="id_btn_search"
						class="btn btn-outline-dark btn-sm">조 회</button>
					&nbsp;
					<button type="button" id="id_btn_reset"
						class="btn btn-outline-dark btn-sm">초기화</button>
				</form>
			</div>
			<div class="row justify-content-end mt-3">
				<button type="button" class="btn searchBtn" id="searchBtn1">최다구매순</button>
				&nbsp;
				<button type="button" class="btn searchBtn" id="searchBtn2">좋아요순</button>
				&nbsp;
				<button type="button" class="btn searchBtn" id="searchBtn3">낮은금액순</button>
				&nbsp;
				<c:choose>
					<c:when test="${sessionScope.login != null}">
						<button type="button" class="btn searchBtn" id="searchBtn4">찜한상품만</button>
				&nbsp;
				</c:when>
					<c:otherwise>
						<button type="button" class="btn searchBtn" id="gologin"
							onclick="location.href='${pageContext.request.contextPath}/login'">찜한상품만</button>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="row mt-2 cardClass">
				<c:if test="${empty giftList}">
					<div class="col text-center">
								<br><br><br><br>
						<p class="text-secondary"
		style="font-size: 50px;">검색 결과에 맞는 물건이 없습니다.</p>
							<br><br><br><br>
					</div>
				</c:if>
				<c:forEach items="${giftList}" var="gift" varStatus="loop">
					<div class="col-lg-4 col-md-6">
						<div class="row">
							<c:if test="${sessionScope.login != null}">
								<div class="col text-right">
									<svg id="reBu1" data-gift-no="${gift.giftNo}"
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="rgb(219,68,85)" class="bi bi-heart" viewBox="0 0 16 16"
										onclick="giftHit(${gift.giftNo})">
                                            <path
											d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z" />
                                        </svg>
									<svg id="reBu2" data-gift-no="${gift.giftNo}"
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="rgb(219,68,85)" class="bi bi-heart-fill"
										viewBox="0 0 16 16" onclick="giftHit(${gift.giftNo})">
  <path fill-rule="evenodd"
											d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
</svg>
								</div>
							</c:if>
						</div>
						<div class="gift-card card mb-3">
							<div class="row g-0 d-flex align-items-center"
								style="height: 230px;">
								<div class="col-md-4 d-flex align-items-center">
									<img src="${gift.giftSrc}"
										class="img-fluid rounded-start gift-img" alt="기프트 이미지"
										style="width: 100%; max-width: 100%; height: auto;"
										onclick="openGiftModal(this)">
								</div>
								<div
									class="col-md-8 d-flex justify-content-center align-items-center">
									<div class="card-body">
										<div style="display: flex; align-items: center;"></div>
										<p class="cardType"
											style="text-align: center; font-size: 19px;">${gift.giftType}</p>
										<p class="cardTitle text-secondary"
											style="text-align: center; font-size: 20px;">${gift.giftName}</p>
										<p class="cardPrice"
											style="text-align: center; font-size: 19px;">${gift.giftPrice}원</p>
										<p class="cardDetail">${gift.giftDetail}</p>
										<p class="cardNotice">${gift.giftNotice}</p>
										<input type="hidden" name="giftNo" class="giftNo"
											value="${gift.giftNo}">
										<p class="itemCount" data-gift-no="${gift.giftNo}"></p>
										<c:choose>
											<c:when test="${sessionScope.login != null}">
												<!-- 세션에 로그인 정보가 있는 경우 -->
												<svg xmlns="http://www.w3.org/2000/svg" width="30"
													height="30" fill="currentColor"
													class="bi bi-cart-plus text-secondary" viewBox="0 0 16 16"
													onclick="addToCart(this)">
  <path
														d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9V5.5z" />
  <path
														d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1H.5zm3.915 10L3.102 4h10.796l-1.313 7h-8.17zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
</svg>

											</c:when>
											<c:otherwise>
												<!-- 세션에 로그인 정보가 없는 경우 -->
												<svg xmlns="http://www.w3.org/2000/svg" width="30"
													height="30" fill="currentColor"
													class="bi bi-cart-plus text-secondary" viewBox="0 0 16 16"
													onclick="location.href='${pageContext.request.contextPath}/login'">
  <path
														d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9V5.5z" />
  <path
														d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1H.5zm3.915 10L3.102 4h10.796l-1.313 7h-8.17zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
</svg>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="col-lg-8 col-xl-7 text-center mt-3">
			<div class="div_paging text-center">
				<nav aria-label="Page navigation example">
					<ul id="pagination-ul" class="pagination justify-content-center">
						<c:if test="${searchVO.curPage > 1}">
							<li class="page-item"><a class="page-link" href="#"
								data-curPage="1"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">처음페이지로</a></li>
						</c:if>
						<c:if test="${searchVO.firstPage gt 5}">
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold" data-curPage="${searchVO.firstPage-1}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">◀</a></li>
						</c:if>
						<c:forEach begin="${searchVO.firstPage}"
							end="${searchVO.lastPage}" step="1" var="i">
							<c:if test="${searchVO.curPage ne i}">
								<li class="page-item"><a class="page-link" href="#"
									data-curPage="${i}"
									data-rowSizePerPage="${searchVO.rowSizePerPage}">${i}</a></li>
							</c:if>
							<c:if test="${searchVO.curPage eq i}">
								<li class="page-item active" aria-current="page"><span
									class="page-link curPage_a" style="font-weight: bold">${i}</span>
								</li>
							</c:if>
						</c:forEach>

						<c:if test="${searchVO.lastPage ne searchVO.totalPageCount}">
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold" data-curPage="${searchVO.lastPage+1}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">▶</a></li>
						</c:if>
						<c:if test="${searchVO.curPage < searchVO.totalPageCount}">
							<a class="page-link" href="#"
								data-curPage="${searchVO.totalPageCount}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">끝페이지로</a>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<div class="modal fade" id="giftModal" data-backdrop="static"
		data-keyboard="false" tabindex="-1" aria-labelledby="giftModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<p class="modal-title text-secondary" style="font-size: 20px;"
						id="giftModalLabel">기프트 상세 정보</p>
					<button type="button" class="close" aria-label="Close"
						data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body row g-0">
					<div
						class="col-md-6 d-flex justify-content-center align-items-center"
						style="height: 250px">
						<img src="" class="modal-giftImg" alt="기프트 이미지"
							style="display: block; margin: 0 auto; max-width: 300px; max-height: auto;">
					</div>
					<div
						class="col-md-6 d-flex justify-content-center align-items-center">
						<div>
							<p class="modal-giftType text-dark"
								style="text-align: center; font-size: 25px;">${gift.giftType}</p>
							<p class="modal-giftName text-secondary"
								style="text-align: center; font-size: 28px;">${gift.giftName}</p>
							<p class="modal-giftPrice text-dark"
								style="text-align: center; font-size: 25px;">${gift.giftPrice}원</p>
						</div>
					</div>
				</div>
				<!-- 네비게이션 탭 -->
				<ul class="nav nav-tabs" id="giftTabs" role="tablist">
					<li class="nav-item" role="presentation"><a
						class="nav-link active" id="notice-tab" data-toggle="tab"
						href="#notice" role="tab" aria-controls="notice"
						aria-selected="false">상세 정보</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link"
						id="detail-tab" data-toggle="tab" href="#detail" role="tab"
						aria-controls="detail" aria-selected="true">유의사항</a></li>
				</ul>
				<!-- 탭 컨텐츠 -->
				<div class="tab-content" id="giftTabContent"
					style="height: 450px; overflow-y: auto;">
					<div class="tab-pane fade show active" id="notice" role="tabpanel"
						aria-labelledby="notice-tab">
						<br>
						<p class="modal-giftDetail text-dark" style="font-size: 18px;"></p>
					</div>
					<div class="tab-pane fade text-dark" id="detail" role="tabpanel"
						aria-labelledby="detail-tab" style="font-size: 16px;">
						<br>
						<p class="modal-giftNotice"></p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="quick-banner">
		<c:if test="${sessionScope.login != null}">
			<p style="text-align: center; font-size: 24px;"
				class="text-secondary">최근 담은 상품</p>
			<hr>
			<div class="bannerContainer">
				<!-- START_REPLACE_BANNER_CONTENT -->
				<c:forEach items="${cartList}" var="cart" varStatus="loop" begin="0"
					end="2">
					<div class="mt-1 bannerList">
						<img src="${cart.giftSrc}" alt="장바구니"
							data-gift-type="${cart.giftType}"
							data-gift-name="${cart.giftName}"
							data-gift-price="${cart.giftPrice}"
							style="width: 160px; height: auto; display: block; margin: 0 auto;"
							onclick="openModalBanner(this)">
						<p class="cardDetail">${cart.giftDetail}</p>
						<p class="cardNotice">${cart.giftNotice}</p>
						<a style="text-align: center;">${cart.giftName}</a>
					</div>
					<hr>
				</c:forEach>
				<!-- END_REPLACE_BANNER_CONTENT -->
			</div>
			<div class="col text-center">
				<button type="button" style="text-align: center;"
					class="btn btn-lg btn-secondary"
					onclick="location.href='${pageContext.request.contextPath}/cartView'">장바구니
					가기</button>
			</div>
		</c:if>
	</div>

	<script>
	
    $(document).ready(function() {
    	
        var lastClickedButton = localStorage.getItem('lastClickedButton');
        
    	if (!localStorage.getItem('lastClickedButton')) {
    	    localStorage.setItem('lastClickedButton', 'searchBtn1');
    	}
    	console.log("lastClickedButton : ", lastClickedButton);

        const giftNoArray = [];
        
        $(".bi-heart").each(function() {
            const giftNo = $(this).data("gift-no");
            giftNoArray.push(giftNo);
        });

        giftHitCheck(giftNoArray);

        $('#pagination-ul').off('click', 'a.page-link');

        function loadPageData(pageNumber) {
        	var searchBtn = localStorage.getItem('lastClickedButton');
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/giftView',
                data: {
                    curPage: pageNumber,
                    rowSizePerPage: '${searchVO.rowSizePerPage}',
                    searchCategory: $('#id_searchCategory').val(),
                    searchCategory2: $('#id_searchCategory2').val(),
                    searchWord: $('input[name="searchWord"]').val(),
                    searchBtn : searchBtn
                },
                dataType: 'html',
                success: function(data) {
                    $('.cardClass').html($(data).find('.cardClass').html());
                    $('.div_paging').html($(data).find('.div_paging').html());

                    const giftNoArray = [];
                    $(".bi-heart").each(function() {
                        const giftNo = $(this).data("gift-no");
                        giftNoArray.push(giftNo);
                    });

                    giftHitCheck(giftNoArray);

                    $('#pagination-ul').on('click', 'a.page-link', function(e) {
                        e.preventDefault();
                        const curPage = $(this).data('curpage');
                        loadPageData(curPage);
                    });
                },
                error: function(xhr, status, error) {
                }
            });
        }

        function performSearch() {
        	var searchBtn = localStorage.getItem('lastClickedButton');
            const searchCategory = $('#id_searchCategory').val();
            const searchCategory2 = $('#id_searchCategory2').val();
            const searchWord = $('input[name="searchWord"]').val();
            const curPage = 1;
            console.log("searchBtn : ", searchBtn);

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/giftView',
                data: {
                    curPage: curPage,
                    rowSizePerPage: '${searchVO.rowSizePerPage}',
                    searchCategory: searchCategory,
                    searchCategory2: searchCategory2,
                    searchWord: searchWord,
                    searchBtn: searchBtn
                },
                dataType: 'html',
                success: function(data) {
                    $('.cardClass').html($(data).find('.cardClass').html());
                    $('.div_paging').html($(data).find('.div_paging').html());

                    $('#pagination-ul').off('click', 'a.page-link');
                    $('#pagination-ul').on('click', 'a.page-link', function(e) {
                        e.preventDefault();
                        const curPage = $(this).data('curpage');
                        loadPageData(curPage);
                    });

                    const giftNoArray = [];

                    $(".bi-heart").each(function() {
                        const giftNo = $(this).data("gift-no");
                        giftNoArray.push(giftNo);
                    });

                    giftHitCheck(giftNoArray);
                },
                error: function(xhr, status, error) {
                }
            });
        }

        $(document).on('click', '#id_btn_search', function(e) {
            e.preventDefault();
            performSearch();
        });

        $(document).on('click', '.searchBtn', function(e) {
            var searchBtn = $(this).attr('id');
            localStorage.setItem('lastClickedButton', searchBtn);
            e.preventDefault();
            var lastClickedButton = localStorage.getItem('lastClickedButton');
            performSearch();
        });

        function performReset() {
            const curPage = 1;
            const rowSizePerPage = '${searchVO.rowSizePerPage}';

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/giftView',
                data: {
                    curPage: curPage,
                    rowSizePerPage: rowSizePerPage,
                    searchCategory: '',
                    searchCategory2: '',
                    searchWord: '',
                    searchBtn: ''
                },
                dataType: 'html',
                success: function(data) {
                    $('.cardClass').html($(data).find('.cardClass').html());
                    $('.div_paging').html($(data).find('.div_paging').html());

                    $('#pagination-ul').off('click', 'a.page-link');
                    $('#pagination-ul').on('click', 'a.page-link', function(e) {
                        e.preventDefault();
                        const curPage = $(this).data('curpage');
                        loadPageData(curPage);
                    });

                    $('input[name="searchWord"]').val('');
                    $('#id_searchCategory').val('');
                    $('#id_searchCategory2').val('');

                    const giftNoArray = [];

                    $(".bi-heart").each(function() {
                        const giftNo = $(this).data("gift-no");
                        giftNoArray.push(giftNo);
                    });

                    giftHitCheck(giftNoArray);
                },
                error: function(xhr, status, error) {
                }
            });
        }

        $(document).on('click', '#id_btn_reset', function(e) {
            e.preventDefault();
            performReset();
        });

        loadPageData('${searchVO.curPage}');
    });
</script>

	<script>
	function openGiftModal(img) {
	    var giftSrc = img.getAttribute("src");
	    var giftType = img.closest(".gift-card").querySelector(".cardType").textContent;
	    var giftName = img.closest(".gift-card").querySelector(".cardTitle").textContent;
	    var giftPrice = img.closest(".gift-card").querySelector(".cardPrice").textContent;
	    var giftDetail = img.closest(".gift-card").querySelector(".cardDetail").innerHTML;
	    var giftNotice = img.closest(".gift-card").querySelector(".cardNotice").innerHTML;
	    
	    $("#giftModal .modal-giftImg").attr("src", giftSrc);
	    $("#giftModal .modal-giftType").text(giftType);
	    $("#giftModal .modal-giftName").text(giftName);
	    $("#giftModal .modal-giftPrice").text(giftPrice);
	    $("#giftModal .modal-giftDetail").html(giftDetail);
	    $("#giftModal .modal-giftNotice").html(giftNotice);

	    $("#giftModal").modal("show");
	}
	
function openModalBanner(img) {
    var giftSrc = img.getAttribute("src");
    var giftType = img.getAttribute("data-gift-type");
    var giftName = img.getAttribute("data-gift-name");
    var giftPrice = img.getAttribute("data-gift-price");
    var giftDetail = img.parentNode.querySelector(".cardDetail").innerHTML;
    var giftNotice = img.parentNode.querySelector(".cardNotice").innerHTML;
    
    $("#giftModal .modal-giftImg").attr("src", giftSrc);
    $("#giftModal .modal-giftType").text(giftType);
    $("#giftModal .modal-giftName").text(giftName);
    $("#giftModal .modal-giftPrice").text(giftPrice);
    $("#giftModal .modal-giftDetail").html(giftDetail);
    $("#giftModal .modal-giftNotice").html(giftNotice);

    $("#giftModal").modal("show");
}
</script>
	<script>
let isRecommended;

function updateUI(giftNo, isRecommended) {
    const heartButton = $("#reBu1[data-gift-no='" + giftNo + "']");
    if (!isRecommended) {
        console.log("isRecommended 값:", isRecommended);
        heartButton.show();
        heartButton.next("#reBu2").hide();
    } else {
        heartButton.next("#reBu2").show();
        heartButton.hide();
    }
}

function giftHitCheck(giftNoArray) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/giftHitCheck",
        contentType: 'application/json',
        data: JSON.stringify(giftNoArray),
        success: function(response) {
            response.forEach(function(isRecommended, index) {
            	 const heartButton = $("#reBu1[data-gift-no='" + giftNoArray[index] + "']");
            	    if (!isRecommended) {
            	        heartButton.show();
            	        heartButton.next("#reBu2").hide();
            	    } else {
            	        heartButton.next("#reBu2").show();
            	        heartButton.hide();
            	    }
            });
        },
        error: function(xhr, status, error) {
            console.log("Error: 로그인안함 ");
        }
    });
}

function giftHitEdit(giftNo) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/giftHitEdit",
        data: { giftNo: giftNo },
        success: function(response) {
            console.log("edit response: ", response);
            isRecommended = response;
            updateUI(giftNo, isRecommended);
        },
        error: function(xhr, status, error) {
            console.log("error");
        }
    });
}

function giftHit(giftNo) {
    if (isRecommended) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/giftHitCancel",
            data: { giftNo: giftNo },
            success: function(response) {
                giftHitEdit(giftNo);
                console.log("추천 취소", response.isRecommended);
                isRecommended = response.isRecommended;
            },
            error: function(xhr, status, error) {
                console.log("error");
            }
        });
    } else {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/giftHit",
            data: { giftNo: giftNo },
            success: function(response) {
                giftHitEdit(giftNo);
                console.log("추천", response.isRecommended);
                isRecommended = response.isRecommended;
            },
            error: function(xhr, status, error) {
                alert("추천실패");
            }
        });
    }
}
</script>
	<script>
		const cartData = {};

		function addToCart(button) {
			const cardContainer = button.closest('.gift-card');
			const itemCountSpan = cardContainer.querySelector('.itemCount');
			const giftNoElement = cardContainer.querySelector('.giftNo');

			if (itemCountSpan && giftNoElement) {
				const giftNo = giftNoElement.value;
				if (!cartData[giftNo]) {
					cartData[giftNo] = {
						cartParentNo : giftNo,
						cartCount : 1,
						cartId : "${sessionScope.login.id}"
					};
				} else {
					cartData[giftNo].cartCount++;
				}
				itemCountSpan.textContent = cartData[giftNo].cartCount;

				if (cartData[giftNo].cartCount === 0) {
					itemCountSpan.style.display = "none";
				} else {
					itemCountSpan.style.display = "inline";
				}

				insertCart(cartData[giftNo]);
			}
		}
	
		function insertCart(cartData) {
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/insertCart",
				data : JSON.stringify([ cartData ]),
				contentType : "application/json",
				success : function(cartList) {
					console.log("Success");
					updateCartUI(cartList);
				},
				error : function(error) {
					console.error("Error");
				}
			});
		}
		
		function updateCartUI(cartList) {
		    const quickBanner = document.getElementById("quick-banner");
		    const bannerContainer = quickBanner.querySelector(".bannerContainer"); 
		    console.log("updateCartUI cartList : ",cartList);
		    console.log("updateCartUI bannerContainer : ",bannerContainer);
		    
		    let newContent = '';
		    const loopEnd = Math.min(cartList.length, 3);
		    for (var i = 0; i < loopEnd; i++) {
		        var cart = cartList[i]; 
		        var giftName = cart.giftName;
		        var giftPrice = cart.giftPrice;
		        var giftSrc = cart.giftSrc;
		        var giftDetail = cart.giftDetail;
		        var giftNotice = cart.giftNotice;

		        newContent += '<div class="bannerList">';
		        newContent += '<img src="' + giftSrc + '" alt="장바구니"';
		        newContent += 'data-gift-type="" data-gift-name="' + giftName + '"';
		        newContent += 'data-gift-price="' + giftPrice + '"';
		        newContent += 'style="width: 160px; height: auto; display: block; margin: 0 auto;"';
		        newContent += 'onclick="openModalBanner(this)">';
		        newContent += '<p class="cardDetail">' + giftDetail + '</p>';
		        newContent += '<p class="cardNotice">' + giftNotice + '</p>';
		        newContent += '<a style="text-align: center;">' + giftName + '</a>';
		        newContent += '</div>';
		        newContent += '<hr>';
		    }
		    
		    bannerContainer.innerHTML = newContent;
		}
	</script>

	<%@ include file="/WEB-INF/inc/footer.jsp"%>

	<!-- JavaScript Libraries -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/easing/easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/owlcarousel/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/isotope/isotope.pkgd.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/lightbox/js/lightbox.min.js"></script>

	<!-- Contact Javascript File -->
	<script
		src="${pageContext.request.contextPath }/mail/jqBootstrapValidation.min.js"></script>
	<%-- <script src="${pageContext.request.contextPath }/mail/contact.js"></script> --%>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
