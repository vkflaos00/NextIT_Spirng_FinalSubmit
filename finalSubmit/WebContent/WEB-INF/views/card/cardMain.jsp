<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Conv - Card</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.nav-link2 {
	display: block;
	padding: 0.5rem 1rem;
}

.nav-link2:hover, .nav-link2:focus {
	text-decoration: none;
}

.nav-link2.disabled {
	color: #6c757d;
	pointer-events: none;
	cursor: default;
}

.nav-tabs .nav-item2 {
	margin-bottom: -1px;
}

.nav-tabs .nav-link2 {
	border: 1px solid transparent;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.nav-tabs .nav-link2:hover, .nav-tabs .nav-link2:focus {
	border-color: #e9ecef #e9ecef #dee2e6;
}

.nav-tabs .nav-link2.disabled {
	color: #6c757d;
	background-color: transparent;
	border-color: transparent;
}

.nav-tabs .nav-link2.active, .nav-tabs .nav-item2.show .nav-link2 {
	color: #495057;
	background-color: #fff;
	border-color: #dee2e6 #dee2e6 #fff;
}

.nav-pills .nav-link2 {
	border-radius: 5px;
}

.nav-pills .nav-link2.active, .nav-pills .show>.nav-link2 {
	color: #fff;
	background-color: #DDDDDD;
	border-radius: 5px;
}

.nav-fill>.nav-link2, .nav-fill .nav-item2 {
	flex: 1 1 auto;
	text-align: center;
}

.nav-justified>.nav-link2, .nav-justified .nav-item2 {
	flex-basis: 0;
	flex-grow: 1;
	text-align: center;
}

.navbar-nav .nav-link2 {
	padding-right: 0;
	padding-left: 0;
}

.navbar-expand-sm .navbar-nav .nav-link2 {
	padding-right: 0.5rem;
	padding-left: 0.5rem;
}

.navbar-expand-md .navbar-nav .nav-link2 {
	padding-right: 0.5rem;
	padding-left: 0.5rem;
}

.navbar-expand-lg .navbar-nav .nav-link2 {
	padding-right: 0.5rem;
	padding-left: 0.5rem;
}

@media ( max-width : 1199.98px) {
	.navbar-expand-xl>.container, .navbar-expand-xl>.container-fluid,
		.navbar-expand-xl>.container-sm, .navbar-expand-xl>.container-md,
		.navbar-expand-xl>.container-lg, .navbar-expand-xl>.container-xl {
		padding-right: 0;
		padding-left: 0;
	}
}

@media ( min-width : 1200px) {
	.navbar-expand-xl .navbar-nav .nav-link2 {
		padding-right: 0.5rem;
		padding-left: 0.5rem;
	}
}

.navbar-expand .navbar-nav .nav-link2 {
	padding-right: 0.5rem;
	padding-left: 0.5rem;
}

.navbar-light .navbar-nav .nav-link2 {
	color: rgba(0, 0, 0, 0.5);
}

.navbar-light .navbar-nav .nav-link2:hover, .navbar-light .navbar-nav .nav-link2:focus
	{
	color: rgba(0, 0, 0, 0.7);
}

.navbar-light .navbar-nav .nav-link2.disabled {
	color: rgba(0, 0, 0, 0.3);
}

.navbar-light .navbar-nav .show>.nav-link2, .navbar-light .navbar-nav .active>.nav-link2,
	.navbar-light .navbar-nav .nav-link2.show, .navbar-light .navbar-nav .nav-link2.active
	{
	color: rgba(0, 0, 0, 0.9);
}

.navbar-dark .navbar-nav .nav-link2 {
	color: rgba(255, 255, 255, 0.5);
}

.navbar-dark .navbar-nav .nav-link2:hover, .navbar-dark .navbar-nav .nav-link2:focus
	{
	color: rgba(255, 255, 255, 0.75);
}

.navbar-dark .navbar-nav .nav-link2.disabled {
	color: rgba(255, 255, 255, 0.25);
}

.navbar-dark .navbar-nav .show>.nav-link2, .navbar-dark .navbar-nav .active>.nav-link2,
	.navbar-dark .navbar-nav .nav-link2.show, .navbar-dark .navbar-nav .nav-link2.active
	{
	color: #fff;
}
</style>

<script>
	function setActiveNavItem() {
		var currentPath = window.location.pathname;

		$('.nav-link2').removeClass('active');

		$('.nav-link2').each(function() {
			var $link = $(this);
			var href = $link.attr('href');

			if (href === currentPath) {
				$link.addClass('active');
			}
		});
	}

	$('.nav-link2').click(function(e) {
		e.preventDefault();

		var $link = $(this);
		var href = $link.attr('href');

		$('.nav-link2').removeClass('active');
		$link.addClass('active');

		window.location.href = href;
	});

	$(document).ready(function() {
		setActiveNavItem();

		$('.nav-link2[href$="/cardGS25"]').addClass('active');
		loadCardInfo("GS25");
	});
</script>


</head>

<body oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- Contact Section Form-->
	<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">제휴카드</p>
	<div class="row justify-content-center mt-1">
		<div class="col-lg-8 col-xl-7 text-center">
			<ul class="nav nav-pills nav-fill mt-3">
				<li class="nav-item2" style="width: 33%;"><a class="nav-link2"
					href="${pageContext.request.contextPath}/cardGS25"
					data-conv-type="GS25"> <img
						src="${pageContext.request.contextPath}/img/gifticon/gs.png"
						alt="GS25" width="150" height="50">
				</a></li>
				<li class="nav-item2" style="width: 33%;"><a class="nav-link2"
					href="${pageContext.request.contextPath}/cardCU"
					data-conv-type="CU"> <img
						src="${pageContext.request.contextPath}/img/gifticon/cu.png"
						alt="CU" width="auto" height="50">
				</a></li>
				<li class="nav-item2" style="width: 33%;"><a class="nav-link2"
					href="${pageContext.request.contextPath}/cardSevenEleven"
					data-conv-type="SEVEN_ELEVEN"> <img
						src="${pageContext.request.contextPath}/img/gifticon/logo.png"
						alt="세븐 일레븐" width="auto" height="50">
				</a></li>
			</ul>

		</div>
	</div>

	<div class="row justify-content-center mt-1">
		<div id="cardContainer" class="col-lg-8 col-xl-7 text-center"></div>
	</div>
	<script>
		// Ajax를 이용하여 카드 정보를 로드하는 함수
		function loadCardInfo(convType) {
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath }/card/" + convType,
				dataType : "json",
				success : function(data) {
					showCardInfo(data);
				},
				error : function() {
					console.log("카드 정보를 가져오는 데 실패했습니다.");
				}
			});
		}

		function showCardInfo(data) {
			var cardContainer = $("#cardContainer");
			cardContainer.empty();

			$
					.each(
							data,
							function(index, card) {
								var cardHTML = '<div class="card text-dark bg-light mb-3">'
										+ '<div class="row g-0" style="height: auto; min-height: 350px;" >'
										+ '<div class="col-md-4 d-flex justify-content-center align-items-center">'
										+ '<img src="' + card.cardSrc + '" class="img-fluid rounded-start" alt="...">'
										+ '</div>'
										+ '<div class="col-md-8 d-flex justify-content-center align-items-center">'
										+ '<div class="card-body">'
										+ '<p class="card-title text-secondary" style="font-size: 20px;">'
										+ card.cardTitle
										+ '</p>'
										+ '<p class="card-text">'
										+ card.cardDiscount
										+ '</p>'
										+ '<p class="card-text">'
										+ card.cardContent
										+ '</p>'
										+ '<p class="card-text"><small class="text-muted">'
										+ card.cardNotice
										+ '</small></p>'
										+ '</div>'
										+ '</div>'
										+ '</div>'
										+ '</div>';

								cardContainer.append(cardHTML);
							});
		}

		$('.nav-link2').click(function(e) {
			e.preventDefault();

			var convType = $(this).data('conv-type');

			$('.nav-link2').removeClass('active');
			$(this).addClass('active');

			loadCardInfo(convType);
		});
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

	<!-- Contact Javascript File -->
	<script
		src="${pageContext.request.contextPath }/mail/jqBootstrapValidation.min.js"></script>
	<script src="${pageContext.request.contextPath }/mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
