package com.kh.myq.model.dao;

import static com.kh.common.JDBCTemplate.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.common.model.vo.Attachment;
import com.kh.common.model.vo.PageInfo;
import com.kh.myq.model.vo.MYQ;
import com.kh.product.model.vo.Product;

public class MYQDao {
	
	private Properties prop = new Properties();
	
	public MYQDao() {
		String filename = MYQDao.class.getResource("/sql/myq/myq-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 관리자 현재 총 게시글 조회
	 * @return
	 */
	public int selectListCountAdmin(Connection conn) {
		// SELECT
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt("LISTCOUNT");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}
	
	/**
	 * 관리자 게시글 리스트 조회
	 * @param pi
	 * @return
	 */
	public ArrayList<MYQ> selectListAdmin(Connection conn, PageInfo pi) {
		// SELECT 
		ArrayList<MYQ> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListAdmin");
		
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1);
			pstmt.setInt(2, pi.getCurrentPage() * pi.getBoardLimit());
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) { 
			list.add(new MYQ(rset.getInt("MYQ_NO")
				            , rset.getString("MYQ_CATEGORY")
				            , rset.getString("MYQ_TITLE")
				            , rset.getDate("MYQ_ENROLL_DATE")
				            , rset.getDate("MYQ_ANS_DATE")
				            , rset.getString("MEM_ID")
				            , rset.getString("P_CODE")
				            , rset.getString("MYQ_ANS_CONTENT")
				            , rset.getString("P_NAME")));
			
			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}
	
	/**
	 * 관리자 게시글 자세히 보기
	 * @param myqNo
	 * @return
	 */
	public MYQ selectDetailAdmin(Connection conn, int myqNo) {
		// SELECT
		MYQ q = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectDetailAdmin");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, myqNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) { 
				q = new MYQ(rset.getInt("MYQ_NO")
						  , rset.getString("MYQ_CATEGORY")
						  , rset.getString("MYQ_TITLE")
						  , rset.getString("MYQ_CONTENT")
						  , rset.getDate("MYQ_ENROLL_DATE")
						  , rset.getString("MYQ_ANS_CONTENT")
						  , rset.getDate("MYQ_ANS_DATE")
						  , rset.getInt("MEM_NO")
						  , rset.getString("P_CODE")
						  , rset.getString("MEM_ID")
						  , rset.getString("P_NAME")
						  , rset.getString("MEM_NAME"));
						}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return q;
	}
	
	/**
	 * 관리자 첨부파일 보기
	 * @param myqNo
	 * @return
	 */
	public ArrayList<Attachment> selectAttachmentAdmin(Connection conn, int myqNo) {
		// SELECT
		ArrayList<Attachment> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAttachmentAdmin");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, myqNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) { 
				Attachment at = new Attachment();
				at.setFileNo(rset.getInt("FILE_NO"));
				at.setOrgFileName(rset.getString("ORG_FILENAME"));
				at.setMdfFileName(rset.getString("MDF_FILENAME"));
				at.setFilePath(rset.getString("FILE_PATH"));
				at.setRefBoardType(rset.getString("REF_BOARD_TYPE"));
				at.setRefBoardNo(rset.getInt("REF_BOARD_NO"));
				at.setMyqNo(rset.getInt("MYQ_NO"));
				at.setpCode(rset.getString("P_CODE"));
				
				list.add(at);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	/**
	 * 관리자 답글
	 * @param answer
	 * @param getMyq_no
	 * @return
	 */
	public int answer(Connection conn, String answer, int getMyq_no) {
		// update
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("answer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, answer);
			pstmt.setInt(2, getMyq_no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	/** 
	 * 사용자 총 게시글 조회
	 * @param conn
	 * @return
	 */
	public int selectListCountUser(Connection conn, String memId) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListCountUser");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt("LISTCOUNT");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}
	
	/**
	 * 사용자 게시글 리스트 조회
	 * @param memId
	 * @param pi
	 * @return
	 */
	public ArrayList<MYQ> selectListUser(Connection conn, String memId, PageInfo pi) {
		
		ArrayList<MYQ> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListUser");
				
			try {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, memId);
				pstmt.setInt(2, (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1);
				pstmt.setInt(3, pi.getCurrentPage() * pi.getBoardLimit());
				
				rset = pstmt.executeQuery();
				
				while(rset.next()) { 
				list.add(new MYQ(rset.getInt("MYQ_NO")
					            , rset.getString("MYQ_CATEGORY")
					            , rset.getString("MYQ_TITLE")
					            , rset.getDate("MYQ_ENROLL_DATE")
					            , rset.getDate("MYQ_ANS_DATE")
					            , rset.getString("MEM_ID")
					            , rset.getString("P_CODE")
					            , rset.getString("MYQ_ANS_CONTENT")
					            , rset.getString("P_NAME")));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
		return list;
	}

	/**
	 * 사용자 게시글 자세히 보기
	 * @param myqNo
	 * @return
	 */	
	public MYQ selectDetailUser(Connection conn, int myqNo) {
		// SELECT
		MYQ q = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectDetailUser");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, myqNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) { 
				q = new MYQ(rset.getInt("MYQ_NO")
						  , rset.getString("MYQ_CATEGORY")
						  , rset.getString("MYQ_TITLE")
						  , rset.getString("MYQ_CONTENT")
						  , rset.getDate("MYQ_ENROLL_DATE")
						  , rset.getString("MYQ_ANS_CONTENT")
						  , rset.getDate("MYQ_ANS_DATE")
						  , rset.getInt("MEM_NO")
						  , rset.getString("P_CODE")
						  , rset.getString("MEM_ID")
						  , rset.getString("P_NAME")
						  , rset.getString("MEM_NAME"));
						}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return q;
	}
	
	/**
	 * 사용자 첨부파일 조회
	 * @param myqNo
	 * @return
	 */
	public ArrayList<Attachment> selectAttachmentUser(Connection conn, int myqNo) {
		// SELECT
		ArrayList<Attachment> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAttachmentUser");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, myqNo);
			
			rset = pstmt.executeQuery();
			
			// 각 객체 반복문 돌려서 list 값에 담고 이따가 detail jsp에서 반복문으로 뿌려주기
			while(rset.next()) { 
				Attachment at = new Attachment();
				at.setFileNo(rset.getInt("FILE_NO"));
				at.setOrgFileName(rset.getString("ORG_FILENAME"));
				at.setMdfFileName(rset.getString("MDF_FILENAME"));
				at.setFilePath(rset.getString("FILE_PATH"));
				at.setRefBoardType(rset.getString("REF_BOARD_TYPE"));
				at.setRefBoardNo(rset.getInt("REF_BOARD_NO"));
				at.setMyqNo(rset.getInt("MYQ_NO"));
				at.setpCode(rset.getString("P_CODE"));
				
				list.add(at);
				}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	/**
	 * 사용자 문의글 작성
	 * @param q
	 * @param list
	 * @return
	 */
	public int insertUser(Connection conn, MYQ q) {
		// insert문
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertUser");
		
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, q.getMyq_category());
			pstmt.setString(2, q.getMyq_title());
			pstmt.setString(3, q.getMyq_content());
			pstmt.setInt(4, q.getMem_no());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	/**
	 * 사용자 첨부파일 작성
	 * @param q
	 * @param list
	 * @return
	 */
	public int insertUserAttachment(Connection conn, ArrayList<Attachment> list) {
		// insert문
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertUserAttachment");
		
		try {
			for( Attachment at : list ) {
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, at.getOrgFileName());
				pstmt.setString(2, at.getMdfFileName());
				pstmt.setString(3, at.getFilePath());
				
				result = pstmt.executeUpdate();	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * 사용자 상품문의글 조회
	 * @param pcode
	 * @return
	 */
	public Product selectProduct(Connection conn, String pcode) {
		// select문
		Product p = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectProduct");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pcode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				p = new Product(rset.getString("P_NAME")
						      , rset.getString("P_CODE"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return p;
	}

	/**
	 * 사용자 상품문의글 작성
	 * @param q
	 * @param list
	 * @return
	 */
	public int insertProductUser(Connection conn, MYQ q) {
		// insert문
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertProductUser");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, q.getMyq_category());
			pstmt.setString(2, q.getMyq_title());
			pstmt.setString(3, q.getMyq_content());
			pstmt.setInt(4, q.getMem_no());
			pstmt.setString(5, q.getP_code());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * 사용자 문의글 첨부파일 삭제
	 * @param myq_no
	 * @return
	 */
	public int deleteUserAttachment(Connection conn, String[] myq_no_list) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteUserAttachment");
		
		try {
			for (String myq_no : myq_no_list) {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, myq_no);
				
				result = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * 사용자 문의글 삭제
	 * @param myq_no
	 * @return
	 */
	public int deleteUserMYQ(Connection conn, String[] myq_no_list) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteUserMYQ");
		
		try {
			for (String myq_no : myq_no_list) {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, myq_no);
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}



}
