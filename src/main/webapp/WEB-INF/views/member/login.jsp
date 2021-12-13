<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		input{
	display:block;
	}
</style>
</head>
<body>
	<h2>로그인 화면</h2>
	<form action = "/member/login" method="post">
		ID : <input type ="text" name ="m_id" placeholder="아이디를 입력하세요">
		PW : <input type ="password" name="m_password" placeholder="비밀번호를 입력하세요">
		<input type ="submit" value="Login">
	</form>
</body>
</html>