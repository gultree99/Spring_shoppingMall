<%@page import="com.dto.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
 

<%-- <%
 
  GoodsDTO dto=(GoodsDTO)request.getAttribute("goodsRetrieve");
	String gCode=dto.getgCode();
	String gName=dto.getgName();
	int gPrice=dto.getgPrice();
	String gImage=dto.getgImage();
%>     --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(function () {
	$("#cart").click(function () {
		if($("#gSize").val()=="사이즈선택"){
			alert("사이즈 선택하세요");
			return false;
		}
		if($("#gColor").val()=="색상선택"){
			alert("색상을 선택하세요");
			return false;
		}
		$("form").attr("action","loginCheck/cartAdd"); //인터셉터 거쳐서 진행
	});
	
	$("#up").click(function () {
		var n=parseInt($("#gAmount").val())+1;
		$("#gAmount").val(n);
	});
	$("#down").click(function () {
		if($("#gAmount").val()==1){
			$("#gAmount").val()=1;
		}
		var n=parseInt($("#gAmount").val())-1;
		$("#gAmount").val(n);
	});
});


</script>
<c:if test="${!empty mesg}">
	<script>
alert('${mesg} 상품을 장바구니에 담았습니다.');
</script>
</c:if>
<%
	String mesg=(String)session.getAttribute("mesg");
	if(mesg!=null){session.removeAttribute("mesg");}
%>   

<form name="goodRetrieveForm" method="GET" action="#">
	    <!-- hidden  tag생성 -->
	    <input type="hidden" name="gImage" value="${goodsRetrieve.gImage}">
	    <input type="hidden" name="gCode" value="${goodsRetrieve.gCode}">
	    <input type="hidden" name="gName" value="${goodsRetrieve.gName }">
	    <input type="hidden" name="gPrice" value="${goodsRetrieve.gPrice }">

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
						<td rowspan="7"><img src="images/items/${goodsRetrieve.gImage }.gif"
							border="0" align="center" width="300" /></td>
						<td class="td_title">제품코드</td>
						<td class="td_default" colspan="2" style='padding-left: 30px'>
						${goodsRetrieve.gCode }
						</td>
					</tr>
					<tr>
						<td class="td_title">상품명</td>
						<td class="td_default" colspan="2" style='padding-left: 30px'>${goodsRetrieve.gName }</td>
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
						<input type="text" name="gAmount" value="1" id="gAmount"
							style="text-align: right; height: 18px"> 
							<img src="images/up.PNG" id="up"> 
							<img src="images/down.PNG" id="down"></td>
					</tr>
				</table>

			</td>
		</tr>
	</table>

	<br> <button onclick="reqCheck('order')">구매</button>
	&nbsp;&nbsp;
	<button onclick="reqCheck('cart')" id="cart">장바구니</button>
</form>
    