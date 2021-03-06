<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>

<title>Plupload - Custom example</title>

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
<%-- 
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css"
	type="text/css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/dropzone.css"
	type="text/css" rel="stylesheet" /> --%>


</head>
<!--<body style="font: 13px Verdana; background: #eee; color: #333">

<h1>Custom example</h1>

<p>Shows you how to use the core plupload API.</p>

<div id="filelist">Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
 <br />

<div id="container">
    <a id="pickfiles" href="javascript:;">[Select files]</a> 
    <a id="uploadfiles" href="javascript:;">[Upload files]</a>
</div>

<br />
<pre id="console"></pre>

<h3>Flash runtime</h3>
<div id="flash_uploader">Your browser doesn't have Flash installed.</div>
 
<h3>Silverlight runtime</h3>
<div id="silverlight_uploader">Your browser doesn't have Silverlight installed.</div>
 
<h3>HTML 4 runtime</h3>
<div id="html4_uploader">Your browser doesn't have HTML 4 support.</div>
  -->
<h3>HTML 5 runtime</h3>
<div id="html5_uploader">Your browser doesn't support native upload.</div>

<script type="text/javascript">
// Custom example logic


$(function() {
   /*  // Setup flash version
    $("#flash_uploader").pluploadQueue({
        // General settings
        runtimes : 'flash',
        url : "/examples/upload",
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
        resize : {width : 320, height : 240, quality : 90},
 
        // Flash settings
        flash_swf_url : '../js/Moxie.swf'
    });
 
 
    // Setup silverlight version
    $("#silverlight_uploader").pluploadQueue({
        // General settings
        runtimes : 'silverlight',
        url : "/examples/upload",
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
        resize : {width : 320, height : 240, quality : 90},
 
        // Silverlight settings
        silverlight_xap_url : '../js/Moxie.xap'
    });
  */
    // Setup html5 version
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
 
 
  /*   // Setup html4 version
    $("#html4_uploader").pluploadQueue({
        // General settings
        runtimes : 'html4',
        url : "/board/fileTest.do",
        unique_names : true,
         
        filters : {
            mime_types: [
                {title : "Image files", extensions : "jpg,gif,png"},
                {title : "Zip files", extensions : "zip"}
            ]
        }
    }); */
});
</script>


</body>
</html>
