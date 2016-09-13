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
<%-- <c:if test="${boardDetail.writer == sessionScope.id.id}">
<c:set var="check" value="display:show;"></c:set>
</c:if>
<c:if test="${boardDetail.writer != sessionScope.id.id}">
<c:set var="check" value="display:none;"></c:set>
</c:if> --%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<style type="text/css">
a {
	text-decoration: none;
	color: black;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세보기</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	function del(no) {
		alert("삭제되었습니다.");
		location.href = "${pageContext.request.contextPath}/board/boardDel.do?no="+no;
	}
	function edit(no) {
		//alert(no);
		location.href = "${pageContext.request.contextPath}/board/boardEdit.do?no="+no;
	}
	function rep(no, dept, pno) {
		//alert(no);
		location.href = "${pageContext.request.contextPath}/board/replyBoard.do?no="+no+"&dept="+dept+"&pno="+pno;
	}
	function goList() {
		if("${sessionScope.condition}" != ""){
			location.href = 
				"${pageContext.request.contextPath}/board/getByCondition.do?page=${sessionScope.currentPage}&condition=${sessionScope.condition}&contents=${sessionScope.contents}";
		}else{
			location.href = 
				"${pageContext.request.contextPath}/board/getAll.do?page="+${sessionScope.currentPage};	
		}
		
	}
	function down(a, b, event) {
		event.preventDefault();

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
	<h1>
	${sessionScope.id.id}(${sessionScope.id.name})님
		<kbd>게시글보기</kbd>
	</h1>
<c:if
		test="${(sessionScope.id.id == boardDetail.writer)}">
		<input type="button"  class="btn btn-info" value="수정"
			onclick="edit('${boardDetail.board_seq}')">
		
	</c:if>
	<c:if
		test="${(sessionScope.id.id == boardDetail.writer)||(sessionScope.admin == true)}">
		<input type="button"  class="btn btn-danger" value="삭제"
			onclick="del('${boardDetail.board_seq}')">
	</c:if>

	<c:if test="${boardDetail.dept < 3}">
		<input type="button" value="답글" class="btn btn-success"
			onclick="rep('${boardDetail.board_seq}','${boardDetail.dept}','${boardDetail.p_no}')">
	</c:if>
	<input type="button" value="목록" class="btn btn-primary" onclick="goList()">

	<table class="table table-condensed" width="100%">

	 	<tr class="info">
			<th >제목:</th><td>${boardDetail.title}</td><th>조회수 :</th><td> ${boardDetail.hits}</td>
		</tr> 
		<tr class="info">
		<th>작성자:</th><td> ${boardDetail.writer}(${boardDetail.writername})</td>
		<th>작성일:</th><td> ${boardDetail.reg_date}</td>
		</tr>
			<c:if test="${fileListSize > 0}">

					<c:forEach var="file" items="${fileList}">
						<tr class="warning">
							<th>파일명:</th>
							<td><a
								href="${pageContext.request.contextPath}/board/down.do?board_seq=${boardDetail.board_seq}&fileseq=${file.fileNo}">
									${file.fileName1}</a>
							</td>
							<th>사이즈:</th>
							<td> ${file.fileSize}</td>
						</tr>
					</c:forEach>

				</c:if>
			
		
		<tr class="success">
			<th>내용</th><td colspan="4"></td>
		</tr>
		<tr class="success">
			<td colspan="6" width="100%" height="400px;" valign="top">${boardDetail.contents}</td>
		</tr>

	</table>
</body>
</html>