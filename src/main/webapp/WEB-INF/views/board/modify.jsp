<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="content-header">
   <h1>게시글 보기</h1>
</section>
<section class="content">
    <div class="container">
       <form id="updateFrm">
           <input type="hidden" id="boardId"  name="boardId"  value="${board.boardId}">
	        <div class="form-group">
	           <label for="boardTitle">제목</label>
	           <input type="text" class="form-control" id="boardTitle" name="boardTitle"    value="${board.boardTitle }"  >
	        </div>
	        <div class="form-group">
		           <label for="file">첨부파일</label>
		            <input type="file" class="form-control" id="file" name="file" >
	        </div>
	          <div class="form-group">
		           <label for="boardContents">내용</label>
		           <textarea  class="form-control"  rows = "20"  cols="70" 
		                  id="boardContents" name="boardContents" >${board.boardContents } </textarea>
	        </div>
        </form>
        <div>
	    <button type="button" id="saveBtn"  class="btn btn-primary  pull-right" >수정</button>
	    <button type="button"  id="listBtn"   class="btn btn-primary  pull-right" style="margin-right: 3px">취소</button>
	  </div>
    </div>
    <script>
    
     function validate() {
    	 const boardTitle = $('#boardTitle');
    	 const boardContents = $('#boardContents');
    	 
    	 if($.trim( boardTitle.val()  ).length === 0) {
    		 alert('제목을 입력하십시오');
    		 boardTitle.focus();
    		 return false;
    	 }
    	 
    	 if($.trim( boardContents.val()  ).length === 0) {
    		 alert('내용을 입력하십시오');
    		 boardContents.focus();
    		 return false;
    	 }
    	 
    	 	const file = $('#file').val();
    	 	
    	 	if(file) {
    	 		 const isConfirm = confirm('기존 첨부파일이 있다면 삭제됩니다. 진행하시겠습니까?');
    	 		 if(!isConfirm) {
    	 			$("#file").val(""); // 선택된 파일 삭제 
    	 			 return false;
    	 		 }
    	 	}
    	 return true;
     }
      
     
     function initBtn(){
    	   //자바스크립트 
    	   const saveBtn = document.querySelector('#saveBtn');
    	   const listBtn   = $('#listBtn');
    	   
    	   if(typeof saveBtn !=='undifined') {
    		   saveBtn.addEventListener('click', function(e) {
    			      e.preventDefault(); //이벤트 동작 방지 
    			      if(validate()) {
    			    	  
    			    	  const updateFrm = $('#updateFrm')[0];
    			    	   //폼전체를 데이터객체화 
    			    	   const formData = new FormData(updateFrm);
    			    	   //ajax 로 파일 데이터 전송하기
    			          $.ajax({
    			        	  url : '/board/update.do',
    			        	  type : "POST",
    			        	  data : formData,
    			        	  dataType : 'json',
    			        	  enctype : 'multipart/form-data',
    			        	  contentType : false,
    			        	  processData : false  // ajax 넘길 때 전송되는 데이터 파라메터 	  
    			          }).done(function(data){
    			        	  
    			        	  if(data.resultCode === 200) {
    			        		  alert('수정되었습니다.');
    			        	  }else {
    			        		  alert('수정이 실패하였습니다');
    			        	  }
    			        	 //리스트 화면 전환
    			        	  $('#contents').load('/board/list.do', null);
    			          }).fail(function(xhr, error, status) {
    			        	    console.log(error);
    			          })
    			      }
    		   });
    	   }
    	   
     	   if(typeof listBtn !=='undifined') {
     		  listBtn.on('click',  function(e) {
     				$('#contents').load('/board/list.do', null);
    		   });
     	   }
       }

       $(document).ready(function(){
    	      initBtn();
       });
    
    
    </script>
</section>