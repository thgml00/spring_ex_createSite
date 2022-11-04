<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  th, td {
    text-align:  center;
  }
  
  table {
    width: 100%;
    background:  #FFFFFF;
  }
  
  table thead th {
      min-height: 32px;
      padding: 12px 10px;
      color:  #000000;
      font-size: 14px;
      text-align: center;
      line-height: 18px;
      border-bottom: 1px solid #eaeaea;
      word-break: normal;   
  }
  
  table tbody td a .link {
          color:rgba(0, 126, 255, 1.0);
  }
  
</style>

<section class="content-header">
   <h1>게시판</h1>
</section>
<section class="content">
   <div class ="row">
      <div class = col-xs-12>
           <div class="box-body">
                <!-- 실제 테이블이 들어갈 자리  -->
                 <div class = "container">
                      <input type="hidden" name ="nowPageNumber"  id="nowPageNumber"  value="1">
                      <table class="table table-hover">
                         <thead>
                            <tr>
                                <th width="5%">번호</th>
                                <th width="40%">제목</th>
                                 <th width="15%">작성자</th>
                                 <th width="15%">작성날짜</th>
                                 <th width="5%">조회 수</th>
                            </tr>
                         </thead>
                         <tbody id="dataBody"></tbody>
                      </table>     
                       <hr/>
                       <a class="btn btn-default pull-right" 
                                        href="javascript:void(0)" onclick="loadPage('writeBoard')">글쓰기</a>
                       <div class="text-center">
                               <ul class="pagination" id="pageDiv"></ul>
                       </div>
                 </div>
           </div>
      </div>
   </div>
   <script>
   
        function getTableData() {
        	
        	const param ={
        			nowPageNumber : $('#nowPageNumber').val()
        	}
        	
        	    $.ajax({
        	    	type : 'post',
        	    	dataType : 'json',
        	    	url : '/board/list.do',
        	    	data : param
        	    }).done(function(data){
        	        console.log('그리기')
        	    	drawTables(data.dataList,  data.pageHtml);
        	 
        	    }).fail(function(xhr, status, exp){
        	    	  console.log(status);
        	    });	   
        }

        function drawTables(list,  pageHtml) {
	      	  const tbody = $('#dataBody');
	    	  //비우기
	    	  tbody.empty();
	    
	    	  console.log(list);
	    	  
	    	  for(data of list) {
	    		 const tr = $('<tr></tr>')
	    		 const rnTd = $('<td></td>')
	    		 const titleTd = $('<td></td>')
	             const writerTd = $('<td></td>')
	             const countTd = $('<td></td>')
	             const updateTd = $('<td></td>')
	             
	             const link = $('<a/>')
	             link.attr('href', 'javascript:void(0);');
	    		  link.attr('onclick',"goDetail(" + data.boardId + ");");
	             
	             //각각의 td 에 내용 채우기 
	             rnTd.append(data.rn);
	    		 titleTd.append(  link.append(data.boardTitle)  );
	    		 writerTd.append(data.boardWriter);
	    		 countTd.append(data.boardCount);
	    		 updateTd.append(data.updateTime);
	    		 
	    		 
	    		 //td를 tr에 추가하기 
	    		 tr.append(rnTd);
	    		 tr.append(titleTd);
	    		 tr.append(writerTd);
	    		 tr.append(updateTd);
	    		 tr.append(countTd);
	    		 
	    		 //tbody에 tr 추가 
	    		  tbody.append(tr);
	    	  }
	    	  
	    	  //페이지 영역 만들기 
	    	  const pagingArea = $('#pageDiv');
	    	  pagingArea.empty(); 
	    	  pagingArea.append(pageHtml);
	    	  
        }
        
        function goPage(pageNumber) {
              $('#nowPageNumber').val(pageNumber + 1);
              //다시 테이블 그리기
              getTableData();
        }
        
        function goDetail(boardId) {
        	$('#contents').load('/board/detail.do?boardId='+boardId, null);
        }
        
        $(document).ready(function(){
            	getTableData();
        });
   
   
   </script>
</section>