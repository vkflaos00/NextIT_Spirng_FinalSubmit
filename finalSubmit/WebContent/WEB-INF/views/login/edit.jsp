<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>수정</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="Free HTML Templates" name="keywords" />
<meta content="Free HTML Templates" name="description" />

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<body>
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<!-- 수정 폼 -->
<section class="page-section mt-5" id="contact">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-10 mb-5 mb-lg-0">
                <div class="col-lg-20 container d-flex justify-content-center">
                    <div class="card border-0">
                        <div class="card-header bg-secondary text-center p-5">
                            <h1 class="text-white m-0">수정</h1>
                        </div>
                        <div class="card-body rounded-bottom bg-primary p-5">
                            <form action="${pageContext.request.contextPath }/memberEditDo" method="post">
                                <!-- Id input (hidden) -->
                                <input type="hidden" name="id" value="${member.id}" />

                                <!-- 기존 비밀번호 입력 -->
                                <div class="form-group">
                                    <label for="pw">기존 비밀번호:</label>
                                    <input type="password" id="pw" name="pw" required />
                                </div>

                                <!-- 새로운 비밀번호 입력 -->
                                <div class="form-group">
                                    <label for="pwNew">새로운 비밀번호:</label>
                                    <input type="password" id="pwNew" name="pwNew" required />
                                </div>

                                <!-- 새로운 비밀번호 확인 입력 -->
                                <div class="form-group">
                                    <label for="pwCheck">새로운 비밀번호 확인:</label>
                                    <input type="password" id="pwCheck" name="pwCheck" required />
                                </div>
								<!-- Name input -->
                                <div class="form-group">
                                    <label for="name">이름:</label>
                                    <input type="text" id="name" name="name" value="${member.name}" required />
                                </div>
								<!-- Bir input -->
                                <div class="form-group">
                                    <label for="bir">생일:</label>
                                    <input type="text" id="bir" name="bir" value="${member.bir}" required />
                                </div>
                                <!-- 주소 검색 -->
                                <div class="form-group">
                                    <input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호"
                                        name="zip" id="zip" type="text" readonly="readonly" value="${member.zip}" />
                                    <button type="button" class="btn btn-default" onclick="execPostCode();">
                                        <i class="fa fa-search"></i> 우편번호 찾기
                                    </button>
                                </div>

                                <!-- Address input -->
                                <div class="form-group">
                                    <input class="form-control" id="add1" name="address1" type="text" readonly="readonly"
                                        placeholder="주소" required="required" value="${member.address1}" />
                                </div>

                                <!-- Detail Address input -->
                                <div class="form-group">
                                    <input class="form-control" id="add2" name="address2" type="text"
                                        placeholder="상세주소" required="required" value="${member.address2}" />
                                </div>

                                <!-- Hp input -->
                                <div class="form-group">
                                    <label for="hp">핸드폰 번호</label>
                                    <input class="form-control" id="hp" name="hp" type="text" required value="${member.hp}" />
                                </div>

                                <!-- Email input -->
                                <div class="form-group">
                                    <label for="mail">E-mail:</label>
                                    <input class="form-control" id="mail" name="mail" type="text" placeholder="E-mail" required
                                        value="${member.mail}" />
                                    <!-- E-mail 인증 버튼 -->
                                    <button type="button" id="mailAuth">E-mail 인증</button>
                                </div>

                                <!-- 저장하기 버튼 -->
                                <div>
                                    <button class="btn btn-secondary btn-block border-0 py-3" id="submitButton" type="submit">저장하기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

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

		function join() {
			console.log("regist");

			let id = $('#id').val();
			console.log("id:", id);

			// 아이디 중복 체크를 먼저 수행
			fn_checkId();
			if (idCheck) {
				$("#loginForm").submit();
			}
		}
	</script>
</body>
</html>