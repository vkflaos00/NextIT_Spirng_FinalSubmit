<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page-title text-center">
       <div class="container">
           <h3>고객의소리 목록</h3>
       </div>
   </div>
<div class="mb-3 text-center">
	<form name="search2" action="${pageContext.request.contextPath }/admin/adminPage" method="post" onsubmit="return false;">
		<input type="hidden" name="curPage" value="${vocSearchVO.curPage}"> 
		<input type="hidden" name="rowSizePerPage" value="${vocSearchVO.rowSizePerPage}">
		<div>
			<label for="id_searchCategory">분류</label>
			&nbsp;&nbsp;
			<select id="id_searchCategory" name="searchCategory" class="form-select">
				<option value="">-- 분류 전체 --</option>
				<option value="결제 환불/취소" ${vocSearchVO.searchCategory eq "결제 환불/취소" ? "selected='selected'" : "" }>결제 환불/취소</option>
				<option value="상품 문의" ${vocSearchVO.searchCategory eq "상품 문의" ? "selected='selected'" : "" }>상품 문의</option>
				<option value="성복씨 문의" ${vocSearchVO.searchCategory eq "성복씨 문의" ? "selected='selected'" : "" }>성복씨 문의</option>
				<option value="계정 문의" ${vocSearchVO.searchCategory eq "계정 문의" ? "selected='selected'" : "" }>계정 문의</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<label for="id_searchType2">검색</label>
			&nbsp;&nbsp;
			<select id="id_searchType2" name="searchType2" class="form-select">
				<option value="ID" ${vocSearchVO.searchType eq "ID" ? "selected='selected'" : ""}>아이디</option>
				<option value="MA" ${vocSearchVO.searchType eq "MA" ? "selected='selected'" : ""}>메일</option>
			</select>
			<label for="id_searchWord2">검색</label>
			&nbsp;&nbsp;
			<input type="text" id="id_searchWord2" name="searchWord2" value="${vocSearchVO.searchWord }" placeholder="검색어">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" id="submit2" class="btn btn-outline-dark btn-sm">검 색 </button>
			<button type="button" id="id_btn_reset2" class="btn btn-outline-dark btn-sm">초기화</button>
		</div>
	</form>
	
</div>    
<div class="rowSizePerPage text-right col-9">
	<div>
		전체 ${vocSearchVO.totalRowCount } 건 조회
		<select id="id_rowSizePerPage2" name="rowSizePerPage2">
			<c:forEach begin="10" end="50" step="10" var="i">
				<option value="${i }" ${vocSearchVO.rowSizePerPage eq i ? "selected='selected'" : "" }>${i }개씩 보기!</option>
			</c:forEach>
		</select>
	</div>
</div>
<table class="table">
  <thead>
    <tr>
      <th><input type="checkbox" id="check_all2"></th>
      <th scope="col">#</th>
      <th scope="col">ID</th>
      <th scope="col">MAIL</th>
      <th scope="col">CATEGORY</th>
      <th scope="col">TITLE</th>
      <th scope="col">등록일자</th>
      <th scope="col">PROCESS</th>
    </tr>
  </thead>
  <tbody>
	<c:forEach items="${vocList }" var="voc">
		<tr>
			<td><input type="checkbox" name="check_list2" value="${voc.memId }"></td>
			<td>${voc.rnum }</td>
			<td>${voc.memId }</td>
			<td>${voc.vocMail}</td>
			<td>${voc.vocCategory}</td>
			<td><button type="button" class="btn btn-link voc-modal-button" data-bs-toggle="modal" data-bs-target="#vocModal">${voc.vocTitle }</button></td>
			<td>${voc.vocRegDate }</td>
			<td>
				<c:if test="${voc.process == 0 }">
					미확인
				</c:if>
				<c:if test="${voc.process == 1 }">
					처리중
				</c:if>
			</td>
		</tr>
	</c:forEach> 
  </tbody>
</table>
<!-- paging -->
<div class="col-lg-8 text-center mt-3">
	<div class="div_paging text-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${vocSearchVO.firstPage gt 5 }">
					<li class="page-item"><a class="page-link" href="#"
						style="font-weight: bold" onclick="fn_vocPaging(${vocSearchVO.firstPage-1})">&laquo;</a></li>
				</c:if>

				<c:if test="${vocSearchVO.curPage ne 1 }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="fn_vocPaging(${vocSearchVO.curPage-1})">&lt;</a></li>
				</c:if>

				<c:forEach begin="${vocSearchVO.firstPage }"
					end="${vocSearchVO.lastPage }" step="1" var="i">
					<c:if test="${vocSearchVO.curPage ne i}">
						<li class="page-item"><a class="page-link" href="#"
							onclick="fn_vocPaging(${i})">${i }</a></li>
					</c:if>
					<c:if test="${vocSearchVO.curPage eq i }">
						<li class="page-item active" aria-current="page"><span
							class="page-link curPage_a" style="font-weight: bold">${i }</span></li>
					</c:if>
				</c:forEach>

				<c:if test="${vocSearchVO.lastPage ne searchVO.totalPageCount }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="fn_vocPaging(${vocSearchVO.curPage+1})">&gt;</a></li>
					<li class="page-item"><a class="page-link" href="#"
						style="font-weight: bold" onclick="fn_vocPaging(${searchVO.lastPage + 1})">&raquo;</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>
<!-- VOC 답변 관련 modal -->
<div class="modal fade" id="vocModal" tabindex="-1" aria-labelledby="vocModalLabel" aria-hidden="true" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="vocModalLabel">VOC 상세 내용</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 여기에 모달 내용을 추가하세요. -->
                hm...............
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
function initModalScripts() {
	console.log("initMOdalScripts()");
    const modalButtons = document.querySelectorAll(".voc-modal-button");
    const modalContent = document.querySelector(".modal-body");

    modalButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            // 클릭한 항목에 해당하는 데이터를 가져와서 모달 내용에 채우기
            const vocTitle = button.textContent;
            const vocContent = "여기에 해당 항목의 내용을 가져와서 채우세요.";
            modalContent.innerHTML = `
                <h5>${vocTitle}</h5>
                <p>${vocContent}</p>
            `;
        });
    });
}

// adminVOC.jsp 로드 이후에 모달 스크립트 초기화 함수 호출
document.addEventListener("DOMContentLoaded", function () {
    const modalButtons = document.querySelectorAll(".voc-modal-button");
    console.log("Number of modalButtons: " + modalButtons.length);

    const modalContent = document.querySelector(".modal-body");

    modalButtons.forEach(function (button, index) {
        button.addEventListener("click", function () {
            console.log("modal_start button click");
            console.log("Clicked button index: " + index);
            const vocTitle = button.textContent;
            const vocContent = "여기에 해당 항목의 내용을 가져와서 채우세요.";
            modalContent.innerHTML = `
                <h5>${vocTitle}</h5>
                <p>${vocContent}</p>
            `;
        });
    });
});
</script>



	<%-- <script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<link href="${pageContext.request.contextPath }/css/style.css"
		rel="stylesheet" />
	<script src="${pageContext.request.contextPath }/js/main.js"></script> --%>





