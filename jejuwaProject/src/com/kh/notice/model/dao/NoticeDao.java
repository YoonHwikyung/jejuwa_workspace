package com.kh.notice.model.dao;

import static com.kh.common.JDBCTemplate.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.common.model.vo.PageInfo;
import com.kh.notice.model.vo.Notice;

public class NoticeDao {
	
	private Properties prop = new Properties();
	
	public NoticeDao() {
		String fileName = NoticeDao.class.getResource("/sql/notice/notice-mapper.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * [휘경] 공지사항 총 게시글 갯수 조회
	 * @param conn
	 * @return 공지사항 게시글 총 갯수
	 */
	public int selectListCount(Connection conn) {
		// select문 => ResultSet(게시글 총 수)
		int listCount = 0;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql); // 완성된 sql
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
	 * [휘경] 공지사항 리스트 조회
	 * @param conn
	 * @param pi
	 * @return
	 */
	public ArrayList<Notice> selectList(Connection conn, PageInfo pi){
		// select문 => ResultSet(여러행)
		ArrayList<Notice> list = new ArrayList<>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectList");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql문
			/*
			 * startRow = (currentPage - 1) * boardLimit + 1
			 * endRow = currentPage * boardLimit
			 */
			pstmt.setInt(1, (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1);
			pstmt.setInt(2, pi.getCurrentPage() * pi.getBoardLimit());
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Notice(rset.getInt("NOTICE_NO"),
									rset.getString("NOTICE_TITLE"),
									rset.getDate("ENROLL_DATE"),
									rset.getInt("NOTICE_COUNT"),
									rset.getString("ORG_FILENAME"),
									rset.getString("FILE_PATH")));
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
	 * [휘경] 공지사항 insert(테이블 내에 첨부파일 따로 관리)
	 * @param conn
	 * @param n
	 * @return
	 */
	public int insertNotice(Connection conn, Notice n) {
		// insert => 처리된 행수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertNotice");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql문
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeContent());
			pstmt.setString(3, n.getOriginFileName()); // Q
			pstmt.setString(4, n.getFilePath()); // Q
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	/**
	 * [휘경] 공지사항 상세조회시 조회수 증가
	 * @param conn
	 * @param noticeNo
	 * @return
	 */
	public int increaseCount(Connection conn, int noticeNo) {
		// update문 => 처리된 행 수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseCount");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql
			pstmt.setInt(1, noticeNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * [휘경] 공지사항 상세조회
	 * @param conn
	 * @param noticeNo
	 * @return
	 */
	public Notice selectNotice(Connection conn, int noticeNo) {
		// select문 => ResultSet(한 행)
		Notice n = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectNotice");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성
			pstmt.setInt(1, noticeNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new Notice(rset.getInt("NOTICE_NO"),
							   rset.getString("NOTICE_TITLE"),
							   rset.getString("NOTICE_CONTENT"),
							   rset.getDate("ENROLL_DATE"),
							   rset.getString("ORG_FILENAME"),
							   rset.getString("FILE_PATH"));
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return n;
	}
	
	/**
	 * [휘경] 공지사항 업데이트 1(첨부파일이 있는경우)
	 * @param conn
	 * @param n
	 * @return
	 */
	public int updateNotice1(Connection conn, Notice n) {
		// update문 => 처리된 행 수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateNotice1");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeContent());
			pstmt.setString(3, n.getOriginFileName());
			pstmt.setString(4, n.getFilePath());
			pstmt.setInt(5, n.getNoticeNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * [휘경] 공지사항 업데이트2 (첨부파일이 없는 경우)
	 * @param conn
	 * @param n
	 * @return
	 */
	public int updateNotice2(Connection conn, Notice n) {
		// update문 => 처리된 행 수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateNotice2");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeContent());
			pstmt.setInt(3, n.getNoticeNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	/**
	 * [휘경] 공지사항 삭제
	 * @param conn
	 * @param noticeNo
	 * @return
	 */
	public int deleteNotice(Connection conn, int noticeNo) {
		// update문 => 처리된 행수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteNotice");
		
		try {
			pstmt = conn.prepareStatement(sql); // 미완성 sql
			pstmt.setInt(1, noticeNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
		
	}
	
	
	/**
	 * [휘경] 공지사항 키워드 검색
	 * @param conn
	 * @param searchCtg 검색 카테고리(제목, 내용, 제목+내용 중 하나)
	 * @param keyword
	 * @return
	 */
	public ArrayList<Notice> searchNotice(Connection conn, String searchCtg, String keyword){
		// select문 => ResultSet(여러행)
		ArrayList<Notice> list = new ArrayList<>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		//String sql = prop.getProperty("selectList");
		String sql = "";
		
//		switch(searchCtg) {
//		case"title": sql=prop.getProperty("searchNoticeTitle"); break;
//		case"content": sql=prop.getProperty(""); break;
//		case"titleContent" : sql=prop.getProperty("");
//		}
		
		
		// 카테고리 : 제목 으로 검색한 경우
		if(searchCtg.equals("title")) {
			sql = prop.getProperty("searchNoticeTitle");
			
			try {
				pstmt = conn.prepareStatement(sql); // 미완성 sql
				pstmt.setString(1, "%" + keyword + "%");
				rset = pstmt.executeQuery();
				while(rset.next()) {
					list.add(new Notice(rset.getInt("NOTICE_NO"),
							rset.getString("NOTICE_TITLE"),
							rset.getDate("ENROLL_DATE"),
							rset.getInt("NOTICE_COUNT"),
							rset.getString("ORG_FILENAME"),
							rset.getString("FILE_PATH")));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
		}
		
		
		// 카테고리 : 내용 으로 검색한 경우
		if(searchCtg.equals("content")) {
			sql = prop.getProperty("searchNoticeContent");
			
			try {
				pstmt = conn.prepareStatement(sql); // 미완성 sql
				pstmt.setString(1, "%" + keyword + "%");
				rset = pstmt.executeQuery();
				while(rset.next()) {
					list.add(new Notice(rset.getInt("NOTICE_NO"),
							rset.getString("NOTICE_TITLE"),
							rset.getDate("ENROLL_DATE"),
							rset.getInt("NOTICE_COUNT"),
							rset.getString("ORG_FILENAME"),
							rset.getString("FILE_PATH")));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
		}
		
		// 카테고리 : 제목+내용 으로 검색한 경우
		if(searchCtg.equals("titleContent")) {
			sql = prop.getProperty("searchNoticeTitleContent");
			
			try {
				pstmt = conn.prepareStatement(sql); // 미완성 sql
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				rset = pstmt.executeQuery();
				while(rset.next()) {
					list.add(new Notice(rset.getInt("NOTICE_NO"),
							rset.getString("NOTICE_TITLE"),
							rset.getDate("ENROLL_DATE"),
							rset.getInt("NOTICE_COUNT"),
							rset.getString("ORG_FILENAME"),
							rset.getString("FILE_PATH")));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
		}
		
		
		
		return list;
		
	
		
	}
	

}
