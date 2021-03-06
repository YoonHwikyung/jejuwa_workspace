<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.common.model.vo.PageInfo
			   , java.util.ArrayList, com.kh.coupon.model.vo.Coupon" %>
<%
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Coupon> adlist = (ArrayList<Coupon>)request.getAttribute("adlist");
	
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminCoupon</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
    
 <style>
    

.outer{

    height: 900px; width: 800px;
    margin: auto;
    margin-top: 10px;
    }
    
    .select-coupon{
        float: left;
        
    }
    
   
    
    /* 쿠폰관리 타이틀 */

    #coupon_title{
       font-weight: 800;
       padding:20px;
    }

   
    /* 테이블 */
    .listArea{
    text-align:center;
    padding:25px;
    }
    
   
    .listArea>table>tbody>tr:hover{
        background:lightgray;
        cursor:pointer;
    }
    .listArea>table *{
        magin:10px;
        padding:8px;
        }
    
    
    /* 버튼 + 페이징 구역*/
    .bottomArea a{
        margin: 15px;
        margin-left: 150px;
    }

    #send-button{
        float: right;
        
    }
   
    
    /* 버튼 */
    .btn a{
    text-decoration: none; 
    text-align: center;
    color:white; 
    background-color: dimgray;
    display: block;
    padding:7px;
    border-radius:4px;
    width:70px;
    
    }
    
    .btn a:hover{background-color: rgb(243, 225, 192);}
    
    
    /* 페이징 구역 */
    .pagingArea{
        margin-left:190px;
        margin-right: 120px;
    }

    #next-buttton{
        padding: 20px;
    }

    #send-button{
        margin-top: 30px;
        margin-left: 50px;
    }
    
    </style>
    
</head>
<body>
	
	<%@ include file="../common/adminPageMenubar.jsp" %>
	

	
        <!-- 헤더 -->
        

        <!-- 컨테이너 => iodex, content -->
        <div id="container">
         
           
            <!-- 내용  -->
        <div class="content">
            
            <div class="outer">
        	<br>
        	<h2 id="coupon_title">쿠폰관리</h2>
        	<hr><br><br>
       		<div class="area1">
           
            
        	</div>

        <!-- 쿠폰 리스트 테이블 -->
        <div class="listArea">
            <table  align="center" id="memberList">
                <thead>
                    <tr>
                        <th width="10px" ><input type="checkbox"></th>
                          <th width="200px">등록일</th>
                        <th width="90px">쿠폰코드</th>
                        <th width="170px">쿠폰명</th>
                        <th width="290px">기간</th>
                        <th width="70px">할인율</th>
                      
                        
                    </tr>
                </thead>
                <tbody>
                   <!-- 조회된 결과가 없을 경우 -->
		                <% if(adlist.isEmpty()){ %>
		                	<tr>
		                		<td colspan="5">조회된 회원이 없습니다.</td>
		                	</tr>
		                <% }else{%>
			                <!-- 조회된 결과가 있-->
			                <% for(Coupon cp : adlist) {%>
		                    <tr>
		                        <td><input type="checkbox"></td>
		                        <td><%=cp.getCpn_Rgdt()%></td>
		                        <td><%=cp.getCpn_Code()%></td>
		                        <td><%=cp.getCpn_Name()%></td>
		                        <td><%=cp.getCpn_Str_Date()%>
		                        <span>~</span> 
		                        <%=cp.getCpn_End_Date()%></td>
		                        <td><%=cp.getCpn_Dc()%>%</td>
		                        
		                        
		                    </tr>
                    	<% } %>
                   
                   <% } %>
                   
                </tbody>

            </table>

        </div>
        
		<br><br>
       
            <!-- 페이징  -->
            <div align="center" class="pagingArea">
                    
                    	
                    <% if(currentPage == 1) {%>
                    	<button disabled>&laquo;</button>
	                    <button disabled>&lt;</button>			
                    <%} else {%>
	                    <button onclick="location.href='<%=contextPath%>/listadmin.cpn?currentPage=1';">&laquo;</button>
	                    <button onclick="location.href='<%=contextPath%>/listadmin.cpn?currentPage=<%=currentPage-1%>';">&lt;</button>			
					<% } %>
					
					<% for(int p=startPage; p<=endPage; p++ ) {%>
					
						<% if(currentPage == p) {%>
                        	<button disabled><%= p %></button>
                        <% }else{ %>				
	                        <button onclick="location.href='<%=contextPath%>/listadmin.cpn?currentPage=<%= p %>';"><%= p %></button>
                        <% } %>		
                	<% } %>
                	
                	
                	<% if(currentPage == maxPage){ %>
                		<button disabled>&gt;</button>
	                    <button disabled>&raquo;</button>
                	<% } else{ %>
                		<button onclick="location.href='<%=contextPath%>/listadmin.cpn?currentPage=<%=currentPage+1%>';">&gt;</button>
	                    <button onclick="location.href='<%=contextPath%>/listadmin.cpn?currentPage=<%=maxPage%>';">&raquo;</button>
                	
					<% } %>

             	</div>
             	
             	
             	<!-- 검색바 -->
            	<div align="right" class="searchArea"style="margin-right:50px" >
              
                        	<a href="<%= contextPath %>/list.go" class="btn btn-outline-info">
                        	쿠폰등록</a>
                        	
                 </div>
			</div>
			
    	</div>
    	
    	</div>
    	
                


    
	</body>
</html>