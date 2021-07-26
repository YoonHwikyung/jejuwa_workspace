<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- idFindSuccess css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/member/idFindSuccess.css">

<!-- idFindSuccess js-->
<script src=""></script>

<!-- idFindSuccess fonts-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet">

<!-- jQuery 휴대폰 인증 서비스-->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<!-- iamport.payment.js 휴대폰 인증 서비스-->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
	<%@ include file="../common/loginUserMenubar.jsp"%>
	<div class="idPwFind_wrap">
		<p>아이디 찾기</p>
		<br>
		<br>
		<div class="idFind_wrap">
			<div class="idFind_success">
				<b style="font-size: 25px;">아이디 찾기 완료</b><br>
				<br>
			</div>
			<div class="idFind">
				<b>아이디 : </b> <b style="color: orange;"><%= request.getAttribute("memId") %></b>
			</div>
			<br>
			<div class="buttonArea">
				<button type="button" class="btn btn-warning btn-login">
					<a href="<%= request.getContextPath() %>/lgview.me">로그인 ></a>
				</button>
				<button type="button" class="btn btn-warning btn-idPwfind">
					<a href="<%= request.getContextPath() %>/IdPwFind.me">비밀번호 찾기 ></a>
				</button>
			</div>
		</div>
	</div>
	</div>
	<br>
	<br>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>