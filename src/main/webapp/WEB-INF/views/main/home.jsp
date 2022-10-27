<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>
<%
  String context = request.getContextPath();
%>

<%--head.jsp--%>
<%@ include file="../include/head.jsp" %>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div>
    <%--main_header.jsp--%>
    <%@ include file="../include/main_header.jsp" %>
    <%--left_column.jsp--%>
    <%@ include file="../include/left_column.jsp" %>  
    <%-- Content Wrapper. Contains page content --%>
    <div class="content-wrapper" id = contents>
        
    </div>
    <%-- /.content-wrapper --%>

    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>
</div>
<%-- ./wrapper --%>

<%--plugin_js.jsp--%>
<%@ include file="../include/plugin_js.jsp" %>

<script type="text/javascript">

 $(document).ready(function(){

	 var url ='/content.do';	 
	 $('#contents').load(url, null);
	 
 });


 function loadPage(pgType) {
     var url = '';

     if(pgType =='dboard') {
         url = "/board/list.do";
         $('#contents').load(url, null);
     }else  if(pgType =='writeBoard') {
         console.log('writeBoard');
         url = "/board/write.do";
         $('#contents').load(url, null);
     }
 }

</script>

</body>
</html>
