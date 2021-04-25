<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.product.model.vo.Product"%>
<%
	ArrayList<Product> list = (ArrayList<Product>)request.getAttribute("list");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주와_상품검색</title>

    <!-- css -->
     <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/product/productSearchView.css">   


</head>
<body>

	<%@ include file="../common/loginUserMenubar.jsp" %> 

    <div class="content_wrap">

    
        <div class="searchBar">     
            <form action="" id="searchForm" method="post">
                <div id="searchBox">
                    <input type="search" name="keyword" placeholder="[추천상품]제주시티투어">
                </div>
                    
                <div id="searchBtn">
                    <button type=""><img src="<%=contextPath%>/resources/images/loupe_c.png" width="30"></button>
                </div>              
            </form>
            <div class="divisionLine"></div>
        </div>

        <div class="sortBar" align="right">
            <a href="">제주와 추천순<img src="<%=contextPath%>/resources/images/check_c.png" alt="" width="15"></a> &nbsp;&nbsp;
            <a href="">판매순<img src="<%=contextPath%>/resources/images/check_c.png" alt="" width="15"></a>
        </div>

		<div class="category">
			<ul class="sub">
				<li class="current" onclick="top.location.href='<%=contextPath%>/mapSearch.pdt';"><a >전체보기</a></li>
				<li onclick="top.location.href='<%=contextPath%>/search_TR.pdt';"><a>투어</a></li>
				<li><a href="">티켓</a></li>
				<li><a href="">액티비티</a></li>
			</ul>
		</div>

		<div class="pdt_wrap">
             <ul class="pdtList">
        	<%
        		for (Product p : list) {
        	%> 
                        <li class=pdtArea>
                        <input type="hidden" value="<%=p.getpCode()%>">
                            <div class="pdtBox">
                                <a >
                                    <div class="pdtPhoto"><img src="<%=contextPath%>/<%= p.getBasicPath()%>" style="width: 220px;"></div>
                                    <div class="pdtInfo">
                                        <p class="pdtName"><%=p.getpName() %></p>
                                        <p class="pdtPrice"><%=p.getPrice() %>원</p>
                                    </div>
                                </a>
                            </div>
                        </li>
			<% } %>		
			</ul>

        </div>
        
        <script>
        	$(function(){
        		$(".pdtArea").click(function(){
        			location.href = '<%=contextPath%>/infoDetail.pdt?pcode='+ $(this).children().eq(0).val();
        		})	
        	})
        	
        </script>
   

        <div align="center" class="pageingArea">
            <button>이전</button>
            <button>x</button>
            <button>x</button>
            <button>다음</button>

        </div>



    </div>


</body>
</html>