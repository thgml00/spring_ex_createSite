
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="content-header">
   <h1>게시글 보기</h1>
</section>
<section class="content">
    <div class="container">
        <input type="hidden" id="boardId"  name="boardId"  value="${board.boardId}">
        <div class="form-group">
           <label>제목</label>
           <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" readonly="readonly">
        </div>
          <div class="form-group">
	           <label>작성자</label>
	           <input type="text" class="form-control" id="boardWriter" name="boardWriter" value="${board.boardWriter}" readonly="readonly">
        </div>
        <div class="form-group">
	           조회수 : <span>${board.boardCount} </span>
        </div>
        <div class="form-group">
	           <label>첨부파일</label>
	           <br/>
	           <span id="attach" style="margin-left: 10px">
	              <c:if test="${board.originFileName ne null  &&  board.originFileName ne ''}">
                      <a href="/board/down.do?boardId=${board.boardId}">${board.originFileName}</a>
                    </c:if>
                    <c:if test="${board.originFileName eq null  ||  board.originFileName eq ''}">
                         없음
                    </c:if>
                </span>
        </div>
          <div class="form-group">
	           <label>내용</label>
	           <textarea  class="form-control"  rows = "20"  cols="70" 
	                  id="boardContents" name="boardContents" readonly="readonly">${board.boardContents} </textarea>
        </div>
        <div>
	    	<button type="button"  id="listBtn"        class="btn btn-primary  pull-right" >목록으로</button>
	    	<button type="button" id="deleteBtn"    class="btn btn-primary  pull-right"   style="margin-right: 3px" >삭제</button>
	    	<button type="button" id="updateBtn"  class="btn btn-primary  pull-right"   style="margin-right: 3px" >수정</button>
	  </div>
    </div>
    <script>
    
       function initBtn(){
    	   
    	   //자바스크립트 
    	   const modifyBtn = document.querySelector('#updateBtn');
    	   const listBtn   = $('#listBtn');
    	   const deleteBtn = $('#deleteBtn');
    	   
    	   if(typeof modifyBtn !=='undefined') {
    		   modifyBtn.addEventListener('click', function(e) {
    			  console.log(e);
    			      e.preventDefault(); //이벤트 동작 방지 
    			  	$('#contents').load('/board/update.do?boardId=' + $('#boardId').val(),    null);
    		   });
    	   }
    	   
     	   if(typeof listBtn !=='undefined') {
     		  listBtn.on('click',  function(e) {
     				$('#contents').load('/board/list.do', null);
    		   });
     	   }
     	   
     	  if(typeof deleteBtn !=='undefined') {
     		 deleteBtn.on('click',  function(e) {
   				
     			 const isConfirm = confirm('정말 삭제하시겠습니까 ?');
     			 
     			 if(isConfirm) {
     				 $.ajax({
     					 url: '/board/remove.do',
     					 type : 'GET',
     					 dataType : 'json',
     					 data : {
     						   boardId : $('#boardId').val()
     					 },
     					 beforeSend:function(xhr){
     						 xhr.setRequestHeader("AJAX",true);
     					 }
     				 }).done(function(data){
     					 
     					 if(data.resultCode === 200) {
     						 alert('게시글이 삭제되었습니다.');
     					 }else {
     						 alert('게시글이 삭제가 실패하였습니다.');
     					 }
     					 
     					 $('#contents').load('/board/list.do', null);
     					 
     					 
     				 }).fail(function(xhr, status, error){
     					 if(xhr.status===401){
     						 alert('로그인이 필요한 기능힙니다. 로그인하십시오.');
     					 }
     				 });
     				 
     			 }
  		   });
     	  }  
       }

       $(document).ready(function(){
    	      initBtn();
       });
    
    
    </script>
</section>