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

<title>메세지 보내기</title>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
<style>
#receiver {
	width: 100%;
}

#msgBox {
	height: 50vh;
}
</style>
</head>

<body id="page-top">


			<!-- 메인 콘텐츠 시작 부분 -->

			<form id="frm" action="${pageContext.request.contextPath}/send.msg?entry=${entry}"
				method="post">
				<div class="container mt-5 rounded">
					<h3>답장하기</h3>
					<div class="row mt-2 border mx-3 mx-md-0">
						<div class="d-none d-md-block col-md-3 text-right">받으시는 분 :</div>
						<div class="col-10 border col-sm-10 col-md-5 px-0">
							<input id="receiver" type="text" value="${dto.message_sender}" name="sendList" readonly>
						</div>
						<div class="col-4 col-sm-2 col-md-3">
							<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#find">추가</button>
						</div>
					</div>
					<div class="row">
					<!-- 메시지 보낼 대상자 리스트 -->
						<p>메시지를 보낼 대상 : </p><br>
						<div id="sendList" class="ml-5"></div>
					</div>
					<!-- 메시지 보낼 대상자 리스트 끝 -->
					<div class="row mt-4 mx-3 mx-md-0">
						<div id="msgBox" class="col px-0">
							<div id="inputMsg" name="content" class="border px-0 h-100"
								contenteditable="true"></div>
							<textarea class="d-none" id="tArea" name="tArea"></textarea>
						</div>
						<div class="w-100"></div>
						<div class="row w-100 mt-4">
							<div class="col-12 text-center">
								<button id="send">전송</button>
								<button id="cancel" class="ml-5" type="button">취소</button>
							</div>
						</div>
					</div>
			</form>

<!-- 보낼 사람 탐색 및 등록 -->
<div class="modal fade" id="find" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">보낼 대상 찾기</h5>
        <button type="button" class="close" data-dismiss="modal">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group row">
            <input type="text" class="col-8" id="findID" placeholder="받으실 분">
            <button id="searchID" type="button" class="col-3">추가</button>
          </div>
          <div class="form-group">
          <p>쪽지 보낼 대상 목록</p>
          	<div id="foundedID"></div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <input id="findCompleted" type="button" class="btn" value="완료">
        <button id="cancelFind" type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 보낼 사람 탐색 및 등록 끝 -->

			<!-- 메인 콘텐츠 끝 -->

	<script src="${pageContext.request.contextPath}/message/reply.js">
  </script>
  <script>
    $("#send").on("click", function() {
      $("#tArea").val($("#inputMsg").html());
      if ($("#tArea").val() == "") {
    	  alert("내용을 입력하세요");
    	  return false;
      }
      $("#frm").submit();  
    }) 
	$("#sendList").on("click", '.fa-minus', function() {
		$(this).parent().remove();
	})
    $("#foundedID").on("click", '.fa-minus', function() {
    	$(this).parent().remove();
    })
	$("#findCompleted").on("click", function(e) {
		if ($(".foundedIDs").length == 0) {
			alert("추가할 대상을 입력해주세요");
			return;
		}
		$(".foundedIDs").each(function() {
			let add = true;
			let input = '<div class="row"><i class="fas fa-minus mr-2 mt-1"></i><span class="sendList">' + $(this).html() + '</span>';
			let input2 = '<input type="hidden" name="sendList" value="' + $(this).text() + '"></div>';
			let id = $(this).text();
			$(".sendList").each(function() {
				if ($(this).text() == id) {
					alert($(this).text() + "는 이미 추가된 대상입니다");
					add = false;
				}
			})
			if (add) $("#sendList").append(input + input2);
		});	
		$("#find").modal("hide");
		$("#findID").val('');
		$(".foundedIDs").html('');
		$("#foundedID").children().remove();
	})
	// 모달에서 보낼 대상자 검색
	$("#searchID").on("click", function() {
		searchID();
	});
	$("#findID").on("keydown", function(e) {
		if (e.keyCode == 13) {
			if ($("#findID").val() == '') {
				e.preventDefault();
				alert("대상을 입력해주세요");
				return;
			}
			searchID(e);
			$("#findID").val('');
			e.preventDefault();
		}
	})
   function searchID(e) {
		if ($("#findID").val() == '') {
			alert("대상을 입력해주세요");
			return;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/findID.msg",
			type: "post",
			dataType: "text",
			data: {
				id: $("#findID").val()		
			}	
		}).done(function(resp) {
			let add = true;
			if (resp == 'null') {
				alert("찾는 대상이 존재하지 않습니다");
			} else {
				$(".foundedIDs").each(function() {
					if ($(this).text() == resp) {
						alert("이미 추가한 대상입니다");
						$("#findID").val('');
						add = false;
						return;
					}
				});
			if (add) 
				var input = '<div class="minusID"><i class="fas fa-minus mr-2 mt-1"></i><span class="foundedIDs">' + resp + '</span></div>';
				$("#foundedID").append(input);
				$("#findID").val('');
			} 
		}).fail(function(resp) {
			alert("오류발생으로 탐색에 실패했습니다 다시 시도해주세요");
			console.log(resp);
		}); 
    } 
    $("#cancel").on("click", function() {
    	history.back();
    })
    $("#cancelFind").on("click", function() {
		$("#find").modal("hide");
		$("#findID").val('');
		$(".foundedIDs").html('');
    })
  </script>
</body>
</html>

