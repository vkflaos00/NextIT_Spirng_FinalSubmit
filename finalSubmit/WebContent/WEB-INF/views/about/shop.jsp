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
<link href="${pageContext.request.contextPath }/css/about/map.css"
	rel="stylesheet" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a78cc469173a56e650b15a51632e4580&libraries=services"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath }/js/main.js"></script>
<script>
	function closeOverlay() {
		infowindow.close();
	}
</script>
<style>

</style>
</head>
<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- Team Start -->
	<div class="container-fluid pt-5">
		<div class="container">
			<div class="text-center pb-2">
				<p class="section-title px-5">
					<span class="px-2">편의점 찾기</span>
				</p>
			</div>
			<!-- Map Select -->
			<div class="row">
				<!-- 1번 영역 중앙 배치를 위한 빈공간--------------------------------------------------  -->
				<div class="col-md-4"></div>

				<!-- 2번 영억. 검색한 지역 기반 편의점 노출 --------------------------------------------------  -->

				<div class="col-md-4 col-lg-4 text-center team mb-5">
					<div class="position-relative overflow-hidden mb-4"
						style="border-radius: 100%">
						<img class=" img-fluid w-100" src="img/about/conv2.jpg" alt="" />
						<div
							class="team-social d-flex align-items-center justify-content-center w-100 h-100 position-absolute"
							onclick="toggleSearchArea(true)"></div>
					</div>
					<div>
						<h4>편의점을 검색해보자!</h4>
						<i>나를 눌러봐! </i>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!---------------------- 첫번째 지역명 검색 영역 -------------------->
	<div class="row">
		<div class="col-md-4"></div>

		<div class="col-md-4">
			<div id="searchArea" style="display: none;" class="search-area">
				<input type="text" name="searchValue" id="searchValue"
					class="form-control border-3 p-4" placeholder="원하는 지역을 입력하세요!"
					style="width: 100%; border-width: 3px">
			</div>
		</div>

		<div class="col-md-2 d-flex">
			<button type="button" id="search" onclick="searchConvenienceStore()"
				class="btn btn-secondary btn-block border-0 py-3"
				style="width: 100%; display: none;">전송</button>

		</div>

	</div>


	<!---------------------- 맵 출력 영역 -------------------->
	<div style="height: 30px"></div>

	<div class="map_wrap mt-0" style="width: 80%;">
		<div id="map"
			style="width: 100%; height: 600px; position: relative; overflow: hidden;"></div>
		<div class="radius_border">
			<!-- 기존 버튼 -->
			<div class="custom_typecontrol">
				<span class="selected_btn" id = "btnRoadmap" onclick="setMapType('roadmap')">지도</span> 
				<span class="nonselected_btn" id = "btnSkyview" onclick="setMapType('skyview')">스카이 뷰</span>
			</div>

			<!-- 로드뷰 버튼 -->
			<div class="custom_roadviewcontrol">
				<span class="roadview_btn" id="btnRoadview" onclick="setMapType('roadview')">로드뷰</span>
			</div>
		</div>
		<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
		<div class="custom_zoomcontrol radius_border">
			<span onclick="zoomIn()"><img
				src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
				alt="확대"></span> <span onclick="zoomOut()"><img
				src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
				alt="축소"></span>
		</div>
		<div id="menu_wrap" class="bg_white">
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

	<div style="height: 30px"></div>

	<div id="rvWrapper">
		<div id="roadview" style="width: 100%; height: 100%"></div>
		<!-- 로드뷰를 표시할 div 입니다 -->
	</div>


	<!-- 모든 페이지 하단에 포함되는 부분 -->

	<%@ include file="/WEB-INF/inc/footer.jsp"%>


	<script>
		// Enter 키 이벤트 처리
		$("#searchValue").on('keypress', function(event) {
			// 엔터 키의 keyCode는 13입니다.
			if (event.keyCode === 13 || event.which === 13) {
				// 검색 기능 실행
				search($("#searchValue").val());
			}
		});

		function moveButton(input) {
			const submitContainer = document.getElementById('submitContainer');
			if (input.value) {
				submitContainer.classList.add('slideInRight');
			} else {
				submitContainer.classList.remove('slideInRight');
			}
		}
	</script>


	<script>
		// 버튼 클릭 시 새로운 영역이 열리게 하는 함수------------------------------------------------
		var isSearchAreaVisible = false;

		function toggleSearchArea() {
			var searchArea = document.getElementById("searchArea");
			var searchButton = document.getElementById("search");
			// 			var searchDetail = document.getElementById("searchDetail")

			if (!isSearchAreaVisible) {
				searchArea.style.display = "block";
				searchButton.style.display = "block"; // 전송 버튼을 보이도록 변경
				// 				searchDetail.style.display = "block";
				isSearchAreaVisible = true;
			} else {
				searchArea.style.display = "none";
				searchButton.style.display = "none"; // 전송 버튼을 숨기도록 변경
				// 				searchDetail.style.display = "none";
				isSearchAreaVisible = false;
			}
		}

		// 2번 버튼 클릭 후 검색 영역에 입력한 값을 받아오는 함수-----------------------------------------
		function searchConvenienceStore() {
			var searchValue = document.getElementById("searchValue").value;
		}
	</script>

	<!-- API Script 추가 -->

	<script src="${pageContext.request.contextPath }/js/map.js"></script>
</body>
</html>
