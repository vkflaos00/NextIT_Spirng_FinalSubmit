<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<head>
<meta charset="utf-8" />
<title>Conv - ${notice.noticeTitle }</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<style>
.attach-image {
	max-width: 100%; /* 이미지의 최대 너비를 부모 요소의 100%로 제한합니다. */
	height: auto; /* 이미지의 높이를 자동으로 조정합니다. */
}
</style>
<script>
let isRecommended;
let recommendationCount = ${notice.noticeHit}; 

function updateUI() {
    $("#noticeHitLabel").text("【 추천수 】" + recommendationCount + " 개");
    if (!isRecommended) {
        $("#reBu1").show();
    } else {
        $("#reBu1").hide();
    }
    if (isRecommended) {
        $("#reBu2").show();
    } else {
        $("#reBu2").hide();
    }
}

function hitCheck(noticeNo) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/hitCheck",
        data: { noticeNo: noticeNo },
        success: function (response) {
        	console.log("response : " , response);
            isRecommended = response;
            updateUI();
        },
        error: function (xhr, status, error) {
        	alert("에러");
        }
    });
}

function hitEdit(noticeNo){
	$.ajax({
		type: "POST",
		url: "${pageContext.request.contextPath}/hitEdit",
		data: { noticeNo: noticeNo },
       success: function(response){
    	   console.log("edit response : " , response);
    	   isRecommended = response;
    	   updateUI();
       },
	 error: function (xhr, status, error) {
    	console.log("error");
    }
	});
}

function hit(noticeNo) {
    if(isRecommended) {
        if ("${sessionScope.login.id}" != null && "${sessionScope.login.id}" !== "") {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/hitCancel",
                data: { noticeNo: noticeNo },
                success: function (response) {
                	 hitEdit(noticeNo);
                	console.log("추천 취소", response.isRecommended);
                    recommendationCount -= 1;
                    isRecommended = response.isRecommended;
                    updateUI();
                    alert("추천 취소 되었습니다.");
                },
                error: function (xhr, status, error) {
                    alert("추천 취소 실패");
                }
            });
        } else {
            window.location.href = "${pageContext.request.contextPath}/login";
        }
    } else {
   	 if ("${sessionScope.login.id}" != null && "${sessionScope.login.id}" !== "") {
       $.ajax({
           type: "POST",
           url: "${pageContext.request.contextPath}/hit",
           data: { noticeNo: noticeNo },
           success: function (response) {
        	   hitEdit(noticeNo);
        	   console.log("추천", response.isRecommended);
        	   recommendationCount += 1;
        	   isRecommended = response.isRecommended;
               updateUI();
               alert("추천 되었습니다.");
           },
           error: function (xhr, status, error) {
               alert("추천실패");
           }
        });
    	 } else {
             window.location.href = "${pageContext.request.contextPath}/login";
         }
    }
}
$(document).ready(function() {
   hitCheck('${notice.noticeNo}');
});

</script>


</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- 글 상세 폼 -->
	<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">${notice.noticeTitle }</p>
	<div class="row justify-content-center" >
		<div class="col-lg-7 col-xl-6  text-dark" style="font-size: 16px;">
			<div class="form-control-lg">
				<label for="exampleFormControlInput1" class="form-label">【 카테고리 】
					${notice.noticeCategory }</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label
					for="exampleFormControlInput1" class="form-label">
					【 작성일 】 ${notice.noticeDate } </label>
			</div>
			<div class="form-control-lg">
				<label for="exampleFormControlInput2" class="form-label"
					id="noticeCountLabel">【 조회수 】&nbsp;
					${notice.noticeCount} 회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
										
				<label for="exampleFormControlInput1" class="form-label"
					id="noticeHitLabel">【 추천수 】</label>
				<div class="row justify-content-end">
					<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
					<c:if test="${sessionScope.login.role == 'USER' }">
						<svg id="reBu1" xmlns="http://www.w3.org/2000/svg" width="9%"
							height="9%" fill="rgb(219,68,85)" class="bi bi-chat-square-heart"
							viewBox="0 0 16 16" onclick="hit(${notice.noticeNo})">
  					<path
								d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1h-2.5a2 2 0 0 0-1.6.8L8 14.333 6.1 11.8a2 2 0 0 0-1.6-.8H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12ZM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Z" />
  						<path
								d="M8 3.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z" />
  							</svg>
						<svg id="reBu2" xmlns="http://www.w3.org/2000/svg" width="9%"
							height="9%" fill="rgb(219,68,85)"
							class="bbi bi-chat-square-heart-fill" viewBox="0 0 16 16"
							onclick="hit(${notice.noticeNo})">
  						<path
								d="M2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm6 3.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z" />
				</svg>
					</c:if>
				</div>
			</div>
			<div class="form-control-lg " style="height: auto;">
				<div>
					<table>
						<tr>
							<td class="td_left">【 첨부이미지 】</td>
							<td class="td_right"><c:forEach items="${notice.attachList}"
									var="attach" varStatus="status">
									<div class="text-secondary">${status.count}.&nbsp;
										<a class="text-secondary" href="<c:url value='/attach/download/${attach.atchNo }'/>"
											target="_blank"> ${attach.atchOriginalName } </a>
									</div>
								</c:forEach></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="form-control-lg mt-3" style="border: 1px solid #ccc; padding: 10px; height: auto;">
				<c:forEach items="${notice.attachList}" var="attach"
					varStatus="status">
					<c:if test="${not empty attach.atchNo }">
						<img alt="첨부이미지" style="width: 500px; height: 500px;"
							src="<c:url value='/image/${attach.atchNo } '/>">
					</c:if>
				</c:forEach>
				<div class="mt-3" id="message" style="height: auto;">${notice.noticeContent }</div>
				<div class="row float-right mt-5" >
					<input type="button" class="btn btn-secondary" style="margin-right: 4px;"
						onclick="location.href='${pageContext.request.contextPath}/noticeView'"
						value="목록">
					<c:if test="${sessionScope.login.role == 'ADMIN' }">
						<form action="${pageContext.request.contextPath }/noticeEditView"
							method="POST">
							<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
							<button type="submit" class="btn btn-secondary" style="margin-right: 4px;">수정</button>
						</form>
						<form id="delForm"
							action="${pageContext.request.contextPath }/noticeDelDo"
							method="POST">
							<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
							<button type="button" class="btn btn-secondary" onclick="f_del()">삭제</button>
						</form>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- 모든 페이지 하단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>

	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		function f_del() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				// form태그의 action을 실행(submit)
				document.getElementById("delForm").submit();
			}
		}
	</script>
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
	<script src="${pageContext.request.contextPath }/mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
