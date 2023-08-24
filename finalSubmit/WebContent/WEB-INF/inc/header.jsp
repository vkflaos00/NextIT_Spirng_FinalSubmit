<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.nezzt/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/9c1701a209.js"
	crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- Flaticon Font -->
<link
	href="${pageContext.request.contextPath }/lib/flaticon/font/flaticon.css"
	rel="stylesheet" />

<!-- Libraries Stylesheet -->
<link
	href="${pageContext.request.contextPath }/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath }/lib/lightbox/css/lightbox.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath }/css/style.css"
	rel="stylesheet" />
<!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"/> -->
<script>
  $(function() {
    $('.nav-item.dropdown').on('mouseenter', function() {
      $(this).find('.dropdown-toggle').attr('aria-expanded', 'true');
      $(this).addClass('show');
      $(this).find('.dropdown-menu').addClass('show');
    }).on('mouseleave', function() {
      $(this).find('.dropdown-toggle').attr('aria-expanded', 'false');
      $(this).removeClass('show');
      $(this).find('.dropdown-menu').removeClass('show');
    });
  });
</script>
<style>
  /* 스피너를 감싸는 부모 요소를 화면 중앙에 배치 */
  .spinner-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
</style>

<!-- 스피너를 감싸는 부모 요소 -->
<div id="spinnerContainer" class="spinner-container">
  <!-- 스피너 또는 로딩 아이콘을 넣으세요 -->
   <div class="spinner-border position-relative text-primary" style="width: 6rem; height: 6rem;" role="status"></div>
        <img class="position-absolute top-50 start-50 translate-middle" src="${pageContext.request.contextPath }/img/login/ing2.gif" alt="Icon">
</div>
<!-- Navbar Start -->
<div class="container-fluid bg-light position-relative shadow">
	<nav
		class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0 px-lg-5">
		<a href="<c:url value="/"/>"
			class="navbar-brand font-weight-bold text-secondary"
			style="font-size: 50px"><!-- <i class="fa-duotone fa-store fa-bounce"
			style="-fa-primary-color: #57026e; - -fa-secondary-color: #19bb16;"></i> -->
			<img alt="" src="${pageContext.request.contextPath }/img/conv.png" style="width: 50px; height: 50px;">
			<span class="text-primary">Conv</span> </a>
		<button type="button" class="navbar-toggler" data-toggle="collapse"
			data-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-between"
			id="navbarCollapse">
			<div class="navbar-nav font-weight-bold mx-auto py-0">
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">PRDOUCT</a>
					<div class="dropdown-menu rounded-0 m-0">
						<a href="<c:url value="/product/productView"/>" class="dropdown-item">PRODUCT</a> 
						<a href="<c:url value="/product/productChat"/>" class="dropdown-item">CHATTING</a>
					</div>
				</div>
				<a href="<c:url value="/boardList"/>" class="nav-item nav-link active">BOARD</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">ABOUT</a>
					<div class="dropdown-menu rounded-0 m-0">
						<a href="<c:url value="/shop"/>" class="dropdown-item">FIND SHOP</a> 
						<a href="<c:url value="/voc"/>" class="dropdown-item">VOC</a>
					</div>
				</div>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">NOTICE</a>
					<div class="dropdown-menu rounded-0 m-0">
						<a href="${pageContext.request.contextPath }/cardMain" class="dropdown-item">NEGO INFO</a> <a
							href="${pageContext.request.contextPath }/noticeView"
							class="dropdown-item">NOTICE</a>
					</div>
				</div>
				<a href="<c:url value='/giftView' />" class="nav-item nav-link active">GIFTICON</a>
			</div>
			<!-- 로그인이 안되었을때 보여줄 화면 -->
			<c:choose>
				<c:when test="${sessionScope.login == null }">
					<a class="btn btn-primary px-3" href="<c:url value='/login/'/>">로그인</a>
				</c:when>
				<c:otherwise>
					<div class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle"
							data-toggle="dropdown">${sessionScope.login.getName() }님</a>
						<div class="dropdown-menu rounded-0 m-0">
							
							<a class="dropdown-item" href="<c:url value="/myPage"/>">MY PAGE</a> 
							<a class="dropdown-item" href="<c:url value='/logoutDo'/>">LOGOUT</a>
							<c:if test="${login.getRole() == 'ADMIN' }">
								<a class="dropdown-item" href="${pageContext.request.contextPath }/admin/adminPage">ADMIN PAGE</a> 
							</c:if>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
</div>
<!-- Navbar End -->

<!-- Bootstrap JavaScript -->

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script>
  // 로딩이 완료되면 스피너를 숨깁니다.
  $(window).on('load', function() {
    $('#spinnerContainer').fadeOut('slow');
  });
</script>
