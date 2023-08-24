<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>로그인</title>
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
<!-- 오류 메시지 띄우기 -->
<c:if test="${not empty errMsg }">
	<script>
		alert("${errMsg}");
	</script>
</c:if>



	<!-- 로그인 폼 -->
	<div class="container-fluid pt-5">
		<div class="container pb-3">
			<div class="row">
				<div class="col-lg-6 col-md-6 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4"
						style="padding: 30px;">
						<img class="img-fluid mt-3" src="${pageContext.request.contextPath }/img/login/five.jpg" alt=""
							style="margin-top: 50px; heigth: 300px" />
					</div>
				</div>
				<div class="col-lg-6 col-md-6 pb-1">
				<div class="d-flex bg-light shadow-sm border-top rounded mb-4"
						style="padding: 30px;">
					<div class="card-body rounded-bottom p-10">
						<form id="contactForm" action="<c:url value='/loginDo'/>"
							method="POST">
							<!-- Id input -->
							<div class="form-group">
								<input class="form-control" id="id" name="id" type="text"
									value="${cookie.rememberId.value }" placeholder="아이디"
									required="required" />
							</div>

							<div class="form-group">
								<input class="form-control" id="pw" name="pw" type="password"
									placeholder="비밀번호" required="required" />
							</div>
							<div class="mb-5">
								<input class="form-check-input" id="remeberCheck"
									name="rememberId" type="checkbox" ${cookie.rememberId == null ? "" : "checked" } />
								<label class="form-check-label" for="rememberCheck" >아이디
									기억하기</label> 
							</div>
							<div>
								<!-- 로그인 이전 페이지 링크 기억용 -->
                            	<input name="fromUrl" value="${fromUrl }" type="hidden">
								<button class="btn btn-secondary btn-block border-0 py-3"
									id="submitButton" type="submit">로그인</button>
								<div class="text-muted text-center">" 회원가입 하고싶쥬?" <a href="<c:url value='/regist/'/>">드루와</a>
								<div class="text-muted text-center">" 비밀번호가 뭐였쥬?" <a id="newPw" >뭐였쥬?</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>


	<!-- 모든 페이지 하단에 포함되는 부분 -->
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
