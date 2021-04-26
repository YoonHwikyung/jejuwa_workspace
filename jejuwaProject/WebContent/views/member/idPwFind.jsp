<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- idPwFind css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/member/idPwFind.css">

    <!-- idPwFind js-->
    <link rel="stylesheet" href="">

    <!-- idPwFind fonts-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">

    <!-- jQuery 휴대폰 인증 서비스-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    
    <!-- iamport.payment.js 휴대폰 인증 서비스-->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
	<%@ include file="../common/loginUserMenubar.jsp" %>
    <div class="idPwFind_wrap">
        <p>아이디/비밀번호 찾기</p><br><br><br>
        <div class="idFind_wrap">
            <b style="font-size: 20px;">아이디 찾기</b><br><br>
            <form action="">
                <div class="idFind">
                    <table class="tb-id">
                        <tbody>
                            <tr class="name">
                                <th>이름</th>
                                <td><input type="text" class="full"></td>
                            </tr>
                            <tr class="phone">
                                <th>휴대폰번호</th>
                                <td>
                                    <input type="text" onkeyup="addHyphenToPhone(this);">
                                    <button class="send_sms" onclick="javascript:fn_SendSms2();">인증요청</button>
                                </td>
                            </tr>
                            <tr class="certification">
                                <th>인증번호</th>
                                <td><input class="full" type="text"></td>
                            </tr>
                            <tr class="memo">
                                <th></th>
                                <td style="font-size:10px;">* 인증번호는 발송 후 30분내에서만 유효합니다</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </form>
            <br>
            <div class="buttonArea">
                <button type="button" class="btn btn-warning btn-idPwfind">
                    <a href="">아이디 찾기 ></a>
                </button>
            </div>
        </div>
        <div class="pwFind_wrap">
            <b style="font-size: 20px;">비밀번호 찾기</b><br><br>
            <form action="">
                <div class="pwFind">
                    <table class="tb-pw">
                    <tbody>
                        <tr class="id">
                            <th>아이디</th>
                            <td><input type="text" class="full"></td>
                        </tr>
                        <tr class="name">
                            <th>이름</th>
                            <td><input type="text" class="full"></td>
                        </tr>
                        <tr class="phone">
                            <th>휴대폰번호</th>
                            <td>
                                <input type="text" onkeyup="addHyphenToPhone(this);">
                                <button class="send_sms" onclick="javascript:fn_SendSms2();">인증요청</button>
                            </td>
                        </tr>
                        <tr class="certification">
                            <th>인증번호</th>
                            <td><input class="full" type="text"></td>
                        </tr>
                        <tr class="memo">
                            <th></th>
                            <td style="font-size:10px;">* 인증번호는 발송 후 30분내에서만 유효합니다</td>
                        </tr>
                    </tbody>
                    </table>
                </div>
            </form>
            <br>
            <div class="buttonArea">
                <button type="button" class="btn btn-warning btn-idPwfind">
                    <a href="">비밀번호 찾기 ></a>
                </button>
            </div>  
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>