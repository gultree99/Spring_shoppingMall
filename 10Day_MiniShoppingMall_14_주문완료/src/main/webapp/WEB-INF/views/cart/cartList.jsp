<%@page import="com.dto.CartDTO"%>
<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

function totalxxx() {
	var totalPrice=0;
	$(".sumtotal").each(function (index,data) {
		totalPrice+=Number.parseInt($(data).text());
	});
	$("#totalSum").text(totalPrice);	
}

$(function () {
	totalxxx();
	
	$("#allCheck").click(function () {
		var result=this.checked;
		$(".check").each(function (idx,obj) {
			this.checked=result;
		});
	});
	

	//카트 수정
	$(".updateBtn").click(function () {
		var num=$(this).attr("data-xxx");
		var gPrice=$(this).attr("data-price");
		var gAmount=$("#cartAmount"+num).val();
		
		$.ajax({
			type:"get",
			url:"loginCheck/cartUpdate",
			dataType:"text",
			data:{
				num:num, //카트번호
				gAmount:gAmount //수정한 수량 전송
 			},
			success:function(data,status,xhr){
				var sum=parseInt(gAmount)*parseInt(gPrice);
				$("#sum"+num).text(sum);
				totalxxx();
			},
			error:function(xhr,status,error){
				console.log("error");
			}
		});
	});
	
	//카트 삭제
	$(".delBtn").click(function () {
		console.log("delBtn클릭")
		var num=$(this).attr("data-xxx");
		var xxx=$(this);
		$.ajax({
			url:"loginCheck/cartDelete",
			type:"get",
			dataType:"text",
			data:{
				num:num
			},
			success:function(data,status,xhr){
				console.log("seccess");
				xxx.parents().filter("tr").remove();
				totalxxx();
			},
			error:function(xhr,status,error) {
				console.log("error");
			}
		});
	});
	
	

	
	//전체카트삭제
	$("#delAllCart").click(function () {
		$("form").attr("action","loginCheck/delAllCart");
		$("form").submit();
	});
	
	//주문
	$(".orderBtn").click(function () {
		var num=$(this).attr("data-xxx");
		location.href="loginCheck/orderConfirm?num="+num;
	});
	

	
});

	


</script>
<table width="90%" cellspacing="0" cellpadding="0" border="0">

	<tr>
		<td height="30">
	</tr>

	<tr>
		<td colspan="5" class="td_default">&nbsp;&nbsp;&nbsp; <font
			size="5"><b>- 장바구니-</b></font> &nbsp;
		</td>
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
		<input type="checkbox" name="allCheck" id="allCheck"> <strong>전체<br>선택</strong></td>
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
<%-- <%
//데이터 가져오기 //for문 작성 
List<CartDTO> list=(List<CartDTO>)request.getAttribute("cartList");
System.out.print(list);
	for(int i=0; i<list.size(); i++){
		CartDTO dto=list.get(i);
		String userid=dto.getUserid();
		String gCode=dto.getgCode();
		String gName=dto.getgName();
		String gColor=dto.getgColor();
		String gSize=dto.getgSize();
		int gAmount=dto.getgAmount();
		int num=dto.getNum();
		int gPrice=dto.getgPrice();
		String gImage=dto.getgImage();	
   
%>	     --%>
<c:forEach var="dto" items="${cartList}">

	  		

		<tr>
			<td class="td_default" width="80">
			<!-- checkbox는 체크된 값만 서블릿으로 넘어간다. 따라서 value에 삭제할 num값을 설정한다. -->
			<input type="checkbox"
				name="check" id="check81" class="check" value="${dto.num }"></td>
			<td class="td_default" width="80">${dto.num }</td>
			<td class="td_default" width="80">
			<img src="images/items/${dto.gImage }.gif" border="0" align="center" width="80" /></td>
			<td class="td_default" width="300" style='padding-left: 30px'>
			${dto.gName }
				<br> <font size="2" color="#665b5f">[옵션 : 사이즈(${dto.gSize })
					, 색상(${dto.gColor })]
			</font></td>
			<td class="td_default" align="center" width="110">
			${dto.gPrice }
			</td>
			<td class="td_default" align="center" width="90">
			<input class="input_default" type="text" name="cartAmount"
				id="cartAmount${dto.num }" style="text-align: right" maxlength="3"
				size="2" value="${dto.gAmount }"></input></td>
				
			<td><input type="button" value="수정" class="updateBtn"
			data-xxx="${dto.num }"  
			data-price="${dto.gPrice }"></td>
				
			<td class="total" align="center" width="80"
				style='padding-left: 5px'><span id="sum${dto.num }" class="sumtotal">
				${dto.gPrice * dto.gAmount}
				</span></td>
				
			<td><input type="button" value="주문"
				data-xxx="${dto.num}" class="orderBtn"></td>
				
			<td class="td_default" align="center" width="30"
				style='padding-left: 10px'>
				<input type="button" value="삭제"
				class="delBtn" data-xxx="${dto.num}"></td>
			<td height="10"></td>
		</tr>


<%-- <%} %> --%>
</c:forEach><!-- 반복 끝 -->
</form>
	<tr>
		<td colspan="10">
			총합:<span id="totalSum"></span>
			<hr size="1" color="CCCCCC">
		</td>
	</tr>		

	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	<tr>
		<td height="30">
	</tr>

	<tr>
		<td align="center" colspan="5"><a class="a_black"
			href="javascript:orderAllConfirm(myForm)"> 전체 주문하기 </a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<button id="delAllCart"> 전체 삭제하기 </button>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="GoodsList?gCategory=top"> 계속 쇼핑하기 </a>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td height="20">
	</tr>

</table>

    