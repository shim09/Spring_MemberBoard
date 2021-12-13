<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<style>
	input {
	display: block
	}
	</style>
	
	<script>
	function idDuplicate(){
		const id = document.getElementById("m_id").value;
		const check = document.getElementById("idcheck");()
		
		$.ajax({
			type:'post',
			url: "idDuplicate",
			data: {'m_id':id},
			datatype: 'text',
			success: function(result){
				if(result=="ok"){
					check.style.color='green';
					check.innerHTML='GOOD';
				}else{
					check.style.color='red';
					check.innerHTML='이미 있는 아이디 입니다.';
				}
			},
			erroe: function(){
				console.log("안돼~~~");
				
			}
		
		
		})
		
		
		
	}
	</script>
</head>
<body>
 <h2 class="text-center" >회원가입</h2>
        <form action="/member/insert" method="post" enctype="multipart/form-data">
            <input class="form-control mb-3" type="text" name="m_id" placeholder="ID">

            <input class="form-control mb-3" type="password" name="m_password" placeholder="password">

            <input class="form-control mb-3" type="text" name="m_name" placeholder="이름">

            <input class="form-control mb-3" type="text" name="m_email" placeholder="이메일">
            
            <input class="form-control mb-3" type="text" name="m_phone" placeholder="휴대폰번호"><br>

			<input class="form-control mb-3" type="file" name="m_file" placeholder="파일"><br>
			
            <input class="btn btn-outline-success mb-3" style="width: 100%;" type="submit" value="가입하기">
        </form>
            <a class="btn btn-outline-danger mb-3" style="width: 100%;" href="/">취소</a>
            
</body>
</html>