<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script>
	function logout() {
		location.href = "logout";
	}
</script>
<style>
    body {
        background-color: rgb(43, 43, 43);
    }
</style>

<style>
</style>
</head>
<body>

 <div class="container text-center" style="background-color: rgb(255, 255, 255); border-radius: 1rem;">
<h2>${sessionScope.loginId} 님의 마이페이지.</h2>
<div class="mb-3">
<button class="btn btn-outline-danger" onclick="logout()">로그아웃</button>
<a class="btn btn-outline-success" href="/">메인 페이지</a>
<a class="btn btn-outline-dark" href="/member/detail?m_number=${mypage.m_number}">회원상세조회</a>
</div>
<div>
<table class="table table-dark table-striped text-center mb-3">
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>프로필사진</th>
			<th>수정</th>
			<c:if test="${sessionScope.loginId eq 'SHC'}">
			<th>회원전체목록</th>
			</c:if>
		</tr>
		<tr>

			<td>${m.m_number}</td>
			<td>${m.m_id}</td>
			<td>${m.m_name}</td>
			<td>${m.m_email}</td>
			<td><img alt="null" src="/resources/upload/${m.m_filename}"></td>
			<td><a class="btn btn-outline-light" href="/member/update?m_number=${m.m_number}">수정</a></td>
			<c:if test="${sessionScope.loginId eq 'SHC'}">
			<td><a class="btn btn-success" href="/member/findAll">회원목록</a></td>
			</c:if>

		</tr>
		
		</table>
		</div>
</div>

</body>
</html>