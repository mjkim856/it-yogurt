<%@ include file="../common/tag.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
     <link href="/css/admin.css" rel="stylesheet">
<title> 마이페이지 | 관리자 </title>
</head>
<style>
    .form {
        margin-top: 60%;
        margin-bottom: 60%;
    }
</style>
<%@include file="../common/nav.jsp" %>
<body>
<div class="container">
    <div class="form" >
		<h3 id="main" > 회원 관리 </h3> <br>
		<c:choose>
			<c:when test="${sessionScope.user_seq eq 1 || sessionScope.user_seq eq 2}">
				<button class="btn btn-primary px-5 py-2" onclick="location.href='user'">회원관리</button>
				<button class="btn btn-primary px-5 py-2" onclick="location.href='contents'">컨텐츠 등록</button>
				<button class="btn btn-primary px-5 py-2" onclick="location.href='../aws/email'">메일 발송</button>
			</c:when>
			<c:otherwise>
				<p> 관리자 로그인을 해주세요! </p>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</body>
<%@include file="../common/footer.jsp" %>
</html>