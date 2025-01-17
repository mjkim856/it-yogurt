<%@ include file="../common/tag.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
  <!--   <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet"> -->
     <link href="/css/admin.css" rel="stylesheet">
     <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
		    rel="stylesheet"/>
     <link href="/css/styles.css" rel="stylesheet">
     <link href="/css/container.css" rel="stylesheet">
<title> 커뮤니티 | 게시판 </title>

<style>
@font-face {
  font-family: 'NEXON Lv1 Gothic OTF';
  src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff') format('woff');
  font-weight: normal;
  font-style: normal;
}

#keyword {
    border-radius: 15px;
    width: 300px;
}
</style>
</head>
<body>
<%@include file="../common/nav.jsp"%>
<div class="container">
     <div class="form">
		<h3 id="main" > 게시판 </h3> <br>
		
		<!-- 검색을 위한 form -->
	<form action="<%=request.getContextPath()%>/board/list/searchResult" id="">
	<!-- 검색창 -->
	<input type="text" placeholder="검색어 입력" name="keyword" id="keyword">
    <button type="submit" id="search">검색</button>
			
	<!-- 게시판 테이블 -->		
		<table class="table">
		<!-- 게시판 제목 -->
		<thead>
			<tr>
				<th> 번호 </th>
				<th> 카테고리 </th>
				<th> 제목 </th>
				<th> 작성자 </th>
				<th> 조회수</th>
			</tr>
		</thead>	
		<!-- 게시판 내용 -->		
			<tbody class="listData">
			<c:set var="num" value="${paging.totalCount - ((paging.cri.page-1)* 10)}"/>
			<c:forEach items="${boardList }" var="list">
			<tr class="tableList" onClick="location.href='/board/${list.boardSeq}'">
				<td id ="boardSeq">${num}  </td>	
				<td>
				<span class="badge bg-secondary text-decoration-none link-light">${list.sub}</span>
				</td>
				<td style="text-align: left;">${list.title }</td>
				<td>${list.nickname }</td>
				<td>${list.viewcount }</td>
			</tr>
			<c:set var="num" value="${num-1 }"></c:set>
			</c:forEach>
			</tbody>
			</table>
		</form>
		
	<!-- 페이징 -->
	<div class="paging">
	<nav aria-label="Page navigation example" style="margin: 10px;">
			
		<ul class="pagination justify-content-center">
		<!-- 페이지 처음으로 가기 -->
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(1); return false;" class="page-link">
	        		<i class="fas fa-angle-double-left"></i>
	        	</a>
	        </li>
	    <%-- <c:if test="${paging.prev}"> --%>
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${paging.startPage-1});" class="page-link">
		        	<i class="fas fa-angle-left"></i>
		        </a>
	        </li>
	   <%--  </c:if> --%>
	    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
	    	<c:choose>
	    		<c:when test= "${num==1 }">
	        		<li class="page-item active" style="pagination-bg: #91ACCC"><span><a href='javascript:void(0);' onclick="go_page(${num}); return false;" class="page-link">${num}</a></span></li>
				</c:when>
				<c:otherwise>
	        		<li class="page-item" style="pagination-bg: #91ACCC"><span><a href='javascript:void(0);' onclick="go_page(${num}); return false;" class="page-link">${num}</a></span></li>
				</c:otherwise>
			</c:choose>	        
	    </c:forEach>
	    <c:if test="${paging.next && paging.endPage>0}">

	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${paging.endPage+1});return false;" class="page-link">
	        		<i class="fas fa-angle-right"></i>
	        	</a>
	        </li>
		 </c:if>
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${maxpage});return false;" class="page-link">
	        		<i class="fas fa-angle-double-right"></i>
	        	</a>
	        </li>
		</ul>

	</nav>
	</div>
	
<div class="d-grid gap-2 d-sm-flex justify-content-sm-end">
<!-- 글쓰기 버튼  -->
  		<button class="btn btn-primary" style="background-color: #91ACCC; font-size: 15px; width: 80px;" type="button" onClick="location.href='/board/form'">글쓰기</button>
</div>
	</div>

</div>
</body>



<script>


$(document).ready(function () {
  $('#search').click(function (e) {
    if ($('#keyword').val() == "") {
      e.preventDefault()
      alert("검색어를 입력해주세요!")
      return false;
    }
  })
});









function go_page(pageNum){

	$.ajax({
		url: "${pageContext.request.contextPath}/board/list/a?page="+pageNum,
		type: "GET",
		dataType: "json",
		success: function(result){
			let list = result.boardList;
			let paging = result.paging; 
			let number = (paging.totalCount - ((paging.cri.page-1)* 10));
			let content = '';
			for(let i=0;i<list.length;i++){
				content += '<tr class="tableList" onClick="window.location=\'/board/'+list[i].boardSeq+'\'">';
				content += '<td id ="boardSeq">' + number +'</td>';
				content += '<td><span class="badge bg-secondary text-decoration-none link-light"> '+ list[i].sub +'</span></td>';
				content +=	'<td style="text-align: left;">'+ list[i].title+ '</td>';
				content +=	'<td>'+ list[i].nickname + '</td>';
				content += '<td>' + list[i].viewcount + '</td>';
				content += '</tr>';
				number = number-1;
			}
			$('.listData').html(content);	
			
			let content2 = '';
			
				
				content2 += '<nav aria-label="Page navigation example" style="margin: 10px;">';
				content2 += '<ul class="pagination justify-content-center">';
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page(1); return false;" class="page-link"><i class="fas fa-angle-double-left"></i></a></li>';
								
				/* if(paging.prev){ */
					content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+(Number(paging.startPage)-1)+');return false;" class="page-link"><i class="fas fa-angle-left"></i></a></li>';
				/* } */
				for (let num = Number(paging.startPage) ; num <=Number(paging.endPage); num++){
					if (num == Number(paging.cri.page)){
						content2 += '<li class="page-item active" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';
						
					}
					else{
						content2 += '<li class="page-item" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';
					}
				}
				if (paging.next && paging.endPage>0){

					content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ (Number(paging.endPage)+1)+');return false;" class="page-link"><i class="fas fa-angle-right"></i></a></li>';
				}
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ Number(result.maxPage) +');return false;" class="page-link"><i class="fas fa-angle-double-right"></i></a></li>';
				content2 += '</ul>';
				content2 += '</nav>';
			
			
				$('.paging').html(content2);	
		},
		error: function(){
			console.log('error');
		}
	})
}

</script>

<%@include file="../common/footer.jsp" %>
</html>