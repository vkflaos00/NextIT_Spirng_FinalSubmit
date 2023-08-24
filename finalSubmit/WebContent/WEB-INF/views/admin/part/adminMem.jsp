<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	function deleteSeletedUsers() {
		let userIDs = []; // 선택한 사용자 ID를 담을 배열
		
		// 선택한 체크박스의 값을 수집하여 배열에 추가
		$("input[name='userCheckbox']:checked").each(function() {
			userIDs.push($(this).val());
		});
		if (userIDs.length === 0) {
			alert("블랙리스트에 추가할 사용자를 선택해주세요.");
			return;
		}
		
		let shouldDelete = window.confirm("선택한 사용자를 블랙리스트에 추가하시겠습니까?");
		
		if(shouldDelete) {
			let deletionReason = prompt("삭제 이유를 입력해주세요 :");
			if(deletionReason !== null) {
				$.ajax({
	                url: "${pageContext.request.contextPath}/admin/deleteSelectedUsers",
	                type: "post",
	                contentType: "application/json",
	                data: JSON.stringify({
	                	userIDs: userIDs,
	                    deletionReason: deletionReason
	                }),
	                success: function(data) {
	                    alert("선택한 사용자가 성공적으로 삭제되었습니다.");
	                    fn_member_list(1, $("#id_rowSizePerPage").val());
	                },
	                error: function(err) {
	                    console.log(err);
	                }
	            });
			}
		}
	}


  // 페이지 로딩 시 검색 조건 셋팅
$(document).ready(function () {
  
 	// 검색 기능 처리
	$("#submit1").click(function(e){
		e.preventDefault();
		
		var rowSizePerPage = $("#id_rowSizePerPage").val();
		var curPage = 1; // 페이지 초기화 
		var searchType = $("#id_searchType").val();
	    var searchWord = $("#id_searchWord").val();
		// AJAX를 통해 페이지 이동 요청
		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/adminPage"
			,data : {
				curPage: curPage,
		        rowSizePerPage: rowSizePerPage,
		        searchType: searchType,
		        searchWord: searchWord
			}
			,success: function(data) {
				// 검색 결과를 받아서 페이지 업데이트
		        $("#member_list_div").html(data);
				fn_member_list(curPage, rowSizePerPage);
			}
			,error: function(err) {
				console.log(err);
			}
		});
	});
});
</script>
<div class="page-title text-center">
       <div class="container">
           <h3>회원 목록</h3>
       </div>
  </div>
<div class="mb-3 text-center">
	<form name="search" action="${pageContext.request.contextPath }/admin/adminPage" method="post" onsubmit="return false;">
		<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
		<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
		<div>
			<label for="id_searchType">분류</label>
			&nbsp;&nbsp;
			<select id="id_searchType" name="searchType" class="form-select">
				<option value="ID" ${searchVO.searchType eq "ID" ? "selected='selected'" : ""}>아이디</option>
				<option value="NM" ${searchVO.searchType eq "NM" ? "selected='selected'" : ""}>이름</option>
				<option value="HP" ${searchVO.searchType eq "HP" ? "selected='selected'" : ""}>휴대폰</option>
			</select>
			<label for="id_searchWord">검색</label>
			&nbsp;&nbsp;
			<input type="text" id="id_searchWord" name="searchWord" value="${searchVO.searchWord }" placeholder="검색어">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" id="submit1" class="btn btn-outline-dark btn-sm">검 색 </button>
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
<table class="table">
  <thead>
    <tr>
      <th><input type="checkbox" id="check_all"></th>
      <th scope="col">#</th>
      <th scope="col">ID</th>
      <th scope="col">NAME</th>
      <th scope="col">AGE</th>
      <th scope="col">ADDRESS</th>
      <th scope="col">H.P</th>
      <th scope="col">E-MAIL</th>
      <th scope="col">MILEAGE</th>
    </tr>
  </thead>
  <tbody>
	<c:forEach items="${memberList }" var="member">
		<tr>
			<td><input type="checkbox" name="userCheckbox" value="${member.id }"></td>
			<td>${member.rnum }</td>
			<td>${member.id }</td>
			<td>${member.name}</td>
			<td>${member.age }</td>
			<td>${member.address1} ${member.address2 }</td>
			<td>${member.hp }</td>
			<td>${member.mail }</td>
			<td>${member.memMileage }</td>
		</tr>
	</c:forEach> 
  </tbody>
</table>
<!-- paging -->
<div class="text-center mt-3">
	<div class="div_paging text-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${searchVO.firstPage gt 5 }">
					<li class="page-item"><a class="page-link" href="#"
						style="font-weight: bold" onclick="fn_paging(${searchVO.firstPage-1})">&laquo;</a></li>
				</c:if>

				<c:if test="${searchVO.curPage ne 1 }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="fn_paging(${searchVO.curPage-1})">&lt;</a></li>
				</c:if>

				<c:forEach begin="${searchVO.firstPage }"
					end="${searchVO.lastPage }" step="1" var="i">
					<c:if test="${searchVO.curPage ne i}">
						<li class="page-item"><a class="page-link" href="#"
							onclick="fn_paging(${i})">${i }</a></li>
					</c:if>
					<c:if test="${searchVO.curPage eq i }">
						<li class="page-item active" aria-current="page"><span
							class="page-link curPage_a" style="font-weight: bold">${i }</span></li>
					</c:if>
				</c:forEach>

				<c:if test="${searchVO.lastPage ne searchVO.totalPageCount }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="fn_paging(${searchVO.curPage+1})">&gt;</a></li>
					<li class="page-item"><a class="page-link" href="#"
						style="font-weight: bold" onclick="fn_paging(${searchVO.lastPage + 1})">&raquo;</a></li>
				</c:if>
			</ul>
			<div class="div_board_write d-grid gap-2 d-md-flex justify-content-md-end">
           		<input type="button" class="btn btn-primary" onclick="deleteSeletedUsers()" value="회원삭제">
<!--            		<input type="button" onclick="fn_memberExcelUpload()" value="회원엑셀업로드">
           		<input type="button" onclick="fn_memberExcelDownload()" value="회원엑셀다운로드"> -->
           	</div>
		</nav>
	</div>
</div>