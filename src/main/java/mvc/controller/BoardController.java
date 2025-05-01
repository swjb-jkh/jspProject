package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet{
   private static final long serialVersionUID = 1L;
   static final int LISTCOUNT = 10;
   
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   doPost(request, response);
   }
   
   public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   String RequestURI = request.getRequestURI();
	   String contextPath = request.getContextPath();
	   
	   System.out.println(RequestURI);
	   System.out.println(contextPath);
	   
	   String command = RequestURI.substring(contextPath.length());
	   
	   response.setContentType("text/html; charset=utf-8");
	   request.setCharacterEncoding("utf-8");
	   
		
		 if(command.equals("/BoardListAction.do")) { 
			 requestBoardList(request);
		  
			 RequestDispatcher  rd= request.getRequestDispatcher("./board/list.jsp");
		     rd.forward(request, response); 
		 }else if(command.equals("/BoardWriteForm.do")) {
			 requestLoginName(request);
			 
			 RequestDispatcher  rd= request.getRequestDispatcher("./board/writeForm.jsp");
		     rd.forward(request, response); 
		 }else if(command.equals("/BoardWriteAction.do")) {
			 //글쓰는 로직을 수행하는 함수생성
			 requestBoardWrite(request);
			 RequestDispatcher  rd= request.getRequestDispatcher("/BoardListAction.do");
		     rd.forward(request, response); 
		 }else if(command.equals("/BoardViewAction.do")) {
			 //글쓰는 로직을 수행하는 함수생성
			 requestBoardView(request);
			 RequestDispatcher  rd= request.getRequestDispatcher("/BoardView.do");
		     rd.forward(request, response); 
		 }else if(command.equals("/BoardView.do")) {
			 //글쓰는 로직을 수행하는 함수생성
			 RequestDispatcher  rd= request.getRequestDispatcher("./board/view.jsp");
		     rd.forward(request, response); 
		 }else if(command.equals("/BoardUpdateAction.do")) {
			 requestBoardUpdate(request);
			 RequestDispatcher  rd= request.getRequestDispatcher("/BoardListAction.do");
		     rd.forward(request, response); 
		 } else if(command.equals("/BoardDeleteAction.do")) {
			 requestBoardDelete(request);
			 RequestDispatcher  rd= request.getRequestDispatcher("/BoardListAction.do");
		     rd.forward(request, response); 
		 }
		 
		 
		 
		 
   }
   
   public void requestBoardList(HttpServletRequest request) {//등록된 글 목록 가져오기
	   BoardDAO dao = BoardDAO.getInstance();
	   List<BoardDTO> boardlist = new ArrayList<BoardDTO>();//다형성
	   int pageNum = 1;
	   int limit=LISTCOUNT;//5
	   
	   //페이지번호가 있으면
	   if(request.getParameter("pageNum") != null) pageNum = Integer.parseInt(request.getParameter("pageNum"));
	   
	   //정수로 변환해서 pageNum에 저장함
	   boardlist = dao.getBoardList(pageNum);
	   
	  
	   request.setAttribute("pageNum", pageNum);
	   request.setAttribute("boardlist", boardlist);
	   
	   String items = request.getParameter("items");
	   String text = request.getParameter("text");
	   
	   //매개변수 2개짜리는 게시판의 총 갯수를 리턴
	   int total_record = dao.getListCount(items, text);
	   //매개변수 4개짜리는 
	   boardlist = dao.getBoardList(pageNum, limit, items, text);
	   
	   request.setAttribute("items", items);
	   request.setAttribute("text", text);
	   request.setAttribute("pageNum", pageNum);	   
	   request.setAttribute("total_record", total_record);
	   request.setAttribute("boardlist", boardlist);
	   
	   //페이징 갯수 구하기
	   int total_page; //30
	   
	   if(total_record % limit == 0) {
		   total_page = total_record/limit;
	   }else {
		   total_page = (total_record/limit)+1;
	   }
	   
	   request.setAttribute("total_page", total_page);
	   request.setAttribute("boardlist", boardlist);
   }
   
   //인증된 사용자명 가져오는 함수 구현
   public void requestLoginName(HttpServletRequest request) {
	   String id = request.getParameter("id");
	   System.out.println("id:"+id);
	   BoardDAO dao =BoardDAO.getInstance();
	   String name = dao.getLoginNameById(id);
	   request.setAttribute("name", name);
   }
   
   public void requestBoardWrite(HttpServletRequest request) {
	   BoardDAO dao =BoardDAO.getInstance();
	   
	   BoardDTO board = new BoardDTO();
	   board.setId(request.getParameter("id"));
	   board.setName(request.getParameter("name"));
	   board.setSubject(request.getParameter("title"));
	   board.setContent(request.getParameter("content"));
	   
	   System.out.println("id:"+request.getParameter("id"));
	   System.out.println("name:"+request.getParameter("name"));
	   System.out.println("title:"+request.getParameter("title"));
	   System.out.println("contents:"+request.getParameter("content"));
	   
	   board.setHit(0);
	   board.setIp(request.getRemoteAddr());
	   dao.insertBoard(board);
   }
   
   //글 상세 페이지 가져오기
   public void requestBoardView(HttpServletRequest request) {
	   BoardDAO dao =BoardDAO.getInstance();
	   int num = Integer.parseInt(request.getParameter("num"));	 
	   int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	   
	   BoardDTO board = new BoardDTO();
	   board = dao.getBoardByNum(num, pageNum);
	   
	   request.setAttribute("num", num);
	   request.setAttribute("pageNum", pageNum);
	   request.setAttribute("board", board);
	   
   }
   
   //글 수정하기
   public void requestBoardUpdate(HttpServletRequest request) {
	   System.out.println("num");
	   System.out.println("pageNum");
	   int num = Integer.parseInt(request.getParameter("num"));
	   int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	   
	   BoardDAO dao = BoardDAO.getInstance();
	   
	   BoardDTO board = new BoardDTO();
	   board.setNum(num);
	   board.setName(request.getParameter("name"));
	   board.setSubject(request.getParameter("title"));
	   board.setContent(request.getParameter("contents"));
	   board.setUpdate_day(request.getParameter("update_day"));
	   
	   board.setIp(request.getRemoteAddr());
	   
	   dao.updateBoard(board);
   }
   
   public void requestBoardDelete(HttpServletRequest request) {
	   int num = Integer.parseInt(request.getParameter("num"));
	   
	   BoardDAO dao = BoardDAO.getInstance();
	   
	   dao.deleteBoard(num);
   }
   
}









