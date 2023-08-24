<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Conv - Notice</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />
<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function() {
		$('#pagination-ul').off('click', 'a.page-link');

		function loadPageData(pageNumber) {
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/noticeView',
				data : {
					curPage : pageNumber,
					rowSizePerPage : '${searchVO.rowSizePerPage}',
					searchType : $('#id_searchType').val(),
					searchCategory : $('#id_searchCategory').val(),
					searchWord : $('input[name="searchWord"]').val()
				},
				dataType : 'html',
				success : function(data) {
					$('table.table').html($(data).find('table.table').html());
					$('.div_paging').html($(data).find('.div_paging').html());

					$('#pagination-ul').on('click', 'a.page-link', function(e) {
						e.preventDefault();
						const curPage = $(this).data('curpage');
						loadPageData(curPage);
					});
				},
				error : function(xhr, status, error) {
				}
			});
		}
		function performSearch() {
			const searchType = $('#id_searchType').val();
			const searchCategory = $('#id_searchCategory').val();
			const searchWord = $('input[name="searchWord"]').val();
			const curPage = 1;

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/noticeView',
				data : {
					curPage : curPage,
					rowSizePerPage : '${searchVO.rowSizePerPage}',
					searchType : searchType,
					searchCategory: searchCategory,
					searchWord : searchWord
				},
				dataType : 'html',
				success : function(data) {
					$('table.table').html($(data).find('table.table').html());
					$('.div_paging').html($(data).find('.div_paging').html());

					$('#pagination-ul').off('click', 'a.page-link');
					$('#pagination-ul').on('click', 'a.page-link', function(e) {
						e.preventDefault();
						const curPage = $(this).data('curpage');
						loadPageData(curPage);
					});
				},
				error : function(xhr, status, error) {
				}
			});
		}

		$(document).on('click', '#id_btn_search', function(e) {
			e.preventDefault();
			performSearch();
		});

		function performReset() {
			const curPage = 1;
			const rowSizePerPage = '${searchVO.rowSizePerPage}';

			$('#id_searchType').val('T');

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/noticeView',
				data : {
					curPage : curPage,
					rowSizePerPage : rowSizePerPage,
					searchType : '',
					searchCategory : '',
					searchWord : ''
				},
				dataType : 'html',
				success : function(data) {
					$('table.table').html($(data).find('table.table').html());
					$('.div_paging').html($(data).find('.div_paging').html());

					$('#pagination-ul').off('click', 'a.page-link');
					$('#pagination-ul').on('click', 'a.page-link', function(e) {
						e.preventDefault();
						const curPage = $(this).data('curpage');
						loadPageData(curPage);
					});

					$('input[name="searchWord"]').val('');
				},
				error : function(xhr, status, error) {
				}
			});
		}

		$(document).on('click', '#id_btn_reset', function(e) {
			e.preventDefault();
			performReset();
		});
		loadPageData('${searchVO.curPage}');
	});

	function fn_noticeViewNo(noticeNo) {
		let st = $("select[name='searchType']").val();
		let sc = $("select[name='searchCategory']").val();
		let sw = $("input[name='searchWord']").val();

		let cp = $("input[name='curPage']").val();
		let rpp = $("input[name='rowSizePerPage']").val();
		console.log("st : ", st, ", sw: ", sw, ", sc: ", sc);
		location.href = "${pageContext.request.contextPath}/noticeDetailView?noticeNo="
				+ noticeNo
				+ "&searchType="
				+ st
				+ "&searchCategory="
				+ sc
				+ "&searchWord="
				+ sw
				+ "&curPage=" + cp + "&rowSizePerPage=" + rpp;

	}
</script>

</head>

<body  oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>
	<!-- Contact Section Form-->
	<p class="page-section-heading text-center mt-5 text-secondary"
		style="font-size: 40px;">공지사항</p>
	<div class="row justify-content-center mt-1">
		<div class="col-lg-8 col-xl-7 text-center">
			<c:if test="${e eq null}">
				<div class="div_search mt-3">
					<form name="search"
						action="${pageContext.request.contextPath}/noticeView"
						method="post">
						<input type="hidden" name="curPage" value="${searchVO.curPage}">
						<input type="hidden" name="rowSizePerPage"
							value="${searchVO.rowSizePerPage}"> <label
							for="id_searchType"></label> &nbsp;&nbsp; <select
							id="id_searchType" name="searchType"
							style="width: 60px; height: 30px; font-size: 15px;">
							<option value="T"
								${searchVO.searchType eq "T" ? "selected='selected'" : ""}>제목</option>
							<option value="C"
								${searchVO.searchType eq "C" ? "selected='selected'" : ""}>내용</option>
						</select> &nbsp; <label for="id_searchCategory"></label> &nbsp;&nbsp; <select
							id="id_searchCategory" name="searchCategory"
							style="width: 80px; height: 30px; font-size: 15px;">
							<option value="">카테고리</option>
							<option value="A"
								${searchVO.searchCategory eq "A" ? "selected='selected'" : ""}>알림</option>
							<option value="E"
								${searchVO.searchCategory eq "E" ? "selected='selected'" : ""}>이벤트</option>
						</select> &nbsp;&nbsp;&nbsp; <input type="text" name="searchWord"
							value="${searchVO.searchWord}" size="30"
							placeholder="검색어를 입력해주세요."> &nbsp;&nbsp;&nbsp;&nbsp;
						<button type="submit" id="id_btn_search"
							class="btn btn-outline-dark btn-sm">검 색</button>
						&nbsp;
						<button type="button" id="id_btn_reset"
							class="btn btn-outline-dark btn-sm">초기화</button>
						<table class="table mt-3">
							<thead>
								<tr>
									<th style="width: 10%; font-size: 17px; font-family: Arial, sans-serif;" class="text-left text-secondary">No</th>
									<th style="width: 15%; font-size: 17px;
									 font-family: Arial, sans-serif;" class="text-left text-secondary">Category</th>
									<th style="width: 40%; font-size: 17px; font-family: Arial, sans-serif;" class="text-left text-secondary">Title</th>
									<th style="width: 15%; font-size: 17px; font-family: Arial, sans-serif;" class="text-left text-secondary">Date</th>
									<th style="width: 10%; font-size: 17px; font-family: Arial, sans-serif;" class="text-left text-secondary">Hit</th>
									<th style="width: 10%; font-size: 17px; font-family: Arial, sans-serif;" class="text-left text-secondary">Count</th>
								</tr>
							</thead>

							<c:forEach items="${noticeList }" var="notice" begin="0" end="9">
								<tr>
									<td class="text-left">${notice.noticeNo }</td>
									<td class="text-left">${notice.noticeCategory}</td>
									<td class="text-left"><a href="#"
										onclick="fn_noticeViewNo('${notice.noticeNo}')">
											${notice.noticeTitle }</a></td>
									<td class="text-left">${notice.noticeDate }</td>
									<td class="text-left">${notice.noticeHit }</td>
									<td class="text-left">${notice.noticeCount }</td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
			</c:if>
		</div>
		<!-- paging -->
		<div class="col-lg-8 col-xl-7 text-center mt-3">
			<div class="div_paging text-center">
				<nav aria-label="Page navigation example">
					<ul id="pagination-ul" class="pagination justify-content-center">
						<c:if test="${searchVO.curPage > 1}">
							<li class="page-item"><a class="page-link" href="#"
								data-curPage="1"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">처음페이지로</a></li>
						</c:if>
						<c:if test="${searchVO.firstPage gt 5}">
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold" data-curPage="${searchVO.firstPage-1}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">◀</a></li>
						</c:if>
						<c:forEach begin="${searchVO.firstPage}"
							end="${searchVO.lastPage}" step="1" var="i">
							<c:if test="${searchVO.curPage ne i}">
								<li class="page-item"><a class="page-link" href="#"
									data-curPage="${i}"
									data-rowSizePerPage="${searchVO.rowSizePerPage}">${i}</a></li>
							</c:if>
							<c:if test="${searchVO.curPage eq i}">
								<li class="page-item active" aria-current="page"><span
									class="page-link curPage_a" style="font-weight: bold">${i}</span>
								</li>
							</c:if>
						</c:forEach>

						<c:if test="${searchVO.lastPage ne searchVO.totalPageCount}">
							<li class="page-item"><a class="page-link" href="#"
								style="font-weight: bold" data-curPage="${searchVO.lastPage+1}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">▶</a></li>
						</c:if>
						<c:if test="${searchVO.curPage < searchVO.totalPageCount}">
							<a class="page-link" href="#"
								data-curPage="${searchVO.totalPageCount}"
								data-rowSizePerPage="${searchVO.rowSizePerPage}">끝페이지로</a>
						</c:if>
					</ul>
				</nav>
				<c:if test="${sessionScope.login.role == 'ADMIN' }">
					<div class="text-right">
						<a href="<c:url value="/noticeWriteView" />">
							<button type="button" class="btn btn-secondary">글쓰기</button>
						</a>
					</div>
				</c:if>
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
	<script src="${pageContext.request.contextPath }/mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
