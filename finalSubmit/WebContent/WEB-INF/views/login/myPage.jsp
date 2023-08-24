<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>마이 페이지</title>
<link href="${pageContext.request.contextPath }/css/myPage.css" 
	rel="stylesheet" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />

</head>

<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>


	<!-- Facilities Start -->
	<div class="container-fluid pt-5 back">
		<div class="container pb-1">
			<div class="row">
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="row d-flex bg-light shadow-sm border-top rounded mb-1"
						style="padding: 30px;">
						<i class="font-weight-normal text-primary mb-3"> </i>
						<div class="pl-4">
							<h4>차트들어갈 자리</h4>
							<p class="m-0">차트1 자리 입니다.</p>
						</div>
					</div>
					<div class="row d-flex bg-light shadow-sm border-top rounded mb-1"
						style="padding: 30px;">
						<i class="font-weight-normal text-primary mb-3"> </i>
						<div class="pl-4">
							<h4>차트들어갈자리</h4>
							<p class="m-0">차트2 자리입니다</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4"
						style="padding: 30px;">
						<div class="d-flex flex-column">
							<h4 class="align-self-start">프로필</h4>
							<div style="width: 400px; overflow: hidden;">
								<img class="img-fluid mt-1" src="<c:url value='/image/${member.atchNo }'/>" alt="프로필사진"
									style="height: 280px; width: 300px;" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-10"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> </i>
						<div class="pl-4">
							<h4>회원정보</h4>
							<p class="m-0">
							<div class="form-floating mb-3">
								<label for="id">아이디</label> <input class="form-control" id="id"
									name="id" type="text" value="${member.id }"
									readonly /> <label for="name">닉네임</label> <input
									class="form-control" id="name" name="name" type="text"
									value="${member.name}" readonly /> <label
									for="add1">주소</label> <input class="form-control" id="add1"
									name="add1" type="text"
									value="${member.address1 } ${member.address2}"
									readonly /> <label for="hp">전화번호</label> <input
									class="form-control" id="hp" name="hp" type="text"
									value="${member.hp }" readonly /> <label
									for="mail">메일</label> <input class="form-control" id="mail"
									name="mail" type="text" value="${member.mail }"
									readonly />
								</p>
							</div>
							<div class="row">
								<div class="col-lg-8 col-xl-7">
									<form id="contactForm" action="<c:url value='/edit'/>"
										method="POST">
										<button class="btn btn-primary btn-xl" id="submitButton"
											type="submit">수정</button>
									</form>
								</div>
								<div class="col-lg-8 col-xl-7 ">
									<form id="contactForm" action="<c:url value='/memberDelDo'/>"
										method="POST">
										<button class="btn btn-danger btn-xl" id="submitButton"
											type="submit">삭제</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모든 페이지 하단에 포함되는 부분 -->
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


	<!-- Contact Javascript File -->
	<script
		src="${pageContext.request.contextPath }/mail/jqBootstrapValidation.min.js"></script>
	<%-- <script src="${pageContext.request.contextPath }/mail/contact.js"></script> --%>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
