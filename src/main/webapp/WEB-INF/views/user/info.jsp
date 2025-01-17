<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/container.css" rel="stylesheet">
<link href="/css/login.css" rel="stylesheet">
<link href="/css/quiz.css" rel="stylesheet">
<script src="/js/user/signup.js"></script>
<script src="/js/util/ajax.js"></script>
<script src="/js/util/util.js"></script>	
<title>myPage</title>
</head>
<body>
	<div class="container">
		<%@include file="../common/nav.jsp"%>
		<div class="content">
		<div style="display: block; width:100%;">
		<form action="<%=request.getContextPath()%>" method="post" >
			<br>
			<h1>${userDto.nickname}님!</h1>
			<p>당신의 새로운 정보를 입력해주세요!</p><br><br>
			<b>유저정보</b>
			<div class="myDiv">
				<label>닉네임</label>
				<div style="display: inline;"> <input type="text" value="${userDto.nickname}" name="nickname" required="required"></div>
			</div>
			<div class="myDiv">
				<label>이메일</label>
				<div style="display: inline;"> ${userDto.email}</div>
			</div>
			<div class="myDiv">
				<label>연락처</label>
				<div style="display: inline;"> <input type="text" value="${userDto.phone}" name="phone" required></div>
			</div>
			<div class="myDiv">
				<div style="display: inline;" id="category" > 
					<label for="main">카테고리</label>
	                <select name="main" id="main">
	 
	                </select>
	                <select name="middle" id="middle">
	
	                </select>
	                <select name="sub" id="sub">
	
	                </select>
				</div>
			</div>
			<div class="myDiv">
				<label>가입일자</label>
				<div style="display: inline;"> ${userDto.insertDate}</div>
			</div>
			<div class="myDiv2">
				<label>비밀번호</label>
				<div style="display: inline;">
					<a id="a1" onclick="openPass()">수정하기</a>
					<a id="a2" onclick="closePass()" style="display: none;">닫기</a>
					<div id="hide" style="display: none;">
						<input type="password" placeholder="수정할 비밀번호 입력" id="newPass" name="newPass" class="pw"><input type="reset" value="지우기" id="clear"><br>
						<input type="password" placeholder="비밀번호 확인" id="newPassCheck" name="newPassCheck" class="pw"><br>
						<span id="alert-form" style="display: none; color: red;">형식 불일치(영문,숫자 6~12자)</span>
						<span id="alert-success" style="display: none; color: blue;">비밀번호 일치</span>
						<span id="alert-fail" style="display: none; color: red;">비밀번호 불일치. 다시 입력하세요.</span>
					</div>				
				</div><br>
			</div>
			<div id="infoDiv">
				<input type="submit" value="수정하기" id="infoBtn" onclick="goSubmit()">
				<input type="button" value="뒤로가기" id="back" onclick="backInfo()">
			</div>	
			</form>
		</div>
		</div>
		<%@include file="../common/footer.jsp"%>
	</div>
<script type="text/javascript">
	

	//뒤로가기
	function backInfo(){
		location.href="${pageContext.request.contextPath}/mypage/${sessionScope.user_seq}";
	}

	//비밀번호 수정하기 클릭하면 비밀번호 수정 공간 확인
	function openPass(){
		$("#hide").show();
		$(".myDiv2").css("height","200px");
		$("#a1").hide();
		$("#a2").show();
		
	}
	//다시 클릭하면 사라짐
	function closePass(){
		$("#hide").hide();
		$(".myDiv2").css("height","80px");
		$("#a2").hide();
		$("#a1").show();
	}
	
	//비밀번호 입력시 일치, 불일치 확인 가능
	$(".pw").keyup(function(){
		let pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/;//6자 이상 12자 이하/ 1개의 문자,숫자 포함
		let pwd1=$("#newPass").val();
		let pwd2=$("#newPassCheck").val();
		//형식체크
		if(pattern.test(pwd1) == true){
			$("#alert-form").hide();
			if(pwd1 == pwd2){
				$("#alert-success").show();
				$("#alert-fail").hide();
			}else{
				$("#alert-fail").show();
				$("#alert-success").hide();
			}			
		}else{
			$("#alert-form").show();
			$("#alert-fail").hide();
			$("#alert-success").hide();
		}
		
		
	});
	
	//submit클릭시
	function goSubmit(e){
		let pwd1=$("#newPass").val();
		let pwd2=$("#newPassCheck").val();
		let pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/;//6자 이상 12자 이하/ 1개의 문자,숫자 포함
		
		let check = confirm('정보를 수정하시겠습니까?');
	
		if(check == true){//수정하시겠습니까? 예.
			if(pwd1 == "" && pwd2 == ""){// 비밀번호 수정 안하고싶을때
				alert('수정되었습니다.');
				$("form").attr("action","/mypage/newInfo/"+${sessionScope.user_seq})
			}else{ //비밀번호칸에 뭐가 적혀있을때
				if(pattern.test(pwd1) == true){//양식통과O
					if(pwd1 == pwd2){
						alert('수정되었습니다.');
						$("form").attr("action","/mypage/newInfo/"+${sessionScope.user_seq});
					}else{
						alert('비밀번호 재확인하세요.');
						e.preventDefault();
					}
				}else{ //양식통과X
					alert('비밀번호 재확인하세요.');
					e.preventDefault();
				}
			}		
		}else{ //수정 아직 안해요
			e.preventDefalut();
		}
		
	}
	
	

	
</script>	

</body>
</html>