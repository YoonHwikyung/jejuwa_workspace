        
$(document).ready(function(){

    // 아이디찾기 핸드폰 인증
    $("#id_mobile_auth").click(function(){

        $.ajax({
            url:"idFindMobileAuth.me",
            type:"POST",
            data:{
                idFind_name: $('#idFind_name').val(),
                id_phone: $('#id_phone').val()
            },

            // 이름 == 휴대폰 맞는것 성공시 실행될 이벤트
            success: function(res){
                if(res.result == true){
                        $("input[name=memId]").val(res.memId);
                        var phoneNumber = $("#id_phone").val();
                        alert("인증번호 발송 완료!!");

                        $.ajax({
                            url:"mobileAuth.me",
                            type:"POST",
                            data:{
                                "phoneNumber" : phoneNumber
                            },
                            success: function(res){
                                $("#id_auth_confirm").click(function(){
                                    if($.trim(res.result) == $("#id_auth_num").val()){
                                        // 체크조건 바꾸기
                                        $('#is_mobile_auth_id').val('T');
                                        // 인증번호 버튼 불가로 만들기
                                        $("#id_auth_confirm").attr('disabled', 'disabled');
                                        alert('휴대폰 인증에 성공했습니다.')

                                    } else{
                                        alert("인증번호가 일치하지 않습니다. 인증번호를 다시 확인해주세요");
                                        $('#id_auth_num').one('focus',focus());
                                    }
                                })
                            }
                        })
                } else{
                    alert("이름과 핸드폰번호가 일치하지 않습니다. 다시 확인해주세요.")
                    $('#idFind_name').one('focus', focus());
                }
            }
        }) 
    })

        // 아이디 찾기 버튼 클릭시 발생할 이벤트
    $('#idFind_btn').click(function(e) {
            e.preventDefault();

            // 휴대폰 인증 체크
            if($('#is_mobile_auth_id').val() !== 'T') {
                alert('휴대폰 인증해주시기 바랍니다.');
                return false;
            }

            $('#frmFindId').submit();
        });



    // 비밀번호찾기 핸드폰 인증
    $("#pwd_mobile_auth").click(function(){
        $.ajax({
            url:"PwFindMobileAuth.me",
            type:"POST",
            data:{
                pwFind_id : $('#pwFind_id').val(),
                pwFind_name: $('#pwFind_name').val(),
                pwd_phone: $('#pwd_phone').val()
            },
            // 이름 == 휴대폰 맞는것 성공시 실행될 이벤트
            success: function(res){
                if(res.result == true){
                        $("input[name=memPwd]").val(res.memPwd);
                        var phoneNumber = $("#pwd_phone").val();
                        alert("인증번호 발송 완료!!");
                        
                        $.ajax({
                            url:"mobileAuth.me",
                            type:"POST",
                            data:{
                                "phoneNumber" : phoneNumber
                            },
                            success: function(res){
                                console.log(res.result);
                                $("#pwd_auth_confirm").click(function(){
                                    if($.trim(res.result) == $("#pwd_auth_num").val()){
                                        // 체크조건 바꾸기
                                        $('#is_mobile_auth_pwd').val('T');
                                        // 인증번호 버튼 불가로 만들기
                                        $("#pwd_auth_confirm").attr('disabled', 'disabled');
                                        alert('휴대폰 인증에 성공했습니다.')

                                    } else{
                                        alert("인증번호가 일치하지 않습니다. 인증번호를 다시 확인해주세요");

                                        $('#pwd_auth_num').one('focus',focus());
                                    }
                                })
                            }
                        })
                } else{
                    alert("아이디와 이름과 핸드폰번호가 일치하지 않습니다. 다시 확인해주세요.")
                    $('#pwFind_id').one('focus', focus());
                }
            }
        }) 
    })

        // 비밀번호 찾기 버튼 클릭시 발생할 이벤트
    $('#pwFind_btn').click(function(e) {
        e.preventDefault();
        
        // 휴대폰 인증 체크
        if($('#is_mobile_auth_pwd').val() !== 'T' ) {
            alert('휴대폰 인증해주시기 바랍니다.');
            return false;
        }
        $('#frmFindPwd').submit();
    });
})
