<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
	<h2>아이디 입력하기</h2>
	<label for="id">아이디</label>
	<input type="text" id="id" name="id" required>
	<input type="button" id="idSubmit" value="인증하기" />

	<br>

	<form action="resetPassword" method="post">
		<label for="code">인증번호:</label> <input type="text" id="code" required>
		<button type="submit">인증하기</button>

		<br> <label for="newPassword">새로운 비밀번호:</label> <input
			type="password" id="newPassword" name="newPassword" required>
		<button type="submit">저장하기</button>
		<br>

	</form>

	<script type="text/javascript">
$("#idSubmit").on("click", function(){
	let id = $("#id").val();
	console.log ("id",id) 
 // 1. 사용자가 id를 입력하게 함
 // 2. 입력한 아이디를 기반으로 데이터를 가져와서 
 // 3. 데이터가(유저) 있으면 해당 유저의 전화번호에 인증키 문자를 보냄
 // 4. 유저가 입력한 인증키와 전송한 인증키가 맞으면 비밀번호 새로 설정하게 함
 // 5. 입력한 비밀번호를 디비에 저장
	// $("#id") == id = "id"
	// $(".id") ==  class= "id"

$.ajax({
	  url:"<c:url value='/Message'/>"
	, type: "get"
	, data: {"id" : id}
	, success:function(id){
		console.log("id :");
		let popupWidth = 600;
		let popupHeight = 150;
		let winWidth = document.body.offsetWidth;
		let winHeight = document.body.offsetHeight;
		let popupX = (winWidth/2) - (popupWidth/2);
		let popupY = (winHeight/2) - (popupHeight/2);
		
		if(data) {
			 
		}
	}
	, error: function(){
		alert("error");
	}
});

	
});

</script>
</body>
</html>