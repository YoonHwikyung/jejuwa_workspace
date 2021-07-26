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

	/**
	 * 로그인 기능
	 * @param memId
	 * @param memPwd
	 * @return
	 */
	public Member loginMember(String memId, String memPwd) {
		Connection conn = getConnection();
		Member loginMember = new MemberDao().loginMember(conn, memId, memPwd);
		
		close(conn);
		
		return loginMember;
	}
	
	
	/**
	 * [휘경] 관리자 페이지에서 관리자로 로그인
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
	 * [민국] 핸드폰 api Service단
	 * @param phoneNumber
	 * @param numStr
	 * @return
	 */
	
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
	
	
	/**
	 * [민국] 아이디 찾기: 핸드폰번호 == 이름 체크여부
	 * @param memId
	 * @param phoneNumber
	 * @return
	 */
	public Member idFindCheck(String memName, String phoneNumber) {
		Connection conn = getConnection();
		
		Member m = new MemberDao().idFindCheck(conn, memName, phoneNumber);
		
		close(conn);
		
		return m;
	}
	
	/**
	 * [민국] 비밀번호 찾기: 아이디 == 이름 == 핸드폰번호 체크여부
	 * @param memId
	 * @param memName
	 * @param phoneNumber
	 * @return
	 */
	
	public Member pwFindCheck(String memId, String memName, String phoneNumber) {
		Connection conn = getConnection();
		
		Member m = new MemberDao().pwFindCheck(conn, memId, memName, phoneNumber);
		
		close(conn);
		
		return m;
	}

	
	/**
	 * [휘경] 멤버 수 조회(활동회원, 관리자)
	 * @return
	 */
	public int selectMemberCount() {
		Connection conn = getConnection();
		int memberCount = new MemberDao().selectMemberCount(conn);
		close(conn);
		return memberCount;
	}
	
	/**
	 * [휘경] 현재 요청한 페이지(currentPage)에 보여질 회원 리스트 조회
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
	 * [휘경] 회원 상세조회
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
	 * [휘경] 관리자 권한으로 회원 비밀번호 초기화(비밀번호를 회원아이디와 일치화)
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
	 * [휘경] 관리자 회원정보 변경 (처리된 행 수 반환)
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
	 * [휘경] 사용자 회원정보수정(변경된 회원 객체 반환)
	 * @param m
	 * @return
	 */
	public Member UserUpdateMember(Member m) {
		Connection conn = getConnection();
		int result = new MemberDao().UserUpdateMember(conn, m);
		
		Member updateMem = null;
		if(result > 0) {
			commit(conn);
			updateMem = new MemberDao().selectMember(conn, m.getMemNo());
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return updateMem;
	}
	
	
	/**
	 * [휘경] 사용자 비밀번호 변경(변경된 회원 객체 반환)
	 * @param memId
	 * @param memPwd
	 * @param updatePwd
	 * @return
	 */
	public Member updatePwd(int memNo, String memPwd, String updatePwd) {
		Connection conn = getConnection();
		int result = new MemberDao().updatePwd(conn, memNo, memPwd, updatePwd);
		
		Member updateMem = null;
		if(result > 0) {
			commit(conn);
			updateMem = new MemberDao().selectMember(conn, memNo);
		}else {
			rollback(conn);
		}
		close(conn);
		return updateMem;
	}

	
	/**
	 * [휘경] 사용자 회원탈퇴(탈퇴후 로그인된 정보 비우기)
	 * @param memId
	 * @return
	 */
	public int userDeleteMember(int memNo) {
		Connection conn = getConnection();
		int result = new MemberDao().userDeleteMember(conn, memNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	
	/**
	 * [휘경] 멤버 키워드 검색
	 * @param searchCtg 검색 카테고리(아이디, 이름, 전화번호)
	 * @param keyword
	 * @return
	 */
	public ArrayList<Member> searchMember(String searchCtg, String keyword){
		Connection conn = getConnection();
		ArrayList<Member> list = new MemberDao().searchMember(conn, searchCtg, keyword);
		close(conn);
		return list;
	}

	/**
	 * [휘경] 멤버 상태로 검색
	 * @param status
	 * @return
	 */
	public ArrayList<Member> searchMember2(String status){
		Connection conn = getConnection();
		ArrayList<Member> list = new MemberDao().searchMember2(conn, status);
		close(conn);
		return list;
	}

	
	/**
	 * [휘경] 멤버 수 조회2
	 * @return
	 */
	public int selectMemberCount2(String status) {
		Connection conn = getConnection();
		int memberCount = new MemberDao().selectMemberCount2(conn, status);
		close(conn);
		return memberCount;
	}
	
	
	/**
	 * [휘경] 현재 요청한 페이지(currentPage)에 보여질 회원 리스트 조회2
	 * @param pi
	 * @return
	 */
	public ArrayList<Member> selectList2(PageInfo pi, String status){
		Connection conn = getConnection();
		ArrayList<Member> list = new MemberDao().selectList2(conn, pi, status);
		close(conn);
		return list;
	}


}
