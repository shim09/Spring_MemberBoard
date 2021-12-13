<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    body {
        background-color: rgb(80, 188, 223);
    }
</style>
<script defer>
	function logout(){
		location.href="logout"
	}
</script>
</head>
<body>
	<h2>메인 페이지 </h2>
	 <h4>${sessionScope.loginId} 회원님 반갑습니다.</h4><br>
	
 <!--   1. 관리자용 페이지가 따로 있음. 
          2. 관리자페이지에서 회원 목록 페이지로 이동할 수 있음. 
          3. 회원목록 페이지에서 회원 삭제 가능함.  -->
 <!--  SHC = 관리자 ID, 관리자 아이디로 로그인 시 회원목록 조회가능 -->
       <c:if test="${sessionScope.loginId eq 'SHC'}">
       <a class="btn btn-success" href="/member/findAll">회원목록[관리자]</a>
       </c:if>
       	<a class="btn btn-danger" href="/member/insertForm">회원가입 하기</a>
	<a class="btn btn-success" href="/member/login">로그인 하러가기</a>
	<a class="btn btn-dark" href="/board/save">글작성</a>
	<a class="btn btn-dark" href="/board/findAll">게시판</a>
   	
</body>
</html>