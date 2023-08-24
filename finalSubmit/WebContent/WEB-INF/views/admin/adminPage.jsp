<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>ADMIN PAGE</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<!-- Google Charts 라이브러리 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
    /* 선택된 탭에 밑줄과 색상을 적용 */
    ul.nav-pills li.active a {
        border-bottom: 2px solid #000;
        color: #000;
    }
</style>
<script type="text/javascript">
	function fn_member_list(curPage, rowSizePerPage) {
	    // 검색 폼의 검색 조건 가져오기
	    var searchType = $("#id_searchType").val();
	    var searchWord = $("#id_searchWord").val();
	
	    let url = "${pageContext.request.contextPath}/admin/adminMember";
	    $.ajax({
	        url: url,
	        type: "post",
	        data: {
	            curPage: curPage,
	            rowSizePerPage: rowSizePerPage,
	            searchType: searchType, // 검색 조건 추가
	            searchWord: searchWord  // 검색어 추가
	        },
	        success: function (data) {
	            // alert("success");
	            $("#member_list_div").html(data);
	        },
	        error: function (err) {
	            console.log(err);
	        }
	    });
	}
	function fn_voc_list(curPage, rowSizePerPage) {
        // 검색 폼의 검색 조건 가져오기
        var searchType = $("#id_searchType").val();
        var searchWord = $("#id_searchWord").val();

        let url = "${pageContext.request.contextPath}/admin/adminVOC";
        $.ajax({
            url: url,
            type: "post",
            data: {
                curPage: curPage,
                rowSizePerPage: rowSizePerPage,
                searchType: searchType, // 검색 조건 추가
                searchWord: searchWord  // 검색어 추가
            },
            success: function (data) {
                // alert("success");
                $("#voc_list_div").html(data);
		        // adminVOC.jsp가 로드된 후에 모달 스크립트 초기화 함수 호출
                initModalScripts();
            },
            error: function (err) {
                console.log(err);
            }
        });
        
        
    }
	
	$(function(){
		// Select the "MEMBER" tab by default
	    $('ul.nav-pills li:first-child').addClass('active');
	    
	    // Call the function to load member data
	    fn_member_list(1, $("#id_rowSizePerPage").val());
	    
		$('#id_rowSizePerPage').change(function() {
			e.preventDefault();
			
			let curPage = sf.find("input[name='curPage']").val(1);
			let rowSizePerPage = sf.find("input[name='rowSizePerPage']").val($(this).val());
			fn_member_list(curPage,rowSizePerPage);
		});
		
		let sf =$("form[name='search']");
		let curPage= sf.find("input[name='curPage']");
		let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
		$('ul.pagination li a').click(function(e) {
	        e.preventDefault();

	        var curPage = $(this).data("curpage");
	        var rowSizePerPage = $("#id_rowSizePerPage").val();

	        // AJAX를 통해 페이지 이동 요청
	        fn_member_list(curPage, rowSizePerPage);
	    });
		
		$('#id_rowSizePerPage2').change(function() {
			sf2.find("input[name='curPage2']").val(1);
			sf2.find("input[name='rowSizePerPage2']").val($(this).val());
			sf2.submit();
		});
		
		let sf2 =$("form[name='search2']");
		let curPage2= sf2.find("input[name='curPage2']");
		let rowSizePerPage2 = sf2.find("input[name='rowSizePerPage2']");
		
		$('ul.pagination2 li a').click(function(e) {
			e.preventDefault();

			console.log($(e.target).data("curpage2"));  
			
			curPage2.val($(e.target).data("curpage2")); 
			rowSizePerPage2.val($(this).data("rowsizeperpage2")); 
			sf2.submit();
		});
		
		sf.find("button[id=submit2]").click(function(e) {
			e.preventDefault();
			curPage2.val(1);
			rowSizePerPage2.val(10);
			sf2.submit();
		});
		
		$('#id_btn_reset2').click(function() {
			sf2.find("select[name='searchType2'] option:eq(0)").attr(
					"selected", "selected");
			sf2.find("select[name='searchCategory'] option:eq(0)").attr(
					"selected", "selected");
			sf2.find("input[name='searchWord2']").val("");
			sf2.find("input[name='curPage2']").val(1);
			sf2.find("input[name='rowSizePerPage2']").val(10);
			sf2.submit();
		});
	 	// 회원목록 항목 클릭 시 페이지 이동
	    $('ul.nav-pills li a').click(function (e) {
	        e.preventDefault();

	        // 클릭한 탭에 활성화 시키는 CSS 스타일 적용
	        $('ul.nav-pills li').removeClass('active');
	        $(this).parent('li').addClass('active');

	        var curPage = $(this).data("curpage");
	        var rowSizePerPage = $("#id_rowSizePerPage").val();

	        if ($(this).text() === 'VOC') {
	            $("#member_list_div").html(""); // Member 리스트를 지우고 VOC 리스트를 보여주기 위해 div 비우기
	            fn_voc_list(curPage, rowSizePerPage);
	        } else {
	            $("#voc_list_div").html(""); // VOC 리스트를 지우고 Member 리스트를 보여주기 위해 div 비우기
	            fn_member_list(curPage, rowSizePerPage);
	        }
	    });
		
		
		// 초기화 기능 처리
		$("#id_btn_reset").click(function (e) {
	        e.preventDefault();
	        $("#id_searchType").val("");
            $("#id_searchWord").val("");
	        var rowSizePerPage = $("#id_rowSizePerPage").val();
	        fn_member_list(1, rowSizePerPage);
	    });
	});
	function fn_paging(curPage) {
		// alert("curPage:"+ curPage);
		var rowSizePerPage = $("#id_rowSizePerPage").val();
		$("#member_list_div").html("");
		fn_member_list(curPage, rowSizePerPage);
	}
	function fn_vocPaging(curPage) {
		// alert("curPage:"+ curPage);
		var rowSizePerPage = $("#id_rowSizePerPage").val();
		$("#voc_list_div").html("");
		fn_voc_list(curPage, rowSizePerPage);
	}

</script>
</head>

<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>


	<!-- Facilities Start -->
	<h2
		class="page-section-heading text-center text-uppercase text-secondary mt-5">관리자
		페이지</h2>
	<div class="container-fluid py-5">
		<div class="row">
			<div class="col-lg-4 col-md-4 pb-1">
				<div id="piechart" class="row d-flex"
					style="width: 100%; float: top; height: 500px;"></div>
				<div id="categoryChart" class="row d-flex"
					style="width: 100%; float: bottom; height: 500px;"></div>
			</div>
			<div class="col-lg-8 col-md-8 pb-1">
				<div class="row justify-content-center mt-1">
					<div class="col-lg-8 col-xl-7 text-center">
						<ul class="nav nav-pills nav-fill">
							<!-- 회원목록 항목 -->
							<li class="nav-item"><a class="nav-link"
								style="font-size: 20px;"
								href="<c:url value='/admin/adminMember' />">MEMBER</a></li>
							<!-- VOC 항목 -->
							<li class="nav-item"><a class="nav-link"
								style="font-size: 20px;"
								href="${pageContext.request.contextPath }/adimn/adminVOC">VOC</a></li>
						</ul>
					</div>
				</div>
				<div id="member_list_div"></div>
				<div id="voc_list_div"></div>
			</div>
		</div>
	</div>
	<!-- 모든 페이지 하단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<script type="text/javascript">

	// 구글 차트 라이브러리 로드
	google.charts.load('current', {'packages':['corechart']});

	// 구글 차트 라이브러리 로드 완료 후 실행할 함수 정의
	google.charts.setOnLoadCallback(drawCharts);

	// 차트를 그리는 함수 정의
	function drawCharts() {
	    // 차트에 표시할 데이터 배열 생성
	    fetch('${pageContext.request.contextPath}/admin/regionChartData')
	        .then(response => response.json())
	        .then(data => {
	            // 가져온 데이터를 사용하여 차트에 표시할 데이터 배열 생성
	            var chartData = new google.visualization.DataTable();
	            chartData.addColumn('string', 'Address1');
	            chartData.addColumn('number', 'Count');

	            // 가져온 데이터를 반복하여 행 추가
	            data.forEach(item => {
	                chartData.addRow([item.address1, item.count]);
	            });

	            // 원형 차트 옵션 설정
	            var options = {
	                title: '지역별 이용자수',
	                is3D: true // 3D 효과 사용 여부 (선택적)
	            };

	            // 원형 차트 그리기
	            var chart1 = new google.visualization.PieChart(document.getElementById('piechart'));
	            chart1.draw(chartData, options);
	            
	            // 분류별 제품수 차트 그리기
	            drawCategoryChart();
	        })
	        .catch(error => console.error('Error fetching data:', error));
	    
		
	}
	
	// 차트를 그리는 함수 정의
	function drawCategoryChart() {
	    // 차트에 표시할 데이터 배열 생성
	    fetch('${pageContext.request.contextPath}/admin/ageChartData')
	        .then(response => response.json())
	        .then(data => {
	            // 가져온 데이터를 사용하여 차트에 표시할 데이터 배열 생성
	            var categoryData = new google.visualization.DataTable();
	            categoryData.addColumn('string', 'Age');
	            categoryData.addColumn('number', 'Count');

	            // 가져온 데이터를 반복하여 행 추가
	            data.forEach(item => {
	                categoryData.addRow([item.age, item.count]);
	            });

	            // 원형 차트 옵션 설정
	            var options = {
	                title: '연령대별 이용자수',
	                is3D: true // 3D 효과 사용 여부 (선택적)
	            };

	            // 원형 차트 그리기
	            var chart2 = new google.visualization.PieChart(document.getElementById('categoryChart'));
	            chart2.draw(categoryData, options);
	        })
	        .catch(error => console.error('Error fetching data:', error));
		
	}
	
	</script>
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
	<%-- <script src="${pageContext.request.contextPath }/mail/contact.js"></script> --%>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
