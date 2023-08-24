<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Footer Start -->
	<div
		class="container-fluid bg-secondary text-white mt-5 py-5 px-sm-3 px-md-5">
		<div class="row pt-5">
			<div class="col-lg-4 col-md-6 mb-5">
				<a href=""
					class="navbar-brand font-weight-bold text-primary m-0 mb-4 p-0"
					style="font-size: 40px; line-height: 40px"> <i
					class="flaticon-043-teddy-bear"></i> <span class="text-white">Conv</span>
				</a>
				<p>편의점.편의점 편의점</p>
				<div class="d-flex justify-content-start mt-4">
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/facebook.jpg" style="width: 38px; height: 38px">
					</a> 
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/twitter.jpg" style="width: 38px; height: 38px">
					</a> 
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/kakaotalk.svg" style="width: 38px; height: 38px">
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/kakaostory.jpg" style="width: 38px; height: 38px">
					</a>
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/naver.jpg" style="width: 38px; height: 38px">
					</a>
					<a class="btn text-center mr-2 px-0" style="width: 38px; height: 38px" href="#">
						<img alt="..." src="${pageContext.request.contextPath }/img/emoticon/band.jpg" style="width: 38px; height: 38px">
					</a>
				</div>
			</div>
			<div class="col-lg-4 col-md-6 mb-5">
				<h3 class="text-primary mb-4">Get In Touch</h3>
				<div class="d-flex">
					<h4 class="fa fa-map-marker-alt text-primary"></h4>
					<div class="pl-3">
						<h5 class="text-white">Address</h5>
						<p>Heeyoung Building,825 Gyeryong-ro, Jung-gu, Daejeon, Republic of Korea</p>
					</div>
				</div>
				<div class="d-flex">
					<h4 class="fa fa-envelope text-primary"></h4>
					<div class="pl-3">
						<h5 class="text-white">Email</h5>
						<p>skyall03@gmail.com</p>
					</div>
				</div>
				<div class="d-flex">
					<h4 class="fa fa-phone-alt text-primary"></h4>
					<div class="pl-3">
						<h5 class="text-white">Phone</h5>
						<p>+82 042-719-8850</p>
					</div>
				</div>
			</div>
			<div class="col-lg-4 col-md-6 mb-5">
				<h3 class="text-primary mb-4">Quick Links</h3>
				<div class="d-flex flex-column justify-content-start">
					<a class="text-white mb-2" href="${pageContext.request.contextPath }/">
						<i class="fa fa-angle-right mr-2"></i>Home
					</a> 
					<a class="text-white mb-2" href="${pageContext.request.contextPath }/productView">
						<i class="fa fa-angle-right mr-2"></i>PRODUCT
					</a> 
					<a class="text-white mb-2" href="${pageContext.request.contextPath }/boardList">
						<i class="fa fa-angle-right mr-2"></i>BOARD
					</a> 
					<div class="nav-item dropdown mb-2">
						<a href="#" class="text-white mb-2"
							data-toggle="dropdown"><i class="fa fa-angle-right mr-2"></i>ABOUT</a>
						<div class="dropdown-menu rounded-0 m-0">
							<a href="<c:url value="/shop"/>" class="dropdown-item">FIND STORE</a>
							<a href="<c:url value="/voc"/>" class="dropdown-item">VOC</a>
						</div>
					</div>
					<div class="nav-item dropdown mb-2">
						<a href="#" class="text-white mb-2"
							data-toggle="dropdown"><i class="fa fa-angle-right mr-2"></i>NOTICE</a>
						<div class="dropdown-menu rounded-0 m-0">
							<a href="${pageContext.request.contextPath }/cardGS25" class="dropdown-item">NEGO INFO</a>
							<a href="${pageContext.request.contextPath }/noticeView" class="dropdown-item">NOTICE</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid pt-5"
			style="border-top: 1px solid rgba(23, 162, 184, 0.2);">
			<p class="m-0 text-center text-white">
				&copy; <a class="text-primary font-weight-bold" href="#">Conv by Legend</a>. All Rights Reserved.

				<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
				Designed by <a class="text-primary font-weight-bold"
					href="https://htmlcodex.com">HTML Codex</a> <br />Distributed By:
				<a href="https://themewagon.com" target="_blank">ThemeWagon</a>
			</p>
		</div>
	</div>
	<!-- Footer End -->

	<!-- Back to Top -->
	<a href="#" class="btn btn-primary p-3 back-to-top"><i
		class="fa fa-angle-double-up"></i></a>
