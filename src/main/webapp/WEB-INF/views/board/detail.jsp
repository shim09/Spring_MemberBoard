<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/test.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
    body {
        background-color: rgb(43, 43, 43);
    }
</style>
</head>
<body>
    <div class="container text-center" style="background-color: rgb(238, 238, 238); border-radius: 1rem;">
        <h2>상세페이지</h2>
        <table class="table table-hover text-center">
            <tr>
                <th>번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>내용</th>
                <th>조회수</th>
                <th>작성시간</th>
                <th>수정</th>
                <th>삭제</th>
                <th>파일</th>
            </tr>
                <tr>
                    <td>${board.b_number}</td>
                    <td>${board.b_writer}</td>
                    <td>${board.b_title}</td>
                    <td>${board.b_contents}</td>
                    <td>${board.b_hits}</td>
                    <td>${board.b_date}</td>
                    <td><a class="btn btn-success" href="update?b_number=${board.b_number}&page=${page}">수정</a></td>
                    <td><a class="btn btn-danger" href="delete?b_number=${board.b_number}">삭제</a></td>
                    <td><img alt="" src="/resources/upload/${board.b_filename}">
                    ${board.b_filename}</td>
                </tr>
        </table>
            <a class="btn btn-danger mb-3" href="/board/paging?page=${page}">글목록</a>
        <!-- 댓글 작성 -->
        <div id="comment-write">
        	<input type="text" id="c_writer" value=${sessionScope.loginId}  class="form-control" >
        	<input type="text" id="c_contents" placeholder="댓글내용" class="form-control" >
        	<button id="comment-write-btn" class="btn btn-success mb-3">댓글등록</button>
        </div>
        
        <!-- 댓글목록출력 -->
        <div id="comment-list">
        	<table class="table">
        	<tr>
        		<th>댓글번호</th>
				<th>작성자</th>
				<th>내용</th>
				<th>작성시간</th>
			</tr>
				<c:forEach items="${commentList}" var="comment">
				<tr>
					<td>${comment.c_number}</td>
					<td>${comment.c_writer}</td>
					<td>${comment.c_contents}</td>
					<td>${comment.c_date}</td>
				</tr>
				</c:forEach>
        	</table>
        </div> 
        </div>
       
</body>
<script>

	
	$("#comment-write-btn").click(function(){
		console.log("댓글등록버튼 클릭");
//	 const commentWriter = document.getElementById('c_witer').value;
//	 const commentContents = document.getElementById('c_contents').value;
	
		const commentWriter = $("#c_writer").val();
		const commentContents = $("#c_contents").val();
		const boardNumber = '${board.b_number}';
		console.log(commentWriter,commentContents,boardNumber);
	 $.ajax({
     	type: 'post', // 전송방식
     	url: '/comment/save', // 요청주소
     	data: {"c_writer": commentWriter , 'c_contents' : commentContents ,
     		'b_number' : boardNumber}, // 전송할 데이터
     	dataType:'json',
     	success: function(result){
     		console.log(result);
     		let output = "<table class='table'>";
			output += "<tr><th>댓글번호</th>";
			output += "<th>작성자</th>";
			output += "<th>내용</th>";
			output += "<th>작성시간</th></tr>";
			for(let i in result){
				output += "<tr>";
				output += "<td>"+result[i].c_number+"</td>";
				output += "<td>"+result[i].c_writer+"</td>";
				output += "<td>"+result[i].c_contents+"</td>";
				output += "<td>"+result[i].c_date+"</td>";
				output += "</tr>";
			}
			output += "</table>";
			// id가 comment-list인 div에 출력
			document.getElementById('comment-list').innerHTML = output;
			// 댓글 입력창을 비움. 
			document.getElementById('c_writer').value='';
			document.getElementById('c_contents').value='';
     	},
     	error: function(){
     		console.log("오류");
     	}
     	
     	
     	
     	// 요청 후 리턴받을 때의 데이터 형식
	 })
	});
	
	
</script>
</html>
