<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>

   <!-- boardMenu css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/customerBoardMenu.css">

    <!-- boardMenu fonts-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
    <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
    div{border: 1px  rgb(145, 145, 145);}

/* 상세 네비게이션 바 */

#product-navWrap0{ padding: 40px;}

.review-p{
    display:table-cell;
    height:20px;
    width:140px;
}
.review-p a:hover{background:rgb(243, 224, 170);
                color: rgb(219, 217, 216);}

/* 헤더 추가되면 위에 중복이라서 지워도 됨 */

.product-navWrap a:hover{
 background:rgb(243, 202, 148);
 color: coral;}


.product-navWrap{
    display:table-cell;
    height:20px;
    width:174px;
    margin: 10px;
}

.product-navWrap a{
    text-decoration:none;
    color:rgb(0, 0, 0);
    font-size:15px;
    line-height:40px;
    font-weight:bold;
    display:block;
    width:160px;
    height:100%;
    background-color: rgb(231, 229, 224);
}

/* 제목,설명 */

#title{font-size: medium;
        font-weight: 800;
        margin-left: 10px;}


#explan{float: left;}

/* 비워주기 */
.clear {clear:both; height:0; overflow:hidden;}

/* 상세성명 / 리뷰버튼 */

.expln-button-wrap{
   width: 700px;
   padding: auto;
   margin: 10px;
}


#review-btn{
    float:right;
    padding: 10px;
    

}



/* review content */

.reviews{
    margin: auto;
    padding: 10px;
    width: 700px;
   
}

#review-top{
    margin: auto;
    padding: 10px;
    width: 700px;}


.review-row{float: left;}

.review-title{font-size: medium; font-weight: 600;
}

/*  */

.review-write-wrap{width: 700px;}

.wr-img{
    float: left;
    margin: 10px;
    margin-left: 20px;
    margin-top: 30px;
}
/* 이미지크기 */
.wr-img>img{
    width: 220px;
    height: 220px;
}

.review-write-wrap2{
    float: right;
    width: 400px;
    margin: 10px;
}

.review-write-wrap2 button {padding: 7px;}

.pic-btn{
    width: 375px;
    margin: 5px;
}

.write-sub-btn{
    width: 670px;
    padding: 20px;
}

.write-sub-btn input {width: 120px; height: 35px;}

    
    </style>
</head>

<body>
	
		<%@ include file = "../common/loginUserMenubar.jsp" %>

    <!-- 상세메뉴 리뷰 -->
    <div class="review-wrap" style="border:  black; width: 1000px;" >
        
        <div id="product-navWrap0" align="center">
            <div class="product-navWrap" align="center">
                <div class="review-p"><a href="">상품설명</a></div>
                <div class="review-p"><a href="">사용정보</a></div>
                <div class="review-p"><a href="">취소/환불</a></div>
                <div class="review-p"><a href="">리뷰</a></div>
                <div class="review-p"><a href="">상품문의</a></div>
            </div>
        </div>
            <div id="review-top">
            <p id="title">
                등록된 리뷰 기준<br>
                사용자 리뷰 총 평점 ★★★★★
            </p>
        
            <div class="expln-button-wrap">
            <span id="explan">상품평은 구매한 고객님만 작성이 가능하십니다. <br>
                상품 문의는 1:1문의 게시판, 취소 및 환불은 마이페이지를 이용해 주세요.</span><br><br>
                
            </div>
            <br><hr>
            <form action="" id="enrollForm" method="post" enctype="multipart/form-data">
            <div id="review-write-wrap">
                <div class="wr-img">
                <!-- 미리보기할 img -->
                <img id="titleImg" class="write-image">
                </div>

                <div class="review-write-wrap2">
                
                <textarea name="content" id="" cols="43" rows="10" placeholder="최대 1000글자" resize="none" required maxlength="1000"></textarea>
            
            </div>
            <!-- 파일첨부  -->
            <div class="pic-btn" id="fileArea">
                <input type="file" name="file1" id="file1" onchange="loadImg(this, 1);">
            </div>
            
            
            
            <script>
            
            
            	$(function() {
            			
            			$("#fileArea").hide();
            		
            			$("#titleImg").click(function(){
            				$("#file1").click();
            			});
            	})	
            
            
            	function loadImg(inputFile, num) {
            		// inputFile : 현재 변화가 생긴 input type
            		// 몇번째 input 요소인지 확인 후 영역에 미리보기 
            		
            		//파일 선택후 inputFile.files라는 속성배열에 0번 인덱스 파일 정보 담김
            		
            		if(inputFile.files.length == 1) { //선택파일이 있다면 
            			
            			//파일리더 객체 생성
            			var reader = new FIleReader();
            		
            			//선택된 파일 읽어들이기
            			//고유한 url부여
            			
            			reader.readAsDataURL(inputFile.file[0]);
            			
            			//파일 읽어들이기가 완료된 순간 실행할 함수 정의
            			
            			reader.onload = function(e) {
            				//각 영역에 맞춰서 이미지 미리보기 
            				switch(num) {
            				case 1: $("#titleImg").attr("src", e.target.result); break;
            				}
            			}
            			
            		}else{ //파일 사라졌을경우 
            			switch(num) {
        				case 1: $("#titleImg").attr("src", null); break;
        				}
            		}
            		
            	}
            </script>
            
            
            <div class="clear"></div>
            <div class="write-sub-btn" align="right">
            <input type="submit" value="등록"class="btn btn-primary" >
            </div>
            
            
            
            </form>
            </div>
          
</body>
</html>