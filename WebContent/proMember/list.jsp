<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/css/bootstrap.min.css">

<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/js/bootstrap.min.js"></script>
   <style>
#navBar{
      margin-top: 86px;
   }
</style>
</head>
<body>
<!-- 게시판 네비 시작 -->
<ul class="nav nav-tabs" id="navBar">
   <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle text-dark" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">일정</a>
      <div class="dropdown-menu">
         <a class="dropdown-item" href="${pageContext.request.contextPath}/viewTask.pt" aria-selected="true">일정 게시판</a>
         <a class="dropdown-item" href="${pageContext.request.contextPath}/task/viewCalendar.jsp">일정 캘린더</a>
      </div>
   </li>
   <li class="nav-item">
      <a class="nav-link text-dark" href="${pageContext.request.contextPath}/list.file">파일</a>
   </li>
   <li class="nav-item">
      <a class="nav-link text-dark" href="${pageContext.request.contextPath}/list.pm">멤버</a>
   </li>
</ul>
<!-- 게시판 네비 끝 -->
<c:choose><c:when test="${pm_checklogin == 'H'}">
   <table class="table">
      <thead>
         <tr>
             <th scope="col">rank</th>
            <th scope="col">name</th>
            <th scope="col">nickname</th>
            <th scope="col">Email</th>         
            <th scope="col">delete</th>               
         </tr>
      </thead>            
         <button class="btn" id="insertBtn" hidden>생성</button>         
         <button class="btn" id="updateBtn" hidden>추가</button>            
      <tbody>
      <c:forEach items="${pmList}" var="dto">
         <tr>      
             <c:if test="${dto.pm_check == 'H'}">
               <td>manager</td>
            </c:if>   
            <c:if test="${dto.pm_check == 'M'}">
               <td>staff</td>
            </c:if>   
            <td class="updateName">${dto.pm_img}${dto.pm_name}</td>
            <td>${dto.pm_nickname}</td>
            <td>${dto.pm_email}</td>
              <c:if test="${dto.pm_check == 'M'}">
            <td><button class="deleteBtn" id="${dto.pm_nickname}">삭제</button></td>
            </c:if>
         </tr>
         </c:forEach>
      </tbody>
      
   </table>
   </c:when>
   <c:otherwise>
   <table class="table">
      <thead>
         <tr>
             <th scope="col">rank</th>
            <th scope="col">name</th>
            <th scope="col">nickname</th>
            <th scope="col">Email</th>
            <th scope="col">delete</th>         
         </tr>
      </thead>
      <tbody>
      <c:forEach items="${pmList}" var="dto">
         <tr>
            <c:if test="${dto.pm_check == 'H'}">
               <td>manager</td>
            </c:if>   
            <c:if test="${dto.pm_check == 'M'}">
               <td>staff</td>
            </c:if>   
            <td>${dto.pm_img}${dto.pm_name}</td>
            <td>${dto.pm_nickname}</td>
            <td>${dto.pm_email}</td>
             <c:if test="${loginInfo == dto.pm_nickname}">
            <td><button class="selfoutBtn" id="${dto.pm_nickname}">나가기</button></td>
            </c:if>
         </tr>
         </c:forEach>
      </tbody>      
   </table>
   </c:otherwise>
   </c:choose>
</body>
<script>


   $("#insertBtn").on("click", function() {
      if(confirm("멤버들을 생성하시겠습니까?") == true){
      location.href = "${pageContext.request.contextPath}/memberList.pm";
		  
	   if($(".updateName").length == 1){
	      $("#updateBtn").attr('hidden',true);
	      $("#insertBtn").attr('hidden',false);
	   }else if($(".updateName").length > 1){
	      $("#updateBtn").attr('hidden',false);
	      $("#insertBtn").attr('hidden',true);   
	   }
	   }else { 
	      location.reload(true);
	   }
   });
   console.log($(".updateName").length);
   $("#updateBtn").on("click", function() {
      if(confirm("멤버들을 추가하시겠습니까?") == true){
      location.href = "${pageContext.request.contextPath}/updateList.pm";
      }else {     
         location.reload(true);
      }
   });
   $(".deleteBtn").on("click", function() {
      if(comfirm("삭제하시겠습니까?") == true){
      $.ajax({
         url : "${pageContext.request.contextPath}/delete.pm",
         type : "post",
         data : {
            pm_nickname : $(this).attr("id")
         },
         dataType : "json"
      }).done(function(data) {
         if (data.result == 'success') {
            location.href = "${pageContext.request.contextPath}/list.pm";
         } else {
            alert("삭제에 실패하셨습니다.");
         }
      })
      }else { 
         location.reload(true);
      }
   });
   $(".selfoutBtn").on("click", function() {
      if(confirm("삭제하시겠습니까?") == true){
      $.ajax({
         url : "${pageContext.request.contextPath}/delete.pm",
         type : "post",
         data : {
            pm_nickname : $(this).attr("id")
         },
         dataType : "json"
      }).done(function(data) {
         if (data.result == 'success') {
            location.href = "https://www.naver.com/";
         } else {
            alert("삭제에 실패하셨습니다.");
         }
      })
      }else {
         location.reload(true);
      }
   });
   
</script>
</html>