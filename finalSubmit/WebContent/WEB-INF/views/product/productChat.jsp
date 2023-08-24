<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Conv - 편돌이순이를 위한 사이트</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
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
		
		$('#id_btn_reset').click(function() {
			sf.find("select[name='searchEvent'] option:eq(0)").attr(
					"selected", "selected");
			sf.find("select[name='searchStore'] option:eq(0)").attr(
					"selected", "selected");
			sf.find("select[name='searchCategory'] option:eq(0)").attr(
					"selected", "selected");
			sf.find("input[name='searchWord']").val("");
			sf.find("input[name='curPage']").val(1);
			sf.find("input[name='rowSizePerPage']").val(10);
			sf.submit();
		});
		
		
	});
	
	function fn_detailView(itemNo) {
		console.log("itemNo" + itemNo);
		
		let ss = $("select[name='searchStore']").val();
		let se = $("select[name='searchEvent']").val();
		let sw = $("input[name='searchWord']").val();
		let sc = $("select[name='searchCategory']").val();
		
		let cp = $("input[name='curPage']").val();
		let rpp = $("input[name='rowSizePerPage']").val();
		console.log("ss:",ss,"se:",se,"sw:",sw,"sc:",sc,"cp:",cp,"rpp:",rpp)
		location.href="${pageContext.request.contextPath}/product/productDetailView?itemNo="+itemNo+"&searchStore="+ss+"&searchEvent="+se+"&searchWord="+sw+"&searchCategory="+sc+"&curPage="+cp+"&rowSizePerPage="+rpp;
	}
</script>
</head>

<body>
	
	<!-- 모든 페이지 상단에 포함되는 부분 -->
   	<%@ include file="/WEB-INF/inc/header.jsp" %>
   	
<!-- 	<div class="container-fluid bg-primary px-0 px-md-5 mb-5">
		<div class="row align-items-center px-3">
			<div class="col-lg-6 text-center text-lg-left">
				<h4 class="text-white mb-4 mt-5 mt-lg-0">Conv</h4>
				<h1 class="display-3 font-weight-bold text-white">Convenience store information site for convenience</h1>
				<p class="text-white mb-4">CU는 1+1인데 GS는 왜 행사 안해!
				불편한 니들을 구제해주러 왔도다.
				우리 Conv만 확인해봐. 확 편해질 껄?</p>
				<a href="#product" class="btn btn-secondary mt-1 py-3 px-5">함 보자</a>
			</div>
			<div class="col-lg-6 text-center text-lg-right">
				<img class="img-fluid mt-5" src="img/Inconvenience.jpeg" alt="" />
			</div>
		</div>
	</div>  -->
	
	<!-- Facilities Start -->
	<div class="page-title text-center" style="margin-top: 60px;">
		<h2>채팅방 항목</h2>
	</div>
	<c:if test="${e ne null }">
		<div class="alert alert-warning">
			목록을 불러오지 못하였습니다. 민기한테 문의 부탁드립니다. 010-7406-4815
		</div>	
		<div class="div_button">
			<input type="button" onclick="history.back();" value="뒤로가기">
		</div>
	</c:if>   
	<c:if test="${e eq null }">  
		<div class="container-fluid py-5" id="product">
			<div class="mb-3 text-center">
				<form name="search" action="${pageContext.request.contextPath }/productChat" method="post">
					<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
					<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
					
					<div>
						<label for="id_searchStore">편의점</label>
						&nbsp;&nbsp;
						<select id="id_searchStore" name="searchStore" class="form-select">
							<option value="">-- 편의점 전체 --</option>
							<option value="CU" ${searchVO.searchStore eq "CU" ? "selected='selected'" : "" }>CU</option>
							<option value="GS25" ${searchVO.searchStore eq "GS25" ? "selected='selected'" : "" }>GS25</option>
							<option value="7-ELEVEN" ${searchVO.searchStore eq "7-ELEVEN" ? "selected='selected'" : "" }>7-ELEVEN</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label for="id_searchEvent">행사</label>
						&nbsp;&nbsp;
						<select id="id_searchEvent" name="searchEvent" class="form-select">
							<option value="">-- 행사 전체 --</option>
							<option value="1+1" ${searchVO.searchEvent eq "1+1" ? "selected='selected'" : "" }>1+1</option>
							<option value="2+1" ${searchVO.searchEvent eq "2+1" ? "selected='selected'" : "" }>2+1</option>
							<option value="3+1" ${searchVO.searchEvent eq "3+1" ? "selected='selected'" : "" }>3+1</option>
							<option value="4+1" ${searchVO.searchEvent eq "4+1" ? "selected='selected'" : "" }>4+1</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label for="id_searchCategory">분류</label>
						&nbsp;&nbsp;
						<select id="id_searchCategory" name="searchCategory" class="form-select">
							<option value="">-- 분류 전체 --</option>
							<option value="음료" ${searchVO.searchCategory eq "음료" ? "selected='selected'" : "" }>음료</option>
							<option value="과자류" ${searchVO.searchCategory eq "과자류" ? "selected='selected'" : "" }>과자류</option>
							<option value="식품" ${searchVO.searchCategory eq "식품" ? "selected='selected'" : "" }>식품</option>
							<option value="아이스크림" ${searchVO.searchCategory eq "아이스크림" ? "selected='selected'" : "" }>아이스크림</option>
							<option value="생활용품" ${searchVO.searchCategory eq "생활용품" ? "selected='selected'" : "" }>생활용품</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label for="id_searchWord">검색</label>
						&nbsp;&nbsp;
						<input type="text" id="id_searchWord" name="searchWord" value="${searchVO.searchWord }" placeholder="검색어">
						&nbsp;&nbsp;&nbsp;&nbsp;	
						<button type="submit" class="btn btn-outline-dark btn-sm">검 색 </button>
						<button type="button" id="id_btn_reset" class="btn btn-outline-dark btn-sm">초기화</button>
					</div>
				</form>
			</div>    
			<div class="rowSizePerPage text-right col-9">
				<div>
					전체 ${searchVO.totalRowCount } 건 조회
					<select id="id_rowSizePerPage" name="rowSizePerPage">
						<c:forEach begin="10" end="50" step="10" var="i">
							<option value="${i }" ${searchVO.rowSizePerPage eq i ? "selected='selected'" : "" }>${i }개씩 보기!</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="container pb-3">
				<div class="row searchResult">
					<c:forEach items="${productChatList }" var="product">
						<input type="hidden" value="${product.itemNo }" name="itemNo">
						<div class="col-md-6 pb-1" id="chat">
							<a href="#" class="deco-none" >
								 <div class="card border mt-2 mb-2">
									<div class="card-header text-black px-2 py-1">
										<small class="float-left font-weight-bold">${product.storeType }</small>
										<small class="float-right font-weight-bold">${product.itemCategory}</small>
										<small class="float-right text-black mr-3"><i class="fa fa-sync-alt"></i> ${fn:substring(product.updateDate,0,10)}</small>
									</div>
									<div class="card-body px-2 py-2">
										<div class="prod_img_div float-left text-center mr-2">
											<img onerror="this.style.display='none';" src="${product.imagePath }" class="prod_img" style="width: 150px; height: 150px;">
										</div>
										<div>
											<strong>${product.itemName}</strong>
											<br>
											<i class="fa fa-coins text-warning pr-1"></i> <fmt:formatNumber value="${product.itemPrice}" pattern="#,###"/>원
												<c:choose>
													<c:when test="${product.storeEvent eq '1+1'}">
														<span class="text-muted small">(<fmt:formatNumber value="${product.itemPrice / 2}" pattern="#,###"/>원)</span>
													</c:when>
													<c:when test="${product.storeEvent eq '2+1'}">
														<span class="text-muted small">(<fmt:formatNumber value="${(product.itemPrice * 2) / 3}" pattern="#,###"/>원)</span>
													</c:when>
													<c:when test="${product.storeEvent eq '3+1'}">
														<span class="text-muted small">(<fmt:formatNumber value="${(product.itemPrice * 3) / 4}" pattern="#,###"/>원)</span>
													</c:when>
													<c:otherwise>
														<span class="text-muted small">(<fmt:formatNumber value="${(product.itemPrice * 4) / 5}" pattern="#,###"/>원)</span>
													</c:otherwise>
												</c:choose>
											</span>
											<br>
											<span class="badge bg-cu text-black">${product.storeEvent }</span>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
				<!-- paging -->
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
		
								<c:if test="${searchVO.lastPage ne searchVO.totalPageCount }">
									<li class="page-item"><a class="page-link" href="#"
										data-curPage=${searchVO.curPage+1  }
										data-rowSizePerPage=${searchVO.rowSizePerPage }>&gt;</a></li>
									<li class="page-item"><a class="page-link" href="#"
										style="font-weight: bold" data-curPage=${searchVO.lastPage+1  }
										data-rowSizePerPage=${searchVO.rowSizePerPage }>&raquo;</a></li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<!-- Facilities Start -->
	<!-- 모든 페이지 상단에 포함되는 부분 -->
   	<%@ include file="/WEB-INF/inc/footer.jsp" %>
   	<script type="text/javascript">
	   	$("#chat").on('click', function(e){
	   	    e.preventDefault();
	   	    console.log($(this).data);
	   	 	let itemNo = $("input[name='itemNo']").val();
	   	    window.open("${pageContext.request.contextPath}/chat/chat?itemNo=" + itemNo, "/chat/chat", "width=500, height=800, top=200, left=200");
	   	});
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
	<%-- <script src="${pageContext.request.contextPath }/mail/contact.js"></script> --%>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
