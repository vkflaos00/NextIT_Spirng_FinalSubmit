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
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Favicon -->
<link href="${pageContext.request.contextPath }/img/favicon.ico"
	rel="icon" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function fn_detailView(itemNo) {
		// console.log("itemNo" + itemNo);
		
		const urlParams = new URLSearchParams(window.location.search);
		// Get values of searchStore, searchEvent, searchWord, searchCategory, curPage, and rowSizePerPage from the query parameters
		let ss = urlParams.get("searchStore");
		let se = urlParams.get("searchEvent");
		let sw = urlParams.get("searchWord");
		let sc = urlParams.get("searchCategory");
		let cp = urlParams.get("curPage");
		let rpp = urlParams.get("rowSizePerPage");

		// console.log("ss:", ss, "se:", se, "sw:", sw, "sc:", sc, "cp:", cp, "rpp:", rpp);

		// Your existing code for navigating to the productDetailView with the extracted query parameters
		location.href = "${pageContext.request.contextPath}/product/productDetailView?itemNo=" + itemNo + "&searchStore=" + ss + "&searchEvent=" + se + "&searchWord=" + sw + "&searchCategory=" + sc + "&curPage=" + cp + "&rowSizePerPage=" + rpp;
	}
	
</script>
</head>
<body>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>
<!-- 	<div class="container-fluid bg-primary px-0 px-md-5 mb-5">
		<div class="row align-items-center px-3">
			<div class="col-lg-6 text-center text-lg-left">
				<h4 class="text-white mb-4 mt-5 mt-lg-0">Conv</h4>
				<h1 class="display-3 font-weight-bold text-white">Convenience
					store information site for convenience</h1>
				<p class="text-white mb-4">CU는 1+1인데 GS는 왜 행사 안해! 불편한 니들을 구제해주러
					왔도다. 우리 Conv만 확인해봐. 확 편해질 껄?</p>
				<a href="#product" class="btn btn-secondary mt-1 py-3 px-5">함 보자</a>
			</div>
			<div class="col-lg-6 text-center text-lg-right">
				<img class="img-fluid mt-5" src="img/Inconvenience.jpeg" alt="" />
			</div>
		</div>
	</div> -->
	<!-- Facilities Start -->
	<div class="container-fluid py-5"
		<%-- style="background-image: url('${pageContext.request.contextPath}/img/inside2.jpeg');" --%> id="product">
		<div class="container pb-3">
			<div class="row">
				<div class="col-md-12 pb-1">
					<div class="mt-3">
						<div>
							<h1	class="h1-sub">
								<strong>${product.storeType } 행사상품</strong>
							</h1>
						</div>
					</div>
					<div class="card border mt-2 mb-2">
						<div class="card-header text-black px-2 py-1">
							<small class="float-left font-weight-bold">${product.storeType }</small>
							<small class="float-right font-weight-bold">${product.itemCategory}</small>
							<small class="float-right text-black mr-3"><i
								class="fa fa-sync-alt"></i>
								${fn:substring(product.updateDate,0,10)}</small>
						</div>
						<div class="card-body px-2 py-2">
							<div class="prod_img_div float-center text-center mr-2">
								<img onerror="this.style.display='none';"
									src="${product.imagePath }" class="prod_img"
									style="width: 450px; height: 450px;">
								<div class="float-right">
									<a href="#" class="btn btn-primary btn-sm" id="chat">
									<%-- <a href="#" class="btn btn-primary btn-sm" id="chat" onclick="goToChat('${product.itemNo}')"> --%>
									<!-- <a href="#" class="btn btn-primary btn-sm" onclick="goToChat()"> -->
  										<i class="fa fa-comments"></i> 채팅방으로 가기
  									</a>	
								</div>
							</div>
							<button id="zzim" class="btn btn-danger btn-wishlist" onclick="fn_zzim('${product.itemNo}')">
								<i class="bi-heart"></i> <span id="wishlistText">찜하기</span>
							</button>
							<div class="float-right">
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
					<div class="mt-3">
						<div>
							<h1	class="h1-sub">
								<strong>유사 상품</strong>
							</h1>
						</div>
					</div>
					<div class="row">
						<c:forEach items="${similarList }" var="similar">
							<div class="col-md-6 pb-1" onclick="fn_detailView('${similar.itemNo}')">
								<a href="#" class="deco-none" >
									 <div class="card border mt-2 mb-2">
										<div class="card-header text-black px-2 py-1">
											<small class="float-left font-weight-bold">${similar.storeType }</small>
											<small class="float-right font-weight-bold">${similar.itemCategory}</small>
											<small class="float-right text-black mr-3"><i class="fa fa-sync-alt"></i> ${fn:substring(similar.updateDate,0,10)}</small>
										</div>
										<div class="card-body px-2 py-2">
											<div class="prod_img_div float-left text-center mr-2">
												<img onerror="this.style.display='none';" src="${similar.imagePath }" class="prod_img" style="width: 150px; height: 150px;">
											</div>
											<div>
												<strong>${similar.itemName}</strong>
												<br>
												<i class="fa fa-coins text-warning pr-1"></i> <fmt:formatNumber value="${similar.itemPrice}" pattern="#,###"/>원
													<c:choose>
														<c:when test="${similar.storeEvent eq '1+1'}">
															<span class="text-muted small">(<fmt:formatNumber value="${similar.itemPrice / 2}" pattern="#,###"/>원)</span>
														</c:when>
														<c:when test="${similar.storeEvent eq '2+1'}">
															<span class="text-muted small">(<fmt:formatNumber value="${(similar.itemPrice * 2) / 3}" pattern="#,###"/>원)</span>
														</c:when>
														<c:when test="${similar.storeEvent eq '3+1'}">
															<span class="text-muted small">(<fmt:formatNumber value="${(similar.itemPrice * 3) / 4}" pattern="#,###"/>원)</span>
														</c:when>
														<c:otherwise>
															<span class="text-muted small">(<fmt:formatNumber value="${(similar.itemPrice * 4) / 5}" pattern="#,###"/>원)</span>
														</c:otherwise>
													</c:choose>
												</span>
												<br>
												<span class="badge bg-cu text-black">${similar.storeEvent }</span>
											</div>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
					<div class="row mt-3">
						<div class="col-5">
							<h2 class="h1-sub mb-0">
								<strong> <i class="fa fa-comment-dots"> </i> 댓글
								</strong>
							</h2>
						</div>
					</div>
					<div id="reply_list_div">
					</div>
			        <div class="card border-cu mt-2 mb-3" id="noComment">
			            <div class="card-header text-white px-2 py-0" style="background-color: violet;">
			                <small> <i class="fa fa-exclamation-circle"> </i> No comments</small>
			            </div>
			            <div class="card-body px-2 py-2">
			                <div>첫 댓글을 남겨주세요.</div>
			            </div>
			        </div>
					<c:choose>
						<c:when test="${sessionScope.login != null}">
							<form class="mt-2 mb-3" method="post" name="reply_form" novalidate>
								<input type="hidden" name="replyCate" value="PRODUCT">
				                <input type="hidden" name="replyParentno" value="${product.itemNo}">    
				                <input type="hidden" name="replyMemId" value="${login.id }">
								<div class="form-group">
									<textarea name="replyContent" rows="3" cols="40" placeholder="다른 사람들을 위해 상품 소개/평가를 해주세요." class="form-control" required id="id_content"></textarea>
									<small class="form-text text-muted"> 최대 100자</small>
								</div>
								<button type="submit" class="btn btn-primary btn-block" name="master_comment_button" id="reply_regist">등록</button>
							</form>
						</c:when>
						<c:otherwise>
							<div class="alert alert-info text-center" role="alert">
								<i class="fa fa-info-circle"> </i> 로그인 후 댓글을 남길 수 있습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<!-- Facilities Start -->
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<script type="text/javascript">
		function fn_reply_list(curPage) {
		    let url = "<c:url value='/reply/replyList' />";
		    $.ajax({
		        url: url,
		        data: {
		            "replyCate": "PRODUCT",
		            "replyParentno": "${product.itemNo}",
		            "curPage": curPage
		        },
		        success: function (response) {
		            if (response.trim().indexOf('<small') === -1) {
		                $("#reply_list_div").hide();   // 댓글이 없을 경우, 해당 div를 숨김
		                $("#noComment").show();
		                // console.log(response.trim());
		            } else {
		            	// console.log(response.trim());
		                $("#noComment").hide(); // 댓글이 있을 경우, 해당 div를 숨김
		                $("#reply_list_div").show(); // 댓글이 있을 경우, 해당 div를 보여줌
		                $("#reply_list_div").html(response); // 댓글이 있을 경우, 해당 부분을 업데이트
		            }
		        },
		        error: function () {
		            alert("error");
		        }
		    });
		}
	
	
		$(function(){
			fn_reply_list();
			getZzim();
			
			$("#reply_regist").on("click", function(e){
				e.preventDefault();
				
				let replyForm = $("form[name='reply_form']");
				// console.log("replyForm.serialize()", replyForm.serialize());
				$.ajax({
					url:"<c:url value='/reply/replyRegister' />"
					,type:"post"
					,data: replyForm.serialize()
					,success: function() {
						$("textarea[name='replyContent']").val("");
						
						$("#reply_list_div").html("");
						fn_reply_list();
					}
					,error:function(){
						alert("error");
					}
				});
			});
			
			$("#reply_list_div").on("click", "button[name='btn_reply_delete']", function(e){
				alert("삭제버튼");
				let replyNo = $(this).closest(".replyList_row").data("replyno");
				alert("replyNo: "+ replyNo);
				
				let replyMemId = "${login.id}";
				alert("replyMemId:"+replyMemId);
				let param = {"replyNo": replyNo, "replyMemId": replyMemId};
				console.log(param);
				
				let ret = confirm("댓글을 정말 삭제하시겠습니까?");
				if(ret){
					$.ajax({
						url:"<c:url value='/reply/replyDelete' />"
						,type: "post"
						,data: param
						,success: function(data){
							// alert("success");
							console.log("data: ", data);
							console.log("data.result: ", data.result);
							if(data.result){
								alert("댓글이 삭제 되었습니다.");
								$("#reply_list_div").html("");
								fn_reply_list();
							}else{
								alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
								$("#reply_list_div").html("");
								fn_reply_list();
							}
						}
						,error:function(){
							alert("error");
							alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
						}
					});
				}
			});
			
			//수정 버튼 클릭하면  저장, 취소 버튼 변경 하고 사용자가 댓글 수정할수 있게 변경하기
			let temp_content ="";
			$("#reply_list_div").on('click', 'button[name="btn_reply_edit"]', function(e){   
			
				let replyNo = $(this).closest(".replyList_row").data('replyno');  
				console.log("replyNo : ", replyNo);
				
				let replyMemId = "${login.id }";  
				console.log("replyMemId : ", replyMemId);
				
				let ret = confirm("댓글을 수정 하시겠습니까?");
				if(ret){
					
					let reply_content = $(this).closest(".card-body").find(".reply_content");
				    temp_content = reply_content.text().trim();
				    console.log("temp_content: ", temp_content);
		 			/* let reply_button = $(this).parent();
		 			console.log("reply_button:"+reply_button);
		 			let reply_content = reply_button.prev();
		 			console.log("reply_content:"+ reply_content);
					
		 			temp_content = reply_content.find("span").text();
		 			console.log("temp_content", temp_content); */
		 			
		 			reply_content.html("");
		 			
		 			let str1 = '';
		 			str1 += '<form name="reply_update" method="post"> ';
					str1 += '	<input type="hidden" name="replyCate" value="PRODUCT"> ';
				 	str1 += '	<input type="hidden" name="replyNo" value=""> ';  
				 	str1 += '	<input type="hidden" name="replyMemId" value=""> ';  
					str1 += '	<div> ';
					str1 += '		<textarea name="replyContent" rows="3" cols="40">'+temp_content+'</textarea> ';
					str1 += '	</div>';
		 			str1 += '</form>';
		 			
					reply_content.append(str1);
		 			
					let reply_button = $(this).parent();
					
					reply_button.html("")
					let str2 = '';
					str2 += '<button type="button" name="btn_reply_update" class="btn btn-success btn-sm btn_update"><i class="far fa-edit"></i>저장</button>';
					str2 += '<button type="button" name="btn_reply_cancel" class="btn btn-secondary btn-sm btn_cancel"><i class="far fa-times"></i>취소</button>';
					reply_button.append(str2);
					
				}
			});
			
			//취소버튼을 클릭하면 이전 상태로 변경하기
			$("#reply_list_div").on('click', 'button[name="btn_reply_cancel"]', function(e){  
				
				let replyNo = $(this).closest(".replyList_row").data('replyno');
				console.log("replyNo : ", replyNo);
				
				let replyMemId = "${login.id }";  
				console.log("replyMemId : ", replyMemId);
				
				let ret = confirm("댓글을 취소 하시겠습니까?");
				if(ret){
					let reply_content = $(this).closest(".card-body").find(".reply_content");
				    temp_content = reply_content.text().trim();
				    console.log("temp_content: ", temp_content);
		 			/* let reply_button = $(this).parent()
		 			let reply_content = reply_button.next();
		 			console.log(reply_content);
	
		 			console.log("temp_content", temp_content); */
		 			
		 			reply_content.html("");
		 			
		 			let str1 = '';
					str1 += temp_content;
		 			
					reply_content.append(str1);
		 			
					let reply_button = $(this).parent();
					
					reply_button.html("")
					let str2 = '';
					str2 += '<button type="button" name="btn_reply_edit" class="btn btn-success btn-sm btn_edit"><i class="far fa-edit"></i>수정</button>';
					str2 += '<button type="button" name="btn_reply_delete" class="btn btn-danger btn-sm btn_delete"><i class="far fa-trash-alt"></i>삭제</button>';
					reply_button.append(str2);
					
				}
			});
			
			//댓글을 수정한 후 저장 버튼을 클릭하면 수정한 내용 저장하기 
			$("#reply_list_div").on('click', 'button[name="btn_reply_update"]', function(e){ 
				
				let replyListRow = $(this).closest(".replyList_row")
				let replyNo = replyListRow.data('replyno');
				console.log("replyNo", replyNo);
				
				let replyUpdate = replyListRow.find("form[name='reply_update']");
				replyUpdate.find("input[name='replyNo']").val(replyNo);
				
				let replyMemId = $("form[name='reply_form']").find("input[name='replyMemId']").val();		
				replyUpdate.find("input[name='replyMemId']").val(replyMemId);
				
				console.log("replyUpdate.serialize(): ", replyUpdate.serialize());
	
			 	$.ajax({
					url:"<c:url value='/reply/replyUpdate'/>"  
					,type:"post"
					,data: replyUpdate.serialize()
					,success: function(data){
						console.log("btn_reply_update success");
					 	
						if(data.result){
							alert("댓글이 수정 되었습니다.");
							$("#reply_list_div").html("");
							fn_reply_list();
						}else{
							alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
							$("#reply_list_div").html("");
							fn_reply_list();
						}
					}
					,error: function(err){
						console.log("err.status : ", err.status);
						alert("댓글 수정에 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
					}
				});
			});
			
			
			
		});
	
		function fn_paging(curPage) {
			// alert("curPage:"+ curPage);
			
			$("#reply_list_div").html("");
			fn_reply_list(curPage);
		}
	
		
		function fn_zzim(itemNo) {
			if(${login == null}) {
				let ret = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?");
				if(ret) {
					location.href="${pageContext.request.contextPath}/login";
				}else {
					fn_detailView(itemNo);
				}
			}else {
				console.log("fn_zzim userId:" + userId);
				let param = {"itemNo": itemNo, "userId": userId};
				console.log(param);
				if(isZzimed) {
					$.ajax({
						url: "<c:url value='/product/cancelZzim' />"
						,type: "post"
						,data: param
						,success: function (data) {
							isZzimed = false;
							alert("찜하기를 해제하셨습니다.");
							update(isZzimed);
						}
						,error: function(err) {
							console.log("Error occurred while canceling zzim:", err);
						}
					})
				}else {
					$.ajax({
						url:"<c:url value='/product/plusZzim'/>"
						,type: "post"
						,data: param
						,success: function(data){
							isZzimed = true;
							alert("찜하기 성공");
							update(isZzimed);
						}
						,error: function(err){
							console.log("err.status : ", err.status);
							alert("찜하기에 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
						}
					});
				}
			}
		}
	
	
	
		// 찜 상태를 화면에 업데이트하는 함수
		function update(isZzimed) {
			$("#wishlistText").text(isZzimed ? "찜목록에 추가됨" : "찜하기");
		}
		
		let userId = '${login != null ?login.getId()  : ''}';
	    let itemNo = '${product.itemNo}';
	    
		// 사용자가 로그인할 때 찜한 상태를 가져오는 함수
		function getZzim() {
 			console.log("getZzim itemNo:" + itemNo +" getZzim userId:"+ userId);
 			let url = "<c:url value='/product/getZzim'/>";
			$.ajax({
			    url: url
			    ,type: "POST"
			    ,data: {"itemNo": itemNo, "userId": userId}
			    ,success: function (data) {
			    	console.log("data:"+data);
			    	if(data == '') {
			    		isZzimed = false;
			    		update(isZzimed);
			    	}else {
			    		isZzimed = true;
			    		update(isZzimed);
			    	}
			    }
			    ,error: function (err) {
			      console.log("찜하기 불러오기 에러", err);
			    }
			});
		}
		
		function cancelZzim(itemNo, userId) {
			console.log("cancelZzim"+ itemNo + userId);
			$.ajax({
				url: "<c:url value='/cancelZzim' />"
				,type: "post"
				,data: {"itemNo": itemNo, "userId": userId}
				,success: function (data) {
					
				}
				,error: function(err) {
					console.log("Error occurred while canceling zzim:", err);
				}
			});
		}
		
		/* function goToChat(itemNo) {
		    // 채팅방 페이지 URL을 생성하고 itemNo를 쿼리 파라미터로 전달합니다.
		    const chatRoomUrl = "${pageContext.request.contextPath}/chat/chatRoom?itemNo=" + itemNo;

		    // 사용자를 채팅방 페이지로 리다이렉트합니다.
		    window.location.href = chatRoomUrl;
		} */
		/* function goToChat() {
			const chatRoomUrl = "${pageContext.request.contextPath}/chat/chat";
			
			window.location.href = chatRoomUrl;
		} */
		let itemName = "${product.itemName}";
		$("#chat").on('click', function(e){
			e.preventDefault();
			window.open("${pageContext.request.contextPath}/chat/chat?itemNo=${product.itemNo}", "/chat/chat", "width=500, height=800, top=200, left=200");
			// 경로, 파일, 너비 , 높이, 위치 지정
		});
	</script>
	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<%-- <script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/easing/easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/owlcarousel/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/isotope/isotope.pkgd.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/lib/lightbox/js/lightbox.min.js"></script> --%>

	<!-- Contact Javascript File -->
	<%-- <script
		src="${pageContext.request.contextPath }/mail/jqBootstrapValidation.min.js"></script> --%>
	<%-- <script src="${pageContext.request.contextPath }/mail/contact.js"></script> --%>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath }/js/main.js"></script>
</body>
</html>
