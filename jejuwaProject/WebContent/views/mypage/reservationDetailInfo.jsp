<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.ArrayList, 
    com.kh.order.model.vo.*, com.kh.product.model.vo.*"%>
<%
	String contextPath = request.getContextPath(); 
	//ArrayList<Order> list = (ArrayList<Order>)request.getAttribute("list");
	Order o = (Order)request.getAttribute("o");
	Product p = (Product)request.getAttribute("p");
	String travleDate = (String)request.getAttribute("travleDate");
%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- 예약상세내역 css-->
  	<link rel="stylesheet" type = "text/css" href="<%=request.getContextPath() %>/resources/css/mypage/reservationDetailInfo.css">
  	
  	
<style>
	
</style>
</head>
<body>
	<div class="outer">
        <div id="div">예약상세</div>
        <br>
        <form action="<%=contextPath %>/detail.res" class="reservationForm">
        	<input type="hidden" name="pcode" value="pcode">
            <div id="div">상품명 </div> 
            
            <div id="notice" style="font-size: 15px; border-bottom: none;" >
                <b style="color: blue;" >SMS 또는 카카오톡으로 사용 방법 또는 e-티켓이 전송될 예정입니다.</b> <br>
    <b style="color: red;">업체 별로 사용방법 또는 e-티켓 발송 방식이 다를 수 있으니, 반드시 구매하신 상품 상세 페이지에서 내용을 확인하여 주세요. <br>
    사용 방법 및 e-티켓 발송에 대한 문의 사항은 제주와 상품 상세 페이지에 적힌 공급업체로 연락바랍니다.</b>
            </div>
            <br><br>
            <table border="1px">
                <tr align = "center">
                    <th>예약번호</th>
                    <td><%=o.getOrderNo() %></td>
                    <th>이용일</th>
                    <td><%=o.getTravelDate() %></td>
                </tr>
                <tr align = "center">
                    <th>여행자</th>
                    <td colspan="3"><%=o.getTravelUser() %>님</td>
                </tr>
                <tr align = "center">
                    <th>주문정보</th>
                    <td colspan="3"><%=o.getpName() %></td>
                </tr>

            </table>
            <br><br>

            <div id="div">결제금액</div>

            <table border="1px" >
                <tr align = "center">
                    <th>예약번호</th>
                    <td><%=o.getOrderNo() %></td>
                    <th>총 금액</th>
                    <td><%=o.getAmount() %> 원</td>
                </tr>
               
            </table>
            <br><br>
			
			<!-- 이메일 모달 -->
			<div class="container">
			  <!-- Button to Open the Modal -->
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="emailButton">
			    이메일 전송
			  </button>
			
			  <!-- The Modal -->
			  <div class="modal fade" id="myModal">
			    <div class="modal-dialog modal-dialog-centered">
			      <div class="modal-content">
			      
			        <!-- Modal Header -->
			        <div class="modal-header">
			          <h4 class="modal-title">이메일전송</h4>
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        
			        <!-- Modal body -->
			        <div class="modal-body">
			          <input type = "email" placeholder="<%=o.getTravelEmail()%>" style="width: 100%;">
			        </div>
			        
			        <!-- Modal footer -->
			        <div class="modal-footer">
                      <button type="button" class="btn btn-warning" data-dismiss="modal">전송</button>
			          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			        </div>
			        
			      </div>
			    </div>
			  </div>
			  
			</div>
            <!-- 모달 -->
            <div id="div">여행확인증
            	
            
            </div>
           
            <table border="1px">
                <tr>
                    <td>지각 관련 안내사항(약관 기반)</td>
                </tr>
                <tr>
                    <td>단독 투어: 15분 이상 미팅 장소에 나오지 않을 시 여행 해지/환불 불가 <br>
                        그룹 투어: 다른 여행자를 위해 지각할 시 기다려드리지 않으며 정시 출발
                    </td>
                </tr>
            </table>
            <br><br>
            <div id="div">예약정보상세</div>
            <table border="1px">
                <tr>
                    <td>주문정보<br>
                        성인 입장권 ✕ 1
                    </td>
                </tr>
                <tr>
                    <td>
                        필수 안내- 주소 : 제주특별자치도 서귀포시 상예동 3592-5 <br>
                        - 문의전화 : 010-2691-0666 <br>
                        - 운영시간 : 09:30~18:00 (입장마감 17:30) <br>
                        - 48개월 이상 소인 금액 적용 <br>
                        
                        
                        【 꼭 확인하세요! 】
                        - 구매하신 인원 수대로 바코드가 MMS 문자로 발송됩니다. <br>
                        - 바코드에 수령된 인원 기준으로 관광지 입장하셔야 합니다. <br>
                        - 렌터카 및 자가운전자만 이용 가능합니다. <br>
                        - 단체관광 및 운전기사, 가이드 동반, 렌터카 기사 대여, 택시 이용 시 사용이 불가합니다. <br>
                        - 타 관광지 할인쿠폰과 중복할인이 불가합니다. <br>
                        - 관광지 폐장 1시간 전까지 입장해주셔야 관람이 편리합니다. <br>
                        - 패키지 상품은 한 군데라도 이용 시 부분 환불이 불가합니다. <br>
                        - 해당 상품의 유효기간은 구매 후 60일입니다. <br>
                        <br>
                        * 바코드 미발송, 분실 등에 대한 문의는 제주와로 부탁드립니다 
                    </td>
                </tr>
            </table>
            <br><br>
            <div style="font-size: 15px;" id="div">
                제주와는여행 확인증에 명시한 가이드 서비스 요금에만 취소 및 환불 정책을 적용하며 그 권리를 보장합니다. <br>
                여행 확인증에 명시되지 않은 내용이나 가이드와 개별적으로 약속한 내용은 제주와하고는 무관함을 알려드립니다. <br>
                현지 긴급 상황 발생 시 : 가이드 (공급처) 연락처로 연락주세요. <br>
                고객센터 운영시간: 한국시간 09시 ~ 18시 (월~금, 공휴일&휴일 1:1 문의만 가능) <br>
            </div>
        </form>
    </div>

    <br>

    <div id = "click_btn" align="center">
        <button type='button' id="modal_btn" class="btn btn-warning">취소요청하기</button>
    </div>

    <form id = "cancelForm" action = "<%=contextPath%>/update.or" method = "post">
    	<input type="hidden" name="pcode" value="<%=o.getpCode() %>">
		<!-- <input type="hidden" name="amount" value="<%=o.getAmount() %>"> -->
		<!-- <input type="hidden" name="travle" value="<%=travleDate%>">-->
		<!-- <input type="hidden" name="cReason" value="<%=o.getcReason() %>">-->
		
        <div class="black_bg"></div>
            <div class="modal_wrap">
                <div class="modal_close"><a href="#">close</a></div>
                    <div>
                    	<br>
                        <p style="border-bottom: 1px solid gray;" id="cancelHead">취소하기</p>
                        <p id="smallCancelHead"><b>취소사유를 선택해주세요.</b></p> <br>
                        <select name = "cReason" style="width: 80%; margin-left: 35px;" id="selectOption">
	                        <option value="여행자개인사정">여행자개인사정</option>
	                        <option value="모객마감"> 모객마감 </option>
	                        <option value="모객부족"> 모객부족 </option>
	                        <option value="가이드일정불가 "> 가이드일정불가 </option>
	                        <option value="가이드무응답"> 가이드무응답 </option>
	                        <option value="건강 상의 이유"> 건강 상의 이유 </option>
	                        <option value="재예약 진행을 위해"> 재예약 진행을 위해 </option>
	                        <option value="천재지변"> 천재지변 </option>
	                        <option value="기타 "> 기타 </option>
                        </select>

                        <script>
                        	$(function(){
                        		
                        		$("#updateForm option").each(function(){
                        			if($(this).text() == "<%=o.getcReason()%>"){
                        				$(this).attr("selected", true);
                        			}
                        		})
                        		
                        	})
                        </script>

                        <br><br> <br>                  

                        <div id="reservationCancel" align = "center">
                            <button type="submit" class="btn btn-danger">예약취소하기</button>
                        </div>
                    </div>
            </div>

    <script>
        window.onload = function() {
     
        function onClick() {
            document.querySelector('.modal_wrap').style.display ='block';
            document.querySelector('.black_bg').style.display ='block';
        }   
        function offClick() {
            document.querySelector('.modal_wrap').style.display ='none';
            document.querySelector('.black_bg').style.display ='none';
        }
     
        document.getElementById('modal_btn').addEventListener('click', onClick);
        document.querySelector('.modal_close').addEventListener('click', offClick);
        
     
    };
    </script>
    
    </form> 
</body>
</html>