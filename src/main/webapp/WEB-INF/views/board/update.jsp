<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	input {
		display: block
	}
	
	body {
		background-color: rgb(43, 43, 43);
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
    <div class="container mt-5" style="border: 1px solid black; border-radius: 1rem; background-color: rgb(248, 248, 248);">
        <h2 class="text-center">수정 페이지</h2>
        <div>
            <form action="update" method="post" name="update_form">
           		<input type="hidden" name="page" value="${page}">
                <input type="hidden" name="b_number" value="${board.b_number}">
            	<label for="">작성자</label>
                <input class="form-control mb-3" type="text" name="b_writer" value="${board.b_writer}" readonly>
                <label for="">제목</label>
                <input class="form-control mb-3" type="text" name="b_title" value="${board.b_title}">
                <label for="">내용</label>
                <textarea class="form-control mb-3" name="b_contents">${board.b_contents}</textarea>
                <input type="submit" class="btn btn-outline-success mb-3" style="width: 100%;" value="수정" >
            </form>
            	<a class="btn btn-outline-danger mb-3" style="width: 100%;" href="/board/paging?page=${page}">취소</a>
        </div>
    </div>
</body>
</html>