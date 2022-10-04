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

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script type="text/javascript">
	$(document).ready(function(){
		
		//아이디 중복 확인
		$("#userid").keyup(function() {
			$.ajax({
				type : "get",
				url : "idDuplicateCheck",
				dataType : "text",
				data: {
					id : $("#userid").val(), //parameter id=입력하는 값 keyup event시 마다
				},
				success: function(data, status, xhr) {
					console.log(data);
					$("#result").text(data);
				},
				error: function(xhr, status, error) {
					console.log("error");
				}
			});
		});
		
		//비밀번호 확인
		$("#passwd2").keyup(function() {
			let mesg = '비밀번호 일치';
			if ($("#passwd").val() != $(this).val()) {
				mesg = '비밀번호 불일치';
			}
			$("#result2").text(mesg);
		});
		
		//이메일 select
		$("#emailSel").change(function() {
			$("#email2").val($(this).val());
		});
		
		//form 제출 전 미입력값 검사
		$("form").submit(function() {
			if ($("#userid").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("아이디 미입력");
				event.preventDefault();
			} else if ($("#passwd").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("비밀번호 미입력");
				event.preventDefault();
			} else if ($("#passwd2").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("비밀번호 미확인");
				event.preventDefault();
			} else if ($("#username").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("이름 미입력");
				event.preventDefault();
			} else if ($("#sample4_postcode").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("우편번호 미입력");
				event.preventDefault();
			} else if ($("#sample4_roadAddress").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("주소 미입력");
				event.preventDefault();
			} else if ($("#sample4_jibunAddress").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("주소 미입력");
				event.preventDefault();
			} else if ($("#phone1").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("전화번호 미입력");
				event.preventDefault();
			} else if ($("#phone2").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("전화번호 미입력");
				event.preventDefault();
			} else if ($("#phone3").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("전화번호 미입력");
				event.preventDefault();
			} else if ($("#email1").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("이메일 미입력");
				event.preventDefault();
			} else if ($("#email2").val().length==0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("이메일 미입력");
				event.preventDefault();
			}
		});
	});
</script> 

<div class="container col-md-4">
	<div class="signupContent justify-content-center">
		<form action="memberAdd" method="post"><!-- web.xml에서 post 한글 처리 -->
		  <fieldset>
		    <legend>Sign Up</legend>
		    <div class="form-group">
		      <!-- 아이디 -->
		      <label for="exampleInputId" class="form-label mt-4">Id</label>
		      <div class="input-group">
		      <input type="text" class="form-control" name="userid" id="userid"  placeholder="Enter Id" aria-label="idHelp" aria-describedby="checkBtn">
		      <span id="result"></span>
		      </div>
		      <!-- 비밀번호 -->
		      <label for="exampleInputPassword1" class="form-label mt-4">Password</label>
		      <div class="input-group">
		      <input type="password" class="form-control" name="passwd" id="passwd" placeholder="Password">
		      </div>
		      <!-- 비밀번호 확인 -->
		      <label for="exampleInputPassword2" class="form-label mt-4">Password Check</label>
		      <div class="input-group">
		      <input type="password" class="form-control" name="passwd2" id="passwd2" placeholder="Enter Password again">
		      <span id="result2"></span>
		      </div>
		      <!-- 이름 -->
		      <label for="exampleInputNickName" class="form-label mt-4">Name</label>
		      <div class="input-group">
		      <input type="text" class="form-control" name="username" id="username"  placeholder="Enter Name" aria-label="nameHelp" aria-describedby="checkBtn">
		      </div>
		      <!-- 주소 -->
		      <label for="exampleInputNickName" class="form-label mt-4">Address</label>
		      <div class="input-group">
		      <input type="text" name="post" id="sample4_postcode" placeholder="우편번호">&nbsp;&nbsp;
			  <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br>
			  </div>
			  <div class="input-group">
			  <input type="text" class="form-control" name="addr1" id="sample4_roadAddress" placeholder="도로명주소" aria-label="addr1Help" aria-describedby="checkBtn">
			  <br>
		      </div>
		      <div class="input-group">
		      <input type="text" class="form-control" name="addr2" id="sample4_jibunAddress" placeholder="지번주소" aria-label="addr2Help" aria-describedby="checkBtn">
			  <span id="guide" style="color:#999"></span>
		      </div>
		      <!-- 전화번호 -->
		      <label for="exampleInputphone" class="form-label mt-4">Number</label>
		      <div class="input-group">
		      <select name="phone1" id="phone1">
				  <option value="010">010</option>
				  <option value="011">011</option>
			  </select>&nbsp;-&nbsp;
			  <input type="text" name="phone2" id="phone2">&nbsp;-&nbsp;<input type="text" name="phone3" id="phone3">
		      </div>
		      <!-- 이메일 -->
		      <label for="exampleInputemail" class="form-label mt-4">Email</label>
		      <div class="input-group">
		      <input type="text" name="email1" id="email1">@
		      <input type="text" name="email2" placeholder="직접입력" id="email2">&nbsp;&nbsp;
		      <select id="emailSel">
		        <option value="daum.net">daum.net</option>
		        <option value="naver.com">naver.com</option>
		        <option value="google.com">google.com</option>
		      </select>
			  <br>
		      </div>
		    </div>
		    <!-- 전송/취소 버튼 -->
		    <a href="javascript:history.back();" class="btn btn-primary float-end">취소</a>
		    <button type="submit" class="btn btn-primary float-end" id="signupBtn">가입하기</button>
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


<!-- 카카오 주소 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>