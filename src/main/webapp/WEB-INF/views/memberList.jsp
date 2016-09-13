<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ�� ���</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
function delMem(memseq){
	location.href="${pageContext.request.contextPath}/member/delMem.do?memseq="+memseq;

}
function goList(){
	location.href="${pageContext.request.contextPath}/board/getAll.do";
}
</script>
</head>
<body>
<c:if test="${sessionScope.id == null }">
	<script>
	alert("�α������ּ���");
	location.replace("${pageContext.request.contextPath}/member/goIndex.do");
	</script>
	</c:if>

<table class='table table-striped'>
<tr><th>���̵�</th><th>��й�ȣ</th><th>�̸�</th><th>����</th><th><input type="button" class="btn btn-primary" onclick="goList()" value="�Խ��ǰ���"></th></tr>
<c:forEach var="m" items="${memList}">
<tr>
<td>${m.id}</td><td>${m.pw}</td><td>${m.name}</td>
<td>
<c:if test="${m.auth ==1}">
<kbd>������</kbd>
</c:if>
<c:if test="${m.auth ==0}">
�Ϲݻ����
</c:if>
</td>
<td>
<c:if test="${sessionScope.id.id != m.id}">
<input  type="button" value="����" class="btn btn-danger" onclick="delMem(${m.mem_seq})">
</c:if>
<c:if test="${sessionScope.id.id == m.id}">
<kbd>����</kbd>
</c:if>
</td>
</tr>
</c:forEach>
</table>
	
</body>
</html>