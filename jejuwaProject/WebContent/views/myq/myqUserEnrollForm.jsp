<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "com.kh.product.model.vo.*"%>
<% Product p = (Product)request.getAttribute("p"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- content css-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/myq/myqUserEnrollForm.css">

<style>


</style>
</head>
<body>

	<%@ include file="../common/customerMenubar.jsp" %>

	<div class="outer" >
        <br>
        <h2>문의사항 등록</h2>
        <div class="divisionLine"></div>
        <br>
        
        <br>

        <div class="enrollForm">
                <form id="enrollForm" action="<%=contextPath%>/insert.umyq" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="memNo" value="<%=login.getMemNo() %>">
                    <input type="hidden" name="memId" value="<%= login.getMemId() %>">
                    <input type="hidden" name="memName" value="<%= login.getMemName() %>">
                    <!-- 제목, 내용, 첨부파일 -->
                    <table align="center" id="enrollTable">
                        <tr>
                            <th>제목</th>
                            <td colspan="2">
                                <input type="text" name="title" size="72" placeholder="제목을 입력해주세요" required>
                            </td>
                        </tr>

                        <tr>
                            <th>분류</th>
                            <td colspan="2">
                                <select name="category" id="category">
                                    <option value="none">선택</option>
                                    <option value="회원" name="op_member" id="op_member">회원</option>
                                    <option value="주문/결제" name="op_payment" id="op_payment">주문/결제</option>
                                    <option value="환불" name="op_exchange" id="op_exchange">환불</option>
                                    <option value="이벤트" name="op_evnet" id="op_event">이벤트</option>
                                    <option value="기타" name="op_etc" id="op_etc">기타</option>
                                </select>
                            <span id="op_product_info" style="color:red;">상품문의는 상품 상세페이지에서 해주시기 바랍니다 :)</span>

                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td id="file_target">첨부파일 추가<!-- 이미지 클릭시 화살표나오면서 파일 담을수있는 리스트 나오기 FAQ보기 -->
	                            <td colspan="2" style="display: none;">
	                                <input type="file" name="upfile1" ><br>
	                                <input type="file" name="upfile2" ><br>
	                                <input type="file" name="upfile3" >
	                            </td>
                            </td>
                            <!-- 대표이미지?? 흠... -->
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td colspan="2">
                                <textarea name="content" id="content" cols="75" rows="18" style="resize:none;" placeholder="내용을 입력해주세요" required></textarea>
                            </td>
                        </tr>
                    </table>
                    
					 <!-- Notice 테이블에는 작성자 컬럼 없으므로 회원 번호 넘기지 않아도 된다(?) -->

                     <!-- 버튼 구역 -->
			        <div class="bottomArea">
			
			            <!-- 버튼 (목록으로) -->
			            <div class="btn">
			                <a href="<%=contextPath%>/list.umyq?currentPage=1" id="btn4">목록으로</a>
			            </div> 
			             <!-- 버튼 (등 록) -->
			            <div class="btn">
			                <a href="<%=contextPath%>/insert.umyq" id="btn4" data-toggle="modal" data-target="#enrollBtn" >글 작성</a>
			            </div>   			
					</div>
					
			        <!-- 공지사항 등록 모달 -->
			       <!-- The Modal -->
			       <div class="modal fade" id="enrollBtn" align="center" >
			           <div class="modal-dialog modal-dialog-centered">
			               <div class="modal-content" >
			             			                               
			                   <!-- Modal body -->
			                   <br>
			                   <div class="modal-body">
			                       	문의 하시겠습니까?
			                   </div>
			                           
			                   <!-- Modal footer -->
			                   <div id="modalFooter">
			                       <button type="button" id="okBtn" class="btn btn-warning">OK</button>
			                       <button id="cancleBtn" data-dismiss="modal" class="btn btn-secondary">Cancle</button>
			                   </div>
			               </div>
			            </div>
			      </div>
                </form>
        </div>
    </div>
    <div style="clear:both;"></div>
    <script>
    
    	
            $('#okBtn').click(function(e) {

                console.log("zzz");
                e.preventDefault();

                // Check
                // 문의분류 체크
                if($('#category option:selected').val() == "none") {
                    $('#op_product_info').change().text("문의 내용을 분류해주세요 !!")
                    return false;
                }

                $('#enrollForm').submit();
            });
            
            
            $(function(){
            $("#file_target").click(function(){
            	console.log("asdasdasd");
            	var $p = $(this).next(); // jQuery 방식으로 선택한 요소를 담아둘 때 변수명 앞에 $를 붙인다.
                
                if($p.css("display") == "none"){
                    $(this).siblings("#upfile").slideUp();
                     // 보여지게
                     $p.slideDown();
                    
                }else{
                    $p.slideUp();
                    //  사라지게
                }
				
				/*
                // slideDown 또는 slideUp 시킬 p 요소
                
				*/
            })
        })
    	
    </script>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>