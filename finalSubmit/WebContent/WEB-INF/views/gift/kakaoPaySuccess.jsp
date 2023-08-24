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
	<div class="row justify-content-center mt-1">
		<p class="page-section-heading text-center mt-5 text-secondary"
			style="font-size: 40px;">카카오페이 결제가 정상적으로 완료되었습니다.</p>
	</div>
	<div class="row justify-content-center mt-3">
		<div class="col-lg-7 col-xl-6 form-control-lg mt-3 text-center"
			style="border: 1px solid #ccc; padding: 10px; height: auto;">
			<br><br>
			<p class="text-secondary" style="font-size: 30px;">결제일시: ${info.approved_at}</p>
			<p class="text-secondary" style="font-size: 30px;">주문번호: ${info.partner_order_id}</p>
			<p class="text-secondary" style="font-size: 30px;">상품명: ${info.item_name}</p>
			<p class="text-secondary" style="font-size: 30px;">상품수량: ${info.quantity}개</p>
			<p class="text-secondary" style="font-size: 30px;">결제금액: ${info.amount.total}원</p>
			<br><br>
		</div>
		<br>
	</div>
	<div class="row justify-content-center mt-5">
		<div class="col-lg-8 col-xl-7 text-center mt-5">
			<div class="text-right">
				<button type="button" class="btn btn-lg btn-secondary"
					onclick="location.href='${pageContext.request.contextPath}/giftView'">상품목록
					돌아가기</button>
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
