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
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
$(function(){
	$("#id").on("focusout",function(){
		var text = $("#id").val();
        var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
        // var regexp = /[0-9]/; // 숫자만
//         var regexp = /[a-zA-Z]/; // 영문만
        
        for(var i=0; i<text.length; i++){
            if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == false ){
				alert("한글이나 특수문자는 입력불가능 합니다.");
				$("#id").val("");
				return false;
			}else if(text.trim().length == 0){
				alert("공백은 입력할 수 없습니다.");
				$("#id").val("");
				return false;
			}
        }	
	});
	$("body").on("focusin",function(){
		opener.document.getElementsByTagName("a").readOnly=true; //부모창 readonly 
		opener.document.getElementsByTagName("a").disabled=true; //부모창 비활성화
	});
	$("form").submit(function(event){
		event.preventDefault();
		var url="${pageContext.request.contextPath}/member/login.do";
		$.post(url, {id:$("#id").val(),pw:$("#pw").val()},function(data) {
			if(data.trim() == "y"){
				alert("로그인에 성공하였습니다.");
				 window.opener.location.replace("${pageContext.request.contextPath}/member/goMenu.do");
				window.close();
				
				
			}else{
				
				alert("아이디 또는 비밀번호를 확인해주세요.");
			}					
		});
	});
	
	
	
});
function a(){ 
	window.opener.location.href="${pageContext.request.contextPath}/member/goSignup.do";
window.close();
	
}
</script>

</head>
<body>
<h1 class="text-center" ><kbd>LOGIN</kbd></h1>
<c:if test="${sessionScope.id == null}">
<form class="form-horizontal" method="post">
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">ID</label>
		 	<div class="col-sm-10">
				 <input type="id" class="form-control" id="id" placeholder="ID">
    		</div>
  		</div>
  	<div class="form-group">
  	 <label for="pw" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="pw" placeholder="Password">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      </div>
    </div>
  
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Log In</button>
      <input type="button" class="btn btn-default" id="signup" value="signup" onclick="a()">
    </div>
  </div>
</form>
 </c:if>
</body>
</html>