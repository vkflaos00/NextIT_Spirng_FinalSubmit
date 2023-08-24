<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${replyPagingVO.replyList}" var="reply">
	<div class="replyList_row card boarder mt-2 mb-3" data-replyNo="${reply.replyNo }">
		<div class="card-header text-white px-2 py-1" style="background-color: violet;">
			<small class="float-left fot-weight-bold">Conv</small>
			<small class="float-right font-weight-bold">
				<i class="fa fa-comment-dots"></i>
			</small>
		</div>
		<div class="card-body px-2 py-1">
			<span class="reply_content font-weight-bold">${reply.replyContent }</span>
			<br>
			<small class="font-weight-bold">${reply.replyMemId }</small>
			<small class="text-muted">
				<i class="far fa-clock"></i>${reply.regDate }
			</small>
			<c:if test="${reply.replyMemId == sessionScope.login.id }">
				<div class="reply_button float-right">
					<button type="button" name="btn_reply_edit" class="btn btn-success btn-sm btn_edit">
						<i class="far fa-edit"></i>수정
					</button>
					<button type="button" name="btn_reply_delete" class="btn btn-danger btn-sm btn_delete">
						<i class="far fa-trash-alt"></i>삭제
					</button>
				</div>
			</c:if>
		</div>
	</div>
</c:forEach>
 <div class="div_paging">
	<ul class="pagination">
		<c:if test="${replyPagingVO.firstPage gt 5 }">
            <li><a href="#none" onclick="fn_paging('${replyPagingVO.firstPage-1 }')">&laquo;</a></li>
        </c:if> 
              
		<c:if test="${replyPagingVO.curPage ne 1 }">
			<li><a href="#none" onclick="fn_paging('${replyPagingVO.curPage-1 }')">&lt;</a></li>
		</c:if>
              
		<c:forEach begin="${replyPagingVO.firstPage }" end="${replyPagingVO.lastPage }" step="1" var="i"> 
			<c:if test="${replyPagingVO.curPage ne i}">
				<li><a href="#none" onclick="fn_paging('${i}')">${i}</a></li>
			</c:if>
			<c:if test="${replyPagingVO.curPage eq i }">
				<li class="curPage_a">${i}</li>
			</c:if>
		</c:forEach>
             
		<c:if test="${replyPagingVO.lastPage ne replyPagingVO.totalPageCount }">
			<li><a href="#none" onclick="fn_paging('${replyPagingVO.curPage +1 }')">&gt;</a></li>
			<li><a href="#none" onclick="fn_paging('${replyPagingVO.lastPage +1 }')">&raquo;</a></li>
		</c:if>
	</ul>
</div>
