<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="content-header">
   <h1>게시글 보기</h1>
</section>
<section class="content">
	<div class="container">
		<input type="hidden" id="boardId" name="boardId" value="${board.boardId}">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" readonly="readonly">
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" id="boardWriter" name="boardWriter" value="${board.boardWriter}" readonly="readonly">
		</div>
		<div class="form-group">
			조회수 : <span>${board.boardCount}</span>
		</div>
		<div class="form-group">
			<label>첨부파일</label>
			<br/>
			<span id="attach" style="margin-left:10px">
				<c:if test="${board.originFileName ne null && board.originFileName ne ''}">
					<a href="/board/down.do?boardId=${board.boardId}">${board.originFileName}</a>
				</c:if>
				<c:if test="${board.originFileName eq null || board.originFileName eq ''}">
					없음
				</c:if>
			</span>
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" rows="20" cols="70"
				id="boardContents" name="boardContents" readonly="readonly">${board.boardContents}</textarea>
		</div>
		<div>
			<button type="button" id="updateBtn" class="btn btn-primary pull-right">수정</button>
			<button type="button" id="listBtn" class="btn btn-primary pull-right" style="margin-right:3px">목록으로</button>
		</div>
	</div>
	<script>
		function initBtn(){
			//자바스크립트
			const modifyBtn=document.querySelector('#updateBtn');
			const listBtn=$('#listBtn'); //jquery 객체로 만듦
			
			if(typeof modifyBtn!=='undefined'){
				modifyBtn.addEventListener('click',function(e){ //자바 함수
					e.preventDefault(); //이벤트 동작 방지
					$('#contents').load('/board/update.do?boardId='+$('#boardId').val(),null);
				});
			}
			
			if(typeof listBtn!=='undefined'){
				listBtn.on('click',function(e){ //on은 jquery 함수
					$('#contents').load('/board/list.do',null);
				});
			}
		}
		
		$(document).ready(function(){
			initBtn();
		});
		
	</script>
</section>