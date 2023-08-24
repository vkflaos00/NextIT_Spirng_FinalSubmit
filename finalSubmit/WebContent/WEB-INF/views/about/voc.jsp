<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="${pageContext.request.contextPath }/css/about/voc.css"
	rel="stylesheet" />
<style>
.pagination {
	width: 300px;
	/* height: 30px; */
	height: 100%;
	/* background-color: lightpink; */
	text-align: center;
	display: flex;
}

@
keyframes rainbowText { 0% {
	color: red;
}

14%
{
color








:orange








;
}
28%
{
color








:yellow








;
}
42%
{
color








:green








;
}
57%
{
color








:blue








;
}
71%
{
color








:indigo








;
}
85%
{
color








:violet








;
}
100%
{
color








:red








;
}
}
.rainbow-text {
	animation: rainbowText 5s infinite;
}

.modal-content {
	background-color: #f8f9fa;
	border: 2px solid #117a8b;
	border-radius: 10px;
	padding: 20px;
}

.modal-header {
	background-color: #117a8b;
	color: white;
	border-bottom: none;
}

.modal-title {
	font-size: 1.5rem;
	margin: 0;
}

.modal-body {
	padding: 10px 0;
}

.modal-body h4 {
	margin: 0;
	padding: 5px 0;
}

.content-textarea {
	width: 100%;
	height: 150px;
	resize: none;
	border: 1px solid #ccc;
	padding: 5px;
}

.category {
	color: #117a8b;
}
</style>
</head>

<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>
	<input type="hidden" id="memberVOValue"
		value="${sessionScope.login.getId()}" />

	<script>
		$(document).ready(function() {

			// 페이지 로딩 시 초기 데이터 출력
			loadVOCList(1);

		});

		// VocVO 리스트와 PagingVO를 출력하는 함수--------------------------------------------------
		function renderDataOnTable(data) {
			let tableBody = $("#vocTableBody"); // 테이블 내용 출력할 영역
			let pageNo = $("#pageNo"); // 페이징 처리할 영역
			tableBody.empty();

			// 페이지 번호나 <, > 버튼 클릭 시 이벤트 처리
			pageNo.on("click", "a[data-curPage]", function(event) {
				event.preventDefault(); // 기본 링크 동작 방지

				let curPage = $(this).data("curPage"); // 클릭한 페이지 번호 가져오기
				loadVOCList(curPage); // 해당 페이지의 문의 리스트 불러오기
			});
			if (data.error != null) {
				// 로그인을 안한 경우 or 문의사항을 등록한 적이 없는 경우
				let vo = "로그인이 필요합니다.";
				let row = $("<tr>");
				let td1 = $("<td>");
				let h = $("<h3>");
				let link = $("<a>", {
					href : "<c:url value='/login'/>",
					text : vo,
				});
				h.append(link);
				td1.append(h);
				row.append(td1);
				tableBody.append(row);
			}else if(data.keyword != null){ 
				vo = "등록한 문의사항이 없습니다.";
				let row = $("<tr>");
				let td1 = $("<td>");
				let h = $("<h3>");
				let link = $("<a>", {
					href : "<c:url value='#'/>",
					text : vo,
				});
				h.append(link);
				td1.append(h);
				row.append(td1);
				tableBody.append(row);
			}else {
				// 문의사항이 있는 경우, VocVO 리스트 출력
				let start = (data.pagingVO.curPage - 1) * 3;
				let finish = start + 3;
				if (finish > data.pagingVO.totalRowCount) {
					finish = data.pagingVO.totalRowCount;
				}

				
				for (let i = start; i < finish; i++) {
				    let vo = data.vocList[i];
				    let row = $("<tr>");
				    let td1 = $("<td>");
				    let link = $("<a>", {
				        href : "#",
				        click : function(){
				            fn_vocViewPopup(vo.vocNo);
				            return false;
				        },
				    });

				    let hElement = $("<h4>").append(link);
					
				    if (vo.process === 0) {
				        let icon = $("<i>", {
				            class: "far fa-circle text-primary mr-3"
				        });
				        link.append(icon);
				    }else if(vo.process === 1){
				    	let icon = $("<i>", {
				            class: "fas fa-hourglass-half text-primary mr-3"
				        });
				        link.append(icon);
				    }else{
				    	let icon = $("<i>", {
				            class: "far fa-check-circle text-primary mr-3"
				        });
				        link.append(icon);
				    }

				    link.append((i + 1) + ". " + vo.vocTitle);

				    td1.append(hElement);
				    row.append(td1);
				    tableBody.append(row);
				}

				// 페이징 처리
				pageNo.empty(); // 페이징 영역 초기화
				let pagingHTML = "<ul class='pagination'>";
				// 이전 페이지 버튼
				if (data.pagingVO.curPage > 1) {
					pagingHTML += '<li><a href="javascript:fn_paging('
							+ (data.pagingVO.curPage - 1) + ')">&lt;</a></li>';
				}

				// 페이지 번호 버튼
				for (let i = data.pagingVO.firstPage; i <= data.pagingVO.lastPage; i++) {

					pagingHTML += '<li><a href="javascript:fn_paging(' + i
							+ ')">' + i + '</a></li>';
				}

				// 다음 페이지 버튼
				if (data.pagingVO.curPage < data.pagingVO.totalPageCount) {
					pagingHTML += '<li><a href="javascript:fn_paging('
							+ (data.pagingVO.curPage + 1) + ')">&gt;</a></li>';
				}

				pagingHTML += "</ul>";
				pageNo.append(pagingHTML);
			}
		}

		// 서버로 AJAX 요청하여 VocVO 리스트와 PagingVO 불러오는 함수
		function loadVOCList(curPage) {
			$.ajax({
				url : "<c:url value='/selectVOC'/>",
				type : "POST",
				data : {
					"curPage" : curPage
				},
				success : function(data) {
					// 로그인한 회원 또는 글을 남긴 회원의 처리
					//console.log("현재 페이지" + data.pagingVO.curPage);

					renderDataOnTable(data);
				},
				error : function() {
					console.log("서버와 통신 중 오류가 발생했습니다.");
					renderDataOnTable(null);
				}
			});
		}

		function fn_paging(curPage) {
			//alert("fn_paging:" + curPage);
			loadVOCList(curPage);
		}
	</script>


	<!-- Header Start -->
	<div class="container-fluid bg-primary px-0 px-md-5 mb-5">
		<div class="row align-items-center px-3">
			<div class="col-lg-6 text-center text-lg-left">
				<h4 class="text-white mb-4 mt-5 mt-lg-0">사장님 집좀 보내주세요</h4>
				<h1 class="display-3 font-weight-bold text-white">24시간 고객센터</h1>
				<p class="text-white mb-4">
					24시간 하루 1교대 근무를 통해 언제나 고객님의 목소리를 들을 상담원이 있습니다.<br> 고객님들의 불만이
					없는 날까지 저희는 집에 가지 않겠습니다. 늘 저희 사이트를 방문해주시는 고객님들께 감사인사를 드리며 더보기..
				</p>
				<c:choose>
					<c:when test="${memId == null }">
						<a class="btn btn-secondary mt-1 py-3 px-5" onclick="checkLogin()">문의하기</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-secondary mt-1 py-3 px-5" onclick="openPopup()">문의하기</a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-lg-6 text-center"
				style="height: 350px; margin-top: 50px">
				<img class="img-fluid mt-3" src="img/about/voc.jpg" alt="" />
			</div>
		</div>
	</div>
	<!-- Header End -->

	<!-- Facilities Start -->
	<div class="container-fluid pt-5">

		<div class="container pb-1">
			<div class="text-center pb-2">
				<p class="section-title px-5">
					<span class="px-1">고객센터</span>
				</p>
				<h1 class="mb-4">저희 고객센터를 소개합니다.</h1>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px;">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/customer-target.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4" style="width: 300px">
							<h4>궁금증은 한방에!</h4>
							<p class="m-0">뭐가 문제지! 이 고객센터는 당신의 궁금증을 시원하게 해결해 드립니다.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/3star.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4" style="width: 300px">
							<h4>미슐랭 3스타</h4>
							<p class="m-0">전문적인 상담가들! 미슐랭 공인 3스타 쉐프들이 상담해드립니다.</p>
						</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/support.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4">
							<h4>저희 직원 내향적이에요</h4>
							<p class="m-0">부끄러움이 많아 상담원이 말이 없어도 이해해주세요.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/best_customer.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4">
							<h4>평점은 뭐다?</h4>
							<p class="m-0">무조건 만점! 상담이 마음에 안들어도 만점 주세요.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/call.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4">
							<h4>불만 있으면 뭐다?</h4>
							<p class="m-0">전화 하지마세요. 고객센터가 일이 바빠요. 메신저를 통해 연락주세요.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 pb-1">
					<div class="d-flex bg-light shadow-sm border-top rounded mb-4 card"
						style="padding: 30px">
						<i class="font-weight-normal text-primary mb-3"> <img
							class="img-fluid mt-1" src="img/about/target.png" alt=""
							style="margin-top: 50px; height: auto; width: 200px" />
						</i>
						<div class="pl-4">
							<h4>고객님 기억하겠습니다.</h4>
							<p class="m-0">문의하신 고객님 전부 기억하고 있으니, 좋은말만 부탁드립니다 ★_★</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Facilities Start -->

	<!-- 자주 찾는 질문 Start -->
	<div class="container-fluid py-5">
		<div class="container p-0">
			<div class="text-center pb-2">
				<p class="section-title px-5">
					<span class="px-1">도움말</span>
				</p>
				<h1 class="mb-4">자주 찾는 질문</h1>
			</div>
			<div class="owl-carousel testimonial-carousel">
				<div class="testimonial-item px-3">
					<div class="bg-light shadow-sm rounded mb-4 p-4">
						<h3 class="fas fa-quote-left text-primary mr-3"></h3>
						결제를 취소 하고 싶으신가요?<br> 죄송해요 그런 기능은 없어요. <br> I'm sorry~
					</div>
					<div class="d-flex align-items-center">
						<img class="rounded-circle" src="img/testimonial-1.jpg"
							style="width: 70px; height: 70px" alt="Image" />
						<div class="pl-3">
							<h5>결제를 취소하고싶어요</h5>
							<i>결제 취소/환불</i>
						</div>
					</div>
				</div>
				<div class="testimonial-item px-3">
					<div class="bg-light shadow-sm rounded mb-4 p-4">
						<h3 class="fas fa-quote-left text-primary mr-3"></h3>
						욕설 혹은 글 도배, 사이트 취지와 관련없는 광고는 운영정책에 따라 계정 접속 제한이 적용될 수 있습니다.<br>
					</div>
					<div class="d-flex align-items-center">
						<img class="rounded-circle" src="img/testimonial-2.jpg"
							style="width: 70px; height: 70px" alt="Image" />
						<div class="pl-3">
							<h5>계정 접속이 제한/이용정지(제재) 되었어요.</h5>
							<i>계정</i>
						</div>
					</div>
				</div>
				<div class="testimonial-item px-3">
					<div class="bg-light shadow-sm rounded mb-4 p-4">
						<h3 class="fas fa-quote-left text-primary mr-3"></h3>
						상담사님의 전화번호를 알고 싶어요! 저를 상담해주시는 최성복 상담사님의 전화번호 알려주세요!
					</div>
					<div class="d-flex align-items-center">
						<img class="rounded-circle" src="img/testimonial-3.jpg"
							style="width: 70px; height: 70px" alt="Image" />
						<div class="pl-3">
							<h5>상담사 소환</h5>
							<i>최성복</i>
						</div>
					</div>
				</div>
				<div class="testimonial-item px-3">
					<div class="bg-light shadow-sm rounded mb-4 p-4">
						<h3 class="fas fa-quote-left text-primary mr-3"></h3>
						저희 CONV에는 각 편의점에서 출시된 모든 상품이 구비되어 있지는 않습니다. 찾으시는 상품이 없다면 제품 목록이
						갱신이 안됐거나 단종 제품인 경우가 많습니다.
					</div>
					<div class="d-flex align-items-center">
						<img class="rounded-circle" src="img/testimonial-4.jpg"
							style="width: 70px; height: 70px" alt="Image" />
						<div class="pl-3">
							<h5>제가 찾는 상품이 없어요</h5>
							<i>상품</i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 자주찾는 질문 End -->

	<!-- Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-5">
					<img class="img-fluid rounded mb-5 mb-lg-0"
						src="img/about/vocView.gif" alt="" />
				</div>
				<div class="col-lg-7" style="margin-top: -100px">
					<p class="section-title pr-5">
						<span class="pr-2">내가 남긴 문의 내역</span>
					</p>
					<h1 class="mb-0">성심성의껏 도와드리겠습니다.</h1>
					<i class="mb-8">성의를 보이세요</i>

					<div class="row pt-4 pb-2">

						<table>
							<tbody id="vocTableBody">
								<!-- renderDataOnTable에서 동적으로 이 영역에 생성 -->
							</tbody>
							<tfoot id="pageNo">

							</tfoot>
						</table>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- About End -->
	<!-- 모달 창 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">

					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<!-- 여기에 데이터를 출력할 내용을 작성 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 모든 페이지 하단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>

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


	<!-- 문의하기 팝업 클릭시 -->
	<script>
		function checkLogin() {

			var shouldLogin = confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
			if (shouldLogin) {
				// 로그인 페이지로 이동하도록 처리합니다. (예시로 '/login' 페이지로 이동한다고 가정)
				window.location.href = '<c:url value="/login"/>';
			} else {
				// 사용자가 취소한 경우, 아무 동작도 하지 않습니다.
			}
		}

		function openPopup() {
			var url = '<c:url value="/vocPop"/>'; // JSP 페이지 경로
			//url += '?place=' + encodeURIComponent(place); //place 값을 같이 전송
			// 새로운 팝업 창 열기
			window.open(url, "Popup", "width=800, height=800");
		}
		
		function fn_vocViewPopup(vocNo) {
		    var url = '<c:url value="/vocViewPopup"/>';
		    url += '?vocNo=' + encodeURIComponent(vocNo);
			var originaldata;
			
			$.ajax({
			    type: 'GET',
			    url: url,
			    dataType: 'json',
			    success: function (data) {
			        originaldata = data;
			        var modal = $("#myModal");
			        var modalBody = modal.find(".modal-body");
			        
			        modal.find(".modal-header").text(originaldata.vocTitle);
			        
			        var dataValue = originaldata.vocNo; // 데이터를 URL에 안전하게 인코딩
			        var imageUrl = '<c:url value="/takePicture"/>';
			        var dataValue = encodeURIComponent(originaldata.vocNo);
			        imageUrl += '?dataValue=' + dataValue;
			        console.log(imageUrl);
			        $.ajax({
			            type: 'GET',
			            url: imageUrl,
			            dataType: 'json', 
			            contentType: 'application/json', 
			            success: function (imagePath) {
			            	event.preventDefault();
			            	console.log("--"+JSON.stringify(imagePath));
							var root = "<c:url value='/image/"+imagePath.path+"'/>"
			                
			                if (imagePath !== 0) {
			                    imgTag = '<h4 class="align-self-start">첨부파일</h4>' +
			                    '<img class="img-fluid mt-1" src="'+root+'" alt="첨부파일" style="height: 300px; width: auto;" />';
			                }

			                var newContent =  
			                	` <h4><span class="category">Category:</span> ` 
			                	+ originaldata.vocCategory 
			                	+ `</h4>` 
			                	+ imgTag 
			                	+ ` <h4><span style="color: black">Content:</span></h4> <textarea class="content-textarea" readonly>` 
			                	+ originaldata.vocContent 
			                	+ `</textarea> <h4><span style="color: #117a8b">From:</span> ` 
			                	+ originaldata.vocMail + `</h4>`;

			                modalBody.html(newContent);

			                // 모달 보여주기
			                modal.modal("show");
			            },
			            error: function (error,status,request) {
			                console.error("error:"+JSON.stringify(error));
			                console.error("Error:", error);
			            }
			        });
			    },
			    error: function (error) {
			        console.error("VOC ERROR:");
			        console.error("Error:", error);
			    }
			});

		    return false;
		}
	</script>
</body>
</html>