<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>로그인 에러</title>
</head>
<body>
 <form action="/login/form.do"   id="frm" method="get">
      <input type="hidden" id="errorMsg" value="${msg}">
 </form>
</body>
<script>
      //시작함수
      (function(){
    	    const msg  = document.querySelector('#errorMsg').value;
    	    alert(msg);
    	    const frm = document.querySelector('#frm');
    	    frm.submit();
      })();
</script>
</html>