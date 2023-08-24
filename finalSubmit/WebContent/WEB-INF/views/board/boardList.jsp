<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link href="${pageContext.request.contextPath }/css/board/board.css"
	rel="stylesheet" />
<!-- 부트스트랩 css 사용 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
	$('#id_rowSizePerPage').change(function() {
		sf.find("input[name='curPage']").val(1);
		sf.find("input[name='rowSizePerPage']").val($(this).val());
		sf.submit();
	});
	
	let sf =$("form[name='search']");
	let curPage= sf.find("input[name='curPage']");
	let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
	$('ul.pagination li a').click(function(e) {
		e.preventDefault();

		console.log($(e.target).data("curpage"));  
		
		curPage.val($(e.target).data("curpage")); 
		rowSizePerPage.val($(this).data("rowsizeperpage")); 
		sf.submit();
	});
	
	sf.find("button[type=submit]").click(function(e) {
		e.preventDefault();
		curPage.val(1);
		rowSizePerPage.val(10);
		sf.submit();
	});
	
});

function fn_boardViewBoNo(boNo){
	//console.log("boNo: "+ boNo);
	
	let st = $("select[name='searchType']").val();
	let sw = $("input[name='searchWord']").val();
	
	let cp = $("input[name='curPage']").val();
	let rpp = $("input[name='rowSizePerPage']").val();
	console.log("st : ",st, ", sw: ", sw);
	location.href="${pageContext.request.contextPath}/boardList?boNo="+boNo+"&searchType="+st+"&searchWord="+sw+"&curPage="+cp+"&rowSizePerPage="+rpp;
}

//검색 버튼을 눌렀을 때 이벤트 핸들러
function submitSearch() {
  let selectedCategory = $('#boCate').val();
  let searchWord = $('#search').val().trim();
  let searchType = $('select[name="searchType"]').val();

  if (searchWord === '' && selectedCategory === '카테고리') {
    // 아무것도 입력하지 않고 카테고리도 선택하지 않은 경우
    // 글 목록 전체를 출력
    let selectedSearchType = $('#id_searchType').val();
    $('#searchWord').val('');
    $('select[name="searchType"]').val(selectedSearchType);
  } else {
    // 검색 로직 추가 (여기서는 form을 submit하도록 예시로 작성)
    $('form[name="search"]').submit();
  }
}

//검색 조건 초기화 함수
function resetSearch() {
  $('#boCate').val('카테고리');
  $('#search').val('');

  // 현재 선택한 검색 타입 유지
  let selectedSearchType = $('#id_searchType').val();
  $('#id_searchType').val(selectedSearchType);

  // 여기서 추가로 검색 로직을 작성하여 검색을 수행할 수 있습니다.
  // 검색 로직을 작성하려면 form을 submit하면 됩니다. (form의 name 속성이 'search'인 경우)
  // 예를 들어 $('form[name="search"]').submit();
}
</script>

</head>
<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<section class="board">
		<div class="page-title" style="margin-top: 60px;">
			<div class="container">
				<h3>자유게시판</h3>
			</div>
		</div>

		<!-- board seach area -->
		<div id="board-search">
			<div class="container">
				<div class="search-window">
					<form name="search"
						action="${pageContext.request.contextPath }/boardList"
						method="POST">
						<input type="hidden" name="curPage" value="${searchVO.curPage}">
						<input type="hidden" name="rowSizePerPage"
							value="${searchVO.rowSizePerPage}">
						<div class="search-wrap" style="display: flex;">
							<label for="search" class="blind">자유게시판 내용 검색</label> <select
								name="boCate" id="boCate" class="form-control"
								style="width: 80px;">
								<option value="카테고리"
									${searchVO.boCate eq "카테고리" ? "selected='selected'" : ""}>카테고리</option>
								<option value="잡담"
									${searchVO.boCate eq "잡담" ? "selected='selected'" : ""}>잡담</option>
								<option value="불편사항"
									${searchVO.boCate eq "불편사항" ? "selected='selected'" : ""}>불편사항</option>
								<option value="구인구직"
									${searchVO.boCate eq "구인구직" ? "selected='selected'" : ""}>구인구직</option>
							</select> <select name="searchType" id="id_searchType"
								class="form-control" style="width: 100px;">
								<option value="C"
									${searchVO.searchType eq "C" ? "selected='selected'" : ""}>제목+내용</option>
								<option value="T"
									${searchVO.searchType eq "T" ? "selected='selected'" : ""}>제목</option>
								<option value="W"
									${searchVO.searchType eq "W" ? "selected='selected'" : ""}>작성자</option>
							</select> <input id="search" type="search" name="searchWord"
								class="form-control" placeholder="검색어를 입력해주세요."
								value="${searchVO.searchWord }">
							<button type="submit" class="btn btn-dark"
								onclick="submitSearch()">검색</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- SearchVO Row Count Area -->
		<div id="rowSizePerPage" >
			<div class="container">
				<div class="search-window" style="float: right; margin-top: 30px; margin-bottom:30px;">
					전체 ${searchVO.totalRowCount } 건 조회 
					<select id="id_rowSizePerPage"
						name="rowSizePerPage">
						<c:forEach begin="10" end="50" step="10" var="i">
							<option value="${i }"
								${searchVO.rowSizePerPage eq i ? "selected='selected'" : "" }>${i }</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<!-- board list area -->
		<div id="board-list">
			<div class="container">
				<table class="board-table" id="BoardListTable">
					<thead>
						<tr>
							<th scope="col" class="th-num">번호</th>
							<th scope="col" class="th-date">카테고리</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-date">작성자</th>
							<th scope="col" class="th-date">등록일</th>
							<th scope="col" class="th-date">조회수</th>
							<th scope="col" class="th-date">추천수</th>
						</tr>
					</thead>
					<c:if test="${not empty boardList}">
						<!-- 인기글 표시 -->
						<c:if test="${not empty likeBoard}">
							<tbody class="like-board-table">
								<c:forEach items="${likeBoard}" var="likeItem">
									<tr class="notice" style="background-color: #f4f4f4;">
										<td>HOT</td>
										<td>${likeItem.boCate}</td>
										<td><a
											href="${pageContext.request.contextPath}/boardView?boNo=${likeItem.boNo}">${likeItem.boTitle}</a></td>
										<td>${likeItem.name}</td>
										<td>${likeItem.registDate}</td>
										<td>${likeItem.hit}</td>
										<td>${likeItem.boLike}</td>
									</tr>
								</c:forEach>
							</tbody>
						</c:if>
						<tbody>
							<c:forEach items="${boardList }" var="board">
								<tr>
									<td>${searchVO.totalRowCount - board.rnum + 1}</td>
									<td>${board.boCate }</td>
									<td><a
										href="${pageContext.request.contextPath }/boardView?boNo=${board.boNo}">${board.boTitle }</a></td>
									<td>${board.name}</td>
									<td>${board.registDate }</td>
									<td>${board.hit }</td>
									<td>${board.boLike }</td>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>
				</table>
				<c:if test="${empty boardList and not empty searchVO.searchWord}">
					<p style="text-align: center;">현재 등록된 게시글이 없습니다.</p>
				</c:if>
			</div>
		</div>

		<!-- board submit -->
		<div id="board-submit">
			<div class="container">
				<div
					class="d-grid gap-2 d-md-flex justify-content-md-end submit-window">
					<!-- Paging -->
					<a href="<c:url value="/boardWrite" />">
						<button class="btn btn-primary" type="button">글 쓰기</button>
					</a>
				</div>
			</div>
		</div>

		<!-- paging area -->
		<div class="col-lg-12 text-center mt-3">
			<div class="div_paging text-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${searchVO.firstPage gt 10 }">
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold" data-curPage=${searchVO.firstPage-1 }
								data-rowSizePerPage=${searchVO.rowSizePerPage }>&laquo;</a></li>
						</c:if>

						<c:if test="${searchVO.curPage ne 1 }">
							<li class="page-item"><a class="page-link" href="#"
								data-curPage=${searchVO.curPage-1 }
								data-rowSizePerPage=${searchVO.rowSizePerPage }>&lt;</a></li>
						</c:if>

						<c:forEach begin="${searchVO.firstPage }"
							end="${searchVO.lastPage }" step="1" var="i">
							<c:if test="${searchVO.curPage ne i}">
								<li class="page-item"><a class="page-link" href="#"
									data-curPage=${i }
									data-rowSizePerPage=${searchVO.rowSizePerPage }>${i }</a></li>
							</c:if>
							<c:if test="${searchVO.curPage eq i }">
								<li class="page-item active" aria-current="page"><span
									class="page-link curPage_a" style="font-weight: bold">${i }</span></li>
							</c:if>
						</c:forEach>

						<c:if test="${searchVO.curPage ne searchVO.totalPageCount }">
							<li class="page-item"><a class="page-link" href="#"
								data-curPage=${searchVO.curPage+1 }
								data-rowSizePerPage=${searchVO.rowSizePerPage }>&gt;</a></li>
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold"
								data-curPage=${searchVO.totalPageCount }
								data-rowSizePerPage=${searchVO.rowSizePerPage }>&raquo;</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</section>

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