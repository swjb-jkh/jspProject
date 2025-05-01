<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- sessionId 얻어오기 -->
<%
	String sessionId = (String)session.getAttribute("sessionId");
%>

<header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">

      <a href="/kimssam-portfolio/step06/index.jsp" class="logo d-flex align-items-center">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1 class="sitename">Bootslander</h1>
      </a>

	<!-- 일반 사용자용 네브 -->
      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="/kimssam-portfolio/step06/index.jsp#hero" class="active">Home</a></li>
          <li><a href="/kimssam-portfolio/step06/index.jsp#about">About</a></li>
          <li><a href="/kimssam-portfolio/step06/index.jsp#features">Features</a></li>
          <li><a href="/kimssam-portfolio/step06/index.jsp#products">Products</a></li>
          <li><a href="/kimssam-portfolio/step06/index.jsp#team">Team</a></li>
          <li><a href="/kimssam-portfolio/step06/index.jsp#pricing">Pricing</a></li>
          <li><a href="/kimssam-portfolio/step06/blog.jsp">Blog</a></li>
          
          <li><a href="<c:url value="/BoardListAction.do?pageNum=1"/>">게시판</a></li>
          
          <c:choose>
				<c:when test="${empty sessionId}">
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href='<c:url value="/member/loginMember.jsp"/>'>회원 로그인</a></li>
					<li><a class="dropdown-item" href='<c:url value="/member/addMember.jsp"/>'>회원 가입</a></li>
				</c:when>
				<c:otherwise>
					<li><hr class="dropdown-divider"></li>
					<li style="color:orange"><%= sessionId %>님 로그인 중</li>
					<li><a class="dropdown-item" href='<c:url value="/member/updateMember.jsp"/>'>회원 수정</a></li>
					<li><a class="dropdown-item" href='<c:url value="/member/logoutMember.jsp"/>'>로그아웃</a></li>
				</c:otherwise>
			</c:choose>
         <li><hr class="dropdown-divider"></li>
		<li><a class="dropdown-item" href="#">배송 정보</a></li>
        </ul>
        <!-- 관리자용 네브 -->
    <c:choose>
    	<c:when test='${sessionId eq "admin"}'>
			<nav class="navmenu">
				<ul>
					<li><a class="dropdown-item" href='<c:url value="/step06/addProduct.jsp"/>'>판매제품 등록</a></li>
					<li><a class="dropdown-item" href='<c:url value="/step06/index.jsp?edit=update#products"/>'>판매제품 수정</a></li>
					<li><a class="dropdown-item" href='<c:url value="/step06/index.jsp?edit=delete#products"/>'>판매제품 삭제</a></li>
				</ul>
			</nav>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>

    </div>
  </header>