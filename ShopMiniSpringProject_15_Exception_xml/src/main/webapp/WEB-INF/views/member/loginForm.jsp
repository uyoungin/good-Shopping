<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.container{
	margin-top: 100px;
}
.modal-body{
	text-align: center;
}
p{
	margin: 0;
}
#modalBtn{
	display: none;
}
legend{
	font-size: xx-large;
}
</style>

<c:if test="${!empty mesg}">
	<script>
		alert('${mesg}');
	</script>
</c:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//아이디 비밀번호 필수
		$("form").submit(function() {
			if ($("#userid").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("userid 필수");
				event.preventDefault();
			} else if ($("#passwd").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("passwd 필수");
				event.preventDefault();
			}
		});
});
</script>

<div class="container col-md-4">
	<div class="signupContent justify-content-center">
		<form id="loginForm" action="login" method="post">
		  <fieldset>
		    <legend>Login</legend>
		    <div class="form-group">
		      <!-- 아이디 -->
		      <label for="exampleInputPassword1" class="form-label mt-4">Id</label>
		      <input type="text" class="form-control" name="userid" id="userid" placeholder="Enter Id">
		      <!-- 비밀번호 -->
		      <label for="exampleInputPassword1" class="form-label mt-4">Password</label>
		      <input type="password" class="form-control" name="passwd" id="passwd" placeholder="Enter Password">
		    </div>
		    <!-- 전송/취소 버튼 -->
		    <input type="reset" value="취소" class="btn btn-outline-primary float-end">
		    <input type="submit" value="로그인" id="loginBtn" class="btn btn-outline-primary float-end">
		  </fieldset>
		</form>
	</div>
</div>

<!-- 유효검사 모달 -->
<div class="modal" id="checkVal" data-bs-backdrop="static" data-bs-keyboard="false">
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