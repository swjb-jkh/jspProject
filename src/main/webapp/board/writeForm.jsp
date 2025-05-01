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
	String name = (String)request.getAttribute("name");
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
		if(!document.newWrite.name.value) {
			alert("성명을 입력하세요.");
			document.newWrite.name.focus();
			return false;
		}
		if(!document.newWrite.title.value) {
			alert("제목을 입력하세요.");
			document.newWrite.title.focus();
			return false;
		}
		if(!document.newWrite.contents.value) {
			alert("내용을 입력하세요.");
			document.newWrite.contents.focus();
			return false;
		}
	}
</script>
  <div class="container section-title">
  	<h1>게시판</h1>
  	<p>자유롭게 글을 남겨주세요.</p>
  </div>
	<div class="container mb-5">
		<form name="newWrite" action="./BoardWriteAction.do" onsubmit="return checkForm()" method="post">
			<input type="hidden" name="id" value="${sessionId}"/>
			<div class="mb-3">
				<label for="exampleInputName" class="form-label">성명</label>
				<input type="text" class="form-control" id="exampleInputName" 
					aria-describedby="emailHelp" value="<%=name%>" name="name">
				<div id="emailHelp" class="form-text">작성했을때 보이는 이름입니다.</div>
			</div>
			<div class="mb-3">
				<label for="exampleInputTitle" class="form-label">제목</label>
				<input type="text" class="form-control" id="exampleInputTitle" 
					aria-describedby="emailHelp" name="title">
			</div>
			<div class="mb-3">
				<label for="exampleInputContents" class="form-label">내용</label>
				<textarea type="text" class="form-control" id="exampleInputContents" 
				name="content" rows="10"></textarea>
			</div>
			<input type="submit" class="btn btn-primary" value="등록">
			<input type="reset" class="btn btn-danger" value="취소">
			<input type="button" class="btn btn-success" value="이전" onclick="history.back()">
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