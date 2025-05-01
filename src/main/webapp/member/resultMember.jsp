<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <!-- Vendor CSS Files -->
  <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="../assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="../assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="../assets/css/main.css?v=1.0" rel="stylesheet">
  
  <style>
	#form_layout {
		/* border:1px solid red; */
		margin: 200px 100px;
	}
	.form-group{
		margin-top:20px;
		margin-bottom:20px;
	}
</style>
</head>
<body>
	 <!-- header include-->
  <%@ include file="/step06/navi.jsp" %>
  
  <div id="form_layout">
    <h1>회원정보</h1>
    
      <div class="container">
  	<%
	String msg = request.getParameter("msg");
  	if(msg != null) {
  		if(msg.equals("1")) {
  			out.print("<h2 class='alert alert-primary text-center'>회원가입을 축하드립니다! 다시 로그인해주세요</h2>");
  		} else if(msg.equals("2")) {
  			String loginId = (String)session.getAttribute("sessionId");
  			out.print("<h2 class='alert alert-primary text-center'>"+loginId+"님 환영합니다!</h2>");
  		} else if(msg.equals("0")) {
  			String loginId = (String)session.getAttribute("sessionId");
  			out.print("<h2 class='alert alert-primary text-center'>"+loginId+"님 회원정보가 수정이되었습니다!</h2>");
  		}
  	} else {
  		out.print("<h2>회원정보가 존재하지 않습니다.</h2>");
  	}
  	%>
  </div>
  </div>


  
  
  
  
  
	
  <!-- footer include -->
  <%@ include file="/step06/footer.jsp" %>
</body>
</html>