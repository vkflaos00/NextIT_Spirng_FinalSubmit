<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>회원가입</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />
<style type="text/css">
span{
	color: red;
	text-align: left;
}

.profile_image{
	width: 400px; 
	height: 400px; 
	background-color: rgb(11, 220, 235);
	position: absolute;
	left: 600px;
}
 
.upload {
	width: 400px;
	height: 400px;

}
li {
  list-style: none;
}
.profile_image img{
  width: 300px;
  height: 300px;
}
.image-preview {
	width: 300;
	height: 300px;
	position: absolute;
	top: 50%;
	left: 35%;
	transform: translate(-40%, -50%);
}
.profile_image input{
	width: 200px;
	margin-top: 15px;
}



</style>
<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
	
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<body>
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- 회원가입 폼 -->
	<section class="page-section mt-5" id="contact">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-6">
					<div class="card border-0 shadow-lg">
						<div class="card-header bg-secondary text-center p-5">
							<h1 class="text-white m-0">회원가입</h1>
						</div>
						<form:form name="loginForm" 
							enctype="multipart/form-data" id="contactForm"
							action="${pageContext.request.contextPath}/registDo"
							method="POST" modelAttribute="member">
							<div class="profile_image">
								<div class="upload">
									<!-- 사진이 보여줄 위치 -->
								</div>
								<input type="file" class="real-upload" name="profilePhoto"
									accept="image/*">
								<ul class="image-preview"></ul>
							</div>
							<div class="card-body bg-primary rounded-bottom py-4">
								<!-- Id input -->
								<div class="form-group">
									<div class="form-group" display="flex">
										<label for="id" class="mt-2">아이디</label>
										<button type="button" id="check_Id" name="idCheck"
											onclick="fn_checkId()" class="btn btn-secondary btn-sm mt-2 float-right">ID
											중복 확인</button>
										<form:errors path="id" />
									</div>
									<form:input path="id" class="form-control" id="id" type="text"
										placeholder="아이디" required="required" autocomplete="off" />
									<form:errors path="id" />
								</div>
								<!-- Pw input -->
								<div class="form-group">
									<label for="pw">비밀번호</label>
									<form:input path="pw" class="form-control" id="pw" name="pw"
										type="password" placeholder="비밀번호" required="required"
										autocomplete="off" />
									<form:errors path="pw" />
								</div>
								<!-- Pw Check input -->
								<div class="form-group">
									<label for="pwCheck">비밀번호 확인</label> <input
										class="form-control" id="pwCheck" name="pwCheck"
										type="password" value="" placeholder="비밀번호 확인"
										required="required" autocomplete="off" />
								</div>
								<!-- Name input -->
								<div class="form-group">
									<label for="name">이름</label>
									<form:input path="name" class="form-control" id="name"
										name="name" type="text" placeholder="이름" required="required" />
									<form:errors path="name" />
								</div>
								<!-- Birth input -->
								<div class="form-group">
									<label for="bir">생일</label>
									<form:input class="form-control" id="bir" path="bir"
										type="date" placeholder="생일" required="required" />
									<form:errors path="bir" />
								</div>
								<!-- Address input -->
								<div class="form-group">
									<input class="form-control" style="width: 40%;"
										placeholder="우편번호" name="zip" id="zip" type="text"
										readonly="readonly">
									<button type="button"
										class="btn btn-secondary btn-sm mt-2 float-right"
										onclick="execPostCode();">
										<i class="fa fa-search"></i>우편번호 찾기
									</button>
								</div>
								<!-- Address1 input -->
								<div class="form-group">
									<label for="add1">주소</label>
									<form:input class="form-control" id="add1" path="address1"
										readonly="readonly" placeholder="주소" required="required" />
									<form:errors path="address1" />
								</div>
								<!-- Address2 input -->
								<div class="form-group">
									<label for="add2">상세주소</label>
									<form:input class="form-control" id="add2" path="address2"
										type="text" placeholder="상세주소" required="required" />
									<form:errors path="address2" />
								</div>
								<!-- Hp input -->
								<div class="form-group">
									<label for="hp">핸드폰번호</label>
									<form:input path="hp" class="form-control" id="hp" name="hp"
										type="tel" placeholder="핸드폰 번호" />
									<form:errors path="hp" />
								</div>
								<!-- Email input -->
								<div class="form-group">
									<label for="mail">E-mail</label>
									<button type="button" id="check_Mail" name="mailCheck"
										onclick="fn_checkMail()"
										class="btn btn-secondary btn-sm mt-2 float-right">메일
										중복 확인</button>
									<form:input path="mail" class="form-control" id="mail"
										name="mail" type="text" placeholder="E-mail" />
									<form:errors path="mail" />
									<button type="button" id="mailAuth"
										class="btn btn-secondary btn-sm mt-2 float-right">E-mail
										인증</button>
								</div>
								<div class="text-center">
									<button class="btn btn-secondary mt-5 btn-block border-0 py-3"
										id="submitButton" onclick="submit">가입하기</button>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	function getImageFiles(e) {
		const files = e.currentTarget.files;
		const imagePreview = document.querySelector('.image-preview');
		const file = files[0];
		const reader = new FileReader();
		reader.onload = function(e){
			const preview = createElement(e, file);
			let imageLiTag = document.querySelector('.image-preview > li');
			if(imageLiTag) {
				imagePreview.removeChild(imagePreview.firstElementChild);
			}
			imagePreview.appendChild(preview);
			
		};
		reader.readAsDataURL(file);
	}
	
	function createElement(e, file) {
		const li = document.createElement('li');
		const img = document.createElement('img');
		img.setAttribute('src', e.target.result); // img.setAttribute('src', reader.result);
		img.setAttribute('data-file', file.name);
		li.appendChild(img);
		return li;
	}
	
	const realUpload = document.querySelector('.real-upload');
	const upload = document.querySelector('.upload');
	
	upload.addEventListener('click', function(e){
		realUpload.click();
	});
	
	realUpload.addEventListener('change', getImageFiles);
	console.log("성공");
</script>

<script type="text/javascript">
function fn_checkMail() {
    let mailCheck = $("#mail").val(); // 이 부분은 입력된 이메일 값을 가져오는 것입니다.
    let url = "<c:url value='/regist/mailCheck'/>"; // 이 부분은 Spring의 태그 라이브러리를 사용하여 URL을 생성하는 것입니다.
    let data = {
        "mail": mailCheck
    };

    // AJAX 요청을 보내는 부분입니다.
    $.ajax({
        url: url, // 위에서 생성한 URL을 사용합니다.
        type: "post", // POST 요청 방식을 사용합니다.
        data: data, // 위에서 생성한 데이터를 전송합니다. 이 데이터는 서버로 보내서 중복 체크를 하게 됩니다.
        async: false, // 비동기적으로 실행하지 않도록 설정합니다. (동기적 실행)
        success: function (data) { // 요청이 성공적으로 처리되면 호출되는 함수입니다.
            console.log("data:", data); // 서버로부터 받은 데이터를 콘솔에 출력합니다.
            if (data) { // 서버로부터 받은 데이터가 true인 경우
                alert("너만 쓰고있네?");
                mailCheck = true; // mailCheck 변수를 true로 설정합니다.
            } else { // 서버로부터 받은 데이터가 false인 경우
                $("#mail").val(""); // 이메일 입력 필드를 비웁니다.
                alert("동작그만");
                mailCheck = false; // mailCheck 변수를 false로 설정합니다.
            }
        },
        error: function () { // 요청이 실패한 경우 호출되는 함수입니다.
            alert("오류발생");
            mailCheck = false; // mailCheck 변수를 false로 설정합니다.
        }
    });
}
</script>
	<script type="text/javascript">
	let mail = $("#mail");
	$("#mailAuth").on("click", function(){
		$.ajax({
			  url:"<c:url value='/regist/mailAuth'/>"
			, type: "post"
			, data:{"mail" : mail.val()}
			, success:function(data){
				console.log("data :", data);
				console.log("mail:", mail.val());
				let popupWidth = 600;
				let popupHeight = 150;
				let winWidth = document.body.offsetWidth;
				let winHeight = document.body.offsetHeight;
				let popupX = (winWidth/2) - (popupWidth/2);
				let popupY = (winHeight/2) - (popupHeight/2);
				
				if(data){
					let myWin = window.open("<c:url value='/regist/mailWindow'/>"
						, "mywin"
						, "left="+popupX+"px, "
						+"top=" + popupY+"px, "
						+"width="+popupWidth+"px, "
						+"height="+popupHeight+"px");
				}else{
					alert("메일 발송도중 오류발생");
				}
			}  
			,error:function(){
				alert("error");
			}
			,beforeSend:function(){
				let width = 150;
				let height = 150;
				let top = 50;
				let left = 50;
				$('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' 
					+ top + '%; left:'
					+ left + 'px; height:'
					+ width + 'px; z-index:9999;'
					+ 'background:transparent;'
					+ 'filter:alpha(opacity=50);'
					+ 'opacity:alpha*0.5;' 
					+ 'margin: auto; ' 
					+ 'padding:0; ">'
					+ '<img src="<c:url value = '/img/login/ing2.gif'/>"'
					+ 'style="width:300px; height:300px;"></div>');
			}
			,complete:function(){
				$("#div_ajax_load_image").remove();
			}
		});
		
	});
	
	</script>
	<!-- 모든 페이지 하단에 포함되는 부분 -->
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
	<script>
	function execPostCode() {
        new daum.Postcode({
            oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               console.log(data.zonecode);
               console.log(fullRoadAddr);
               
               
               $("[name=zip]").val(data.zonecode);
               $("[name=address1]").val(fullRoadAddr);
               
               /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
               document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
           }
        }).open();
    }
		let idCheck = "true";
		function fn_checkId() {
			let id = $('#id').val();
			let url = "<c:url value='/login/idCheck' />";
			let data = {
				"id" : id
			};

			$.ajax({
				url : url,
				type : "post",
				data : data,
				async : false,
				success : function(data) {
					console.log("data:", data);
					if (data) {
						alert("당신만의 소중한 고유 ID");
						idCheck = true;
					} else {
						$('#id').val("");
						alert("센스없는 당신 누가 쓰고있지롱~~");
						idCheck = false;
					}
				},
				error : function() {
					alert("오류가 발생했습니다.");
					idCheck = false;
				}
			});
		}

			
			/* function fn_join() {
			console.log("regist");

			let id = $('#id').val();
			console.log("id:", id);
			
			let mailaddress = $('#mail').val();
			console.log("mailaddress:", mailaddress);

			// 아이디 중복 체크를 먼저 수행
			fn_checkId();
			if (idCheck) {
				$("#loginForm").submit(); 
				console.log("idCheck");

			
			// 메일중복체크를 먼저수행
			fn_checkMail();
			if (mailCheckObj.value) {
				$("#loginForm").submit(); 
			}
			 
		}} */
		
	</script>
</body>
</html>