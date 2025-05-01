<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="dbconn.jsp" %>
<%
String filename="";
String realFolder = application.getRealPath("/resources/assets/img/product/");
String encType = "utf-8";
int maxSize = 5 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, 
		new DefaultFileRenamePolicy());
String productId = multi.getParameter("newProduct");
String pName = multi.getParameter("pName");
String unitPrice = multi.getParameter("unitPrice");
String description = multi.getParameter("description");
String category = multi.getParameter("category");
String condition = multi.getParameter("condition");
//String pQuantity = multi.getParameter("pQuantity");

int price;
if(unitPrice.isEmpty()) price = 0;
else price = Integer.valueOf(unitPrice);

Enumeration files = multi.getFileNames();
String fname = (String)files.nextElement();
String fileName = multi.getFilesystemName(fname);

//int quantity = Integer.valueOf(pQuantity);

String sql = "select * from product where p_productId = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, productId);
rs = pstmt.executeQuery();

if (rs.next()) {
	if (fileName != null) {
		sql = "UPDATE product SET p_pname=?, p_unitPrice=?, p_description=?, p_category=?, p_condition=?, p_filename=? WHERE p_productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pName);
		pstmt.setInt(2, price);
		pstmt.setString(3, description);
		pstmt.setString(4, category);
		pstmt.setString(5, condition);
		pstmt.setString(6, fileName);
		/* pstmt.setInt(7, quantity); */
		pstmt.setString(7, productId);
		pstmt.executeUpdate();
	} else {
		sql = "UPDATE product SET p_pname=?, p_unitPrice=?, p_description=?, p_category=?, p_condition=? WHERE p_productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pName);
		pstmt.setInt(2, price);
		pstmt.setString(3, description);
		pstmt.setString(4, category);
		pstmt.setString(5, condition);
		/* pstmt.setInt(6, quantity); */
		pstmt.setString(6, productId);
		pstmt.executeUpdate();
	}
}
if (rs != null)	rs.close();
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("index.jsp?edit=update#products");
%>