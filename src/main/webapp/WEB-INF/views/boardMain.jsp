<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
if(request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control","no-cache");	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script>

$(function(){
 $("#goMenu").click(function(){
	 location.href="${pageContext.request.contextPath}/member/goMenu.do";
 })
})
</script>

<style>
div {
	display: table;
	height: 30px;
	border: 1px solid graytext;
	width: 100%;
	text-align: center;
}

a {
	text-decoration: none;
	color: black;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>

 $(function(){
	
	 
	 if("${condition}" != ""){
		 $("#searchCondition").val("${condition}");
	 }
	 if("${contents}" != ""){
		 $("#searchContents").val("${contents}");
	 }
	 
	 if($("#searchCondition option:selected").val() == "all"){
		 $("#searchContents").val("");	
		 $("#searchContents").attr("disabled",true);
			
		}
	 
	  $("#searchCondition").on("change",function(){
		
		if($("#searchCondition option:selected").val() == "all"){
			 $("#searchContents").val("");	
			$("#searchContents").attr("disabled",true);
		}else{
			$("#searchContents").attr("disabled",false);
		}
	 }); 
	 
	 $("#searchBTN").click(function(){
		 
		 fnSearchCondition(1);
	 
	 });
	 
	 $("#goMenu").click(function(){
		 location.href="${pageContext.request.contextPath}/member/goMenu.do";
	 })
	$("#writeBt").click(function(){
		
		location.href="${pageContext.request.contextPath}/board/goWriteBoard.do";
		//$("#boardContents").load("${pageContext.request.contextPath}/views/writeBoard.jsp");
		//$("#boardContents").html(data);
		//location.href="${pageContext.request.contextPath}/views/writeBoard.jsp";
		
	});
	$("#mainLogin").click(function(){
		location.href="${pageContext.request.contextPath}/member/goIndex.do";
	})
	
	$("#mainLogout").click(function(event){
		event.preventDefault();
		$.post("${pageContext.request.contextPath}/member/logout.do",function(data){
			alert(data);
			location.replace("${pageContext.request.contextPath}/member/goIndex.do");
		});
	})
	
	 $("#goMemlist").click(function(){
			location.href="${pageContext.request.contextPath}/member/memlist.do";
		});
	
	$("#searchContents").on("focusin",function(){
		$("body").on("keypress",function(event){
			if(event.keyCode==13){
				fnSearchCondition(1);
			}
		});
	});

})
function fnSearchCondition(pageNo){
	 	$("#hiddenPage").val(pageNo);
		var contents = $("#searchContents").val();
		var condition = $("#searchCondition option:selected").val();
		$("#hiddenCondition").val(condition);
		var regexp =  /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi // 숫자,영문,한글

  	if(condition != "all" && contents.length == 0){
			alert("내용을 입력하세요");
			$("#searchContents").val("");
		}else{
			var sideRemove = 0;
			   for(var i=0; i<contents.length; i++){
		            if(contents.charAt(i) != " " && regexp.test(contents.charAt(i)) == true ){
						alert("특수문자는 입력불가능 합니다.");
						$("#searchContents").val("");
						return false;
					} else if(contents.charAt(i) == " "){
						//alert(contents.trim("").length+"//"+contents.length);
						if(i == 0 || i == contents.length-1){
							sideRemove = 1;
					
						}
						
						$("#searchContents").val("");
						//return false;
					}
		        }
			   if(sideRemove == 1){
				   
				   contents = contents.replace(/(^\s*)|(\s*$)/gi,"");
				   
			   }
			   $("#hiddenContents").val(contents);
			   
			   
			  $("#searchForm").submit();	
			  
	 
	 }
 }
function aBoardClick(id,event){
	 event.preventDefault();
		//alert($("a").attr("id"));
		
		location.href="${pageContext.request.contextPath}/board/boardDetail.do?boardNo="+id;
		url = "${pageContext.request.contextPath}/board/boardDetail.do";
		 /* $.get(url,{"boardNo":id}, function(data){
			 $("#boardContents").html(data);
		 }); */
 }
 
 function aPageClick(pageNo,event){
	 event.preventDefault();
	 if("${condition}" != ""){
		 fnSearchCondition(pageNo);
	 }else{
			location.href="${pageContext.request.contextPath}/board/getAll.do?page="+pageNo;			 
	 }
	 	
}

</script>
</head>
<body>
<c:if test="${sessionScope.id == null }">
	<script>
		alert("로그아웃되었습니다.");
		location.replace("${pageContext.request.contextPath}/member/goIndex.do");
	</script>
	</c:if>

	<header>
	<div>
		<c:if test="${sessionScope.id != null}">
		${sessionScope.id.id}(${sessionScope.id.name})님 안녕하세요.<input type="button" class="btn btn-danger" id="mainLogout"
				value="로그아웃">
		</c:if>
		<c:if test="${sessionScope.admin == true}">
			<input type="button" id="goMemlist" class="btn btn-info" value="회원목록">
		</c:if>
		<c:if test="${sessionScope.id == null}">
			<input type="button" id="mainLogin" value="로그인">
		</c:if>
		<input type="button" class="btn btn-primary" id="goMenu" value="메뉴가기">
	</div>
	</header>

	<article id="boardContents"> 
	<input type="button" id="writeBt" class="btn btn-success" value="글쓰기"> 
	
	<form id="searchForm" action="${pageContext.request.contextPath}/board/getByCondition.do" accept-charset="UTF-8">
	<select id="searchCondition">
		<option id="all" value="all">전체보기</option>
		<option id="writer" value="id">작성자</option>
		<option id="title" value="title">제목</option>
		<option id="contents" value="contents">글내용</option>
		<option id="filename" value="filename">첨부파일이름</option>
	</select>
	<input type="hidden" id="hiddenCondition"name="condition">
	<input type="hidden" id="hiddenContents"name="contents">
	<input type="hidden" id="hiddenPage"name="page">
	<input type="text" id="searchContents"><input type="button" id="searchBTN" value="검색">
	</form> 
	<!-- 보드내용 -->
	<table class='table table-striped'  width="100%">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="10%">작성자</th>
			<th width="5%">조회</th>
			<th width="25%">게시일</th>
		</tr>
		<c:if test="${bListSize > 0}">
			<c:forEach var="b" items="${bList}">
				<tr>
					<td><c:if test="${b.dept == 0}">${b.board_seq}</c:if>&nbsp;<c:if test="${b.fileCnt > 0 }">@</c:if></td>
					<td><c:choose>
							<c:when test="${b.dept == 1 }">
								ㄴ
							</c:when>	
							<c:when test="${b.dept == 2 }">
								&nbsp;&nbsp;&nbsp;&nbsp;ㄴ
							</c:when>
							<c:when test="${b.dept == 3 }">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ
							</c:when>
						</c:choose> 
						<c:if test="${b.isDel == 0}">

							<a href="#" id="${b.board_seq}"
								onclick="aBoardClick(${b.board_seq},event)">${b.title}</a>
						</c:if> 
						<!-- 취소선이면 --> 
						<c:if test="${b.isDel == 1}">
							<s>${b.title}</s>
						</c:if></td>
					<td>${b.writer}</td>
					<td>${b.hits}</td>
					<td>${b.reg_date}</td>
					<%-- <td>--${b.p_no}--</td><td>--${b.dept}--</td><td>--${b.reply_seq}</td> --%>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${bListSize == 0}">
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	
	
	<!-- 페이징 -->
		<c:if test="${currentBlock > 1}">
			<c:set var="prevshow" value="display:show" />
		</c:if>
		<c:if test="${currentBlock <= 1}">
			<c:set var="prevshow" value="display:none" />
		</c:if>

		<c:if test="${endPage < totalPageCnt}">
			<c:set var="nextshow" value="display:show" />
		</c:if>
		<c:if test="${endPage >= totalPageCnt}">
			<c:set var="nextshow" value="display:none" />
		</c:if>
<nav class="text-center" >
  <ul class="pagination pagination-lg">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous"  onclick="aPageClick(${startPage}-1,event)"
			style="${prevshow}">
        <span aria-hidden="true">&laquo;</span>
        <span class="sr-only" >Previous</span>
      </a>
    </li>
    <c:forEach var="page" begin="${startPage}" end="${endPage}">
			<li class="page-item"><a class="page-link" href="#" onclick="aPageClick(${page},event)">${page}</a></li>
	</c:forEach>
	<li class="page-item">
      <a class="page-link" href="#" aria-label="Next" onclick="aPageClick(${endPage}+1,event)"
			style="${nextshow}">
        <span aria-hidden="true">&raquo;</span>
        <span class="sr-only">Next</span>
      </a>
    </li>
  </ul>
</nav>
	
	
	
	
	</article>
	




	
	
	
<%-- 	<div>
		<c:if test="${currentBlock > 1}">
			<c:set var="prevshow" value="display:show" />
		</c:if>
		<c:if test="${currentBlock <= 1}">
			<c:set var="prevshow" value="display:none" />
		</c:if>

		<c:if test="${endPage < totalPageCnt}">
			<c:set var="nextshow" value="display:show" />
		</c:if>
		<c:if test="${endPage >= totalPageCnt}">
			<c:set var="nextshow" value="display:none" />
		</c:if>

		<a href="#" onclick="aPageClick(${startPage}-1,event)"
			style="${prevshow}">[Prev]&nbsp;</a>

		<c:forEach var="page" begin="${startPage}" end="${endPage}">
			<a href="#" onclick="aPageClick(${page},event)">|&nbsp;${page}&nbsp;|</a>
		</c:forEach>

		<a href="#" onclick="aPageClick(${endPage}+1,event)"
			style="${nextshow}">[Next]</a>

	</div> --%>

	
</body>
</html>