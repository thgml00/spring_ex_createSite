<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <%-- Font Awesome --%>
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/font-awesome/css/font-awesome.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/Ionicons/css/ionicons.min.css"/>">
    <%-- Theme style --%>
    <link rel="stylesheet" href="<c:url value="/resources/dist/css/AdminLTE.min.css"/>">
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
	
	<!-- AdminLTE App -->
	<script src="<c:url value="/resources/dist/js/adminlte.min.js"/>"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>
	
	<style>
		.bg-light{
			height:1100px;
			padding-top:15px;
		}
		.container.py-4{
			margin:0 auto;
			width:503px;
		}
		
	</style>
	
</head>
<body>
	<section class="bg-light">
		<div class="container py-4">
			<div align="center" style="margin:10px auto">
				<span class="text-dark h4">회원가입</span>
			</div>
			<form action="/login/join.do" method="post" id="frm" onsubmit="return false;">
				<div class="form-group">
					<label class="form-label-mt-4">아이디</label>
				</div>
				<div class="row" style="margin-bottom:1rem">
					<div class="col-md-8" align="left">
						<input type="text" class="form-control" id="userId" name="userId">
					</div>
					<div class="col-md-4" align="right">
						<button type="button" class="btn btn-secondary" onclick="checkId();">중복확인</button>
					</div>
				</div>
				<div class="form-group">
					<label for="userPasswd" class="form-label-mt-4">비밀번호</label>
					<input type="text" class="form-control" id="userPasswd" name="userPasswd">
				</div>
				<div class="form-group">
					<label for="passwdConfirm" class="form-label-mt-4">비밀번호 확인</label>
					<input type="text" class="form-control" id="passwdConfirm" name="passwdConfirm">
				</div>
				<div class="form-group">
					<label for="userName" class="form-label-mt-4">이름</label>
					<input type="text" class="form-control" id="userName" name="userName">
				</div>
				<div class="form-group">
					<label for="userBirth" class="form-label-mt-4">생년월일(6자)</label>
					<input type="text" class="form-control" id="userBirth" name="userBirth">
				</div>
				<div class="form-group">
					<label for="userGender" class="form-label-mt-4">성별</label>
					<select id="userGender" name="userGender" class="form-control">
						<option value="님자" selected="selected">남자</option>
						<option value="여자">여자</option>
					</select>
				</div>
				<div class="form-group">
					<label class="form-label-mt-4">주소</label>
				</div>
				<div class="row" style="margin-bottom:1rem">
					<div class="col-md-8" align="left">
						<input type="text" readonly="readonly" style="width:80px" id="postCode" name="postCode" placeholder="우편번호">
					</div>
					<div class="col-md-4" align="right">
						<button type="button" class="btn btn-info btn-sm" onclick="searchPostCode()">우편번호 찾기</button>
					</div>
				</div>
				<div class="row" style="margin-top:5px">
					<div class="col-md-12">
						<input type="text" style="width:100%" readonly="readonly" id="userAddr1" name="userAddr1" placeholder="주소">
					</div>
				</div>
				<div class="row" style="margin-top:5px;margin-bottom:1rem">
					<div class="col-md-12">
						<input type="text" style="width:100%" id="userAddr2" name="userAddr2" placeholder="상세주소">
					</div>
				</div>
				<div class="form-group">
					<label class="userRoleId" class="form-label-mt-4">권한</label>
					<select id="userRoleId" name="userRoleId" class="form-control">
						<option value="admin" selected="selected">슈퍼 관리자</option>
						<option value="superUser">중간관리자</option>
						<option value="user">사용자</option>
					</select>
				</div>
				<div class="row" style="margin-top:5rem" align="center">
					<div class="col-md-12">
						<button type="button" class="btn btn-primary" style="margin-right:5px" onclick="register()">회원가입</button>
						<button type="button" class="btn btn-secondary" onclick="cancel()">취소</button>
					</div>
				</div>
			</form>
		</div>
	</section>
</body>
<script>

	let isCheckId=false;
	
	function searchPostCode(){
		daum.postcode.load(function(){
			new daum.Postcode({
				oncomplete:function(data){
					let fullAddr='';
					let extraAddr='';
					
					//사용자가 도로명 주소를 선택했을 경우
					if(data.userSelectedType==='R'){
						fullAddr=data.roadAddress;
						
						//법정동 명이 있을 경우
						if($.trim(data.bname).length>0){
							extraAddr += data.bname;
						}
						
					}else{
						fullAddr=data.jibunAddress;
					}
					
					//빌딩 이름이 있을 경우
					if(data.buildingName!==''){
						extraAddr += (extraAddr!=='' ?','+data.buildingName : data.buildingName);
					}
					
					//조합형 주소의 유무의 따라 양쪽에 괄호를 추가하여 최종 주소를 만듦
					fullAddr += (extraAddr!==''?'('+extraAddr+')':'');
					
					//우편번호
					$('#postCode').val(data.zonecode);
					//주소
					$('#userAddr1').val(fullAddr);
				}
			}).open();
		})
	}
	
	function register(){
		
		if(validated()){
			const param=getParam();
			
			$.ajax({
				url:'/login/join.do',
				type:'post',
				contentType:'application/json;charset=utf-8',
				data:JSON.stringify(param),
				dataType:'json'
			}).done(function(data){
				if(data.resultCode==200){
					alert('사용자 등록이 완료되었습니다.');
					location.href="/login/form.do";
				}else{
					alert('사용자 등록이 실패하였습니다. 다시 시도해주세요.');
					return false;
				}
			}).fail(function(xhr,status,error){
				console.log(error);
			});
		}
		
	}
	
	function getParam(){
		let param={}; //빈 자바스크립트 객체
		const inputAll=document.querySelectorAll('input');
		$.each(inputAll,function(index,obj){
			const inputId=$(obj).attr('id');
			checkObj=$('#'+inputId);
			param[inputId]=$.trim(checkObj.val()); //trim은 앞뒤 뛰어쓰기 없앰(중간은 못 없앰)
		});
		
		param['userGender']=$('#userGender').val();
		param['userRoleId']=$('#userRoleId > option:selected').val();
		
		return param;
	}
	
	function validated(){
		
		//모든 input 가져오기
		const inputAll=document.querySelectorAll('input');
		
		//유효성 결과 담을 변수
		let isValid=true;
		
		//모든 input 반복돌리기
		$.each(inputAll,function(index,obj){
			//input의 id값 가져오기
			const inputId=$(obj).attr('id');
			//jquery 객체로 변환
			checkObj=$('#'+inputId);
			//에러발생 시 사용할 메시지 가죠오기
			const message=getMessage(inputId);
			//체크 - 상세주소는 유효성 제외
			if(inputId!=='userAddr2'){
				if(typeof checkObj==='undefined'||$.trim(checkObj.val()).length===0){
					alert(message);
					checkObj.focus();
					isValid=false; //결과 변경
					return false; //break 문
				}
			}
		});
		
		if(!isCheckId){
			alert('아이디 중복체크를 해주십시오.');
			return false;
		}
		return isValid;
	}
	
	function getMessage(id){
		let message='';
		if(id==='userId'){
			message="아이디를 입력하십시오.";
		}else if(id==='userPasswd'){
			message="패스워드를 입력하십시오.";
		}else if(id==='userName'){
			message="사용자 명을 입력하십시오.";
		}else if(id==='userBirth'){
			message="생년월일을 입력하십시오.";
		}else if(id==='postCode' || id==='userAddr1'){
			message="우편번호 검색을 해주십시오.";
		}
		
		return message;
	}
	
	function checkId(){
		const userId=$('#userId').val();
		
		//검사를 위해 값을 초기화
		isCheckId=false;
		
		if($.trim(userId).length===0){
			alert('아이디를 입력 해주십시오.');
		}else{
			$.ajax({
				url:'/login/check/id.do',
				type:'get',
				dataType:'json',
				data:{userId:userId}
			}).done(function(data){
				if(data.resultCode===200){
					isCheckId=true;
					alert('사용 가능한 아이디입니다.');
				}else if(data.resultCode===300){
					alert('이미 가입된 아이디입니다.');
				}else{
					alert('중복검사 과정에 문제가 있습니다. 다시 실행해 주세요.');
				}
			}).fail(function(xhr,status,error){
				console.log(error);
			})
		}
	}
</script>
</html>