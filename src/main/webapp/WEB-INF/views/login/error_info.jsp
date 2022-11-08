<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css"/>">
    <%-- Font Awesome --%>
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/font-awesome/css/font-awesome.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/Ionicons/css/ionicons.min.css"/>">
    <%-- Theme style --%>
    <link rel="stylesheet" href="<c:url value="/resources/dist/css/AdminLTE.min.css"/>">
     <%@ include file="../include/plugin_js.jsp" %>
</head>
<body class="hold-transition login-page" >
     <div class="login-box">
          <div class="login-logo">
                 HomePage
          </div>
          <div class="login-box-body">
               <form>
                     <div class="form-group has-feedback">
                           로그인이 필요한 기능입니다.
                     </div>
                     <div class="row">
                           <div class="col-xs-12">
                            	<button type="button"  id="loginBtn"  class="btn btn-primary  btn-block" >login</button>
                           </div>
                     </div>
               </form>
          </div>       
     </div>
</body>
  <script >
  
      $(document).ready(function(){
    	   $('#loginBtn').on('click', function(){
    		     location.href = '/login/form.do';
    	   });
      })
  
  
  
  </script>
</html>