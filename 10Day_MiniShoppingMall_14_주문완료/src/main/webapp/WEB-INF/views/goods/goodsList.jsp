<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    

<table width="100%" cellspacing="0" cellpadding="0">

	<tr>
		<td>
			<table align="center" width="710" cellspacing="0" cellpadding="0"
				border="0">
				
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
<!-- request에서 데이터 얻은 후  모든 멤버변수를 변수에 저장  후 표에 출력해줌-->				
<%--  <%
    List<GoodsDTO> list = (List<GoodsDTO>)request.getAttribute("goodsList");
    for(int i=1;i<=list.size();i++){
    	GoodsDTO dto = list.get(i-1);
    	String gCode = dto.getgCode();
    	String gCategory = dto.getgCategory();
    	String gName = dto.getgName();
    	String gContent = dto.getgContent();
    	int gPrice = dto.getgPrice();
    	String gImage = dto.getgImage();
 %> --%>
 <c:forEach var="dto" items="${goodsList}" varStatus="status">
 <!-- "goodsList" 키의 ArrayList get에서 for로 돌려서  방하나의 goodsDTO를 "dto"로 저장, status: 인덱스번호 -->
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="goodsRetrieve?gCode=${dto.gCode}"><!-- 이미지링크 --> 
											<img src="images/items/${dto.gImage}.gif" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
								<tr>
								
									<td height="10">
								</tr>
								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="goodsRetrieve?gCode=${dto.gCode}"> 
										${dto.gName}<br>
										</a>
										<font color="gray">
										 --------------------
										</font>
									</td>
									
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										${dto.gContent}
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_red" align ="center"><font color="red"><strong>
									${dto.gPrice}	</strong></font></td>
								</tr>
							</table>
						</td>
					<!-- 한줄에 4개씩 보여주기 -->	
			<%-- 	   <%
				      if(i%4==0){
				   %> --%>
				   <c:if test="${status.count%4==0}">
				       <tr>
				        <td height="10">
				       </tr>
				<%--    <%
				      }//end if
				   %>	 --%>	
				   </c:if>
						
<%-- <%
    }//end for
%> --%>
</c:forEach>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="10">
	</tr>
</table>
    