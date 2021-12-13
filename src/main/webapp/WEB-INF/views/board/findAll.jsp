<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    body {
        background-color: rgb(43, 43, 43);
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
    <div class="container text-center mt-5" style="background-color: rgb(248, 248, 248); border-radius: 1rem;">
        <h2>게시판</h2>
        
        <form action="/board/search" method="get" class="d-flex">
            <select class="form-select" name="searchtype" style="width: 30%">
                <option value="b_title">제목</option>
                <option value="b_writer">작성자</option>
            </select>
            <input class="form-control" type="text" name="keyword" placeholder="검색어 입력">
            <input class="btn btn-success" type="submit" value="검색">
        </form>
        
        <table class="table table-hover text-center">
            <tr>
                <th>글번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>조회수</th>
                <th>작성시간</th>
                <!-- <th>상세조회</th> -->
                <!-- <th>수정</th> -->
                <!-- <th>삭제</th> -->
                <!-- <th>수정(비밀번호)</th> -->
            </tr>
            <c:forEach items="${bList}" var="b">
                <tr>
                    <td>${b.b_number}</td>
                    <td>${b.b_writer}</td>
                    <td><a class="text-dark" style="text-decoration-line: none;" href="/board/detail?b_number=${b.b_number}&page=${paging.page}">${b.b_title}</a></td>
                    <!-- <td>${b.b_title}</td> -->
                    <td>${b.b_hits}</td>
                    <td>${b.b_date}</td>
                    <!-- <td><a class="btn btn-outline-warning text-dark" href="update?b_number=${b.b_number}">수정</a></td> -->
                    <!-- <td><a class="btn btn-outline-danger" href="delete?b_number=${b.b_number}">삭제</a></td> -->
                    <!-- <td><button class="btn btn-outline-warning text-dark" onclick="updateAjax()">수정(비밀번호)</button></td> -->
                    <!-- <td><button class="btn btn-outline-warning text-dark" onclick="detailAjax('${m.m_number}')">조회(ajax)</button></td> -->
                    <!-- <td>
                    	<form action="update" method="post">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="비밀번호 입력" name="b_password">
                                <a class="btn btn-outline-warning" type="submit" href="update">수정(비밀번호)</a>
                            </div>
                        </form>
                    </td> -->
                </tr>
            </c:forEach>
        </table>
            <a href="/" class="btn btn-outline-danger">홈으로 돌아가기</a>
            <a class="btn btn-outline-dark" href="/board/save">글작성</a>
            <a class="btn btn-outline-dark" href="/member/mypage?m_number=${sessionScope.loginNumber}">마이페이지</a>
        	<div>
		<c:choose>
			<c:when test="${paging.page<=1}">
				[이전]&nbsp;
			</c:when>
			<c:otherwise>
				<a href="/board/paging?page=${paging.page-1}">[이전]</a>&nbsp;
			</c:otherwise>
		</c:choose>
		
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
			<c:choose>
				<c:when test="${i eq paging.page}">
					${i}
				</c:when>
				<c:otherwise>
					<a href="/board/paging?page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:choose>
			<c:when test="${paging.page>=paging.maxPage}">
				[다음]
			</c:when>
			<c:otherwise>
				<a href="/board/paging?page=${paging.page+1}">[다음]</a>
			</c:otherwise>
		</c:choose>
	</div>
	
	</div>
        
        
</body>
</html>
