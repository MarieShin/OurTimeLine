<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
a {
	 text-decoration:none;
	 color: black;
	 }
</style>
<title>Insert title here</title>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script

	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
$(function(){
	$("#goLogin").click(function(event){
		event.preventDefault();
		window.open("${pageContext.request.contextPath}/member/goLogin.do","loginWindow", "scrollbars=no ,width = 500, height= 300, left=300, top=200");
	});
	$("#goList").click(function(event){
		event.preventDefault();
		location.replace("${pageContext.request.contextPath}/board/getAll.do");
	});
});

</script>
</head>
<body>
<blockquote>
	<h1 class="text-center" ><kbd>BOARD</kbd></h1>
</blockquote>
	<pre></pre>
	<pre></pre>
	<pre></pre>
	<pre></pre>
	<pre></pre>

<div class="text-center">
	<c:if test="${sessionScope.id == null }">
		<button id="goLogin" class="btn btn-lg btn-primary btn-lg">LOGIN</button>
	</c:if>
	<c:if test="${sessionScope.id != null }">
		<button class='btn btn-primary' id="goList" class="btn btn-lg btn-primary ">목록</button>
	</c:if>
		<a href="${pageContext.request.contextPath}/member/goSignup.do" class="btn btn-default" role="button">SIGNUP</a>
</div>
</body>
</html>