<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty mesg}">
	<script>
		alert('${mesg}상품을 장바구니에 담았습니다.')
	</script>
</c:if>
<%
	if(session.getAttribute("mesg")!=null) { session.removeAttribute("mesg"); } //mesg 띄운 후 session에서 삭제(el,jstl로 안돼서 jsp 사용)
%>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script type="text/javascript">
	$(document).ready(function() {
		//상품 수량 변경
		$("#up").click(function() {
			let gAmount = $("#gAmount").val();
			gAmount++;
			$("#gAmount").val(gAmount);
		});
		$("#down").click(function() {
			let gAmount = $("#gAmount").val();
			gAmount--;
			if (gAmount==0) {
				gAmount = 1;
			}
			$("#gAmount").val(gAmount);
		});
		
		//옵션 선택 확인
		
		
		//장바구니 버튼 클릭 시 로그인 확인 후 장바구니로 이동
		$("#cart").on("click", function() {
			$("form").attr("action", "loginCheck/cartAdd")
		});
		
		//구매 버튼 클릭 시 로그인 확인 후 주문페이지로 이동
		$("#order").on("click", function() {
			$("form").attr("action", "loginCheck/orderConfirm")
		});
		
	});
</script>

<FORM name="goodRetrieveForm" method="GET" action="#"><!--action을 막음 : 구매와 장바구니 클릭 시 각각의 controller로 이동해야 함 -->
		<!-- hidden data : 이미지, 코드, 상품명, 가격   /   userid는 session에 있는 값 사용 가능 -->
	    <input type="hidden" name="gImage" value="${goodsRetrieve.gImage}"> 
	    <input type="hidden" name="gCode" value="${goodsRetrieve.gCode}">
	    <input	type="hidden" name="gName" value="${goodsRetrieve.gName}"> 
	    <input	type="hidden" name="gPrice" value="${goodsRetrieve.gPrice}">

	<table width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td height="30">
		</tr>
		<tr>
			<td>
				<table align="center" width="710" cellspacing="0" cellpadding="0"
					border="0" style='margin-left: 30px'>
					<tr>
						<td class="td_default"><font size="5"><b>- 상품 정보 -</b></font>
							&nbsp;</td>
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td height="1" colspan="8" bgcolor="CECECE"></td>
					</tr>
					<tr>
						<td height="10"></td>
					</tr>

					<tr>
						<td rowspan="7"><img src="images/items/${goodsRetrieve.gImage}.gif"
							border="0" align="center" width="300" /></td>
						<td class="td_title">제품코드</td>
						<td class="td_default" colspan="2" style='padding-left: 30px'>
							${goodsRetrieve.gCode}
						</td>
					</tr>
					<tr>
						<td class="td_title">상품명</td>
						<td class="td_default" colspan="2" style='padding-left: 30px'>
							${goodsRetrieve.gName}
						</td>
					</tr>
					<tr>
						<td class="td_title">가격</td>
						<td class="td_red" colspan="2" style='padding-left: 30px'>
							${goodsRetrieve.gPrice}
						</td>
					</tr>
					<tr>
						<td class="td_title">배송비</td>
						<td colspan="2"><font color="#2e56a9" size="2"
							style='padding-left: 30px'><b> 무료배송</b> </font> <font size="2">(도서
								산간지역 별도 배송비 추가)</font></td>
					</tr>
					<tr>
						<td class="td_title" rowspan="2">상품옵션</td>
						<td colspan="2" style='padding-left: 30px'><select
							class="select_change" size="1" name="gSize" id="gSize">
								<option selected value="사이즈선택">사이즈선택</option>
								<option value="L">L</option>
								<option value="M">M</option>
								<option value="S">S</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="2" style='padding-left: 30px'><select
							class="select_change" size="1" name="gColor"
							id="gColor">
								<option selected value="색상선택">색상선택</option>
								<option value="navy">navy</option>
								<option value="black">black</option>
								<option value="ivory">ivory</option>
								<option value="white">white</option>
								<option value="gray">gray</option>
						</select></td>
					</tr>

					<tr>
						<td class="td_title">주문수량</td>
						<td style="padding-left: 30px">
							<input type="text" name="gAmount" value="1" id="gAmount" style="text-align: right; height: 18px">
							<img src="images/up.png" id="up">
							<img src="images/down.png" id="down">
						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	<br> <button id="order" class="btn btn-primary">구매</button>
	&nbsp;&nbsp;
	<button id="cart" class="btn btn-primary">장바구니</button>
</FORM>