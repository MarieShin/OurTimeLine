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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plupload/js/plupload.full.min.js"></script>

<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/base/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css" type="text/css" />

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<!-- production -->
<script type="text/javascript" src="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/jquery.ui.plupload.js"></script>
<script type="text/javascript" src="../editor/js/HuskyEZCreator.js" charset="utf-8"></script>


<script type="text/javascript">

$(function(){
	  
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
 
    /*  $('#submit').click(function(event){
    	 event.preventDefault();
    	 alert("서브밋!");

    	 $.post("${pageContext.request.contextPath}/board/writeBoard.do", 
    			 {"title":$("#writeTitle").val(), "contents":$("#writeContents").val()}, function(data){
    				 if ($('#uploader').plupload('getFiles').length > 0) {
    		     			// When all files are uploaded submit form
    		     			
    		     				alert("1"+status);
    		     				
    		     				$('#uploader').plupload('start'); 
    		     				
    		     		
    		     		}
    				location.replace("${pageContext.request.contextPath}/board/getAll.do");
    			 });    		
     }); */
     
     $('#submit').click(function(event){
    	 event.preventDefault();
    	// function submitContents(elClickedObj) {
    		    // 에디터의 내용이 textarea에 적용된다.
    		  oEditors.getById["writeContents"].exec("UPDATE_CONTENTS_FIELD", []);
    		 
    		    // 에디터의 내용에 대한 값 검증은 이곳에서
    		    // document.getElementById("ir1").value를 이용해서 처리한다.
    		    
    		        //elClickedObj.form.submit();
    	 var title = replaceXss($("#writeTitle").val());
    	// var contents = replaceXss($("#writeContents").val());
    	 var contents = $("#writeContents").val();
		if(check()){
    	 $.post("${pageContext.request.contextPath}/board/writeBoard.do", 
    			 {"title":title, "contents":contents}, 
    			 function(data){
    				 $("#hiddenCreateBoardSeq").val(data);
    				 //멀티파람 값 
    				 var uploader = $("#uploader").plupload("getUploader");
    				 //alert(uploader);
    				 uploader.bind('BeforeUpload', 
    					function (up, file) {
    					 up.settings.multipart_params = {"boardSeq": $("#hiddenCreateBoardSeq").val()
    					}
    					
    					//up.settings.multipart_params = {"boardSeq": data}
    				});
    			/*  	$('#uploader').plupload.bind('BeforeUpload', function (up, file) {
    					alert('1');
    					//up.settings.multipart_params = {"boardSeq": data}
    				}); */
    				  
    				/* upload.bind('BeforeUpload', function (up, file) {
    					alert('2');
    					//up.settings.multipart_params = {"boardSeq": data}
    				}); */
    				
    				 if ($('#uploader').plupload('getFiles').length > 0) {
    			   			// When all files are uploaded submit form
    			    			$('#uploader').on('complete', function() {
    			    				alert("게시글 작성이 완료되었습니다.");
    			    				location.replace("${pageContext.request.contextPath}/board/getAll.do");
    			 				}); 
    			 				$('#uploader').plupload('start');
    			 		 }	else{
    			 				alert("게시글 작성이 완료되었습니다.");
    		   			 		location.replace("${pageContext.request.contextPath}/board/getAll.do");
    		   			 	}
    				
    			 });    
		}
/*     	 if ($('#uploader').plupload('getFiles').length > 0) {
   			// When all files are uploaded submit form
    			$('#uploader').on('complete', function() {
 					$('#writeForm').submit();	
 				}); 
 				$('#uploader').plupload('start');
 		 }	 */
    		
     })
})
function replaceXss(str){
    	        if(str == null) {
    	                str = "";
    	        } else {
    	                str = str.replace(/&/gi, "&amp;")
    	                             .replace(/</gi, "&lt;")           
    	                             .replace(/>/gi, "&gt;")
    	                             .replace(/\"/gi, "&quot;");
    	        }
    	       
    	        return str;
}

function goList() {
	location.href = "${pageContext.request.contextPath}/board/getAll.do?page=${sessionScope.currentPage}";
};
	
function check() {
	
	if($("#writeTitle").val().length > 50){
		alert("제목 길이 제한을 초과하였습니다."+$("#writeTitle").val().length+"/50" );
		return false;
	}

	if ($("#writeTitle").val().trim("") == "" ) {
		
		alert("제목을 입력하세요");
		return false;
	}
	return true;
	
	/* else{
		 if ($('#uploader').plupload('getFiles').length > 0) {
  			// When all files are uploaded submit form
  			alert('1');
   			$('#uploader').on('complete', function() {
   				alert('2');
					$('#writeForm').submit();	
			}); 
   			alert('3');
				$('#uploader').plupload('start');
			alert('4');
				//return false;
		 }	
  		
  		} */
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
	
	<h1>${sessionScope.id.id}(${sessionScope.id.name})님<kbd>글쓰기</kbd></h1>
	<button id='submit' class="btn btn-primary">글저장</button>
<input type="button" class="btn btn-default" id="ListGo" value="목록" onclick="goList()">

	
  	<form id="writeForm"
		action="${pageContext.request.contextPath}/board/writeBoard.do"
		method="post" onsubmit="return check();">
		<table class="table table-condensed" width="100%">
			<tr>
				<th>제목</th> 
				<td><input type="text" class="form-control" placeholder="Title" id="writeTitle" name="title" size="100"></td>
			</tr>
			<tr>
				<th>내용</th>
			<td></td>
			</tr>
			<tr>
				<td colspan="6">
				<!-- <textarea class="form-control" id="writeContents" name="contents"cols="100" rows="20"></textarea> -->
				<textarea class="form-control" name="contents" id="writeContents" rows="10" cols="100"></textarea>
				
				</td>
			</tr>
			<tr>
				<td colspan="2">
			
				<div id="uploader">
				    <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
				</div>

				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="hidden" id="hiddenCreateBoardSeq" >
				</td>
			</tr>
		</table>
	</form>

</body>
</html>