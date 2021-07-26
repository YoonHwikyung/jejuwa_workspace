<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.myq.model.vo.MYQ
			   , com.kh.common.model.vo.Attachment
			   , java.util.ArrayList" %>
<%
	MYQ q = (MYQ)request.getAttribute("q");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- content css-->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/myq/myqAdminDetailView.css">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- myqAdminListView.js -->
</head>
<body>

	<%@ include file="../common/adminPageMenubar.jsp" %>

    <script>
        var msg = "<%= session.getAttribute("alertMsg") %>"; // 알람창으로 출력할 메세지
		// var msg = "메세지"   / "null";
		
		if(msg != "null"){
			alert(msg);
			// session에 한 번 담아둔 건 내가 지우기 전 까지 계속 남아있다 (메뉴바 포함된 매 페이지가 열릴때마다 alert 계속 뜰 것)
			// 알람창 띄워준 후에 session에 담긴 메세지 지워야함!!
			<% session.removeAttribute("alertMsg");%>
		}
    </script>
	<input type="hidden" name="getMyq_no" value ="<%= q.getMyq_no() %>" id="getMyq_no">
	<div class="outer">
        <br>
        <h2>1:1 문의 상세보기</h2>
        <div class="divisionLine"></div>
        <br>
        
        <br>
        <div class="btn3" align="right"></div>
        <div class="noticeArea">
            <div class="title">
                <div>
                <% if( q.getP_code() == null){%>
                	<b> 제목 : <%= q.getMyq_title() %><b>
                <% } else { %>
                	<b> 
	                	제목 : <span style="color:red; border: 0px;">[<%= q.getP_code() %>]</span>
	                	<%= q.getMyq_title() %>
	                </b>
                <% } %>
                </div>
                <br>
                <div> 이름 : <%= q.getMem_name() %> </div>
                <div> 아아디 : <%= q.getMem_id() %> </div>
                <div> 작성일 : <%= q.getMyq_enroll_date() %> </div>
            </div>            
            <div class="NoticeContent">
            	<p>
                	<%= q.getMyq_content() %>
                </p>
            </div>
           </div>
            
            <div class="ansArea">
            <div class="title">
                <!-- 미답변 상태-->
            	<% if ( q.getMyq_ans_content() == null){ %> 
	            	<div><b> 답변</b></div>
	                <br>
	                <div></div>
	                <div>
	                	<textarea style="width:800px; height:200px;" name="answer_text" id="answer_text" required></textarea>
	                </div>
                <!-- 답변한 상태(수정하기 가능)-->
            	<% } else{ %>
	                <div><b> 답변</b></div>
	                <br>
	                <div>제주와 관리자</div>
	                <div> 답변일 : <%= q.getMyq_ans_date() %> </div> 
            <div class="AnsContent">
            	<p>
                	<%= q.getMyq_ans_content() %>
                </p>
            </div>
            <% } %>
            </div>
            <script>

            </script>
			
			<!-- 첨부파일 부분 확인 및 수정 필요!! -->
            <!-- 첨부파일이 있을 경우 -->
            <!-- 첨부파일 없을때 nullpointException 뜸 왜그러지? 막는방법좀... -->
		 <div id="fileArea">
			<% if( list.size() == 0){%>
            	<b>첨부파일 없음</b>
            <% } else {%>
            	<% for(int i=0; i<list.size(); i++){%>
               	첨부파일 <a href="<%=contextPath%>/<%= list.get(i).getFilePath() %>/<%= list.get(i).getMdfFileName() %>"><%=list.get(i).getOrgFileName() %></a><br>
            <% }} %>
            </div>

        </div>


        <div class="bottomArea">            
            
            
            <div class="btn btn2" align="right">
                <% if ( q.getMyq_ans_content() == null){ %> 
            	<button id="answer" name="" value="" style="border:0px;">답변하기</button>
                <% } else{ %> 
                <button id="answer_mdf" name="" value="" style="border:0px;">답변수정</button>
                <% } %>
                <a id="btn3" href="<%=contextPath%>/list.amyq?currentPage=1">목록으로</a> 
            </div>               
        </div>
        
    <script>
        $("#answer").click(function(){
            $.ajax({
                url: "ans.amyq",
                type: "get",
                data: {
                    answer:$("#answer_text").val(), // answer_text라는 key값으로 id가 answer_text인 값을 넘기겠다. 
                    getMyq_no:$("#getMyq_no").val()
                },
                success:function(res){
                    if(res > 0){
                        
                        var today = new Date();
                        var date = today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate();
                        var el = "<div><b> 답변</b></div><br><div>제주와 관리자</div><div> 답변일 :" + date + "</div>"
                        + "<div class='AnsContent'><p>" + $("#answer_text").val() + "</p></div>";
                        $("#answer").text('답변수정');
                        $("#answer").attr('id','#answer_mdf');
                        
                        $(".ansArea>.title").html(el);
                        
                    } else{
                        console.log("답글실패?")
                        // 답글 실패
                    }
                },
                error:function(){
                    console.log("댓글 작성용 ajax 통신 실패");
                }
            })
        })

        $("#answer_mdf").click(function(){
            $.ajax({
                url: "ans.amyq",
                type: "get",
                data: {
                    mno:<%=q.getMyq_no()%> // answer_text라는 key값으로 id가 answer_text인 값을 넘기겠다
                },
                success:function(){
                        $(".ansArea>.title").html("");
                        
                		var el = '<div><b> 답변</b></div><br><div></div>' + 
                                 '<div><textarea style="width:800px; height:200px;" name="answer_text" id="answer_text">' + "<%= q.getMyq_ans_content() %>"
                                 + '</textarea></div>';  	
                		
                		$(".ansArea>.title").html(el);
                		$("#answer_mdf").attr('id','#answer_mdf_suc');
                },
                error:function(){
                    console.log("답글 작성용 ajax 통신 실패");
                }
            })
        })
        
        
        $("#answer_mdf_suc").click(function(){
            $.ajax({
                url: "detail.amyq",
                type: "get",
                data: {
                    answer:$("#answer_text").val(),
                    getMyq_no:$("#getMyq_no").val()
                },
                success:function(res){
                    if(res > 0){
                        // 답변 수정시, 날짜 최신화, 답변 내용 수정
                        var today = new Date();
                        var date = today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate();
                        var el = "<div><b> 답변</b></div><br><div>제주와 관리자</div><div> 답변일 :" + date + "</div>"
                        + "<div class='AnsContent'><p>" + $("#answer_text").val() + "</p></div>";
                        
                        $(".ansArea>.title").html(el);
                        $("#answer_mdf_suc").attr('id','#answer_mdf');
                    } else{
                        // 답글 실패
                    }
                },
                error:function(){
                    console.log("답글 작성용 ajax 통신 실패");
                }
            })
        })
        
        </script>
</body>
</html>