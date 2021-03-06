package com.kh.coupon.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.common.model.vo.PageInfo;
import com.kh.coupon.model.vo.Coupon;

import static com.kh.common.JDBCTemplate.*;


public class CouponDao {
	
	private Properties prop = new Properties();
	
	
	public CouponDao() {
		
		String filename = CouponDao.class.getResource("/sql/coupon/coupon-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filename));
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}
	
	
public int selectListCount(Connection conn) {
		
//		1개 조회  select 정수값 총게시글 수 
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			
			if(rset.next()) {
				listCount = rset.getInt("LISTCOUNT");
				//별칭으로 했으면 똑같이 별칭으로 뽑아야함.
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("조회한 dao 리스트카운트" + listCount);
		return listCount;
		
	}
	
	
	//	관리자 쿠폰조회 
	
	
	public ArrayList<Coupon> adminCouponList(Connection conn, PageInfo pi){
		// select문 => ResultSet객체 (여러행)
		ArrayList<Coupon> adlist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("adminCouponList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1);
			pstmt.setInt(2, pi.getCurrentPage() * pi.getBoardLimit());
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				adlist.add(new Coupon(rset.getInt("mem_no"),
								   rset.getInt("cpn_code"),
								   rset.getString("cpn_name"),
								   rset.getInt("cpn_dc"),
								   rset.getDate("cpn_rgdt"),
								   rset.getString("cpn_str_date"),
								   rset.getString("cpn_end_date"),
								   rset.getInt("cpn_min")
								   ));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println(adlist);
		return adlist;
	}
	

	// 결제페이지에서 쿠폰 조회
	
	public Coupon selectCoupon(Connection conn, int memNo) {
		
		Coupon c = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCoupon");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c= new Coupon(rset.getInt("CPN_CODE"),
							  rset.getString("CPN_NAME"),
							  rset.getInt("CPN_DC"),
							  rset.getDate("CPN_RGDT"),
							  rset.getString("CPN_STR_DATE"),
							  rset.getString("CPN_END_DATE"),
							  rset.getInt("CPN_MIN"),
							  rset.getInt("MEM_NO"));
			}
			
			//System.out.println(c);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return c;
	}
	
	public int insertCoupon(Connection conn, Coupon ic) {
		
		System.out.println(ic);
		// insert => 처리된 행수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertCoupon");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql문
			
			pstmt.setString(1, ic.getCpn_Name());
			pstmt.setInt(2, ic.getCpn_Dc()); 
			pstmt.setString(3, ic.getCpn_Str_Date());
			pstmt.setString(4, ic.getCpn_End_Date());
			pstmt.setInt(5, ic.getCpn_Min());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
}


