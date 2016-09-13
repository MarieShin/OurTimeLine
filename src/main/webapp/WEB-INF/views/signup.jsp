<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>회원 가입</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	$(function() {
		$("#id").on("focusout",function(){
			var text = $("#id").val();
			
	        var regexp = /[0-9a-zA-Z]/; // 숫자,영문

	        for(var i=0; i<text.length; i++){
	            if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == false  ){
					alert("한글이나 특수문자는 입력불가능 합니다.");
					$("#id").val("");
					return false;
				}else if(text.trim("").length != text.length){
					alert("공백은 입력이 불가능합니다.");
					$("#id").val("");
					return false;
				}
	            
	        }
		});
		$("#password").on("focusout",function(){
			var text = $("#password").val();
			
	        //var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
	        // var regexp = /[0-9]/; // 숫자만
//	         var regexp = /[a-zA-Z]/; // 영문만
			
	        for(var i=0; i<text.length; i++){
	        	if(text.trim("").length != text.length){
					alert("공백은 입력이 불가능합니다.");
					$("#password").val("");
					return false;
				}
	        }
	        if(text.length <= 4 ){
	        	alert("비밀번호는 5자리 이상입력해주세요.");
	        	$("#password").val("");
	        }
		});
		
		$("#passwordch").on("focusout",function(){
			var text1 = $("#password").val();
			var text2 = $("#passwordch").val();
	        
	        if(text1 != text2 ){
	        	alert("비밀번호를 확인해주세요");
	        	$("#password").val("");
	        	$("#passwordch").val("");
	        }
		});
		$("#name").on("focusout",function(){
			var text = $("#name").val();
			
	        var regexp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
	        for(var i=0; i<text.length; i++){
	        	if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == true){
	        		alert("특수문자는 입력불가능 합니다.");
					$("#id").val("");
					return false;
	        	}else if(text.trim("").length != text.length){
					alert("공백은 입력이 불가능합니다.");
					$("#name").val("");
					return false;
				}
	        }
		});

		
		
		$("#idchk").click(function() {
			var chkId = ($("#id").val());
			if (chkId == "") {
				alert("아이디를 입력해주세요");
			} else {
				$.post("${pageContext.request.contextPath}/member/idchk.do", {
					id : chkId
				}, function(data) {
					if (data.trim() == "y") {
						//아이디를 사용할 수 있으면
						alert("아이디를 사용할 수 있습니다.");

					} else if (data.trim() == "n") {
						alert("아이디를 사용할 수 없습니다.");

					}
					$("#hiddenId").val(data);
				});
			}

		});
		$("form").submit(function(event) {
							event.preventDefault();
							var url = "${pageContext.request.contextPath}/member/signup.do";

							if ($("#id").val().trim() == "") {
								alert("아이디를 적어주세요!");
							}
							if ($("#hiddenId").val().trim() != "y") {
								/* alert($("#hiddenId").val()); */
								alert("아이디 중복 체크 필수!");
							}
							if ($("#name").val().trim() == "") {
								alert("이름을 적어주세요!");
							}
							if (($("#password").val().trim() == "")
									|| ($("#password").val() != $("#passwordch")
											.val())) {
								alert("비밀번호를 확인해 주세요");
								$("#hiddenPw").val("n");
							} else if (($("#password").val().trim() != "")
									&& ($("#password").val() == $("#passwordch").val())) {
								$("#hiddenPw").val("y");
							}
							//서브밋

							if (($("#password").val() == $("#passwordch").val())
									&& ($("#id").val().trim() != "")
									&& ($("#id").val().trim() != "")
									&& ($("#hiddenId").val().trim() == "y")
									&& ($("#hiddenPw").val().trim() == "y")
									&& $("#name").val().trim() != "") {
								var id_val = $("#id").val();
								var name_val = $("#name").val();
								var pw_val = $("#password").val();
								$.post(	url,{id : id_val,pw : pw_val,name : name_val},function(data, status) {
										
										if (status == "success") {
											alert(data);
											location.href = "${pageContext.request.contextPath}/member/goIndex.do";
										}

									});

							}

						});
	})
	function goLogin(){
		location.replace("${pageContext.request.contextPath}/member/goIndex.do");
	}
</script>
</head>
<body>
<h1><kbd>회원가입</kbd></h1>
<input type="button" value="처음으로" class="btn btn-primary" onclick="goLogin()">
<form name="form">
  <div class="form-group">
    <label for="id">ID</label>
    <input type="text" class="form-control" id="id" name="id" placeholder="id">
	<input type="button" class="btn btn-default" id="idchk" value="중복확인">
	<input type="hidden" id="hiddenId">
  </div>
  <div class="form-group">
    <label for="password">Password (5자리이상)</label>
    <input type="password" class="form-control" id="password" name="pw" placeholder="Password">
    
  </div>
  <div class="form-group">
    <label for="pwch">Pw Check</label>
    <input type="password" class="form-control"  id="passwordch" name="pwch" placeholder="Pw Check">
    <input type="hidden" id="hiddenPw">
  </div>
 
  <div class="form-group">
    <label for="name">Name</label>
    <input type="text" class="form-control"  id="name" id="name" placeholder="Name">
    
  </div>
 <input type="submit" class="btn btn-primary" value="가입하기">
					<input type="reset" class="btn btn-default" value="reset">

</form>
	
	
				
			
					
	


</body>
</html>