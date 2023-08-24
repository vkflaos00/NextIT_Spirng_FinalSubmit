<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글쓰기</title>
<link href="${pageContext.request.contextPath }/css/board/board.css"
	rel="stylesheet" />
<!-- 부트스트랩 css 사용 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<script type="text/javascript"
	src="${pageContext.request.contextPath }/smarteditor2-2.8.2.3/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	let oEditors = [];
	smartEditor = function() {
		console.log("Naver SmartEditor")
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "editorTxt",
					sSkinURI : "${pageContext.request.contextPath }/smarteditor2-2.8.2.3/SmartEditor2Skin.html",
					fCreator : "createSEditor2",
					htParams: { fOnBeforeUnload : function(){}}
				});
	};

	$(document).ready(function() {
		smartEditor();
	});

	function fn_checkForm() {
		console.log("fn_checkForm");
		oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
		let title = document.getElementById("title").value
		let content = document.getElementById("editorTxt").value;
	    
	    if (title.trim() === "") {
	        alert("제목을 입력해주세요");
	        return false;
	    }
	    
	    if (content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>') {
	        alert("내용을 입력해주세요");
	        oEditors.getById["editorTxt"].exec("FOCUS");
	        return false;
	    }
	    
	    let result = confirm("저장하시겠습니까?");
	    if (result) {
	        alert("저장되었습니다");
	    } else {
	        alert("취소하였습니다.");
	        return false;
	    }
	} 
	
	function cancle(){
		let list = confirm("취소하시겠습니까?");
		
		if(list){
			let boardListUrl = "${pageContext.request.contextPath}/boardList";
			window.location.href = boardListUrl;
		}
	}
	

</script>

</head>
<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<section class="board">
		<div class="page-title">
			<div class="container">
				<h3>자유게시판</h3>
			</div>
		</div>

		<!-- board write area -->
		<div id="board-write">
			<div class="container">
				<form id="contactForm" action="<c:url value="/boardWriteDo" />"
					method="post"
					modelAttribute="board"
	            	enctype="multipart/form-data"
	            	onsubmit="return fn_checkForm()">
					<!-- title input-->
					<div class="write">
						<label for="title">제목</label>
						<input class="form-control" id="title" name="boTitle" type="text" />
					</div>
					<!-- 단순 데이터 전달용 input 태그(memId) -->
					<input name="id" type="hidden" value="${login.id }" />
					<!-- category input -->
					<div class="form-group">
						<label for="boCate">카테고리</label> 
						<select name="boCate" id="boCate"
							class="form-control">
							<option value="잡담">잡담</option>
							<option value="불편사항">불편사항</option>
							<option value="구인구직">구인구직</option>
						</select>
					</div>
					<!-- content input-->
					<div>
						<div id="smarteditor">
							<textarea name="boContent" id="editorTxt" rows="20" cols="10"
								placeholder="내용을 입력해주세요" style=""></textarea>
						</div>
					</div>

					<!-- file input -->
					<div id="board-file">
						<div class="container">
							<div
								class="d-grid gap-2 d-md-flex justify-content-md-end submit-window">
								첨부파일
								<div>
									<button type="button" id="id_btn_new_file">추가</button>	
								</div>
								<div class="file_area">
									<c:forEach items="${ board.attachList }" 
	           						var="attach" varStatus="status">
	        							<div>
	        								<div>
	        									<span>${status.count } &#46;&nbsp;&nbsp;</span> <!--1부터 시작  -->
	        									<a href="">
	        										${attach.atchOriginalName }	
	        									</a>
	        									<button type="button" class="btn_file_delete"
	        										data-atch-no="${attach.atchNo }">파일삭제</button>
	        								</div>	
	        								<div>
	        									&nbsp;&nbsp;&nbsp; 크기 : ${attach.atchConvertSize }
	        									, 다운로드 횟수 : ${attach.atchDownHit }
	        								</div>	
	        								<div class="form-inline">
                    							<input type="file" name="boFiles">
                    							<button type="button" class="btn_delete">삭제</button>
                    						</div>
	        							</div>
	           					</c:forEach>
								
								</div>
							</div>
						</div>
					</div>

					<!-- Submit Button-->
					<div id="board-submit">
						<div class="container">
							<div
								class="d-grid gap-2 d-md-flex justify-content-md-end submit-window">
								<button class="btn btn-primary me-md-2" id="submitButton" type="submit">저장</button>
								<button class="btn btn-primary" type="button" onclick="cancle()">취소</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>

<script type="text/javascript">
$("#id_btn_new_file").click(function(){
	//alert("id_btn_new_file");
	$(".file_area").append(
		'<div class="file_div">'
		+	'<input type="file" name="boFiles" />'
		+	'<button type="button" class="btn_delete" >삭제</button>'
		+'</div>'
	);
});

$(".file_area").on("click" , '.btn_delete', function(){
	//alert(".file_area .btn_delete");
	$(this).closest('div').remove();
});

$(".btn_file_delete").click(function(){
	//alert(".btn_file_delete: " + $(this).data("atch-no"));
	
	$(this).closest('.file_area')
		.append('<input type="hidden" name="delAtchNos" value="'+$(this).data("atch-no")+'" />')
		
	$(this).closest('div').parent().remove();
})
</script>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
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