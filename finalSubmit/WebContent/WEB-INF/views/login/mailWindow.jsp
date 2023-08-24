<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ConV</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
body{
    background: lightgray;
    text-align: center;
}
input{
    margin-top: 60px;
    height: 25px;
    border-radius: 10px;
}
button{
	border-radius: 10px;
}
</style>
</head>
<body>
인증번호 <input type="text" id="authKey" name="authKey" value="">
<button type="button" id="authKeyCompare">인증키 확인</button>

<script type="text/javascript">
$(document).ready(function(){
	$("#authKeyCompare").on("click", function(){
		
		let mailAdd = opener.document.getElementById("mail").value;
		let authKey = $("input[name='authKey']").val();
		console.log("mailAdd:",mailAdd)
		
		$.ajax({
			  url:"<c:url value='/regist/authKeyCompare'/>"
			, data : {"mailAdd" : mailAdd, "authKey": authKey}
			 , success : function(data){
				 if(data){
					 alert("인증성공");
					 window.close();
				 }else{
					 alert("두눈 똑바로 뜨고 다시 한번");
				 }
			 } 
			,error : function(e){
				alert("메일인증 도중 error",e);
			}
			
		});
	});
});

</script>
</body>
</html>