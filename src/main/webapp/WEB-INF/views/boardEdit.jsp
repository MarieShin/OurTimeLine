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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정</title>
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
    
    $('#submit').click(function(event){
   	 event.preventDefault();
   	oEditors.getById["writeContents"].exec("UPDATE_CONTENTS_FIELD", []);
    var title = replaceXss($("#writeTitle").val());
	// var contents = replaceXss($("#writeContents").val());
	 var contents = $("#writeContents").val();
   	 //파일삭제
   	 if(check()){
   		 if($("#hiddenBoard_seq").val().trim() !="" ){
   			$.post("${pageContext.request.contextPath}/board/delFile.do",{"boardseq":$("#hiddenBoard_seq").val(),"deleteFile":$("#deleteFile").val()});		 
   		 }
   
   	 //글수정
   	   
   	 $.post("${pageContext.request.contextPath}/board/doBoardEdit.do", 
   			 {"board_seq":$("#hiddenBoard_seq").val(),"title":title,
   		 "contents":contents}, function(data){	 
   				 $("#hiddenCreateBoardSeq").val(data);
   				 //멀티파람 값 
   				 var uploader = $("#uploader").plupload("getUploader");
   		
   				 uploader.bind('BeforeUpload', function (up, file) {
   					 up.settings.multipart_params = {"boardSeq": $("#hiddenBoard_seq").val()}
   				});
   				 if ($('#uploader').plupload('getFiles').length > 0) {
   			   			// When all files are uploaded submit form
   			    			$('#uploader').on('complete', function() {
   			    				alert("게시글 수정이 완료되었습니다.");
   			    				location.replace("${pageContext.request.contextPath}/board/boardDetail.do?boardNo=${detail.board_seq}");
   			 				}); 
   			 				$('#uploader').plupload('start');
   			 	}else{
   			 		alert("게시글 수정이 완료되었습니다.");
   			 		location.replace("${pageContext.request.contextPath}/board/boardDetail.do?boardNo=${detail.board_seq}");
   			 	}
   				
   			 });    
/*     	 if ($('#uploader').plupload('getFiles').length > 0) {
  			// When all files are uploaded submit form
   			$('#uploader').on('complete', function() {
					$('#writeForm').submit();	
				}); 
				$('#uploader').plupload('start');
		 }	 */
   	 }
    })
    
});
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
function cancel(no){
	//location.href="${pageContext.request.contextPath}/board/boardDetail.do?boardNo="+no;
	history.back(-1);
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

function check(){
	if($("#writeTitle").val().length > 50){
		alert("제목 길이 제한을 초과하였습니다."+$("#writeTitle").val().length+"/50" );
		return false;
	}
	if($("#writeTitle").val().trim()==""){
		alert("제목을 입력하세요");
		return false;
	}


	return true;
}

function delFile(no,name2){
	//alert(no);
	$("#"+no).hide();
	var deleteFile = $("#deleteFile").val();
	deleteFile += name2+",";
	$("#deleteFile").val(deleteFile);

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
	<kbd>글수정</kbd>
	</h1>
<button id='submit'class="btn btn-success">글저장</button>
<input type="button" value="취소" class="btn btn-default" onclick="cancel(${detail.board_seq})">
<input type="button" value="목록" class="btn btn-primary" onclick="goList()">
<form action="${pageContext.request.contextPath}/board/doBoardEdit.do" method="post" onsubmit="return check();">
<input type="hidden" id="hiddenBoard_seq" name="board_seq"value="${detail.board_seq}"> 
<table class="table table-condensed" width="100%">

<tr><th>제목 </th><td colspan="4"><input type="text"  class="form-control" id="writeTitle"name="title" value="${detail.title}" size="100%"></td></tr>
	<tr>
			<c:if test="${fileListSize > 0}">
					<input type="hidden" name="deleteFile" id="deleteFile">
					<c:forEach var="file" items="${fileList}">
						<tr class="warning" id="${file.fileNo}">
							<th>파일명:</th>
							<td><a
								href="${pageContext.request.contextPath}/board/down.do?board_seq=${boardDetail.board_seq}&fileseq=${file.fileNo}">
									${file.fileName1}</a>
							</td>
							<th>사이즈:</th>
							<td> 
							${file.fileSize}
							</td>
							<td colspan="2"><input type="button" value="x" class="btn btn-danger" onclick="delFile('${file.fileNo}','${file.fileName2}')">
							 </td>
						</tr>
					</c:forEach>

				</c:if>
			
		
		<tr>
<tr><th width="20%">내용</th><td colspan="4"></td></tr>
<tr><td colspan="8">
<%-- <textarea class="form-control"  name="contents" id="writeContents" cols="100" rows="20">${detail.contents}</textarea> --%>
<textarea class="form-control" name="contents" id="writeContents" rows="10" cols="100">${detail.contents}</textarea>
</td></tr>
<tr><td colspan="6">
<div id="uploader">
				    <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
				</div></td></tr>
</table>
</form>

</body>
</html>