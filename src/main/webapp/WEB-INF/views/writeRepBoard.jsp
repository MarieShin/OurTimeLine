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

<title>답글쓰기</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plupload/js/plupload.full.min.js"></script>

<link rel="stylesheet"
	href="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/base/jquery-ui.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css"
	type="text/css" />

<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<!-- production -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/jquery.ui.plupload.js"></script>
<script type="text/javascript" src="../editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	type="text/css" />

<script>

	$(function() {
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "writeContents",
		    sSkinURI: "../editor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});
		
		
		
		  $("#uploader").plupload({
		        // General settings
		        runtimes : 'html5,flash,silverlight,html4',
		        url : "${pageContext.request.contextPath}/board/fileUpload.do",
		 
		        // Maximum file size
		        max_file_size : '10mb',
		 
		        chunk_size: '0mb',
		 
		        // Resize images on clientside if we can
		        resize : {
		            width : 200,
		            height : 200,
		            quality : 90,
		            crop: true // crop to exact dimensions
		        },
		 
		        // Specify what files to browse for
		        filters : [
		            {title : "Image files", extensions : "jpg,gif,png"},
		            {title : "Zip files", extensions : "zip,avi"}
		        ],
		 
		        // Rename files by clicking on their titles
		        rename: true,
		         
		        // Sort files
		        sortable: true,
		 
		        // Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
		        dragdrop: true,
		 
		        // Views to activate
		        views: {
		            list: true,
		            thumbs: true, // Show thumbs
		            active: 'thumbs'
		        },
		 
		        // Flash settings
		        flash_swf_url : '/plupload/js/Moxie.swf',
		     
		        // Silverlight settings
		        silverlight_xap_url : '/plupload/js/Moxie.xap',
		     
		        
		     });	
		

		$("#cancel").click(function() {
			location.href = "${pageContext.request.contextPath}/board/getAll.do?page="+${sessionScope.currentPage};
		});

		$('#submit').click(function(event) {
			
			event.preventDefault();
			oEditors.getById["writeContents"].exec("UPDATE_CONTENTS_FIELD", []);
			var title = replaceXss($("#writeTitle").val());
			//var contents = replaceXss($("#writeContents").val());
			var contents = $("#writeContents").val();
			if (check()) {
				$.post("${pageContext.request.contextPath}/board/writeRepBoard.do",
						{"title" : title,"contents" : contents, "no":$("#no").val(),
							"p_no":$("#p_no").val(), "dept":$("#dept").val()},function(data) {
							$("#hiddenCreateBoardSeq").val(data);
								//멀티파람 값 
						var uploader = $("#uploader").plupload("getUploader");
							uploader.bind('BeforeUpload',function(up,file) {
							up.settings.multipart_params = {"boardSeq" : $("#hiddenCreateBoardSeq").val()}
							});

						if ($('#uploader').plupload('getFiles').length > 0) {
							// When all files are uploaded submit form
								$('#uploader').on('complete',function() {
									alert("답글 작성이 완료되었습니다.");
									location.replace("${pageContext.request.contextPath}/board/getAll.do");
								});
						$('#uploader').plupload('start');
						} else {
								alert("답글 작성이 완료되었습니다.");
								location.replace("${pageContext.request.contextPath}/board/getAll.do");
						}
				});

			}
	});
});
	function replaceXss(str) {
		if (str == null) {
			str = "";
		} else {
			str = str.replace(/&/gi, "&amp;").replace(/</gi, "&lt;").replace(
					/>/gi, "&gt;").replace(/\"/gi, "&quot;");
		}
		return str;
	}
	
	function check() {
		/* if(($("#writeTitle").val().trim().size > 49)){
			alert("글자수가 초과되었습니다.");
			return false;
		} */
		if($("#writeTitle").val().length > 50){
			alert("제목 길이 제한을 초과하였습니다."+$("#writeTitle").val().length+"/50" );
			return false;
		}
		if ($("#writeTitle").val().trim() == "") {
			alert("제목을 입력하세요");
			return false;
		}
		
		return true;

	}
	
</script>
</head>
<body>
	<c:if test="${sessionScope.id == null }">
		<script>
			alert("로그인해주세요");
			location.replace("${pageContext.request.contextPath}/member/goIndex.do");
		</script>
	</c:if>
	<h1>
	${sessionScope.id.id}(${sessionScope.id.name})님
		<kbd>답글쓰기</kbd>
	</h1>
	<form id="writeForm"
		action="${pageContext.request.contextPath}/board/writeRepBoard.do"
		method="post">
		<input type="hidden" id="no" name="no" value="${no}"> 
		<input type="hidden" id="p_no" name="p_no" value="${p_no}"> 
		<input type="hidden" id="dept" name="dept" value="${repDept}"> 
		<input type="submit" id="submit" class="btn btn-primary" value="확인">
		<input id="cancel" class="btn btn-default" type="button" value="취소">
		<table class="table table-condensed" width="100%">

			<tr>
				<th>제목</th>
				<td colspan="2">
					<input class="form-control" value="re: ${parentBoard.title} : " 
					type="text" id="writeTitle"	name="title" size="100">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="4">
					<!-- <textarea class="form-control" id="writeContents" name="contents" cols="50" rows="20"></textarea> -->
					<textarea class="form-control" name="contents" id="writeContents" rows="10" cols="100"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div id="uploader">
						<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
					</div>
				</td>
				<td><input type="hidden" id="hiddenCreateBoardSeq"></td>
			</tr>
		</table>
	</form>

</body>
</html>