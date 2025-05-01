package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {
   private static BoardDAO instance;
   private BoardDAO() {}
   
   public static BoardDAO getInstance() {
	   if(instance == null) instance = new BoardDAO();
	   return instance;
   }
   
   //게시판 하단의 페이징과 검색기능이 구현되면서 db에서 원하는 조건에 맞는 레코드 개수를 얻어오는 함수
   public int getListCount(String items, String text) {
	   //items : 컬럼명, text:검색 문자열
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   int x = 0; //선택된 총 게시글의 갯수
	   
	   String sql;
	   
	   if(items == null && text == null) //검색을 안했을 때
		   sql = "select count(*) from board";
	   else
		   sql = "select count(*) from board where "+items+" like '%"+text+"%'";
	   
	   try {
		   conn = DBConnection.getConnection();
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery();
		   
		   if(rs.next()) x = rs.getInt(1);
		   System.out.println("X:"+x);
	   }catch(Exception e) {
		   System.out.println("getListCount() 에러:"+e);
	   }finally {
			try {
				 if(rs !=null) rs.close();
				 if(pstmt !=null) pstmt.close();
				 if(conn !=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	   }
	return x; //선택된 총 게시글의 갯수 리턴
   }
   
   //테이블의 목록을 가져오는 함수 생성
   public ArrayList<BoardDTO> getBoardList(int page){
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   String sql="select * from board order by board_seq desc";
	   
	   ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	   
       try {
        	 conn = DBConnection.getConnection();
  		     pstmt = conn.prepareStatement(sql);
  		     rs = pstmt.executeQuery();
  		     while(rs.next()) {
  		    	BoardDTO board = new BoardDTO();
  		    	board.setNum(rs.getInt("board_seq"));
  		    	board.setId(rs.getString("id"));
  		    	board.setName(rs.getString("name"));
  		    	board.setSubject(rs.getString("subject"));
  		    	board.setContent(rs.getString("content"));
  		    	board.setRegist_day(rs.getString("regist_day"));
  		    	board.setHit(rs.getInt("hit"));
  		    	board.setIp(rs.getString("ip"));
  		    	board.setUpdate_day(rs.getString("update_day"));
  		    	
  		    	list.add(board);
  		     }
       }catch(Exception e) {
          System.out.println("매개변수 하나짜리 getBoardList() 에러 : "+e);
       }finally {
    	   try {
				 if(rs !=null) rs.close();
				 if(pstmt !=null) pstmt.close();
				 if(conn !=null) conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
       }
       return list;
   }
   
   //게시판 하단의 페이징과 검색기능 구현
   public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text){
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   int total_record = getListCount(items, text);
	   
	   int start = (page - 1) * limit;  //start:0,5,10....5,10,15...
	   int index = start + 1; //1,6,11...6,11,16...
	   
	   String sql;
	   
	   if(items == null && text == null) {
		   sql = "select * from board order by board_seq desc";
	   }else {
		   sql = "select * from board where "+items+" like '%"+text+"%' order by board_seq desc";
	   }
	   
	   ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	   
	   try {
      	 conn = DBConnection.getConnection();
		     pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		     rs = pstmt.executeQuery();
		     while(rs.absolute(index)) {
		    	BoardDTO board = new BoardDTO();
		    	board.setNum(rs.getInt("board_seq"));
		    	board.setId(rs.getString("id"));
		    	board.setName(rs.getString("name"));
		    	board.setSubject(rs.getString("subject"));
		    	board.setContent(rs.getString("content"));
		    	board.setRegist_day(rs.getString("regist_day"));
		    	board.setHit(rs.getInt("hit"));
		    	board.setIp(rs.getString("ip"));
		    	board.setUpdate_day(rs.getString("update_day"));
		    	
		    	list.add(board);
		    	
		    	//페이징 로직 처리
		    	if(index < (start + limit) && index <= total_record) index++;
		    	else break;
		     }
     }catch(Exception e) {
        System.out.println("매개변수 네개짜리 getBoardList() 에러 : "+e);
     }finally {
  	   try {
				 if(rs !=null) rs.close();
				 if(pstmt !=null) pstmt.close();
				 if(conn !=null) conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
     }
	return list;
   }
   
   //member테이블에서 인증된 id의 사용자명 가져오는 함수
   public String getLoginNameById(String id) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   String name = null;
	   String sql = "select * from member where id=?";
	   
	try {
		conn = DBConnection.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) name = rs.getString("name");
		return name;
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println("매개변수 id를 가진 getloginNameById(id) 에러 : "+e);
	}finally {
  	   try {
			 if(rs !=null) rs.close();
			 if(pstmt !=null) pstmt.close();
			 if(conn !=null) conn.close();
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
     }
	return name;
   }
   
   public void insertBoard(BoardDTO board) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   
	   String sql = "insert into board (board_seq,id,name,subject,content,regist_day,hit,ip,update_day)\r\n"
	   		+ "    values(board_seq.nextval,?,?,?,?,default,?,?,default)";
	   
	   try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getHit());
			pstmt.setString(6, board.getIp());
			
			pstmt.executeUpdate();
			System.out.println("pstmt.executeUpdate() 실행");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertBoard() 에러 : "+e);
		}finally {
	  	   try {
				 if(pstmt !=null) pstmt.close();
				 if(conn !=null) conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
	     }
   }
   
 //선택된 글 상세 내용 가져오기
   public BoardDTO getBoardByNum(int num, int pageNum) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   BoardDTO board = null;
	   
	   updateHit(num);
	   
	   
	   String sql ="select * from board where board_seq=?";
	   try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("board_seq"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setUpdate_day(rs.getString("update_day"));
			}
			
			System.out.println("pstmt.getBoardByNum() 실행");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getBoardByNum() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	return board;
   }
   
   public void updateHit(int num) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   try {
			conn = DBConnection.getConnection();
			String sql ="select * from board where board_seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			System.out.println("updateHit() 실행");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("updateHit() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
   }
   
   public void updateBoard(BoardDTO board) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   
	   try {
		   String sql = "update board set subject=?,content=?,ip=?,update_day=sysdate where board_seq=?";
		   
		   conn = DBConnection.getConnection();
		   pstmt = conn.prepareStatement(sql);
		   
		   pstmt.setString(1, board.getSubject());
		   pstmt.setString(2, board.getContent());
		   pstmt.setString(3, board.getIp());
		   pstmt.setInt(4, board.getNum());
		   
		   pstmt.executeUpdate();
		   
	   }catch(Exception e) {
		   e.printStackTrace();
			System.out.println("getBoardByNum() 에러 : " + e);
	   }finally {
		   try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
	   }
   }
   
   public void deleteBoard(int num) {
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   
	   try {
		   String sql = "delete board where board_seq=?";
		   
		   conn = DBConnection.getConnection();
		   pstmt = conn.prepareStatement(sql);
		   
		   pstmt.setInt(1, num);
		   
		   pstmt.executeUpdate();
		   
	   }catch(Exception e) {
		   e.printStackTrace();
			System.out.println("deleteBoardByNum() 에러 : " + e);
	   }finally {
		   try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
	   }
   }
}