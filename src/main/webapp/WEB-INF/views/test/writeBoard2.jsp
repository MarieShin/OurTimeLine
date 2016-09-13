<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/js/vendor/jquery.ui.widget.js"></script>
<script
	src="${pageContext.request.contextPath}/js/jquery.iframe-transport.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.fileupload.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plupload/js/plupload.full.min.js"></script> --%>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="http://www.plupload.com/plupload/js/plupload.full.min.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="http://www.plupload.com/plupload/js/jquery.plupload.queue/jquery.plupload.queue.min.js"
	charset="UTF-8"></script>
<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/plupload//js/jquery.plupload.queue/css/jquery.plupload.queue.css"
	media="screen" />
<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/css/bootstrap.css" media="screen" />
<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/css/font-awesome.min.css" media="screen" />

<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/css/prettify.css" media="screen" />
<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/css/shCore.css" media="screen" />
<link type="text/css" rel="stylesheet"
	href="http://www.plupload.com/css/shCoreEclipse.css" media="screen" />
<!-- 
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
<script>

$("#html5_uploader").pluploadQueue({
    // General settings
    runtimes : 'html5',
    url : "${pageContext.request.contextPath}/board/fileTest.do",
    chunk_size : '1mb',
    unique_names : true,
     
    filters : {
        max_file_size : '10mb',
        mime_types: [
            {title : "Image files", extensions : "jpg,gif,png"},
            {title : "Zip files", extensions : "zip"}
        ]
    },

    // Resize images on clientside if we can
    resize : {width : 320, height : 240, quality : 90}
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
			location
					.replace("${pageContext.request.contextPath}/views/login.jsp");
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
			<td><div id="html5_uploader"></div></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="확인"> <input
					type="button" id="ListGo" value="목록" onclick="goList()"></td>
			</tr>
		</table>
	</form>

</body>
</html>