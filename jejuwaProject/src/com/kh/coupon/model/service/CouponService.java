package com.kh.coupon.model.service;


import static com.kh.common.JDBCTemplate.*;


import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.model.vo.PageInfo;
import com.kh.coupon.model.dao.CouponDao;
import com.kh.coupon.model.vo.Coupon;



public class CouponService {

//	조회게시글 총 갯수 
	
	public int selectListCount() {
		Connection conn = getConnection();
		int listCount = new CouponDao().selectListCount(conn);
		System.out.println("서비스 리스트카운트" + listCount);
		close(conn);
		
		return listCount;
		
	}
	
//----------------------관리자 쿠폰조회 
	
	public ArrayList<Coupon> adminCouponList(PageInfo pi) {
		
		Connection conn = getConnection();
		ArrayList<Coupon> adlist = new CouponDao().adminCouponList(conn, pi);
		close(conn);
		return adlist;
			
	}
	
	// 결제페이지에서 쿠폰 조회
	
	public Coupon selectCoupon(int memNo) {
		Connection conn = getConnection();
		Coupon c = new CouponDao().selectCoupon(conn, memNo);
		//System.out.println(c);
		close(conn);
		
		return c;
	}
	
	//마이페이지 쿠폰
	
	public int mySelectListCount() {
		Connection conn = getConnection();
		int listCount = new CouponDao().selectListCount(conn);
		
		close(conn);
		
		return listCount;
		
	}
	
	//관리자 쿠폰등록하기  insert 
	
	public int insertCoupon(Coupon ic) {
		Connection conn = getConnection();
		int result = new CouponDao().insertCoupon(conn, ic);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	
}
