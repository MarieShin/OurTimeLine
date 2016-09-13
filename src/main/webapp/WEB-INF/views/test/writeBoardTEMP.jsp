<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%-- <link rel="stylesheet" 
href="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/base/jquery-ui.css" type="text/css" />
<link rel="stylesheet" 
href="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css" type="text/css" />
 --%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<%-- <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>

<script type="text/javascript" 
src="${pageContext.request.contextPath}/plupload/js/jquery.ui.plupload/jquery.ui.plupload.js"></script>

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
 --%>
<!-- production -->
<script type="text/javascript" 
src="${pageContext.request.contextPath}/plupload/js/plupload.full.min.js"></script>

<script type="text/javascript">
$(function() {
	$('#uploader').pluploadQueue({
		
	})
	// Setup html5 version
	/* $("#uploader").pluploadQueue({
		// General settings
		runtimes : 'html5,flash,silverlight,html4',
		url : '${pageContext.request.contextPath}/board/fileTest.do',
		chunk_size: '1mb',
		rename : true,
		dragdrop: true,
		
		filters : {
			// Maximum file size
			max_file_size : '10mb',
			// Specify what files to browse for
			mime_types: [
				{title : "Image files", extensions : "jpg,gif,png"},
				{title : "Zip files", extensions : "zip"}
			]
		},

		// Resize images on clientside if we can
		resize : {width : 320, height : 240, quality : 90},

		flash_swf_url : '${pageContext.request.contextPath}/plupload/js/Moxie.swf',
		silverlight_xap_url : '${pageContext.request.contextPath}/plupload/js/Moxie.xap'
	}); */
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'pickfiles', // you can pass an id...
		container: document.getElementById('container'), // ... or DOM Element itself
		url : '${pageContext.request.contextPath}/board/fileTest.do',
		flash_swf_url : '../js/Moxie.swf',
		silverlight_xap_url : '../js/Moxie.xap',
		
		filters : {
			max_file_size : '10mb',
			mime_types: [
				{title : "Image files", extensions : "jpg,gif,png"},
				{title : "Zip files", extensions : "zip"}
			]
		},

		init: {
			PostInit: function() {
				document.getElementById('filelist').innerHTML = '';

				document.getElementById('uploadfiles').onclick = function() {
					uploader.start();
					return false;
				};
			},

			FilesAdded: function(up, files) {
				plupload.each(files, function(file) {
					document.getElementById('filelist').innerHTML += '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';
				});
			},

			UploadProgress: function(up, file) {
				document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
			},

			Error: function(up, err) {
				document.getElementById('console').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
			}
		}
	});

	uploader.init();
});
	function goList() {
		location.href = "${pageContext.request.contextPath}/board/getAll.do?page=${sessionScope.currentPage}";
	};
	function check() {
		if ($("#writeTitle").val().trim() == "") {
			alert("제목을 입력하세요");
			return false;
		}
		if ($("#writeContents").val().trim() == "") {
			alert("내용을 입력하세요");
			return false;
		}

	}
</script>
</head>

<body>
	<c:if test="${sessionScope.id == null }">
		<script>
			location.replace("${pageContext.request.contextPath}/views/login.jsp");
		</script>
	</c:if>
	
  	<form id="writeForm"
		action="${pageContext.request.contextPath}/board/writeBoard.do"
		method="post" enctype="multipart/form-data" onsubmit="return check();">
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" id="writeTitle" name="title" size="100"></td>
				<td><input type="file" class="file" name="file[]" value="파일"
					multiple></td>
			</tr>
			<tr>
				<th>내용</th>
			</tr>
			<tr>
				<td colspan="2"><textarea id="writeContents" name="contents"
						cols="100" rows="30"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="filelist">Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
				<br />
				
				<div id="container">
				    <a id="pickfiles" href="javascript:;">[Select files]</a> 
				    <a id="uploadfiles" href="javascript:;">[Upload files]</a>
				</div>
				
				<br />
				<pre id="console"></pre>

				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="확인"> 
				<input type="button" id="ListGo" value="목록" onclick="goList()"></td>
			</tr>
		</table>
	</form>

</body>
</html>