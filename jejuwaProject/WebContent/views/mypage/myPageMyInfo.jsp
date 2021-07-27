<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- content css-->
<link rel="stylesheet" type="text/css" href="resources/css/mypage/myPageMyInfo.css">
</head>
<body>

	<%@ include file = "../common/mypageMenubar.jsp" %>
	<%
		// 현재 로그인한 회원의 정보 조회
		int memNo = login.getMemNo();
		String memId = login.getMemId();
		String memPwd = login.getMemPwd();
		String memName = login.getMemName();
		String phone = login.getPhone();
		String email = (login.getEmail() == null) ? "" : login.getEmail();
		String memBirth = (login.getMemBirth() == null) ? "" : login.getMemBirth();
		
		// 이메일 emailId / domain 으로 나눠서 변수에 저장
		String emailId = "";
		String domain = "";
		if(!email.equals("")){
			emailId = email.substring(0, email.indexOf("@"));
			domain = email.substring(email.indexOf("@")+1);
		}
		
		// 생년월일 "19980314" => "1998", "03", "14"
		String byear = "";
		String bmonth = "";
		String bday = "";
		if(!memBirth.equals("")){
			byear = memBirth.substring(0, 4);
			bmonth = memBirth.substring(4, 6);
			bday = memBirth.substring(6);
		}
%>
	
	<div class="outer">
       
       <br>
	
       <!-- 회원 상세정보 -->
       <div class="viewArea">
           <form action="<%= contextPath %>/myInfoUpdate.me" method="post" id="memInfoTable">
               <table id="infoTable" border="1" align="center">
               <input type="hidden" name="memNo" value="<%= memNo %>">
               <input type="hidden" name="memId" value="<%= memId %>">

                   <tr>
                       <th width="130">회원번호</th>
                       <td width="580"> &nbsp;&nbsp;&nbsp; <%= memNo %></td>
                       
                   </tr>

                   <tr>
                       <th>* 아이디</th>
                       <td> &nbsp;&nbsp;&nbsp; <%= memId %></td>
                       
                   </tr>
                   <tr>
                       <th>* 이름</th>
                       <td><input type="text" name="memName" maxlength="5" required value="<%= memName %>"></td>
                       
                   </tr>
                   <tr>
                       <th>비밀번호</th>
                       <td>

                           <div class="btn1" id="pwdBtn">
                               <a href="" data-toggle="modal" data-target="#updatePwd" >비밀번호 변경</a>        
                           </div>

                       </td>
                               
                       
                   </tr>
                   <tr>
                       <th>* 전화번호</th>
                       <td><input type="text" name="phone" required value="<%= phone %>"></td>
                       
                   </tr>
                   <tr>
                       <th>이메일</th>
                       <td>
                           <input type="text" name="emailId" value="<%= emailId %>">
                           @ <input type="text" name="domain" value="<%= domain %>">
                           <select id="domainSelect">
                               <option>직접입력</option>
                               <option>naver.com</option>
                               <option>gmail.com</option>
                               <option>kakao.com</option>
                               <option>선택안함</option>
                           </select>
                           
                           <!-- 회원정보수정 : 이메일 수정 / 선택안함 -->
                           <script>
                           	$(function(){
                           		$("#domainSelect").change(function(){
                           			if($("#domainSelect option:selected").text() == "직접입력"){
                           				$("input[name=domain]").val("");
                           			}else if($("#domainSelect option:selected").text() == "선택안함"){
                           				$("input[name=emailId]").val("");
                           				$("input[name=domain]").val("");
                           			}else{
                           				$("input[name=domain]").val($("#domainSelect option:selected").text());
                           			}
                           		})
                           	})
                           </script>
                       </td>
                       
                   </tr>
                   <tr>
                       <th>생년월일</th>
                       <td>
                            <select name="byear" id="byear">
                            	<option>----</option>
                              <%for(int i=1930; i<=2021; i++){ %>
		                          <option ><%= i %></option>
		                          <% if(!byear.equals("") &&  i == Integer.parseInt(byear)) {%>
		                          	<option selected><%= i %></option>
		                          <% } %>
                              <% } %>
                            </select> 년
                            
                            <select name="bmonth" id="bmonth">
                            <option>--</option>
                              <%for(int i=1; i<=12; i++){ %>
                              
	                              <% if(!bmonth.equals("") && i == Integer.parseInt(bmonth)) {%>
	                              
	                              	<% if(i < 10){ %>
	                             		<option selected><%= "0" + i %></option>
	                             	<% }else{ %>
	                              		<option selected><%= i %></option>
	                              	<% } %>
	                              	
	                              <% }else{ %>
	                              
	                              	<% if(i < 10){ %>
	                              		<option ><%= "0" + i %></option>
	                              	<% }else{ %>
	                              		<option ><%= i %></option>
	                              	<% } %>
	                              		
	                              <% } %>
	                             
                              <% } %>
                            </select> 월
                            
                            <select name="bday" id="bday">
                            <option>--</option>
                              <%for(int i=1; i<=31; i++){ %>
                              
                              	<% if(!bday.equals("") && i == Integer.parseInt(bday)) {%>
	                              
	                              	<% if(i < 10){ %>
	                             		<option selected><%= "0" + i %></option>
	                             	<% }else{ %>
	                              		<option selected><%= i %></option>
	                              	<% } %>
	                              	
	                              <% }else{ %>
	                              
	                              	<% if(i < 10){ %>
	                              		<option ><%= "0" + i %></option>
	                              	<% }else{ %>
	                              		<option ><%= i %></option>
	                              	<% } %>
	                              		
	                              <% } %>
                              <% } %>
                            </select> 일
                            
                            
                            <!-- 회원정보수정 : 생년월일 reset -->
                            <button type="button" onclick="memBirthReset();" class="btn btn-secondary">reset</button>

                            <script>
                            	function memBirthReset(){
                            		$("select[name=byear]").val("----");
                            		$("select[name=bmonth]").val("--");
                            		$("select[name=bday]").val("--");
                            	}
                            </script>
                            
                        </td>
                       
                   </tr>                    
               </table>
               <br><br>
           </form>

           <div class="bottomArea" >
               
              
                
               <div class="btn2" id="udBtn">
                   <a href="" id="btn3" onclick="return checkRequered();" data-toggle="modal" data-target="#updateMember">회원정보 수정</a> 
               </div>   
               
           </div> 
	</div>
   </div>


       <!-- 비밀번호 변경 모달 -->
        <!-- The Modal -->
        <div class="modal fade" id="updatePwd" align="center">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content" id="updatePwdModalContent">   

                    <!-- Modal body -->
                    
                    <div class="modal-body">
                        <span>
                            <i class="bi bi-person-circle"></i>  <!-- i 태그 -->
                        </span> <b style="font-size: large;">비밀번호 변경</b>
                    </div>
                    
                    <form action="<%= contextPath %>/updatePwd.me" method="post">            
                    <div class="input-group mb-3" id="updatePwdModalContent2">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                &nbsp;&nbsp;현재 비밀번호 입력
                            </span> 
                        </div>
                        <input size="25" type="password" name="memPwd" required>
                    </div>
                    <div class="input-group mb-3" id="updatePwdModalContent2">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                &nbsp;&nbsp;&nbsp;&nbsp;변경할 비밀번호
                            </span>
                        </div>
                        <input size="25" type="password" name="updatePwd" required>
                        <input name="memNo" type="hidden" value="<%=memNo%>">
                    </div>
                    <div class="input-group mb-3" id="updatePwdModalContent2">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                	변경할 비밀번호 확인
                            </span>
                        </div>
                        <input size="25" type="password" name="checkPwd" required>
                    </div>

                    <!-- Modal footer -->
                    <div id="modalFooter">
                        <button id="okBtn" class="btn btn-warning" onclick="return validatePwd();">비밀번호 변경</button>
                        <button id="cancleBtn" data-dismiss="modal" class="btn btn-secondary">취 소</button>
                    </div>
                    <script>
		       			function validatePwd(){
		       				if($("input[name=updatePwd]").val() != $("input[name=checkPwd]").val()){
		       					alert("변경할 비밀번호가 일치하지 않습니다.");
		       					return false;
		       				}
		       			}
	       			</script>
	       			</form>
              </div>
            </div>
        </div>



         <!-- 회원 정보 수정 모달 -->
       <!-- The Modal -->
       <div class="modal fade" id="updateMember" align="center" >
           <div class="modal-dialog modal-dialog-centered">
             <div class="modal-content" id="updateMemberModalContent">
             
               <!-- Modal body -->
               <br>
               <div class="modal-body">
                 	회원정보를 수정하시겠습니까?
               </div>
               
                            
               <div class="input-group mb-3" id="updateMemberModalContent2">
                 <div class="input-group-prepend">
                   <span class="input-group-text" id="basic-addon1" ><i class="bi bi-key" style="padding-left:3px;"></i></span>
                 </div>
                 <input name="memPwd2" size="25" type="password" placeholder=" 비밀번호" aria-label=" 비밀번호" aria-describedby="basic-addon1">
               	 
               </div>
               
               <!-- Modal footer -->
               <div id="modalFooter">
                 <button id="okBtn" class="btn btn-warning" onclick="return checkMember();">OK</button>
                 <button id="cancleBtn" data-dismiss="modal" class="btn btn-secondary">Cancle</button>
               </div>
               <script>
	       			function checkMember(){
	       				if($("input[name=memPwd2]").val() != "<%=memPwd%>"){
	       					alert("비밀번호가 일치하지 않습니다.");
	       				}else{
	       					$("#memInfoTable").submit();
	       				}
	       			}
	       	</script>
	       	
	       	<!-- 회원정보 수정시 필수 입력 사항 입력해야만 모달 띄우기 -->
	        <script>
          	 	function checkRequered(){
          	 		if($("input[name=memName]").val().trim() == ''){
          	 			alert("이름을 입력하세요.");
          	 			$("#btn3").attr("data-target", false);
          	 			$("input[name=memName]").focus();
          	 		} else if($("input[name=phone]").val().trim() == ''){
          	 			alert("전화번호를 입력하세요.");
          	 			$("#btn3").attr("data-target", false);
          	 			$("input[name=phone]").focus();
          	 		}else {
          	 			$("#btn3").attr("data-target", "#updateMember");
          	 		}
          	 	}
              </script>
                    
             </div>
           </div>
         </div>
         
     </div>    
	<%@ include file = "../common/footer.jsp" %>
	
</body>
</html>