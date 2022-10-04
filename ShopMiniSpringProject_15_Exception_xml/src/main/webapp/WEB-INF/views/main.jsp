<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Good Shopping</title>
<style>
#modalBtn{
	display: none;
}
.modal-body{
	text-align: center;
}
#mesg{
	margin: 0;
}
</style>
<c:if test="${not empty success}">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#modalBtn").trigger("click");
			$("#mesg").text('${success}');
		});
	</script>
</c:if>
</head>
<body>
<jsp:include page="common/top.jsp"></jsp:include><br>
<hr>
<jsp:include page="goods/goodsList.jsp"></jsp:include>
<!-- modal -->
<div class="modal" id="checkVal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Good Shopping</h5>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>
</body>
</html>