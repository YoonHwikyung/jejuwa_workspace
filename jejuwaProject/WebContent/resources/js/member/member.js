
$(document).ready(function(){

    // 회원가입 유효성 검사 : 이름,아이디,비밀번호,비밀번호확인
    // 1) 이름 검사

    $('#memName').focusout(function() {
        var regExp = /^[가-힣]{2,}$/g;

        if(!regExp.test( $('#memName').val()  )){
            $('#memName_chk').change($("#memName_chk").html('<label style="color:red;">이름이 잘못입력되었습니다.</label>'));
            $('#memName').val("");
            $('#memName').one('focus',focus());
            return false;
        } else{
            $('#memName_chk').change($("#memName_chk").html('<label style="color:green;">좋은 이름이시네요 :)</label>'));
        }
    });

    // 2) 아이디 검사(첫글자는 반드시 영문자로, 그리고 영문자, 숫자 포함하여 총 4~12자로 입력하시오.)
    $("#memId").focusout(function(){
        var regExp = /^[a-z][a-z\d]{3,11}$/;

        if(!regExp.test( $('#memId').val()  )){
            $('#id_check').change($("#id_check").html('<label style="color:red;">유효한 아이디로 입력해주세요.</label>'));
            $('#memId').val("");
            $('#memId').one('focus',focus());
            return false;
        } else{

        }
    })
    
    // 3) 비밀번호 검사(영문자, 숫자, 특수문자(!@#$%^&*)로 총 8~15자로 입력하시오.)
    $("#memPwd").focusout(function(){
        var regExp = /^[a-z\d!@#$%^&*]{8,15}$/i;

        if(!regExp.test( $('#memPwd').val()  )){
            $('#password_check').change($("#password_check").html('<label style="color:red;">유효한 비밀번호로 입력해주세요.</label>'));
            $('#memPwd').val("");
            $('#memPwd').one('focus',focus());
            return false;
        } else{
            $('#password_check').change($("#password_check").html('<label style="color:green;">야무진 비밀번호입니다 :)</label>'));
        }
    })

    // 4) 비밀번호 일치 검사(위의 비밀번호와 일치하게 입력하시오.)
    $("#pwdChecked").keyup(function(){
        if($('#memPwd').val() == $("#pwdChecked").val()){
                $('#pwd_chk').change($("#pwd_chk").html('<label style="color:green;">비밀번호가 일치합니다.</label>'));
            } else{
                $('#pwd_chk').change($("#pwd_chk").html('<label style="color:red;">비밀번호가 일치하지 않습니다.</label>'));
                $('#pwdChecked').one('focus',focus());
                return false;
            }
    })

    // 전체약관동의 버튼클릭시, 전체 동의 또는 전체해제
    $(".join_content").on("click", "#chk_all", function () {
        $(this).parents(".join_content").find('input').prop("checked", $(this).is(":checked"));
    });
    

    // 아이디 중복확인
    $("#id_check_btn").click(function(){
        var $memId = $("#memId"); 
        $.ajax({
            url: "idCheck.me",
            type: "get",
            data: {checkId:$memId.val()},
            success: function(result){
                if(result == 'NNNNN'){ // 사용불가능(기존에 아이디가 있음)
                    $('#id_check').change($("#id_check").html('<label style="color:red;">이미 존재하거나 탈퇴한 회원의 아이디입니다.</label>'));
                    $memId.one('focus',focus());
                } else{ // 사용가능(아이디 생성 가능)
                    if(confirm("사용가능한 아이디입니다. 정말로 사용하시겠습니까?")){
                        $('#id_check').change($("#id_check").html('<label style="color:green;">좋은 아이디 입니다.</label>'));
                        $("#memId:submit").removeAttr("disabled");
                        $('#is_unique_id').val('T');
                    } else{
                        // 사용가능하지만 다시 입력하겠다
                        $memId.one('focus',focus());
                    }
                }
            }, 
            error: function(){
                console.log("아이디 중복체크용  ajax 통신실패")	
            },
        })
    });

    // 휴대폰 인증
    $("#mobile_auth").click(function(){
        var phoneNumber = $("#phone").val();
        alert("인증번호 발송 완료!!");

        $.ajax({
            url:"mobileAuth.me",
            type:"POST",
            data:{
                "phoneNumber" : phoneNumber
            },
            success: function(res){
                $("#auth_confirm").click(function(){
                    if($.trim(res.result) == $("#auth_num").val()){
                        // 체크조건 바꾸기
                        $('#is_mobile_auth').val('T');
                        // 인증번호 버튼 불가로 만들기
                        $("#auth_num").attr('disabled', 'disabled');
                        alert('휴대폰 인증에 성공했습니다.');
                    } else{
                        alert("인증번호가 일치하지 않습니다. 인증번호를 다시 확인해주세요");
                        $('#auth_num').one('focus',focus());
                    }
                })
            }
        })
    });

    // 회원가입 넘길때 check요소 없을 시, 제약걸기
    $('#btnAgree').click(function(e) {
        e.preventDefault();

        // Check
        // 아이디 인증 체크
        if($('#is_unique_id').val() !== 'T') {
             alert('아이디 중복확인해주시기 바랍니다.');
             return false;
        }
        
        // 비밀번호 체크
        var regExp = /^[a-z\d!@#$%^&*]{8,15}$/i;
        if(!regExp.test( $('#passwod').val())){
               alert('비밀번호를 제대로 입력해야합니다.');
               return false;
          }

        // 비밀번호 확인체크
        if($('#passwod').val() == $('#pass_confirm')){
             alert('비밀번호가 다릅니다. 확인해주세요');
             return false;
        }
        
        // 휴대폰 인증 체크
        if($('#is_mobile_auth').val() !== 'T') {
             alert('휴대폰 인증해주시기 바랍니다.');
             return false;
         }
       
        // 이용약관 체크 checkbox checked 여부 
        if($('input:checkbox[id="chk_ns"]').is(":checked") == true == true){
            
        } else{
            alert('필수 이용약관에 동의해주세요.');
            return false;
        }

        $('#enrollForm').submit();
    });

})



    