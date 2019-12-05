<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update List</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/css/bootstrap.min.css">

<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/dataTables.semanticui.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js" type="text/css"/>

<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
<link rel="stylesheet"
   href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css">

<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript" ></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" type="text/javascript" ></script>
</head>
<style>
   body{
      height: 100%;
      overflow: hidden;
   }
   #navBar{
      margin-top: 86px;
   }
</style>
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
   <button class="btn" id="updateBtn" style="float:right;">추가</button>
   
      <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0"
      width="100%">
      <thead>
         <tr>
            <th scope="col"><input type=checkbox id="allChk" 
            onclick="allChk(this)"></th>
            <th class="th-sm">name</th>
            <th class="th-sm">nickname</th>
         </tr>
      </thead>
      <tbody>

         <c:forEach items="${upList}" var="dto">
            <tr>
               <td><input type=checkbox name="RowCheck" value="${dto.mb_nickname}"></td>
               <td>${dto.mb_img}${dto.mb_name}</td>
               <td class=nicknameClass>${dto.mb_nickname}</td>
            </tr>
         </c:forEach>

      </tbody>
   </table>
</body>
<script>
// $("#searchText").on("input",function(){
//    var searchText = $("#searchText").val();
//    //var nickname = $(".${dto.mb_nickname}").html();
//    var nickname = $(".nicknameClass").attr("")
//    $.ajax({
//          type : 'POST',
//          url : 'search.pm',
//          dataType : 'json',
//          data : {
//             searchText : searchText
//          },
//    }).done(function(resp){
//       for(var i = 0; i<resp.length; i++){
//          resp.mb_nickname == nickname;
//          console.log(1);
//       }
//    })
// });

//   $("#searchText").on("keyup", function() {
//     var value = $(this).val().toLowerCase();
//     $(".table").filter(function() {
//       $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
//     });
//   });

   $('#dtBasicExample').DataTable({
      "info" : false,
       "responsive": {
            details: false
        }
   });
   $('.dataTables_length').addClass('bs-select');


   function allChk(obj) {
      var chkObj = document.getElementsByName("RowCheck");
      var rowCnt = chkObj.length - 1;
      var check = obj.checked;
      if (check) {
         for (var i = 0; i <= rowCnt; i++) {
            if (chkObj[i].type == "checkbox")
               chkObj[i].checked = true;
         }
      } else {
         for (var i = 0; i <= rowCnt; i++) {
            if (chkObj[i].type == "checkbox") {
               chkObj[i].checked = false;
            }
         }
      }
   }
   $("#updateBtn").on("click", function() {
      var checkArray = [];

      $("input[name=RowCheck]:checked").each(function(i) { //jQuery로 for문 돌면서 check 된값 배열에 담는다
                     checkArray.push($(this).val());
                  });

                  if (checkArray.length == 0) {
                     alert("추가할 멤버를 선택하세요.")
                  } else {
                     if (confirm("추가하시겠습니까?") == true) { //확인
                        console.log(checkArray);
                        console.log(1);
                        $.ajax({
                                 type : 'POST',
                                 url : 'update.pm',
                                 dataType : 'json',
                                 data : {
                                    checkArray : JSON.stringify(checkArray)
                                 },
                                 success : function pageReload(resp) {
                                    console.log("됐어?");
                                    console.log(resp);
                                    var s = 1;
                                    for (var i = 0; i < resp.length; i++) {
                                       //console.log(resp)
                                       //console.log(resp.count[i])
                                       if (resp.count[i] == 'success') {
                                          s = s * 1;
                                       } else if (resp.count[i] == 'fail') {
                                          s = s * 0
                                       }
                                    }
                                    if (s == 1) {
                                       location.href = "${pageContext.request.contextPath}/list.pm"
                                    } else {
                                       alert("멤버추가에 실패하셨습니다.")
                                    }
                                 }
                              });
                        //location.href ="${pageContext.request.contextPath}/insert.pm"
                        checkArray = new Array();
                        //nmeCardSeq=0;
                     } else { //취소    
                        console.log("안돼");
                        location.reload(true);
                     }
                  }

               });
</script>
</html>