<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<style>
.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modal_body {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 800px;
	height: 600px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

.forecast-container {
	display: flex;
	justify-content: space-between; /* 아이템들을 왼쪽과 오른쪽으로 나열 */
	overflow: auto; /* 넘치는 내용을 스크롤로 처리 */
}

.forecast-group {
	width: calc(50% - 10px); /* 왼쪽과 오른쪽 간격을 조정 */
	border: 1px solid #ccc;
	padding: 10px;
	box-sizing: border-box;
}

.weather {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.weather-center {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.temp {
	margin-top: 20px;
	color: #4D4D4D;
	font-size: 50px;
	margin-left: 20px;
	position: relative;
	bottom: -40px;
}

.city {
	position: relative;
	bottom: 20px;
}

.items .item {
	display: inline-block;
	padding: 0 5px; /* 간격을 위해 각 너비에 준 패딩 5px을 줌 */
	vertical-align: middle; /* 나란히 배치하는 와중에 수직정렬도 가운데로 하려고 준 속성 */
	text-align: center; /* 영역 안 태그들의 텍스트가 center로 오도록 준 속성 */
	box-sizing: border-box;
}

</style>
<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<!-- Google Charts 라이브러리 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function() {
	    $(".hover-anim").hover(
	        function() {
	            $(this).attr("src", "${pageContext.request.contextPath}/img/loading2.gif");
	        },
	        function() {
	            $(this).attr("src", "${pageContext.request.contextPath}/img/loading.png");
	        }                         
	    );                  
	});
	
	//document.getElementById("weatherUpdate").innerText= month + '/' + dat + '/' day
	

	
	</script>
</head>

<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- Testimonial Start -->
	<div class="container-fluid py-5">
		<div class="container p-0">
			<div class="text-center pb-2">
				<p class="section-title px-5">
					<span class="px-2">펴늬점 최고 사치품</span>
				</p>
				<h1 class="mb-4">무엇일까요!</h1>
			</div>
			<div class="owl-carousel testimonial-carousel">
				<c:forEach items="${productList }" var="product">
					<div class="col-md-6 pb-1"
						onclick="fn_detailView('${product.itemNo}')">
						<a href="#" class="deco-none">
							<div class="card border mt-2 mb-2">
								<div class="card-header text-black px-2 py-1">
									<small class="float-left font-weight-bold">${product.storeType }</small>
									<small class="float-right font-weight-bold">${product.itemCategory}</small>
									<small class="float-right text-black mr-3"><i
										class="fa fa-sync-alt"></i>
										${fn:substring(product.updateDate,0,10)}</small>
								</div>
								<div class="card-body px-2 py-2">
									<div class="prod_img_div float-left text-center mr-2">
										<img onerror="this.style.display='none';"
											src="${product.imagePath }" class="prod_img"
											style="width: 150px; height: 150px;">
									</div>
									<div>
										<strong>${product.itemName}</strong> <br> <i
											class="fa fa-coins text-warning pr-1"></i>
										<fmt:formatNumber value="${product.itemPrice}" pattern="#,###" />
										원
										<c:choose>
											<c:when test="${product.storeEvent eq '1+1'}">
												<span class="text-muted small">(<fmt:formatNumber
														value="${product.itemPrice / 2}" pattern="#,###" />원)
												</span>
											</c:when>
											<c:when test="${product.storeEvent eq '2+1'}">
												<span class="text-muted small">(<fmt:formatNumber
														value="${(product.itemPrice * 2) / 3}" pattern="#,###" />원)
												</span>
											</c:when>
											<c:when test="${product.storeEvent eq '3+1'}">
												<span class="text-muted small">(<fmt:formatNumber
														value="${(product.itemPrice * 3) / 4}" pattern="#,###" />원)
												</span>
											</c:when>
											<c:otherwise>
												<span class="text-muted small">(<fmt:formatNumber
														value="${(product.itemPrice * 4) / 5}" pattern="#,###" />원)
												</span>
											</c:otherwise>
										</c:choose>
										</span> <br> <span class="badge bg-cu text-black">${product.storeEvent }</span>
									</div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>



	<!-- Testimonial End -->
	<div class="row">
		<div id="piechart" class="col-md-6"
			style="width: 50%; float: left; height: 500px;"></div>
		<div id="categoryChart" class="col-md-6"
			style="width: 50%; float: right; height: 500px;"></div>
	</div>


	<!-- Weather area -->

	<div class="weather">
		<div class="modal">
			<div class="modal_body">
				<div class="forecast-container"></div>
			</div>
		</div>
		<div class=weather-center>
			<h2>잠깐! 날씨보고 편의점 다녀오세요!</h2>
			<h2 class="temp"></h2>
			<!-- 현재온도 -->
			<div class="btn-open-popup">
				<div class="icon""></div>
			</div>
			<!-- 아이콘 -->
			<div class="city"></div>
			<!-- 장소 -->
			<div class="hum">습도</div>
			<div class="items">
				<div class="weatherText item"></div>
				<div class="item">
					<img src="${pageContext.request.contextPath }/img/loading.png"
						id="weatherUpdate" class="hover-anim">
				</div>
			</div>
		</div>
	</div>


	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<script>
	console.log("${cookie.id.value }" );
	if("${cookie.id.value }" != ""){
		alert("${sessionScope.login.id}" + "고갱님 어서오세요.");
	}
    // 구글 차트 라이브러리 로드
    google.charts.load('current', {'packages':['corechart']});
    
    // 구글 차트 라이브러리 로드 완료 후 실행할 함수 정의
    google.charts.setOnLoadCallback(drawCharts);
    
    // 차트를 그리는 함수 정의
    function drawCharts() {
        // 차트에 표시할 데이터 배열 생성
        fetch('${pageContext.request.contextPath}/chartData')
            .then(response => response.json())
            .then(data => {
                // 가져온 데이터를 사용하여 차트에 표시할 데이터 배열 생성
                var chartData = new google.visualization.DataTable();
                chartData.addColumn('string', 'Store');
                chartData.addColumn('number', 'Count');

                // 가져온 데이터를 반복하여 행 추가
                data.forEach(item => {
                    chartData.addRow([item.storeType, item.count]);
                });

                // 원형 차트 옵션 설정
                var options = {
                    title: '편의점별 제품수',
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
        fetch('${pageContext.request.contextPath}/categoryData')
            .then(response => response.json())
            .then(data => {
                // 가져온 데이터를 사용하여 차트에 표시할 데이터 배열 생성
                var categoryData = new google.visualization.DataTable();
                categoryData.addColumn('string', 'Category');
                categoryData.addColumn('number', 'Count');

                // 가져온 데이터를 반복하여 행 추가
                data.forEach(item => {
                    categoryData.addRow([item.itemCategory, item.count]);
                });

                // 원형 차트 옵션 설정
                var options = {
                    title: '분류별 제품수',
                    is3D: true // 3D 효과 사용 여부 (선택적)
                };

                // 원형 차트 그리기
                var chart2 = new google.visualization.PieChart(document.getElementById('categoryChart'));
                chart2.draw(categoryData, options);
            })
            .catch(error => console.error('Error fetching data:', error));
    }
/* 날씨 api */

const body = document.querySelector('body');
const modal = document.querySelector('.modal');
const btnOpenPopup = document.querySelector('.btn-open-popup');

btnOpenPopup.addEventListener('click', () => {
  modal.classList.toggle('show');

  if (modal.classList.contains('show')) {
    body.style.overflow = 'hidden';
  }
});

modal.addEventListener('click', (event) => {
  if (event.target === modal) {
    modal.classList.toggle('show');

    if (!modal.classList.contains('show')) {
      body.style.overflow = 'auto';
    }
  }
});

//const API_KEY = '655d75bf4cead0113794155ab2cf9bd5';
//const API_ENDPOINT = `https://api.openweathermap.org/data/2.5/weather?lat=36.326758&lon=127.407796&appid=655d75bf4cead0113794155ab2cf9bd5&units=metric`;


let lat ;
let lon ;
const apiKey = '655d75bf4cead0113794155ab2cf9bd5';

$(document).ready(function () {
    // 위치 업데이트 함수 호출
    updateLocationAndWeather();

    // '업데이트' 버튼 클릭 시 위치 업데이트 및 날씨 정보 업데이트
    $('#weatherUpdate').click(function () {
        updateLocationAndWeather();
    });
});

function updateLocationAndWeather() {
    // 위치 업데이트 로직을 추가 (예: setInterval 등)

    // 임시로 위치 값을 설정
    lat = 36.326758;
    lon = 127.407796;

 	// 기존 날씨 정보 지우기
    $('.temp').empty();
    $('.icon').empty();
    $('.city').empty();
    $('.hum').empty();
    
    // 날씨 정보 업데이트
    getWeatherByCoordinates(lat, lon);
    weatherDetail(lat, lon);
}


function getWeatherByCoordinates(lat, lon) {
    
   	  // const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric`;
     const apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&appid='+apiKey+'&units=metric';

    $.ajax({
        url: apiUrl,
        dataType: 'json',
        type: 'GET',
        success: function (data) {
            //console.log(data);
            let currTemp = Math.round(data.main.temp) + '˚';
            let iconUrl = '<img src="http://openweathermap.org/img/wn/' + data.weather[0].icon + '.png" alt="' + data.weather[0].description + '" style="width: 150px; height: auto;" />';
            let cityName = data.name;
            let humidity = '습도: ' + data.main.humidity + '%';

            $('.temp').append(currTemp);
            $('.icon').html(iconUrl);
            $('.city').append(cityName);
            $('.hum').append(humidity);
        },
        error: function (error) {
            console.log(error);
            $('.temp').html('날씨 정보를 받아오지 못하였습니다.');
        }
    });
}

function weatherDetail(lat, lon) {
    //const apiKey = '655d75bf4cead0113794155ab2cf9bd5';
    const apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?lat='+lat+'&lon='+lon+'&appid='+apiKey+'&units=metric';
    
    $.ajax({
        url: apiUrl,
        dataType: 'json',
        type: 'GET',
        success: function (data) {
            console.log(data);

            const forecastList = data.list; // 날씨 정보 리스트
            const forecastContainer = $('.forecast-container'); // 예보를 표시할 컨테이너

            forecastContainer.empty(); // 컨테이너 비우기

            let currentGroup = null;

            forecastList.forEach(item => {
                const timestamp = item.dt * 1000;
                const date = new Date(timestamp);
                const time = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                const maxTemp = Math.round(item.main.temp_max) + '°';
                const minTemp = Math.round(item.main.temp_min) + '°';
                const weatherIcon = '<img src="http://openweathermap.org/img/wn/' + item.weather[0].icon + '.png" alt="' + item.weather[0].description + '"/>';
                const rainfall = item.rain ? item.rain['3h'] + 'mm' : '비 예보 없음';

                // 새로운 그룹이 시작되었을 때, 그룹 컨테이너를 추가하고 currentGroup을 업데이트
                if (currentGroup === null || currentGroup !== time) {
                    if (currentGroup !== null) {
                        forecastContainer.append('</div>'); // 기존 그룹 닫기
                    }
                    forecastContainer.append('<div class="forecast-group">'); // 새로운 그룹 열기
                    currentGroup = time;
                }

                // 현재 그룹에 해당 예보 정보 추가
                $('.forecast-group:last-child').append('<p><strong>' + time + '</strong></p>' +
                                            weatherIcon +
                                            '<p>' + maxTemp + '/' + minTemp +'</p>' +
                                            '<p>강수량: ' + rainfall + '</p>');
            });
            
            
        },
        error: function (error) {
            console.log(error);
            $('.temp').html('Error while fetching weather data.');
        }
    });
}    




const date = new Date();

const month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줘야 실제 월 값이 됩니다.
const dat = date.getDate();
const day = date.getDay();
let hours = date.getHours(); // 시
let minutes = date.getMinutes();  // 분

$('.weatherText').empty();

/**
* 24시간 형식을 12시간 형식으로 변환한다.
* validation 미구현
* 
* @params time {String} HH:MM 형식의 시간
* @params options {Object}
*			ampmLabel {Array} 오전, 오후 레이블. 기본 값은 [ '오전', '오후' ]
* @return {String} 24시간 형식의 HH:MM 시간 문자열
*/
function convert12H(time, options) {
    var _ampmLabel = (options && options.ampmLabel) || ['오전', '오후'];
    var _timeRegExFormat = /^([0-9]{2}):([0-9]{2})$/;
    
    var _timeToken = time.match(_timeRegExFormat);
    if (typeof _timeRegExFormat === 'undefine') {
        // 잘못된 형식
        return null;
    }
    
    var _intHours = parseInt(_timeToken[1]);
    var _intMinutes = parseInt(_timeToken[2]);
    var _strHours12H = ('0' + (_intHours == 12 ? 12 : _intHours % 12)).slice(-2);
    
    // 이전 내용 지우기
    $('.weatherText').empty();
    
    $('.weatherText').append('업데이트 ' + month + '/' + dat + ' ' + _ampmLabel[parseInt(_intHours / 12)]+ ' ' + hours + ':' + minutes);
}

console.log(convert12H('12:30'));
console.log(convert12H('11:30'));
console.log(convert12H('13:30'));
console.log(convert12H('00:30'));
console.log(convert12H('23:30'));

console.log(convert12H('00:30', {
    ampmLabel: ['AM', 'PM']
}));
console.log(convert12H('22:30', {
    ampmLabel: ['AM', 'PM']
}));


</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
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
