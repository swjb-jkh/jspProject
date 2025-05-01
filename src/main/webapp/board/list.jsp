<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Product" %>
<%@ page import="mvc.model.BoardDTO" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Index - Impact Bootstrap Template</title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <!-- Favicons -->
  <link href="${pageContext.request.contextPath}/assets/img/favicon.png" rel="icon">
  <link href="${pageContext.request.contextPath}/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="${pageContext.request.contextPath}/assets/css/main.css?v=1.0" rel="stylesheet">

<%
	int pageNum = ((Integer)request.getAttribute("pageNum")).intValue();
	List boardList = (List)request.getAttribute("boardlist");
	int total_record = (Integer)request.getAttribute("total_record");
	int total_page = (Integer)request.getAttribute("total_page");
%>
<style>
	html,body{
		padding-top:100px;
	}
</style>

</head>

<body>
  
  <!-- header include-->
  <%@ include file="/step06/navi.jsp" %>
  <script>
	function checkForm() {
		if(${sessionId==null}) {
			alert("로그인해 주세요");
			location.href="./member/loginMember.jsp";
			return false;
		}
		location.href="./BoardWriteForm.do?id=<%= sessionId%>"
	}
</script>
  <div class="container section-title">
  	<h1>게시판</h1>
  </div>
  
  <div class="container">
  	<form action='<c:url value="/BoardListAction.do"/>' method="post">
  		<div class="text-end">
  			<span class="">전체 <%=total_record %>건</span>
  		</div>
  		<div style="padding-tip:100px">
  			<table class="table table-hover">
  				<tr>
  					<th>번호</th>
  					<th>제목</th>
  					<th>작성일</th>
  					<th>수정일</th>
  					<th>조회</th>
  					<th>글쓴이</th>
  				</tr>
  				<%
  					for(int i=0; i<boardList.size(); i++) {
  						BoardDTO boardDTO = (BoardDTO)boardList.get(i);
  				%>
  				<tr>
  					<td><%= boardDTO.getNum() %></td>
  					<td>
  						<a href="./BoardViewAction.do?num=<%=boardDTO.getNum()%>&pageNum=<%=pageNum%>"><%=boardDTO.getSubject() %></a>
  					</td>
  					<td><%= boardDTO.getRegist_day() %></td>
  					<td><%= boardDTO.getUpdate_day() %></td>
  					<td><%= boardDTO.getHit() %></td>
  					<td><%= boardDTO.getName() %></td>
  				</tr>
  				<%
  					}
  				%>
  			</table>
  		</div>
  		<div class="text-center">
	  		<table width="100%">
	  			<td width="150px" align="left">
	  				<select name="items" id="txt">
	  					<option value="subject">제목에서</option>
	  					<option value="content">본문에서</option>
	  					<option value="name">글쓴이에서</option>
	  				</select>
	  				<input type="text" name="text"/>
	  				<input type="submit" class="btn" style="background-color: #10058c; color: white;" value="검색"/>
	  				<a class="btn btn-primary" href='<c:url value="/BoardListAction.do?pageNum=1"/>'>검색 초기화</a>
	  			</td>
	  			<td width="100" align="right">
	  				<a href="#" class="btn" style="background-color: #10058c; color: white;" onclick="checkForm()">✉ 글쓰기</a>
	  			</td>
	  		</table>
  		</div>
  		<!-- 페이지 구조 추가 -->
  		<div class="m-5" align="center">
  			<c:set var="pageNum" value="<%=pageNum %>"/>
  			<c:forEach var="i" begin="1" end="<%= total_page %>">
  				<c:if test="${items != null && text != null}">
  					<a href="<c:url value="/BoardListAction.do?pageNum=${i}&items=${items}&text=${text}"/>">
  						<c:choose>
  							<c:when test="${pageNum==i}">
  								<b>[${i}]</b>
  							</c:when>
  							<c:otherwise>
  								[${i}]
  							</c:otherwise>
  						</c:choose>
  					</a>
  				</c:if>
  				<c:if test="${items == null && text == null}">
  					<a href="<c:url value="/BoardListAction.do?pageNum=${i}"/>">
  						<c:choose>
  							<c:when test="${pageNum==i}">
  								<b>[${i}]</b>
  							</c:when>
  							<c:otherwise>
  								[${i}]
  							</c:otherwise>
  						</c:choose>
  					</a>
  				</c:if>
  			</c:forEach>
  		</div>
  	</form>
  </div>
  
  
  
  
  
	
  <!-- footer include -->
  <%@ include file="/step06/footer.jsp" %>
 
  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/php-email-form/validate.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/aos/aos.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>

  <!-- Main JS File -->
  <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

</body>

</html>