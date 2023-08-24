<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글</title>
<link href="${pageContext.request.contextPath }/css/board/board.css"
	rel="stylesheet" />
<!-- 부트스트랩 css 사용 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
let isRecommended;
let recommendationCount = ${board.boLike}; 

function updateUI() {
    $("#boardHitLabel").text("[추천수] " + recommendationCount);
    if (!isRecommended) {
        $("#reBu1").show();
    } else {
        $("#reBu1").hide();
    }
    if (isRecommended) {
        $("#reBu2").show();
    } else {
        $("#reBu2").hide();
    }
}

function hitCheck(boNo) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/board/hitCheck",
        data: { boNo: boNo },
        success: function (response) {
        	console.log("response : " , response);
            isRecommended = response;
            updateUI();
        },
        error: function (xhr, status, error) {
        	alert("에러");
        }
    });
}

function hitEdit(boNo){
	$.ajax({
		type: "POST",
		url: "${pageContext.request.contextPath}/board/hitEdit",
		data: { boNo: boNo },
       success: function(response){
    	   console.log("edit response : " , response);
    	   isRecommended = response;
    	   updateUI();
       },
	 error: function (xhr, status, error) {
    	console.log("error");
    }
	});
}

function hit(boNo) {
    if(isRecommended) {
        if ("${sessionScope.login.id}" != null && "${sessionScope.login.id}" !== "") {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/board/hitCancel",
                data: { boNo: boNo },
                success: function (response) {
                	 hitEdit(boNo);
                	console.log("추천 취소", response.isRecommended);
                    recommendationCount -= 1;
                    isRecommended = response.isRecommended;
                    updateUI();
                    alert("추천 취소 되었습니다.");
                },
                error: function (xhr, status, error) {
                    alert("추천 취소 실패");
                }
            });
        } else {
            window.location.href = "${pageContext.request.contextPath}/login";
        }
    } else {
   	 if ("${sessionScope.login.id}" != null && "${sessionScope.login.id}" !== "") {
       $.ajax({
           type: "POST",
           url: "${pageContext.request.contextPath}/board/hit",
           data: { boNo: boNo },
           success: function (response) {
        	   hitEdit(boNo);
        	   console.log("추천", response.isRecommended);
        	   recommendationCount += 1;
        	   isRecommended = response.isRecommended;
               updateUI();
               alert("추천 되었습니다.");
           },
           error: function (xhr, status, error) {
               alert("추천실패");
           }
        });
    	 } else {
             window.location.href = "${pageContext.request.contextPath}/login";
         }
    }
}
$(document).ready(function() {
	   hitCheck('${board.boNo}');
	});
</script>
</head>
<body>
	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>

	<section class="board">
		<div class="page-title" style="margin-top: 60px;">
			<div class="container">
				<h3>자유게시판</h3>
			</div>
		</div>

		<!-- board write area -->
		<div id="board-write">
			<div class="container">
				<!-- title input-->
				<div class="title">
					<h2>${board.boTitle }</h2>
				</div>
				<!-- category input -->
				<div class="form-group" style="display: flex; float: right;">
					<span class="author" style="cursor: pointer;">작성자
						${board.name }님</span> <span class="category" style="cursor: pointer;">${board.boCate }</span>
					<span class="reDate" style="cursor: pointer;">${board.registDate }</span>
					<span class="views" style="cursor: pointer;">조회수 ${board.hit }</span>
				</div>


				<!-- content input-->
				<div class="board-Content">
					<div class="time-wrap">최근 수정 일시 : ${board.editDate }</div>
					<div>${board.boContent }</div>
				</div>

				<!-- file input -->
				<div id="board-file">
					<div class="container">
						<div
							class="d-grid gap-2 d-md-flex justify-content-md-end submit-window">
							첨부파일
							<c:forEach items="${board.attachList}" var="attach"
								varStatus="status">
								<div>${status.count}
									<a href="<c:url value='/attach/download/${attach.atchNo }'/>"
										target="_blank"> ${attach.atchOriginalName } </a> <br>
									&nbsp;&nbsp;&nbsp;크기: ${attach.atchConvertSize} <br>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<!-- Submit Button-->
				<!-- 현재 로그인한 사람의 아이디가 -->
				<!-- 현재 게시글의 작성자 아이디와 같아야 표기 -->

				<div id="board-submit">
					<div class="container">
						<div
							class="d-grid gap-2 d-md-flex justify-content-md-end submit-window">
							<c:if test="${login.id == board.id}">
								<form action="${pageContext.request.contextPath}/boardModify"
									method="POST">
									<input type="hidden" name="boNo" value="${board.boNo }">
									<button class="btn btn-primary me-md-2" type="submit">수정</button>
								</form>
								<form id="delForm"
									action="${pageContext.request.contextPath }/boardDel"
									method="POST">
									<input type="hidden" name="boNo" value="${board.boNo }">
									<button class="btn btn-primary me-md-2" type="button"
										onclick="f_del()">삭제</button>
								</form>
							</c:if>
							<button class="btn btn-primary" type="button"
								onclick="location.href='${pageContext.request.contextPath}/boardList'">목록</button>
						</div>
					</div>
				</div>
				
				<!-- boLike area -->
				<div class="form-control-lg text-center" >
					
					<div class="row justify-content-center">
						<input type="hidden" name="boNo" value="${board.boNo }">
						<c:if test="${sessionScope.login.role == 'USER' }">
							<svg id="reBu1" xmlns="http://www.w3.org/2000/svg" width="9%"
								height="9%" fill="rgb(219,68,85)"
								class="bi bi-chat-square-heart" viewBox="0 0 16 16"
								onclick="hit(${board.boNo})" style="width:80px;">
  					<path
									d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1h-2.5a2 2 0 0 0-1.6.8L8 14.333 6.1 11.8a2 2 0 0 0-1.6-.8H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12ZM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Z" />
  						<path
									d="M8 3.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z" />
  							</svg>
							<svg id="reBu2" xmlns="http://www.w3.org/2000/svg" width="9%"
								height="9%" fill="rgb(219,68,85)"
								class="bbi bi-chat-square-heart-fill" viewBox="0 0 16 16"
								onclick="hit(${board.boNo})" style="width:80px;">
  						<path
									d="M2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm6 3.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z" />
				</svg>
						<label for="exampleFormControlInput1" class="form-label"
						id="boardHitLabel">추천수</label>
						</c:if>
					</div>
				</div>
				
				<!-- reply area -->
				<div class="row mt-3">
					<div class="col-5">
						<h2 class="h1-sub mb-0">
							<strong> <i class="fa fa-comment-dots"> </i> 댓글
							</strong>
						</h2>
					</div>
				</div>
				<div id="reply_list_div"></div>
				<div class="card border-cu mt-2 mb-3" id="noComment">
					<div class="card-header text-white px-2 py-0"
						style="background-color: violet;">
						<small> <i class="fa fa-exclamation-circle"> </i> No
							comments
						</small>
					</div>
					<div class="card-body px-2 py-2">
						<div>첫 댓글을 남겨주세요.</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${sessionScope.login != null}">
						<form class="mt-2 mb-3" method="post" name="reply_form" novalidate>
							<input type="hidden" name="replyCate" value="BOARD"> <input
								type="hidden" name="replyParentno" value="${board.boNo}">
							<input type="hidden" name="replyMemId" value="${login.id }">
							<div class="form-group">
								<textarea name="replyContent" rows="3" cols="40"
									class="form-control" required id="id_content"></textarea>
								<small class="form-text text-muted"> 최대 100자</small>
							</div>
							<button type="submit" class="btn btn-primary btn-block"
								name="master_comment_button" id="reply_regist">등록</button>
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
	</section>

	<!-- 모든 페이지 상단에 포함되는 부분 -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>

	<script type="text/javascript">
	
	function fn_reply_list(curPage) {
	    let url = "<c:url value='/reply/replyList' />";
	    $.ajax({
	        url: url,
	        data: {
	            "replyCate": "BOARD",
	            "replyParentno": "${board.boNo}",
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
			//alert("삭제버튼");
			let replyNo = $(this).closest(".replyList_row").data("replyno");
			//alert("replyNo: "+ replyNo);
			
			let replyMemId = "${login.id}";
			//alert("replyMemId:"+replyMemId);
			let param = {"replyNo": replyNo, "replyMemId": replyMemId};
			console.log(param);
			
			let ret = confirm("댓글을 정말 삭제하시겠습니까?");
			if(ret){
				$.ajax({
					url:"<c:url value='/reply/replyDelete' />"
					,type: "post"
					,data: param
					,success: function(data){
						alert("success");
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
				str1 += '	<input type="hidden" name="replyCate" value="BOARD"> ';
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

	<script type="text/javascript">
	
	function f_del(){
		if(confirm("정말로 삭제하시겠습니까?")){
			document.getElementById("delForm").submit();
		}
	}
	
	</script>
</body>
</html>