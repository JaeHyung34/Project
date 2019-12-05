<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>제목을 입력하세요</title>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
</head>

<body id="page-top">


			<!-- 메인 콘텐츠 시작 부분 -->
        <div class="container mt-5 border">
          <div class="row mt-4 ml-2 d-none d-md-block">
            <h3>쪽지 보기</h3>
          </div>
          <div class="row mt-3">
            <div class="col-3 col-md-1 border-right">보낸이 : </div>
            <div class="col">${dto.message_sender}</div>
          </div>
          <div class="row mt-1">
            <div class="col-3 col-md-1 border-right">날짜 : </div>
            <div class="col">${dto.message_time}</div>
          </div>
          <div class="row mt-4">
            <div class="d-none d-md-block col-md-1 border-right border-bottom">내용 : </div>
            <div class="col border-bottom"><c:out value="${dto.message_contents}"></c:out></div>
          </div>
          <div class="row my-5 w-100 d-flex justify-content-center">
            <button id="back" type="button" class="button mx-3">뒤로가기</button>
            <button id="reply" type="button" class="button mx-3">답장</button>
            <button id="delete" type="button" class="button mx-3">삭제</button>
          </div>
        </div>
        </form>
			<!-- 메인 콘텐츠 끝 -->

	<script>
	$("#reply").on("click", function() {
		location.href="${pageContext.request.contextPath}/reply.msg?seq=${dto.message_seq}&entry=${entry}";
	})
	$("#delete").on("click", function() {
		location.href="${pageContext.request.contextPath}/checkedDelete.msg?seq=${dto.message_seq}&entry=${entry}";
	})
	$("#back").on("click", function() {
		location.href="${pageContext.request.contextPath}/view.msg?entry=${entry}";
	})
  </script>
</body>
</html>

