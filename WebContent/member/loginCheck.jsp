<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${loginInfo != null}">
			<script>
				alert( "${loginInfo}" + " 님  환영합니다"); 
				location.href="../main.jsp"; // 메인페이지 가즈아아아
			</script>
		</c:when>
		<c:otherwise>
		      <c:choose>
			      <c:when test="${ManagerInfo != null}">
				      	<script>
				        location.href="${pageContext.request.contextPath}/memberList.admin";
				      	</script>
			        </c:when>
			      <c:otherwise>
				      <script>
						alert( "로그인이 실패했습니다. 이메일과 비밀번호를 확인해주세요"); 
						location.href="../index.jsp";
					</script>
			      </c:otherwise>
		    </c:choose>

		</c:otherwise>
	</c:choose>

</body>
</html>