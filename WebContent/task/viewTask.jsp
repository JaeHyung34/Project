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

<title>일정 게시판</title>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
    <script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/dataTables.semanticui.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" type="text/css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js" type="text/css"/>

<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
<link rel="stylesheet"
   href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/themes/material_green.css">
<link
   href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css"
   rel="stylesheet">


<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript" ></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" type="text/javascript" ></script>   
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.js"></script>
<script
   src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
   

<!-- <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" type="text/css"/> -->
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/js/dataTables.semanticui.min.js" type="text/css"/> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" type="text/css"/> -->
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js" type="text/css"/> -->
<!-- <link rel="stylesheet" -->
<!--    href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css"> -->
<!-- <link rel="stylesheet" -->
<!--    href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css"> -->
<!-- <link rel="stylesheet" -->
<!--    href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.css"> -->
<!-- <link rel="stylesheet" -->
<!--    href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/themes/material_green.css"> -->
<!-- <link -->
<!--    href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" -->
<!--    rel="stylesheet"> -->

<!-- <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript" ></script> -->
<!-- <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" type="text/javascript" ></script> -->
<!-- <script -->
<!--    src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.js"></script> -->
<!-- <script -->
<!--    src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script> -->

<style type="text/css">
   body{
      height: 100%;
      overflow: hidden;
   }
   .container{
      margin-top: 30px;
   }
   #titleTask{
      cursor:pointer;
   }
   .btns{
      text-align: right;
      margin: 10px;
   }
   #navBar{
      margin-top: 86px;
   }
   #navBar li a:hover{
      color: red;
   }
   #addModal{
      width: 1170px;
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
   }
    div.container {
        width: 80%;
    }
    .filterPad{
      padding-top:15px;
   }
   #high, #mid, #low, #highView, #midView, #lowView{
      width: 52px;
      margin-left : 5px;
   }
</style>   
</head>

<body id="page-top">
      <!-- 메인 콘텐츠 시작 부분 -->
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
<!-- 일정 게시판 화면 시작-->
   <div class="container">
      <h2>일정 게시판</h2>
      <div class="btns">
         <button type="button" id="createTask" role="button"
            class="btn btn-info p opover-test align-right" data-toggle="modal" data-target="#addModal" data-backdrop="static" >일정추가</button>
      </div>
      <table class="table table-hover" id="tableTask" style="width:100%;">
         <thead class="thead-light">
            <tr>
               <th>번호</th>
               <th>시작일자</th>
               <th>마감일자</th>
               <th>제목</th>
               <th>우선순위</th>
               <th>담당자</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${TaskDTO}" var="dto">
               <tr>
                  <td></td>
                  <td>${dto.pt_startDate}</td>
                  <td>${dto.pt_endDate}</td>
                  <td class="pt_title" id="titleTask" data-toggle="modal" data-dismiss="modal"
                     data-target="#viewModal" data-backdrop="static"
                     data-value="${dto.pt_seq}">${dto.pt_title}</td>
                  <c:choose>
                     <c:when test="${dto.pt_priority=='H'}">
                        <td>높음</td>
                     </c:when>
                     <c:when test="${dto.pt_priority=='M'}">
                        <td>중간</td>
                     </c:when>
                     <c:when test="${dto.pt_priority=='L'}">
                        <td>낮음</td>
                     </c:when>
                  </c:choose>
                  <td>${dto.pt_writer}</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
   </div>
<!-- 일정 게시판 화면 끝-->
<!--    일정 추가 modal -->
   <div class="modal fade" id="addModal" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">일정 추가</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <form action="${pageContext.request.contextPath}/createTask.pt"
                  method="post" id="frmAdd">
                  <div class="form-group">
                     <label for="title" id="titleLbl" class="col-form-label">일정명:</label>
                     <input type="text" class="form-control" id="title"
                        name="title">
                     <p id="titleInput" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="startDate" id="contentsLbl" class="col-form-label">시작일자:</label>
                     <input type="text" id="startDate" name="startDate"
                        placeholder="시작일자" data-input readonly>
                     <p id="startDateInput" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="endDate" id="startLbl" class="col-form-label">마감일자:</label>
                     <input type="text" id="endDate" name="endDate" placeholder="마감일자"
                        data-input readonly>
                     <p id="endDateInput" hidden></p>
                  </div>
                  <div class="form-group" id="priorityDiv">
                     <label for="priority" id="endLbl" class="col-form-label">중요도:</label>
                     <button type="button" class="btn btn-secondary btn-sm"
                        name="high" id="high">상</button>
                     <button type="button" class="btn btn-secondary btn-sm" name="mid"
                        id="mid">중</button>
                     <button type="button" class="btn btn-secondary btn-sm" name="low"
                        id="low">하</button>
                     <input type="text" id="priority" name="priority" hidden>
                     <p id="priorityInput" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="contents" id="titleLbl" class="col-form-label">일정
                        내용:</label>
                     <div id="contents">
                        <textarea id="summernote" name="summernote"></textarea>
                        <p id="contentsInput" hidden></p>
                     </div>
                  </div>
               </form>
            </div>
            <div class="modal-footer">
               <button type="button" id="cancel" class="btn btn-secondary"
                  data-dismiss="modal">취소</button>
               <button type="button" id="create" class="btn btn-primary">생성</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 일정 추가 modal 끝 -->
   <!-- 일정 조회, 수정 modal -->
   <div class="modal fade" id="viewModal" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">일정 보기</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <form action="${pageContext.request.contextPath}/modifyTask.pt"
                  method="post" id="frmModify">
                  <div class="form-group">
                     <label for="titleView" id="titleLbl" class="col-form-label">일정명:</label>
                     <input type="text" class="form-control" id="titleView"
                        name="titleView" readonly>
                     <p id="titleInputView" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="startDateView" id="contentsLbl"
                        class="col-form-label">시작일자:</label> <input type="text"
                        id="startDateView" name="startDateView" data-input readonly>
                     <p id="startDateInputView" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="endDateView" id="startLbl" class="col-form-label">마감일자:</label>
                     <input type="text" id="endDateView" name="endDateView"
                        data-input readonly>
                     <p id="endDateInputView" hidden></p>
                  </div>
                  <div class="form-group" id="priorityDiv">
                     <label for="priorityView" id="endLbl" class="col-form-label">중요도:</label>
                     <button type="button" class="btn btn-secondary btn-sm"
                        name="highView" id="highView" disabled=true>상</button>
                     <button type="button" class="btn btn-secondary btn-sm"
                        name="midView" id="midView" disabled=true>중</button>
                     <button type="button" class="btn btn-secondary btn-sm"
                        name="lowView" id="lowView" disabled=true>하</button>
                     <input type="text" id="priorityView" name="priorityView"
                        hidden>
                     <p id="priorityInputView" hidden></p>
                  </div>
                  <div class="form-group">
                     <label for="summernoteView" id="titleLbl" class="col-form-label">일정
                        내용:</label>
                     <div id="contents">
                        <textarea id="summernoteView" name="summernoteView"></textarea>
                        <p id="contentsInputView" hidden></p>
                        <input type=text id=hiddenSeq name=hiddenSeq hidden>
                     </div>
                  </div>
               </form>
            </div>
            <div class="modal-footer">
               <c:if test="${user == dtoView.pt_writer}">
                  <button type="button" id="deleteView" class="btn btn-danger" hidden>삭제</button>
                  <button type="button" id="modifyView" class="btn btn-primary" hidden>수정</button> 
               </c:if>
                  <button type="button" id="completeView" class="btn btn-primary" hidden>저장</button>
                  <button type="button" id="cancelView" class="btn btn-secondary"
                  data-dismiss="modal" hidden>닫기</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 일정 수정 modal 끝 -->
   <!-- 메인 콘텐츠 끝 -->

      </div>
   </div>
   
   <script>
   
   jQuery(function($){
      var t = $("#tableTask").DataTable({
//          "responsive": {
//               details: false
//           },
          "info" : false,
         "paging" : true, // 페이징 
         "filter" : true, // 검색 기능 부여
         "lengthChange" : true, //...
         "scrollX": false, //x축 스크롤 생성 x
         "scrollCollapse": true,
         "order": [[ 1, 'asc' ]], // 인덱스 부여
//          "autowidth": true,
//          dom : '<"toolbar"><"filterPad"f>lpit<"floatRight"B><"clear">'
      });
        t.on( 'order.dt search.dt', function () { // 일정 인덱스 부여
           t.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
               cell.innerHTML = i+1;
           });
         }).draw();
   });
   
// 일정 보기 modal 관련 script
   $(".pt_title").on("click", function(){
      
      var destination = "${pageContext.request.contextPath}/detailTask.pt";
      var pt_title = $(this).data('value');
      
      $("#hiddenSeq").val(pt_title); // 일정 seq 담아두기 
      
      $("#deleteView").attr('hidden', true);
      $("#modifyView").attr('hidden', true);
      $("#cancelView").attr('hidden', true);
      $("#completeView").attr('hidden', true); //버튼 초기 리셋
      $("#startDateView").attr("disabled", "disabled");
      $("#endDateView").attr("disabled", "disabled"); //데이트 피커 비활성화
      
      $.ajax({
         url: destination,
         data : {pt_seq : pt_title},
         type : "post", 
         dataType: "json"
      }).done(function(data){
         console.log(data.user);
         console.log(data.dtoView.pt_writer);
         if(data.user == data.dtoView.pt_writer){
            $("#deleteView").attr('hidden', false);
            $("#modifyView").attr('hidden', false);//사용자 작성자 일치 시에만 버튼 보이기
         }else{
            $("#cancelView").attr('hidden', false);//사용자 작성자 불일치 시 버튼 보이기
         }
         
         // datepicker 동작 
         $("#startDateView").flatpickr({
            enableTime : false,
            dateFormat : "Y-m-d"
         });
         $("#endDateView").flatpickr({
            enableTime : false,
            dateFormat : "Y-m-d"
         }); // datepicker 동작 끝
         
         $("#titleView").val(data.dtoView.pt_title);
         $("#titleView").attr("readonly", true); //타이틀 받고 읽기전용
         $("#startDateView").val(data.dtoView.pt_startDate);
//          $("#startDateView").attr("readonly", true); //시작일자 받고 읽기전용
         $("#endDateView").val(data.dtoView.pt_endDate);
//          $("#endDateView").attr("readonly", true); //마감일자 받고 읽기전용
         $('.note-editable').html(data.dtoView.pt_contents);
         $("#summernoteView").summernote('disable');
         $("#priorityView").val(data.dtoView.pt_priority);
         var priority = $("#priorityView").val(); //중요도 받고 변수 담기
         $("#highView").attr("disabled",true);
         $("#midView").attr("disabled",true);
         $("#lowView").attr("disabled",true); // 버튼 읽기전용
         
         if(priority == 'H'){
            $("#highView").attr('class', 'btn btn-danger btn-sm');
            $("#midView").attr('class', 'btn btn-secondary btn-sm');
            $("#lowView").attr('class', 'btn btn-secondary btn-sm');
         }else if(priority == 'M'){
            $("#highView").attr('class', 'btn btn-secondary btn-sm');
            $("#midView").attr('class', 'btn btn-success btn-sm');
            $("#lowView").attr('class', 'btn btn-secondary btn-sm');
         }else if(priority == 'L'){
            $("#highView").attr('class', 'btn btn-secondary btn-sm');
            $("#midView").attr('class', 'btn btn-secondary btn-sm');
            $("#lowView").attr('class', 'btn btn-warning btn-sm');
         } // 중요도에 따른 버튼 색상 주기 
                  
         // 수정 클릭 시 이벤트
         $("#modifyView").on("click", function(){
            
            $("#deleteView").attr('hidden', true);
            $("#modifyView").attr('hidden', true); //수정 클릭 시 기존 버튼 숨기기
            $("#completeView").attr('hidden', false);
            $("#cancelView").attr('hidden', false); //수정 클릭 시 버튼 보이기
            $("#startDateView").attr("disabled", false);
            $("#endDateView").attr("disabled", false); //수정 클릭 시 데이트피커 보이기
            
            // 수정 시 읽기전용 해제
            $("#titleView").attr("readonly", false);
//             $("#startDateView").attr("readonly",false);
//             $("#endDateView").attr("readonly",false);
            $('#summernoteView').summernote('enable');
            $("#highView").attr("disabled",false);
            $("#midView").attr("disabled",false);
            $("#lowView").attr("disabled",false);
            // 수정 시 읽기전용 해제 끝
            
            //버튼 클릭 시 이벤트 재할당
            $("#highView").on("click", function() {
               $("#highView").attr('class', 'btn btn-danger btn-sm');
               $("#midView").attr('class', 'btn btn-secondary btn-sm');
               $("#lowView").attr('class', 'btn btn-secondary btn-sm');
               $("#priorityView").val("H");
            });
            $("#midView").on("click", function() {
               $("#midView").attr('class', 'btn btn-success btn-sm');
               $("#lowView").attr('class', 'btn btn-secondary btn-sm');
               $("#highView").attr('class', 'btn btn-secondary btn-sm');
               $("#priorityView").val("M");
            });
            $("#lowView").on("click", function() {
               $("#lowView").attr('class', 'btn btn-warning btn-sm');
               $("#highView").attr('class', 'btn btn-secondary btn-sm');
               $("#midView").attr('class', 'btn btn-secondary btn-sm');
               $("#priorityView").val("L");
            }); //버튼 클릭 시 이벤트 재할당 끝
                     
            //저장 클릭 시 정규식 검사
            var titleView = 1;
            var startDateView = 1;
            var endDateView = 1;
            var priorityView = 1;
            var contentsView = 1;
            
            $("#completeView").on("click", function() {
               if($("#titleView").val() == ""){
                  titleView = $("#titleInputView").html(0);
                  alert("일정명을 입력해 주세요.");
                  return;
               }else if($("#startDateView").val() == ""){
                  startDate = $("#startDateInputView").html(0);
                  alert("시작일자를 설정해 주세요.");
                  return;
               }else if($("#endDateView").val() == ""){
                  endDate = $("#endDateInputView").html(0);
                  alert("마감일자를 설정해 주세요.");
                  return;
               }else if($("#endDateView").val() < $("#startDateView").val()){
                  endDate = $("#endDateInputView").html(0);
                  alert("마감일자는 시작일자 이후로 설정해 주세요.");
                  return;
               }else if($("#priorityView").val() == ""){
                  priority = $("#priorityInputView").html(0);
                  alert("중요도를 설정해 주세요.");
                  return;
               }else if($("#summernoteView").summernote('isEmpty')){
                  contents = $("#contentsInputView").html(0);
                  alert("일정내용을 입력해 주세요.");
                  return;
               }
               
               var resultView = (titleView*startDateView*endDateView*priorityView*contentsView);
               if(resultView != 0){
                   $("#summernoteView").val($(".note-editable").html());
                  $("#frmModify").submit();
               }return;   
            });//저장 클릭 시 정규식 검사 끝
         });//수정 클릭 시 이벤트 끝
            
         //삭제 클릭 시 이벤트
         $("#deleteView").on("click", function(){
            var pt_seq = $("#hiddenSeq").val();
            if(confirm("일정을 삭제하시겠습니까?")){
               $.ajax({
                  url: "${pageContext.request.contextPath}/deleteTask.pt",
                  data : {pt_seq : pt_seq},
                  type : "post", 
                  dataType: "json"
               }).done(function(resp){
                  console.log(resp);
                  console.log(resp.result);
                  if(resp.result == 'completed'){
                     alert('일정 삭제가 완료되었습니다.');
                     location.href = "${pageContext.request.contextPath}/viewTask.pt";
                     return;
                  }
                  alert("일정 삭제에 실패했습니다.");
                  return;
               }).fail(function(a, b, c){
                  console.log(a);
                  console.log(b);
                  console.log(c);
               });
            }return;            
         });   //삭제 클릭 시 이벤트 끝 
      }).fail(function(a, b, c){
         console.log(a);
         console.log(b);
         console.log(c);
      });
   });   
   $("#viewModal").ready(function() {                  
      $('#summernoteView').summernote({
         disableDragAndDrop : true,
         height : 200,
         toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
               ],
         popover: {
                image: [],
                link: [],
                air: []
                },
         disableResizeEditor: true
      });
   });// 일정 보기 modal 관련 script 끝
//    일정 추가 modal 관련 script
      var title = 1;
      var startDate = 1;
      var endDate = 1;
      var priority = 1;
      var contents = 1;
      
      $("#createTask").on("click", function(){
         $("#title").val("");
         $("#startDate").val("");
         $("#endDate").val("");
         $("#priority").val("");
         $("#high").attr('class', 'btn btn-secondary btn-sm');
         $("#mid").attr('class', 'btn btn-secondary btn-sm');
         $("#low").attr('class', 'btn btn-secondary btn-sm');
         $('#summernote').summernote('code', ''); // 모든 인풋 지워주기
      });
      
      $("#create").on("click", function() {
         if($("#title").val() == ""){
            title = $("#titleInput").html(0);
            alert("일정명을 입력해 주세요.");
            return;
         }else if($("#startDate").val() == ""){
            startDate = $("#startDateInput").html(0);
            alert("시작일자를 입력해 주세요.");
            return;
         }else if($("#endDate").val() == ""){
            endDate = $("#endDateInput").html(0);
            alert("마감일자를 입력해 주세요.");
            return;
         }else if($("#endDate").val() < $("#startDate").val()){
            endDate = $("#endDateInput").html(0);
            alert("시작일자 이후로 날짜를 설정해 주세요.");
            return;
         }else if($("#priority").val() == ""){
            priority = $("#priorityInput").html(0);
            alert("중요도를 설정해 주세요.");
            return;
         }else if($("#summernote").summernote('isEmpty')){
            contents = $("#contentsInput").html(0);
            alert("일정내용을 입력해 주세요.");
            return;
         }
         
         var result = (title*startDate*endDate*priority*contents);
         if(result != 0){
            $("#summernote").val($(".note-editable").html());
            $("#frmAdd").submit();
         }return;         
      });
      
      $("#addModal").ready(function() {                  
         $('#summernote').summernote({
            placeholder : '일정 내용을 입력해 주세요.',
            disableDragAndDrop : true,
            height : 200,
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
             ],
            popover: {
                image: [],
                link: [],
                air: []
                },
            disableResizeEditor: true
         });
      });
      $("#startDate").flatpickr({
         enableTime : false,
         dateFormat : "Y-m-d"
      });
      $("#endDate").flatpickr({
         enableTime : false,
         dateFormat : "Y-m-d"
      });
      $("#high").on("click", function() {
         $("#high").attr('class', 'btn btn-danger btn-sm');
         $("#mid").attr('class', 'btn btn-secondary btn-sm');
         $("#low").attr('class', 'btn btn-secondary btn-sm');
         $("#priority").val("H");
      });
      $("#mid").on("click", function() {
         $("#mid").attr('class', 'btn btn-success btn-sm');
         $("#low").attr('class', 'btn btn-secondary btn-sm');
         $("#high").attr('class', 'btn btn-secondary btn-sm');
         $("#priority").val("M");
      });
      $("#low").on("click", function() {
         $("#low").attr('class', 'btn btn-warning btn-sm');
         $("#high").attr('class', 'btn btn-secondary btn-sm');
         $("#mid").attr('class', 'btn btn-secondary btn-sm');
         $("#priority").val("L");
      }); //일정 추가 modal 관련 script 끝
   </script>
</body>
</html>
