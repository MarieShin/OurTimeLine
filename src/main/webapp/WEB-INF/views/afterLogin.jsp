<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MENU</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
$(function(){

	$("#golist").click(function(){
		location.href = "${pageContext.request.contextPath}/board/getAll.do";
	});
	
	$("#logout").click(function(){
		$.get("${pageContext.request.contextPath}/member/logout.do",function(data){
			alert(data);
			location.replace("${pageContext.request.contextPath}/member/goIndex.do");
		});
	});
	$("#goLogin").click(function(){
		location.replace("${pageContext.request.contextPath}/member/goIndex.do");
	});
	
	$("#goMemlist").click(function(){
		location.href="${pageContext.request.contextPath}/member/memlist.do";
	});
	
});
</script>
</head>
<body>

<c:if test="${sessionScope.id == null }">
	<script>
		alert("로그아웃되었습니다.");
		location.replace("${pageContext.request.contextPath}/member/goIndex.do");
	</script>
</c:if>
<div class="text-center">
<c:if test="${sessionScope.id != null}">

	<h1 ><kbd>MENU</kbd></h1>
<pre>${sessionScope.id.id}(${sessionScope.id.name})님 안녕하세요.</pre>
	<input id="golist" type="button" class="btn btn-default" value="게시판">
	<br/>
	<br/>
	<c:if test="${sessionScope.admin == true}">
		<input id="goMemlist" type="button" class="btn btn-info" value="회원목록보기">
		<br/>
		<br/>
	</c:if>
	<input id="logout" class="btn btn-danger" type="button" value="로그아웃">
	<br/>
	<br/>

	<c:set var="member" value="${sessionScope.id}"/>

		
		
</c:if>

<c:if test="${sessionScope.id == null}">
로그인해주세요.
<input id="goLogin"  class="btn btn-default" type="button" value="로그인">
</c:if>
</div>	
</body>
</html>