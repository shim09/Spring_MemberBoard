<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    label {
        display: block;
    }
    body {
        background-color: rgb(43, 43, 43);
    }
</style>
</head>
<body>
    <div class="container mt-5" style="background-color: rgb(248, 248, 248); border-radius: 1rem; border: 1px solid black;">
	<h2>*글작성 페이지*</h2>
	<form action="/board/save" method="post" enctype="multipart/form-data">
	<!--  제목, 내용, 첨부파일을 입력할 수 있음. 당연히 글번호도....
	작성자 칸은 따로없음 -> 작성자 이름은 로그인시 아이디가 자동 입력됨, -->
				<input class="form-control mb-3" type="text" name="b_writer" value=${sessionScope.loginId} readonly>
	
	<!-- 제목 입력 -->
	            <input class="form-control mb-3" type="text" name="b_title" placeholder="제목">
	<!-- 내용 입력 -->
            <textarea class="form-control mb-3" type="text" name="b_contents" placeholder="내용"></textarea>
    <!-- 파일 첨부 -->
            <input class="form-control mb-3" type="file" name="b_file" placeholder="파일"><br>

            <input class="btn btn-outline-success mb-3" style="width: 100%;" type="submit" value="글작성">
	</form>
	            <a class="btn btn-outline-danger mb-3" style="width: 100%;" href="/">취소</a>
	</div>
</body>
</html>