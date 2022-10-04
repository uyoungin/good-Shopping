<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script type="text/javascript">
	//총합 계산
	function totalXXX() {
		var totalSum = 0;
		$(".sum").each(function(idx, data) {
			totalSum += Number.parseInt($(data).text()); 
		});
		$("#totalSum").text(totalSum);
	};
	$(document).ready(function() {
		//총합 구하는 함수
		totalXXX(); 
		
		//상품 수량 수정
		$(".updateBtn").click(function() { //수정Btn 여러개이므로 class로 이벤트 처리
			let num = $(this).attr("data-num");
			let gPrice = $(this).attr("data-price");
			let gAmount = $("#cartAmount"+num).val();
			let sum = $("#sum"+num);
			console.log(num,gPrice,gAmount)
			
			$.ajax({
				url: "loginCheck/cartUpdate",
				type: "get",
				dataType: "text",
				data: {
					num : num,
					gAmount: gAmount
				},
				success: function(data, status, xhr) {
					sum.text(gPrice*gAmount); //성공 시 받는 데이터 없이 토탈 가격만 변동시킴
					totalXXX(); //총합 구하는 함수
				},
				error: function(xhr, status, error) {
					console.log(error)
				}
			});//end ajax 
		});
		
		//상품 개별 삭제
		$(".deleteBtn").click(function() {
			let num = $(this).attr("data-num");
			let xxx = $(this); //deleteBtn태그
			console.log(num)
			
			$.ajax({
				url: "loginCheck/cartDelete",
				type: "get",
				dataType: "text",
				data: {
					num: num
				},
				success: function(data, status, xhr) {
					console.log("success")
					//dom 삭제
					xxx.parents().filter("tr").remove();
					//xxx는 삭제 버튼
					//filter와 parents를 사용해 xxx의 부모 태그 중 tr태그 삭제
					//성공 시 화면상에서 삭제**
					totalXXX(); //총합 구하는 함수
				},
				error: function(xhr, status, error) {
					console.log(error)
				}
			})//end ajax
		});
		
		//전체선택
		$("#allCheck").click(function() {
			let result = this.checked;
			$(".check").each(function(idx, ele) {
				ele.checked = result;
			});
		});
		
		//전체 삭제 (Btn에 1.data-num 사용자정의 데이터로 넘겨주거나 2.form 전송 : 우리는 2번)
		$("#delAllCart").click(function() {
			$("form").attr("action", "loginCheck/delAllCart");
			$("form").submit(); //Btn이 form밖에 있으므로 submit이벤트 trigger
		});
		
		//주문하기
		$(".orderBtn").click(function() {
			let num = $(this).attr("data-num");
			location.href = "loginCheck/orderConfirm?num="+num;
		});
		
	});
</script>
<div class="container">
<h1>cartList!</h1>
<table cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td height="30">
	</tr>
	<tr>
		<td height="15">
	</tr>
	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	<tr>
		<td height="7">
	</tr>
	<tr>
		<td class="td_default" align="center">
		<input type="checkbox" name="allCheck" id="allCheck"> <strong>전체선택</strong></td>
		<td class="td_default" align="center"><strong>주문번호</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>상품정보</strong></td>
		<td class="td_default" align="center"><strong>판매가</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>수량</strong></td>
		<td class="td_default" align="center"><strong>합계</strong></td>
		<td></td>
	</tr>
	<tr>
		<td height="7">
	</tr>
	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	
<form name="myForm">
<!-- 반복시작 -->
<c:forEach var="x" items="${cartList}" varStatus="status">

		<tr>
			<td class="td_default" width="80">
			<!-- checkbox는 체크된 값만 서블릿으로 넘어간다. 
			따라서 value에 삭제할 num값을 설정한다. -->
			<input type="checkbox" name="check" class="check" value="${x.num}"></td>
			<td class="td_default" width="80">${x.num}</td>
			<td class="td_default" width="80"><img
				src="images/items/${x.gImage}.gif" border="0" align="center" width="80" /></td>
			<td class="td_default" width="300" style='padding-left: 30px'>
				${x.gName}
				<br> <font size="2" color="#665b5f">[옵션 : 사이즈(${x.gSize})
					, 색상(${x.gColor})]
			</font></td>
			<td class="td_default" align="center" width="110">
			<span id="gPrice${x.num}">${x.gPrice}</span>
			</td>
			<td class="td_default" align="center" width="90"><input
				class="input_default" type="text" name="cartAmount"
				id="cartAmount${x.num}" style="text-align: right" maxlength="3"
				size="2" value="${x.gAmount}"></input></td>
			<!-- 수정 btn -->
				<td><input type="button" value="수정"
					class="updateBtn btn btn-outline-primary"
					data-num="${x.num}"
					data-price="${x.gPrice}" /></td>
				<td class="td_default" align="center" width="80"
					style='padding-left: 5px'><span id="sum${x.num}" class="sum">
					${x.gPrice * x.gAmount}
					</span></td>
			<!-- 주문 btn -->
				<td><input type="button" value="주문" class="orderBtn btn btn-outline-primary"
					data-num="${x.num}"></td>
			<!-- 삭제 btn -->
				<td class="td_default" align="center" width="30"
					style='padding-left: 10px'>
					<input class="deleteBtn btn btn-secondary" type="button" value="삭제"
					data-num="${x.num}"></td>
				<td height="10"></td>
		</tr>
 <!-- 반복끝 --> 
</c:forEach>
	</form>
	<tr>
		<td colspan="10">
			총합 : <span id="totalSum"></span>
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	<tr>
		<td height="30">
	</tr>
	<tr>
		<td align="center" colspan="5"><a class="a_black"
			href="javascript:orderAllConfirm(myForm)"> 전체 주문하기 </a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<button class="btn btn-primary">전체 주문하기</button>
			<a class="a_black" > 전체 삭제하기 </a>&nbsp;&nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" id="delAllCart">전체 삭제하기</button>
			<a class="a_black" href="home"> 계속 쇼핑하기 </a>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td height="20">
	</tr>
</table>
</div>