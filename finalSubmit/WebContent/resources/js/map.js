var markers = [];
var mapContainer = document.getElementById('map');
var mapOption = {
	center : new kakao.maps.LatLng(36.326758, 127.407796),
	level : 1,
};
var map = new kakao.maps.Map(mapContainer, mapOption);
var roadviewVisible = false;

var ps = new kakao.maps.services.Places();
var infowindow = new kakao.maps.InfoWindow({
	zIndex : 1
});



ps.keywordSearch('대전 중구 오류동 편의점', placesSearchCB);


$(function() {
    getCurrentRoadview(); // 페이지 로딩 시 360 로드뷰 생성
    $("#search").on('click', function() {
      search($("#searchValue").val());
    });
  });

function search(place) {
	console.log("place: " + place);
	if (!place.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	}
	ps.keywordSearch(place + "편의점", placesSearchCB);
}

var rvContainer = document.getElementById('roadview'); // 로드뷰를 표시할 div
var rv = new kakao.maps.Roadview(rvContainer); // 로드뷰 객체
var rvClient = new kakao.maps.RoadviewClient(); // 좌표로부터 로드뷰 파노ID를 가져올 로드뷰
												// helper객체


// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
		// 정상적으로 검색이 완료됐으면
		// 검색 목록과 마커를 표출합니다
		// console.log(data);
		displayPlaces(data);

		// 페이지 번호를 표출합니다
		displayPagination(pagination);

	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		alert('검색 결과가 존재하지 않습니다.');
		return;

	} else if (status === kakao.maps.services.Status.ERROR) {

		alert('검색 결과 중 오류가 발생했습니다.');
		return;

	}
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다

function displayInfowindow(marker, title, places) {
	title_img = title.substr(0,2);
	GS = "GS";
	SEVEN = "세븐";
	CU = "CU";
	console.log(places);
	for (var i = 0; i < places.length; i++) {
		var place_name = places[i].place_name;
		if (title === place_name) {
			address_name = places[i].address_name;
			road_address_name = places[i].road_address_name;
			place_url = places[i].place_url;
			id = places[i].id;
			getCurrentRoadview(places[i].x, places[i].y);
			break;
		}
	}
	// console.log("--편의점 전체 데이터 값", address_name, road_address_name);

	var content = '<div class="info" style="width:300px">'
			+ '        <div class="title">'
			+ title
			+ '            <div class="close" onclick="closeOverlay()" title="닫기"></div>'
			+ '        </div>'
			+ '        <div class="body">'
			+ '            <div class="img">';
	
	if (title_img === 'GS') {
		  content += '<img src="img/about/gs25.png" width="73" height="70">';
		} else if (title_img === 'CU') {
		  content += '<img src="img/about/cu.png" width="73" height="70">';
		} else if (title_img === '세븐') {
		  content += '<img src="img/about/7-11.png" width="73" height="70">';
		} else {
		  content += '<img src="img/about/other.png" width="73" height="70">';
		}
		  
		content += '	  </div>'
		  + '        <div class="desc">'
		  + '            <div class="ellipsis">'
		  + road_address_name
		  + '			 </div>'
		  + '         	 <div class="jibun ellipsis">'
		  + address_name
		  + '			 </div>'
		  + '            <div class="footer">'
		    + '        <div><a href="' + place_url + '" target="_blank" class="link">홈페이지</a></div>'
		    + '        <div><a href="#" class="link" onclick="openKakaoMap(\'' + id + '\')">길찾기</a></div>'
		    + '      </div>'
		    + '    </div>'
		    + '  </div>';

		 


	infowindow.setContent(content);
	infowindow.open(map, marker);
}

function openKakaoMap(destination) {
	event.preventDefault();
	
    var kakaoMapUrl = 'https://map.kakao.com/link/to/' + id;
    window.open(kakaoMapUrl, '_blank');
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

	var listEl = document.getElementById('placesList'), menuEl = document
			.getElementById('menu_wrap'), fragment = document
			.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

	// 검색 결과 목록에 추가된 항목들을 제거합니다
	removeAllChildNods(listEl);

	// 지도에 표시되고 있는 마커를 제거합니다
	removeMarker();
	
	// 출발지의 위치 (예시로 대전 중앙동의 좌표를 사용)
	  var startLat = 36.326758;
	  var startLng = 127.407796;
	  
	// 사용자의 현재 위치를 얻어옵니다.
	  getCurrentLocation();
	  
	  // 편의점 목록을 거리가 짧은 순으로 정렬
	  places.sort(function(a, b) {
	    const lat1 = startLat;
	    const lon1 = startLng;
	    const lat2 = a.y; // 편의점의 위도
	    const lon2 = a.x; // 편의점의 경도
	    // console.log(a.x, a.y);
	    const distanceA = calculateDistance(lat1, lon1, lat2, lon2);

	    const lat3 = startLat;
	    const lon3 = startLng;
	    const lat4 = b.y; // 편의점의 위도
	    const lon4 = b.x; // 편의점의 경도

	    const distanceB = calculateDistance(lat3, lon3, lat4, lon4);

	    return distanceA - distanceB;
	  });

	for (var i = 0; i < places.length; i++) {

		// 마커를 생성하고 지도에 표시합니다
		var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(
				placePosition, i), itemEl = getListItem(i, places[i]); // 검색 결과
		// 항목
		// Element를
		// 생성합니다
		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가합니다
		bounds.extend(placePosition);

		// 마커와 검색결과 항목에 mouseover 했을때
		// 해당 장소에 인포윈도우에 장소명을 표시합니다
		// mouse out 했을 때는 인포윈도우를 닫습니다
		(function(marker, title) {
			// console.log(title);

			// 마커에 마우스를 올렸을 때 인포윈도우가 노출
			kakao.maps.event.addListener(marker, 'click', function() {
				displayInfowindow(marker, title, places);
			});

			// 리스트 마우스 올리면 인포윈도우 표시
			itemEl.onclick = function() {
				displayInfowindow(marker, title, places);
			};

		})(marker, places[i].place_name);

		fragment.appendChild(itemEl);
	}

	// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

	var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
			+ (index + 1)
			+ '"></span>'
			+ '<div class="info">'
			+ '   <h5>'
			+ places.place_name + '</h5>';

	if (places.road_address_name) {
		itemStr += '    <span>' + places.road_address_name + '</span>'
				+ '   <span class="jibun gray">' + places.address_name
				+ '</span>';
	} else {
		itemStr += '    <span>' + places.address_name + '</span>';
	}

	itemStr += '  <span class="tel">' + places.phone + '</span>' + '</div>';

	el.innerHTML = itemStr;
	el.className = 'item';

	return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커
	// 이미지
	// url,
	// 스프라이트
	// 이미지를
	// 씁니다
	imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
	imgOptions = {
		spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지
		// 중 사용할 영역의
		// 좌상단 좌표
		offset : new kakao.maps.Point(13, 37)
	// 마커 좌표에 일치시킬 이미지 내에서의 좌표
	}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions), marker = new kakao.maps.Marker(
			{
				position : position, // 마커의 위치
				image : markerImage
			});
	
	marker.setMap(map); // 지도 위에 마커를 표출합니다
	markers.push(marker); // 배열에 생성된 마커를 추가합니다

	return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
	var paginationEl = document.getElementById('pagination'), fragment = document
			.createDocumentFragment(), i;

	// 기존에 추가된 페이지번호를 삭제합니다
	while (paginationEl.hasChildNodes()) {
		paginationEl.removeChild(paginationEl.lastChild);
	}

	// pagination 출력
	for (i = 1; i <= pagination.last; i++) {
		var el = document.createElement('a');
		el.href = "#";
		el.innerHTML = i;

		if (i === pagination.current) {
			el.className = 'on';
		} else {
			el.onclick = (function(i) {
				return function() {
					event.preventDefault(); // 기본 클릭 동작을 막습니다.
					pagination.gotoPage(i);
				}
			})(i);
		}

		fragment.appendChild(el);
	}
	paginationEl.appendChild(fragment);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.lastChild);
	}
}

// 두 지점 간의 거리 계산 함수 (단위: 미터)
function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371; // 지구 반지름 (단위: km)
  const dLat = deg2rad(lat2 - lat1);
  const dLon = deg2rad(lon2 - lon1);
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c * 1000; // km to meter

  return distance;
}

// 각도를 라디안으로 변환하는 함수
function deg2rad(deg) {
  return deg * (Math.PI / 180);
}

function getCurrentLocation() {
	  if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(showPosition);
	  } else {
	    console.log("Geolocation is not supported by this browser.");
	  }
	}

// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수
function setMapType(maptype) { 
    var roadmapControl = document.getElementById('btnRoadmap');
    var skyviewControl = document.getElementById('btnSkyview'); 
    if (maptype === 'roadmap') {
        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
        roadmapControl.className = 'selected_btn';
        skyviewControl.className = 'nonselected_btn';
    } else if(maptype === 'skyview'){
        map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
        skyviewControl.className = 'selected_btn';
        roadmapControl.className = 'nonselected_btn';
    } else if(maptype === 'roadview'){
    	toggleRoadmapview();
    }
}

function toggleRoadmapview() {
    if (roadviewVisible) {
        // 로드뷰를 닫고 지도로 변경
    	map.removeOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);
    } else {
        // 로드뷰 표시
    	map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);    
    	
    }
    
    roadviewVisible = !roadviewVisible; // Toggle the state
}


// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}

function showPosition(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    console.log("위도: " + latitude + ", 경도: " + longitude);

    // 위치 정보를 얻은 후, startLat와 startLng 값을 업데이트
    startLat = latitude;
    startLng = longitude;

    // 업데이트 된 좌표 값을 확인
    console.log("새로운 출발지 좌표 - 위도: " + startLat + ", 경도: " + startLng);
}

// 로드뷰 생성 함수
function toggleRoadview(position) {
  rvClient.getNearestPanoId(position, 50, function(panoId) {
	if(panoId==null){
		alert("로드뷰 정보가 없는 지역입니다.");
		return;
	}else{
    rv.setPanoId(panoId, position); // 로드뷰 위치를 특정 좌표로 설정
// rv.setVisible(true); // 로드뷰 보이도록 설정
	}
  });
}

// 현재 위치로 로드뷰 생성
function getCurrentRoadview(x,y) {
      var latitude = 36.326758;
      var longitude = 127.407796;
      if(x != null || y != null){
    	  latitude = y;
    	  longitude = x;  
      }
      var currentPosition = new kakao.maps.LatLng(latitude, longitude);
      toggleRoadview(currentPosition);
 
}



