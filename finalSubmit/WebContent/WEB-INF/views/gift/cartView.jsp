<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Conv - Cart</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
	margin: 0 auto; /* 왼쪽과 오른쪽 여백을 "auto"로 설정하여 가로 가운데 정렬 */
}
</style>


</head>

<body oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- Facilities Start -->
	<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">장바구니</p>
	<div class="row justify-content-center mt-1" style="min-height: 600px;">
		<div class="col-lg-8 col-xl-7 text-center">
			<div class="div_search mt-3">
				<div class="mt-3">
					<c:if test="${not empty cartList}">
						<div class="text-right">
							<p class="text-secondary" style="font-size: 20px;">
								총 &nbsp;&nbsp;<span id="selectedCount"
									style="color: #3C727B; font-size: 30px;">0</span>&nbsp;개&nbsp;&nbsp;
								<span id="totalPrice" style="color: #3C727B; font-size: 30px;">0</span>&nbsp;원
							</p>
							<button type="button" class="btn btn-lg btn-secondary"
								onclick="selectDelete()">삭제하기</button>
							<button type="button" class="btn btn-lg btn-secondary"
								onclick="buyItems()">구매하기</button>
						</div>
						<div class="text-left">
							<input type="checkbox" style="zoom: 1.5" id="check_all" checked>
							<label for="check_all" id="check_all_label"
								style="font-size: larger">전체해제하기</label>
						</div>
					</c:if>
					<c:choose>
						<c:when test="${empty cartList}">
						<br><br><br><br><br><br><br><br><br>
						<p class="text-secondary"
		style="font-size: 50px;">장바구니에 담긴 물건이 없습니다.</p>
							<br><br><br><br><br><br><br><br><br>
						</c:when>
						<c:otherwise>
							<div class="row">
								<c:forEach var="cart" items="${cartList}" varStatus="loop">
									<div class="col-md-6" id="cartItem${loop.index}">
										<div class="card-checkbox"
											style="display: flex; align-items: flex-start;">
											<input type="checkbox" style="zoom: 1.5" name="selectItem"
												id="selectItem${loop.index}" checked
												onclick="updateTotal(${loop.index}, ${cart.giftPrice})">
										</div>
										<div class="gift-card card mb-3">
											<div class="row g-0 ">
												<div class="col-md-5"
													style="display: flex; justify-content: center; align-items: center;">
													<img src="${cart.giftSrc}"
														class="img-fluid rounded-start gift-img" alt="기프트 이미지"
														style="width: 100%; max-width: 100%; height: auto;"
														onclick="openGiftModal(this)">
												</div>
												<div class="col-md-7">
													<div class="card-body" style="height: 220px;">
														<div style="display: flex; align-items: center;"></div>
														<p class="cardType"
															style="text-align: center; font-size: 19px;">${cart.giftType}</p>
														<p class="cardTitle text-secondary"
															style="text-align: center; font-size: 20px;">${cart.giftName}</p>
														<p class="cardPrice"
															style="text-align: center; font-size: 19px;">${cart.giftPrice}원</p>
														<p class="cardDetail">${cart.giftDetail}</p>
														<p class="cardNotice">${cart.giftNotice}</p>
														<input type="hidden" name="giftNo" class="giftNo"
															value="${cart.giftNo}"> <input type="hidden"
															name="Counts" id="Counts${loop.index}"
															value="${cart.cartCount}"> <input type="hidden"
															name="giftNo" id="giftNo${loop.index}"
															value="${cart.giftNo}">
														<button type="button" class="btn btn-lg text-secondary"
															style="font-size: 23px;"
															onclick="minusCount(${loop.index})">-</button>
														<span class="text-secondary" style="font-size: 20px;"
															id="CountDisplay${loop.index}" ondblclick="toInput(this)">&nbsp;&nbsp;${cart.cartCount}&nbsp;&nbsp;</span>
														<button type="button" class="btn btn-lg text-secondary"
															style="font-size: 23px;"
															onclick="plusCount(${loop.index})">+</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
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
					onclick="location.href='${pageContext.request.contextPath}/giftView'">상품목록
					가기</button>
			</div>
		</c:if>
	</div>

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
	function numbering(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	$("#check_all").click(function(){
	    if ($(this).prop("checked")) {
	        $("input[name='selectItem']").prop("checked", true);
	        $("#check_all_label").text("전체해제하기");
	    } else {
	        $("input[name='selectItem']").prop("checked", false);
	        $("#check_all_label").text("전체선택하기");
	    }
	    updateTotal();
	});
	
	function giftCount() {
	    var selectedData = [];

	    for (let i = 0; i < counts.length; i++) {
	        const itemCount = counts[i];
	        const isChecked = document.getElementById('selectItem' + i).checked;
	        const cartItem = document.getElementById('cartItem' + i);

	        if (isChecked && cartItem.style.display !== 'none') { 
	            var giftNo = $("#giftNo" + i).val();
	            const giftCount = itemCount;

	            const giftVO = {
	                giftNo: giftNo,
	                giftCount: giftCount
	            };
	            selectedData.push(giftVO);
	        }
	    }

	    $.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/giftCount",
	        data: JSON.stringify(selectedData),
	        contentType: "application/json",
	        success: function (response) {
	            console.log("giftCount Success");
	        },
	        error: function (xhr, status, error) {
	            console.error("Error");
	        }
	    });
	}
	</script>

	<script>
    let counts = [];
    let selectedCount = 0;
    let selectItem = [];
    let totalPrice = 0;

    function updateTotal() {
    	 let total = 0;
		    selectedCount = 0;

		    const cardPriceElements = document.getElementsByClassName('cardPrice');
		    const checkboxSelect = Array.from(document.querySelectorAll('input[name="selectItem"]:checked'));

		    for (let index = 0; index < cardPriceElements.length; index++) {
		        let cardPriceElement = cardPriceElements[index];
		        let CountDisplay = document.getElementById('CountDisplay' + index);
		        let cartItem = document.getElementById('cartItem' + index);
	            
	        	if (cartItem.style.display === 'none') {
	                continue; 
	            }
            cardPriceElement = cardPriceElements[index];
            CountDisplay = document.getElementById('CountDisplay' + index);

            if (cardPriceElement && CountDisplay) {
                const giftPrice = parseInt(cardPriceElement.textContent);
                const count = parseInt(CountDisplay.textContent);

                if (count > 0 && checkboxSelect.includes(document.getElementById('selectItem' + index))) {
                    const itemTotalPrice = giftPrice * count;
                    total += itemTotalPrice;
                    selectedCount += count;
                } 
            }
        }

        totalPrice = total; 
        document.getElementById('selectedCount').textContent = numbering(selectedCount);
        document.getElementById('totalPrice').textContent = numbering(totalPrice);
        console.log("updateTotal selectedCount : ", selectedCount);
        console.log("updateTotal totalPrice : ", totalPrice);
    }
    
    function toInput(element) {
        const countDisplay = element;
        const currentValue = countDisplay.textContent.trim();
        
        const inputElement = document.createElement('input');
        inputElement.type = 'text';
        inputElement.value = currentValue;
        inputElement.style.width = '40px';
        inputElement.select();
        const originalValue = currentValue;
        
        const applyChanges = () => {
            const newValue = inputElement.value.trim();

            if (newValue === '0') {
                if (confirm("해당 상품을 삭제하시겠습니까?")) {
                    const index = parseInt(countDisplay.id.replace('CountDisplay', ''));
                    deleteCartCount(index);
                    return; 
                }
            } else if (newValue === '' || isNaN(newValue)) {
            	countDisplay.innerHTML = '&nbsp;&nbsp;' + originalValue + '&nbsp;&nbsp;';
                countDisplay.style.display = 'inline';
                inputElement.style.display = 'none';
                return; 
            } else {
                countDisplay.innerHTML = '&nbsp;&nbsp;' + newValue + '&nbsp;&nbsp;';
                countDisplay.style.display = 'inline';
                inputElement.style.display = 'none';
                
                const index = parseInt(countDisplay.id.replace('CountDisplay', ''));
                const newCount = parseInt(newValue);
                
                updateCartCount(index, newCount);

                updateTotal();
            }
        };
        
        const handleBlur = () => {
            applyChanges();
        };

        const handleKeydown = (event) => {
            if (event.key === 'Enter') {
                applyChanges();
            }
        };

        inputElement.addEventListener('blur', handleBlur);
        inputElement.addEventListener('keydown', handleKeydown);

        countDisplay.style.display = 'none';
        countDisplay.parentElement.insertBefore(inputElement, countDisplay);
        inputElement.focus();
    }

    function minusCount(index) {
        if (counts[index] > 1) {
            counts[index]--;
            
            if (document.getElementById('CountDisplay' + index)) {
                document.getElementById('CountDisplay' + index).textContent = counts[index];
                updateCartCount(index,counts[index]);
            }
        } else {
            if (confirm("해당 상품을 삭제하시겠습니까?")) {
                deleteCartCount(index);
            }
        }
    }

    function plusCount(index) {
        counts[index]++;

        if (document.getElementById('CountDisplay' + index)) {
            document.getElementById('CountDisplay' + index).textContent = counts[index];
            updateCartCount(index,counts[index]);
        }
    }

    function updateCartCount(index, newCount) {
        const cardPriceElement = document.getElementsByClassName('cardPrice')[index];
        const giftPrice = parseInt(cardPriceElement.textContent);
        const itemTotalPrice = giftPrice * newCount; 
        
        const requestData = [{
            cartId: "${sessionScope.login.id}",
            cartParentNo: $("#giftNo" + index).val(),
            cartCount: newCount 
        }];

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/countCart",
            data: JSON.stringify(requestData),
            contentType: "application/json",
            success: function(response) {
                console.log("updateCartCount Item count", newCount);
                counts[index] = newCount;
                totalPrice -= (giftPrice * counts[index]);
                totalPrice += itemTotalPrice;
                updateTotal();
            },
            error: function(xhr, status, error) {
                console.error("Error", error);
            }
        });
    }

	function buyItems() {
		    let selectItemArray = [];
			var checkIndex = [];
	        $("input[name='selectItem']:checked").each(function () {
	            var indexes = $(this).attr("id").substring("selectItem".length);
	            checkIndex.push(parseInt(indexes)); 
	        });
	        console.log("buyItems checkIndex",checkIndex);


		    for (let i = 0; i < counts.length; i++) {
		        const itemCount = counts[i];
		        	const cartItem = document.getElementById('cartItem' + i);
		        if (itemCount > 0) {
		        	  if (document.getElementById('cartItem' + i).style.display === 'none') {
		                  continue;
		              }
		            const isChecked = document.getElementById('selectItem' + i);
		            
		            if (isChecked && isChecked.checked) {
		                const currentItemName = document.getElementsByClassName('cardTitle')[i].textContent;
		                const cardPriceElement = document.getElementsByClassName('cardPrice')[i];
		                const totalItemAmount = itemCount * parseInt(cardPriceElement.textContent);

		                const itemVO = {
		                    itemName: currentItemName,
		                    quantity: itemCount,
		                    totalAmount: totalItemAmount
		                };

		                selectItemArray.push(itemVO);
		            }
		        }
		    }
	    console.log(selectItemArray);
	    if (selectItemArray.length > 0) {
	        const result = confirm('정말 구매하시겠습니까?');
	        if (result) {
	            $.ajax({
	                url: "${pageContext.request.contextPath}/kakaoPay",
	                type: "post",
	                data: JSON.stringify(selectItemArray),
	                contentType: "application/json",
	                success: function(data) {
	                    console.log("buyItems data: ",data);
	                        giftCount();
	                    location.href = data;
	        		    for (var i = 0; i < checkIndex.length; i++) {
	        	            var index = checkIndex[i];
	        	            deleteCartCount(index);
	        	        }

	                },
	                error: function() {
	                    alert("error");
	                }
	            });
	        } else {
	            console.log(selectItemArray.length);
	        }
	    } else {
	        alert('구매할 상품을 선택해주세요.');
	    }
	}
	
	function selectDelete() {
	    if (confirm("선택한 상품을 삭제하시겠습니까?")) {
	        var checkIndex = [];
	        $("input[name='selectItem']:checked").each(function () {
	            var indexes = $(this).attr("id").substring("selectItem".length);
	            checkIndex.push(parseInt(indexes)); 
	        });
	        console.log("selectDelete checkIndex",checkIndex);
	        for (var i = 0; i < checkIndex.length; i++) {
	            var index = checkIndex[i];
	            deleteCartCount(index);
	        }
	    }
	}

	function deleteCartCount(index) {
	    const cardPriceElement = document.getElementsByClassName('cardPrice')[index];
	    const giftPrice = parseInt(cardPriceElement.textContent);
	    console.log("deleteCartCount giftPrice : ",giftPrice);
	    
	    const requestData = [{
	        cartId: "${sessionScope.login.id}",
	        cartParentNo: $("#giftNo" + index).val(),
	        cartCount: 0 
	    }];

	    $.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/deleteCart",
	        data: JSON.stringify(requestData),
	        contentType: "application/json",
	        success: function (cartList) {
	            console.log("deleteCartCount Success");
	            const cartItem = document.getElementById('cartItem' + index);
	            cartItem.style.display = 'none';
	            updateTotal();
	            updateCartUI(cartList);
	        },
	        error: function (xhr, status, error) {
	            console.error("Error:", error);
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
	
	 window.onload = function () {
	        const countInputs = document.querySelectorAll('[name="Counts"]');
	        counts = Array.from(countInputs).map(input => parseInt(input.value));
	        console.log("init counts: ", counts);

	        updateTotal();
	    };
</script>

	<%@ include file="/WEB-INF/inc/footer.jsp"%>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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