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

<title>일정 캘린더</title>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
<link href="https://unpkg.com/@fullcalendar/core@4.3.1/main.min.css"
   rel="stylesheet">
<link href="https://unpkg.com/@fullcalendar/daygrid@4.3.0/main.min.css"
   rel="stylesheet">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/themes/material_blue.css">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css"
   rel="stylesheet">
   
<script src="https://unpkg.com/@fullcalendar/core@4.3.1/main.min.js"></script>
<script src="https://unpkg.com/@fullcalendar/daygrid@4.3.0/main.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.js"></script>
<script
   src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>

</head>
<style>
html, body {
   margin: 0;
   padding: 0;
   font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
   font-size: 14px;
   height: 100%;
   overflow: hidden;
}

#calendar {
   max-width: 900px;
   margin: 40px;
}

#navBar{
      margin-top: 91px;
}
.fc-title{
    font-weight: bold;
    white-space: normal;
}
.fc-event-time, .fc-event-title {
   padding: 0 1px;
   white-space: nowrap;
}
#high, #mid, #low, #highView, #midView, #lowView{
      width: 52px;
      margin-left : 5px;
}
</style>
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
<!-- 캘린더 div -->
   <div id='calendar'></div>
<!-- 캘린더 div 끝-->
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
               <form action="${pageContext.request.contextPath}/modifyC_Task.pt"
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
      document.addEventListener('DOMContentLoaded', function() {
         var calendarEl = document.getElementById('calendar');
         var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins : [ 'dayGrid' ],
            timeZone : 'UTC',
            defaultView : 'dayGridMonth',
            eventLimit: true,
              views: {
                timeGrid: {
                  eventLimit: 3
                }
             },
            eventClick:function(event){
                console.log(event.event.title);
                $("#viewModal").modal('show');
                $("#viewModal").on('shown.bs.modal', function(){
                   var destination = "${pageContext.request.contextPath}/detailTask.pt";
                  $("#deleteView").attr('hidden', true);
                  $("#modifyView").attr('hidden', true);
                  $("#cancelView").attr('hidden', true);
                  $("#completeView").attr('hidden', true); //버튼 초기 리셋
                  $("#startDateView").attr("disabled", "disabled");
                  $("#endDateView").attr("disabled", "disabled"); //데이트 피커 비활성화
                  
                  var pt_seq = event.event.extendedProps.pt_seq;
                  $("#hiddenSeq").val(pt_seq); // 일정 seq 담아두기 
                  
                  $.ajax({
                     url: destination,
                     data : {pt_seq : pt_seq},
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
//                      $("#startDateView").attr("readonly", true); //시작일자 받고 읽기전용
                     $("#endDateView").val(data.dtoView.pt_endDate);
//                      $("#endDateView").attr("readonly", true); //마감일자 받고 읽기전용
                     $('.note-editable').html(data.dtoView.pt_contents);
                     $('#summernoteView').summernote('disable');
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
//                         $("#startDateView").attr("readonly",false);
//                         $("#endDateView").attr("readonly",false);
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
                        
                     $("#deleteView").on("click", function(){//삭제 클릭 시 이벤트
                        var pt_seq = $("#hiddenSeq").val();
                        if(confirm("일정을 삭제하시겠습니까?")){
                           $.ajax({
                              url: "${pageContext.request.contextPath}/deleteC_Task.pt",
                              data : {pt_seq : pt_seq},
                              type : "post",
                              dataType: "json"
                           }).done(function(resp){
                              console.log(resp);
                              console.log(resp.result);
                              if(resp.result == 'completed'){
                                 alert('일정 삭제가 완료되었습니다.');
                                 location.href = "viewCalendar.jsp";
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
                     }); //삭제 클릭 시 이벤트 끝 
                  }).fail(function(a, b, c){
                     console.log(a);
                     console.log(b);
                     console.log(c);
                  });
                });
            }
         });
         $.ajax({
            url : "${pageContext.request.contextPath}/viewCalendar.pt",
            dataType : "json",
            async : true,
         }).done(function(data) {
            console.log(data);
            
            for (var i = 0; i < data.length; i++) {
               calendar.addEvent({
                  title : data[i].pt_title,
                  start : data[i].pt_startDate,
                  end : data[i].pt_endDate,
                  extendedProps:{
                     pt_seq:data[i].pt_seq,
                  },
                  color: randomColor()
               });
            }
            calendar.render();         
         }).fail(function(a, b, c) {
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
      });
      
      function randomColor() {
             var color = '#';             
             var backcolorArr = new Array('fcbc0a', '75cdff', 'ffb5d6', 'a4ed82', 'f58c7a', 'dd9eff');
             color += backcolorArr[Math.floor(Math.random() * (6 - 0) + 0)];
             console.log(color);
             return color;
       }
   </script>
</body>
</html>
