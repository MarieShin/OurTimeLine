<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script>

$(function(){
 $("#goMenu").click(function(){
	 location.href="${pageContext.request.contextPath}/member/goMenu.do";
 })
  $("#goBack").click(function(){
	 history.back();
 })
})
</script>

</head>

<body>
<pre></pre>
<pre></pre>
<pre></pre>
<pre></pre>
<div class="text-center">
<h1><kbd>NullPointerException</kbd></h1>
<h1><kbd>NullPointerException</kbd></h1>
<h1><kbd>NullPointerException</kbd></h1>
</div>
<pre></pre>
<pre></pre>
<pre></pre>
<pre></pre>
<input type="button" class="btn btn-primary" id="goMenu" value="메뉴가기">
<input type="button" class="btn btn-primary" id="goBack" value="뒤로가기">
</body>
</html>