<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/views/card/cardMain.jsp"%>

	<div class="row justify-content-center mt-1">
		<div class="col-lg-8 col-xl-7 text-center">

			<c:forEach items="${gsList }" var="gs">
				<div class="card mb-3" style="max-width: 700px;">
					<div class="row g-0">
						<div class="col-md-4">
							<img src="${gs.cardSrc}" class="img-fluid rounded-start" alt="...">
						</div>
						<div class="col-md-8">
							<div class="card-body">
								<h5 class="card-title">${gs.cardTitle}</h5>
								<p class="card-text">${gs.cardDiscount}</p>
								<p class="card-text">${gs.cardContent}</p>
								<p class="card-text">
									<small class="text-muted">${gs.cardNotice}</small>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>

	<%@ include file="/WEB-INF/inc/footer.jsp"%>
</body>
</html>