<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.order.model.vo.Order"%>
<%
	ArrayList<Order> list = (ArrayList<Order>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 취소 내역</title>

<!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- 달력 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

    <style>
        
        .cancelOuter{margin: auto;}
        .cancelOuter>h3{margin-top: 60px; font-size: 20px; font-weight: bold;}       
        th{padding: 10px;}
		#listArea *{vertical-align: middle;}
		#product{color: black; font-weight: bold;}
    </style>
</head>
<body>

	<%@ include file = "../common/mypageMenubar.jsp" %>
	
	
	<div class="cancelOuter">
		
        <table id="listArea" class="table table-striped"> 
        	<thead>  
	            <h3>취소내역</h3>
	            <hr>
	            <tr align="center" style="border-bottom: 1px solid black;">
	            	<th width=150>주문번호</th>
	                <th rowspan="2" width=500 >상품</th>
	                <th rowspan="2" width=200>상세보기</th>
	                <!-- <th rowspan="2" width=200>상태</th> -->
	            </tr>
	        </thead>

			</tbody>               
		        <%if(list.isEmpty()){ %>
		    		<!-- 조회된 결과가 없을 경우-->
		         <tr>
		             <td colspan="6" align="center"><br><br>
		                 	조회된 리스트가 없습니다.
		             </td>
		         </tr>
       	
       		
		  		<%}else{ %>
		            <!-- 조회된 결과가 있을 경우 -->
					<%for(Order o : list){ %>
						<%if(loginUser != null && loginUser.getMemNo() == o.getMemNo() && o.getcReason() != null){ %>
		            <tr align="center">
		                <td id = "detailOrder" width="100"><%=o.getOrderNo() %></td>	
		                <td width="500" >
		                	<img src="<%=contextPath %>/<%=o.getBasicPath() %>" width="50" height="50" alt="">
		                	<a href = "<%=contextPath%>/infoDetail.pdt?pcode=<%=o.getpCode()%>" id="product"><%=o.getpName() %></a>
		                </td>
		                <td width="200" id= "detailView"><a href="<%= contextPath %>/detail.mpc?ono=<%=o.getOrderNo()%>" style="color: orange;">상세보기</a></td>
		                <!-- td width=200>
		                    <input id="datepicker" type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#myModal" value="다시예약하기">
		                    
		                </td>
						-->
		            </tr>
		            	<%} %>
		            	
		            <%} %>
				<%} %>
			</tbody>

        </table>
         
        <script>
        	$(function(){
        		$("#detailView").click(function(){
        			location.href = '<%=contextPath%>/detail.mpc?ono=' + $("#detailOrder").text();
        		})
        	})
        
        </script>       
                 
                
     </div>
</div>

	 <%@ include file = "../common/footer.jsp" %>
</body>
</html>