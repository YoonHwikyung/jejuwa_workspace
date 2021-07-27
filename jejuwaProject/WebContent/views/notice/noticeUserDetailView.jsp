<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.notice.model.vo.Notice" %>
<%
	Notice n = (Notice)request.getAttribute("n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주와 공지사항</title>
<!-- content css-->
<link rel="stylesheet" type="text/css" href="resources/css/notice/noticeUserDetailView.css">
</head>
<body>

	<%@ include file = "../common/customerMenubar.jsp" %>
	
	<div class="outer">
        <h2>공지사항</h2>
        <div class="divisionLine"></div>
        
        <br>
        <!-- 
        <div class="btn3" align="right">
            <a href="">수 정</a>
            <a href="">삭 제</a>
        </div>
         -->
        <div class="noticeArea">
            <div class="title">
                <div><b><%= n.getNoticeTitle() %></b></div>
                <br>
                <div>제주와 <%= n.getEnrollDate() %> </div>
            </div>            
            <div class="NoticeContent" >
            	<p>
            		<% if(n.getOriginFileName() != null){%>
            			<br>
            			<img id="noticeImg" src="<%= contextPath %>/<%=n.getFilePath()%>">
            			<br>
            		<% }%>
                	<%= n.getNoticeContent() %>
                </p>
            </div>
			
			
            <!-- 첨부파일이 있을 경우 -->
            <div id="fileArea">
            <% if(n.getOriginFileName() == null){%>
            	첨부파일 없음
            <% } else {%>
               	첨부파일 &nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/<%=n.getFilePath()%>"><%= n.getOriginFileName() %></a>
            <% } %>
            </div>

        </div>


        <div class="bottomArea">            
            
            
            <div class="btn noticeUserBtn" align="right">
                <a id="btn3" href="<%=request.getContextPath()%>/list.uno?currentPage=1">목록으로</a> 
            </div>               

        </div>

    </div>
    
    <%@ include file = "../common/footer.jsp" %>
</body>
</html>