<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/smarteditor2-2.8.2.3/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	let oEditors = [];
	smartEditor = function() {
		console.log("Naver SmartEditor");
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "noticeContent",
					sSkinURI : "${pageContext.request.contextPath}/smarteditor2-2.8.2.3/SmartEditor2Skin.html",
					fCreator : "createSEditor2"
				});
	};

	$(document).ready(function() {
		smartEditor();
	});

	function fn_checkForm() {
		console.log("fn_checkForm");
		oEditors.getById["noticeContent"].exec("UPDATE_CONTENTS_FIELD", []);
		let content = oEditors.getById["noticeContent"].getIR();

		if (content == "" || content == null || content == '&nbsp;'
				|| content == '<p>&nbsp;</p>') {
			alert("내용을 입력해주세요");
			oEditors.getById["noticeContent"].exec("FOCUS");
			return false;
		} else {
			let result = confirm("등록할까요?");
			if (result == true) {
				document.noticeForm.submit();
			} else {
				return false;
			}
		}
	}
</script>

<head>
<meta charset="utf-8" />
<title>Conv - noticeWrite</title>
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

	<!-- 공지작성 폼 -->
	<!-- Contact Section Heading-->
<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">공지사항 작성</p>
	<div class="row justify-content-center mt-1 text-dark" style="font-size: 16px;">
		<div class="col-lg-7 col-xl-6">
			<form:form id="noticeForm"
				action="${pageContext.request.contextPath }/noticeWriteDo"
				method="post" onsubmit="return fn_checkForm()"
				enctype="multipart/form-data">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<div class="form-control-lg">
				<label for="exampleFormControlInput1" class="form-label">카테고리&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<select name="noticeCategory" id="noticeCategory" style="width: 80px; height: 30px; font-size: 18px;">
					<option value="알림">알 림</option>
					<option value="이벤트">이벤트</option>
				</select>
				</div>
				<div class="mb-5 form-control-lg">
					<label for="exampleFormControlInput1" class="form-label">제목
					</label> <input type="text" class="form-control" name="noticeTitle"
						id="exampleFormControlInput1" placeholder="제목을 입력해주세요">
				</div>
				
				<textarea class="form-control" name="noticeContent"
					id="noticeContent" rows="20" cols="10" placeholder="내용을 입력해주세요 "
					style="height: 500px; display: none;"></textarea>
				<table>
					<tr>
						<td class="td_left" style="font-size: 16px;">&nbsp;&nbsp;첨부파일&nbsp;&nbsp;
							<button type="button" class="btn btn-outline-primary btn-sm"
								id="id_btn_new_file">추가</button>
								<a>&nbsp;&nbsp;</a>
						</td>
						<td class="td_right file_area"><c:forEach
								items="${notice.attachList }" var="attach" varStatus="status">
								<div>
									<div class="text-secondary">
										<span>${status.count } &#46;&nbsp;&nbsp;</span> <a
											href="<c:url value='/attach/download/${attach.atchNo}'/>"
											target="_blank"  class="text-secondary"> ${attach.atchOriginalName }&nbsp;&nbsp; </a>
										<button type="button"
											class="btn btn-outline-primary btn-sm btn_file_delete"
											data-atch-no="${attach.atchNo}">삭제</button>
									</div>
									<div>&nbsp;&nbsp;&nbsp;크기 : ${attach.atchConvertSize }</div>
								</div>
							</c:forEach>
							<div class="form-inline">
								<input type="file" name="boFiles">
								<button type="button" class="btn btn-outline-primary btn-sm"
									class="btn_delete">삭제</button>
							</div></td>
					</tr>
				</table>
				<div class="float-right mt-1">
					<input type="button" class="btn btn-secondary"
						onclick="location.href='${pageContext.request.contextPath}/noticeView'"
						value="목록"> <input type="submit" class="btn btn-secondary"
						value="등록">
				</div>
			</form:form>
		</div>
	</div>

	<script type="text/javascript">
		$("#id_btn_new_file")
				.click(
						function() {
							//alert("id_btn_new_file");
							$(".file_area")
									.append(
											'<div class="file_div">'
													+ '<input type="file" name="boFiles" />'
													+ '<button type="button" class="btn btn-outline-primary btn-sm" class="btn_delete">삭제</button>'
													+ '</div>');
						});

		$(".file_area").on("click", '.btn_delete', function() {
			$(this).closest('div').remove();
		});
	</script>

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
	<script src="${pageContext.request.contextPath }/mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
