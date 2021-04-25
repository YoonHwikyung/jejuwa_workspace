package com.kh.member.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.model.vo.PageInfo;
import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;


import java.util.HashMap;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class MemberService {

	public Member loginMember(String memId, String memPwd) {
		Connection conn = getConnection();
		Member loginMember = new MemberDao().loginMember(conn, memId, memPwd);
		
		close(conn);
		
		return loginMember;
	}
	
	
	/**
	 * 관리자 페이지에서 관리자로 로그인
	 * @param memId
	 * @param memPwd
	 * @return
	 */
	public Member adminLogin(String memId, String memPwd) {
		Connection conn = getConnection();
		
		Member m = new MemberDao().adminLogin(conn, memId, memPwd);
		
		close(conn);
		return m;
	}

	/**
	 * [민국] 회원가입 
	 * */
	public int insertMember(Member m) {
		Connection conn = getConnection();
		
		int result = new MemberDao().insertMember(conn, m);
		
		if(result>0) {
			rollback(conn);
		} else {
			commit(conn);
		}
		
		close(conn);
		return result;
	}
	

	/**
	 * [민국] 아이디 중복체크
	 * @param checkId
	 * @return
	 */
	public int idCheck(String checkId) {
		Connection conn = getConnection();
		
		int count = new MemberDao().idCheck(conn, checkId);
		
		close(conn);
		
		return count;
	}
	
	/**
	 * 멤버 수 조회(활동회원, 관리자)
	 * @return
	 */
	public int selectMemberCount() {
		Connection conn = getConnection();
		int memberCount = new MemberDao().selectMemberCount(conn);
		close(conn);
		return memberCount;
	}
	
	/**
	 * 현재 요청한 페이지(currentPage)에 보여질 회원 리스트 조회
	 * @param pi
	 * @return
	 */
	public ArrayList<Member> selectList(PageInfo pi){
		Connection conn = getConnection();
		ArrayList<Member> list = new MemberDao().selectList(conn, pi);
		close(conn);
		return list;
	}
	
	/**
	 * 회원 상세조회
	 * @param memNo
	 * @return
	 */
	public Member selectMember(int memNo) {
		Connection conn = getConnection();
		Member m = new MemberDao().selectMember(conn, memNo);
		close(conn);
		return m;
	}
	
	
	/**
	 * 관리자 권한으로 회원 비밀번호 초기화(비밀번호를 회원아이디와 일치화)
	 * @param memNo
	 * @return
	 */
	public int resetPwd(int memNo) {
		Connection conn = getConnection();
		int result = new MemberDao().resetPwd(conn, memNo);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	/**
	 * [휘경] 관리자 회원정보 변경
	 * @param m (회원번호, 아이디, 이름, 연락처, 이메일, 생년월일)
	 * @return
	 */
	public int updateMember(Member m) {
		Connection conn = getConnection();
		int result = new MemberDao().updateMember(conn,m);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	/**
	 * [휘경] 관리자 회원탈퇴처리
	 * @param memNo
	 * @return
	 */
	public int adminDeleteMember(int memNo) {
		Connection conn = getConnection();
		int result = new MemberDao().adminDeleteMember(conn, memNo);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	/**
	 *  [휘경] 사용자 비밀번호 업데이트 (수정필요)
	 * @param memId
	 * @param updatePwd
	 * @return
	 */
	public Member updatePwd(String memId, String updatePwd) {
		Connection conn = getConnection();
		int result = new MemberDao().updatePwd(conn, memId, updatePwd);
		
		Member updateMem = null;
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return updateMem;
	}


	public String certifiedPhoneNumber(String phoneNumber, String numStr) {
        
		String api_key = "NCSPU8VROTREVNSS";
        String api_secret = "LAMWEOWXJD7WFQLYVEAT062S0K4GY3CH";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNumber);    // 수신전화번호
        params.put("from", phoneNumber);    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "제주와 휴대폰인증 테스트 메시지 : 인증번호는" + "["+numStr+"]" + "입니다.");
        params.put("app_version", "test app 1.2"); // application name and version

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        } 
		return numStr;
	}


}
