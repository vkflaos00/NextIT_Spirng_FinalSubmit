<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${pageContext.request.contextPath }/css/style.css"
	type="text/css" rel="stylesheet" />
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	width: 800px;
	height: 800px;
	overflow: hidden;
	background-image:#;
}

.popup-container {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 800px; /* 팝업 너비 */
	height: 800px; /* 팝업 높이 */
	background-color: rgba(255, 255, 255, 0.9); /* 배경 색상, 투명도 조정 가능 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
	border-radius: 10px; /* 모서리 둥글게 만들기 */
	overflow: scroll; /* 내용이 넘치는 경우 스크롤 막기 */
}

.upload {
	width: 300px;
	height: auto;
	/* background-color: antiquewhite; */
}

li {
	list-style: none;
}

/* 이미지 업로드 영역 */
.upload {
    cursor: pointer;
}

/* 이미지 미리보기 영역 */
.image-preview {
    max-width: 100%; /* 최대 너비를 부모 영역에 맞춤 */
    max-height: 300px; /* 최대 높이를 설정 (원하는 값으로 조정) */
    overflow: hidden; /* 내용이 영역을 벗어나면 숨김 */
    border: 1px solid #ccc; /* 테두리 추가 */
    margin-top: 10px; /* 위쪽 마진을 조정 (원하는 값으로 조정) */
    padding: 10px; /* 안쪽 여백을 추가 (원하는 값으로 조정) */
    text-align: center; /* 내부 요소 가운데 정렬 */
}

.image-preview img {
    max-width: 100%; /* 이미지의 최대 너비를 부모 영역에 맞춤 */
    max-height: 100%; /* 이미지의 최대 높이를 부모 영역에 맞춤 */
    display: inline-block; /* 이미지 간격 조절을 위해 inline-block으로 설정 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="popup-container">
		<div class="popup-content">
			<div class="container pb-1">
				<div class="card-header bg-secondary text-center p-4">
					<h1 class="text-white m-0">문의 입력</h1>
				</div>
				<div class="card-body rounded-bottom bg-primary p-5">

					<form:form enctype="multipart/form-data" id="vocForm" method="POST"
						modelAttribute="vocPop" onSubmit="return form_submit()">

						<div class="form-group row">
							<label class="col-sm-3 col-form-label">
								<h4>문의 유형</h4>
							</label>
							<div class="col-sm-9">
								<form:select path="vocCategory" 
									class="custom-select border-0 px-3" style="height: 40px">
									<form:option value="">-- 선택하세요 --</form:option>
									<form:option value="1">결제 환불/취소</form:option>
									<form:option value="2">상품 문의</form:option>
									<form:option value="3">성복씨 문의</form:option>
									<form:option value="4">계정 문의</form:option>
								</form:select>
							</div>
						</div>

						<div class="form-group row">
							<label for="vocMail" class="col-sm-3 col-form-label">
								<h4>문의 메일</h4>
							</label>
							<div class="col-sm-9">
								<input type="text" id="vocMail" path="vocMail"
									class="form-control border-0 p-3"
									value="${sessionScope.login.getMail()}" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label for="vocTitle" class="col-sm-3 col-form-label">
								<h4>제목</h4>
							</label>
							<div class="col-sm-9">
								<form:input path="vocTitle" autocomplete="off"
									class="form-control" ></form:input>
								<form:errors path="vocTitle"></form:errors>
							</div>
						</div>

						<div class="form-group row">
							<label for="vocAttach" class="col-sm-3 col-form-label">
								<h4>첨부파일</h4>
							</label> <label class="col-sm-3 col-form-label"> <form:input
									type="file" path="vocAttach" id="file" accept="image/*"
									class="real-upload"></form:input>
								<ul class="image-preview"></ul>
							</label>
						</div>
						<div class="upload"></div>

						<div class="form-group row">
							<label for="vocContent" class="col-sm-3 col-form-label">
								<h4>내용</h4>
							</label>
							<div class="col-sm-9">
								<form:textarea path="vocContent" rows="10"
									class="form-control"></form:textarea>
							</div>
						</div>

						<!-- <button id="sendMail" type="button" onclick="fn_popSubmit()" -->
						<button type="submit"
							class="btn btn-secondary btn-block border-0 py-3">문의하기</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>

	<script>
		function form_submit() {
			//event.preventDefault(); // 이벤트의 기본 동작(페이지 이동)을 막음
			if ($('select[name="vocCategory"]').val() === "") {
				alert("문의 카테고리를 선택하세요.");
				return false;
			} else if ($("#vocTitle").val() === "") {
				alert("제목을 입력하세요.");
				return false;
			} else if ($("#vocContent").val() === "") {
				alert("문의 내용을 입력하세요.");
				return false;
			} else {
				let vocCategory = []; // 선택된 값들을 담을 배열

				// category 체크박스 선택된 값들을 배열에 추가
				$("#vocCategory :checked").each(function() {
					vocCategory.push($(this).val());
				});
				let category = vocCategory[0];
				let mail = $("#vocMail").val();
				let file = $("#file")[0].files[0];
				console.log(file);
				let content = $("#vocContent")[0].value;
				let title = $("#vocTitle")[0].value;
				
								
				let formData = new FormData();
				formData.append("category", category);
				formData.append("mail", mail);				
				formData.append("file",file);
				formData.append("content",content);
				formData.append("title",title);
				
				$.ajax({
					url : "<c:url value='/registerVOC'/>",
					type : "POST",
					processData:false,
					contentType:false,
					data : formData,
					success : function(data) {
						if (data === "success") {
							window.close();
							window.opener.location.reload();
							alert("문의사항이 성공적으로 전송되었습니다.");
						} else {
							alert("문의사항 전송에 실패했습니다. 다시 시도해주세요.");
						}
					},
					error : function() {
						alert("서버와 통신 중 오류가 발생했습니다.");
					}
				});
				return false;
			}
		}

		function getImageFiles(e) {
			const files = e.currentTarget.files;
			const imagePreview = document.querySelector('.image-preview');
			const file = files[0];
			const reader = new FileReader();
			reader.onload = function(e) {
				const preview = createElement(e, file);
				let imageLiTag = document.querySelector('.image-preview > li');
				if (imageLiTag) {
					imagePreview.removeChild(imagePreview.firstElementChild);
				}
				imagePreview.appendChild(preview);
			};
			reader.readAsDataURL(file);
		}

		function createElement(e, file) {
			const li = document.createElement('li');
			const img = document.createElement('img');
			img.setAttribute('src', e.target.result); //img.setAttribute('src', reader.result);
			img.setAttribute('data-file', file.name);
			li.appendChild(img);
			return li;
		}

		const realUpload = document.querySelector('.real-upload');
		const upload = document.querySelector('.upload');

		upload.addEventListener('click', function(e) {
			realUpload.click();
		});

		realUpload.addEventListener('change', getImageFiles);
		console.log("성공");
	</script>
</body>
</html>
