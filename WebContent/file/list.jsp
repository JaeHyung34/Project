<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file List</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/css/bootstrap.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
   href="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"
   type="text/css" />
<link rel="stylesheet"
   href="https://cdn.datatables.net/1.10.20/js/dataTables.semanticui.min.js"
   type="text/css" />
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"
   type="text/css" />
<link rel="stylesheet"
   href="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"
   type="text/css" />

<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
<link rel="stylesheet"
   href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css">

<script
   src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"
   type="text/javascript"></script>
<script
   src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"
   type="text/javascript"></script>

<style>
#selectBtn {
   text-align: right;
}

a {
   text-decoration: none;
   color: black;
}

a:hover {
   color: gray;
}

#navBar {
   margin-top: 20px;
}

#btn {
   position: relative;
   overflow: hidden;
   display: inline-block;
}

.form-group input[type=file] {
   position: absolute;
   opacity: 0;
   left: 15;
   top: 15;
}

#fileDragDesc {
   width: 100%;
   height: 100%;
   margin-left: auto;
   margin-right: auto;
   padding: 5px;
   text-align: center;
   line-height: 300px;
   vertical-align: middle;
}
</style>
</head>
<body>
   <!-- 게시판 네비 시작 -->
   <ul class="nav nav-tabs" id="navBar">
      <li class="nav-item dropdown"><a
         class="nav-link dropdown-toggle text-dark" data-toggle="dropdown"
         href="#" role="button" aria-haspopup="true" aria-expanded="false">일정</a>
         <div class="dropdown-menu">
            <a class="dropdown-item"
               href="${pageContext.request.contextPath}/viewTask.pt"
               aria-selected="true">일정 게시판</a> <a class="dropdown-item"
               href="${pageContext.request.contextPath}/viewCalendar.pt">일정
               캘린더</a>
         </div></li>
      <li class="nav-item"><a class="nav-link text-dark"
         href="${pageContext.request.contextPath}/list.file">파일</a></li>
      <li class="nav-item"><a class="nav-link text-dark"
         href="${pageContext.request.contextPath}/list.pm">멤버</a></li>
   </ul>
   <!-- 게시판 네비 끝 -->
   <div id="selectBtn">
      <button type="button" id="createTask" role="button"
         class="btn btn-info p opover-test align-right" data-toggle="modal"
         data-target="#uploadModal" data-backdrop="static">업로드</button>
      <button id="deleteBtn">삭제</button>
   </div>
   <table id="dtBasicExample" class="table table-striped table-bordered"
      cellspacing="0" width="100%">
      <thead>
         <tr>
            <th scope="col">#</th>
            <th scope="col"><input type=checkbox id="allChk"
               onclick="allChk(this)"></th>
            <th scope="col">FileName</th>
            <th scope="col">Write_Date</th>
            <th scope="col">Writer</th>
            <th scope="col">Download Count</th>
         </tr>
      </thead>
      <tbody>
         <c:choose>
            <c:when test="${list.size() == 0}">
               <tr>
                  <td colspan=6 style="text-align: center">업로드된 파일이 없습니다.</td>
               </tr>
            </c:when>
            <c:otherwise>
               <c:forEach items="${list}" var="file">
                  <tr>
                     <th scope="row" name="f_seq">${file.f_seq}</th>
                     <td><input type=checkbox name="RowCheck"
                        value="${file.f_seq}"></td>
                     <td><a id='${file.f_seq}'
                        href="${pageContext.request.contextPath}/download.file?fileName=${file.file_name}&oriName=${file.original_file_name}&f_seq=${file.f_seq}">
                           ${file.original_file_name}<br>
                     </a></td>
                     <td>${file.formedDate}</td>
                     <td>${file.f_writer}</td>
                     <td class="cnt_${file.f_seq}">${file.f_downloadCnt}</td>
                  </tr>
               </c:forEach>
            </c:otherwise>
         </c:choose>
      </tbody>
   </table>
   <div class="modal fade" id="uploadModal" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">파일 업로드</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"><div class="form-group" id="btn">
            <input type="file" id="input_file" name="input_file" multiple="multiple">
            <button class="upload-btn">파일선택</button>
            </div>
               <div class="form-group">
               <div id="dropZone" style="height: 300px; border-style: dotted; border-color: gray; margin: auto">
               <div id="fileDragDesc">파일을 드래그 해주세요.</div>
               <table id="fileListTable" border="0px">
               <tbody id="fileTableTbody"></tbody>
               </table>
               </div>
               </div>
               <div class="modal-footer">
                  <input type="button" onclick="uploadFile(); return false;" value="업로드">
               </div>
            </div>
         </div>
      </div>
   </div>
</body>
<script>
   $("a").on("click", function() {
      var id = $(this).attr("id");
      console.log(id);
      $.ajax({
         url : "downloadCount.file",
         type : "post",
         data : {
            f_seq : id
         },
         dataType : "json"
      }).done(function(resp) {
         console.log(resp);
         var downCnt = resp;

         console.log(resp);
         //   $("#f_downloadCnt").html(resp);
         $(".cnt_" + resp.f_seq).html(resp.dCnt);
      }).fail(function(a, b, c) {
         console.log(a);
         console.log(b);
         console.log(c);
      });
   })

   $("#input_file").on('change', function() {
      selectFile(this.files);
   });
   // 파일 리스트 번호
   var fileIndex = 0;
   // 등록할 전체 파일 사이즈
   var totalFileSize = 0;
   // 파일 리스트
   var fileList = new Array();
   // 파일 사이즈 리스트
   var fileSizeList = new Array();
   // 등록 가능한 파일 사이즈 MB
   var uploadSize = 100;
   // 등록 가능한 총 파일 사이즈 MB
   var maxUploadSize = 100;

   $(function() {
      // 파일 드롭 다운
      fileDropDown();
   });
   // 파일 드롭 다운
   function fileDropDown() {
      var dropZone = $("#dropZone");
      //Drag기능 
      dropZone.on('dragenter', function(e) {
         e.stopPropagation();
         e.preventDefault();
         // 드롭다운 영역 css
         dropZone.css('background-color', '#E3F2FC');
      });
      dropZone.on('dragleave', function(e) {
         e.stopPropagation();
         e.preventDefault();
         // 드롭다운 영역 css
         dropZone.css('background-color', '#FFFFFF');
      });
      dropZone.on('dragover', function(e) {
         e.stopPropagation();
         e.preventDefault();
         // 드롭다운 영역 css
         dropZone.css('background-color', '#E3F2FC');
      });
      dropZone.on('drop', function(e) {
         e.preventDefault();
         // 드롭다운 영역 css
         dropZone.css('background-color', '#FFFFFF');

         var files = e.originalEvent.dataTransfer.files;
         if (files != null) {
            if (files.length < 1) {
               alert("폴더 업로드 불가");
               console.log("폴더 업로드 불가");
               return;
            } else {
               selectFile(files)
            }
         } else {
            alert("ERROR");
         }
      });
   }
   // 파일 선택시
   function selectFile(fileObject) {
      var files = null;
      if (fileObject != null) {
         // 파일 Drag 이용하여 등록시
         files = fileObject;
      } else {
         // 직접 파일 등록시
         files = $('#multipaartFileList_' + fileIndex)[0].files;
      }
      // 다중파일 등록
      if (files != null) {
         if (files != null && files.length > 0) {
            $("#fileDragDesc").hide();
            $("#fileListTable").show();
         } else {
            $("#fileDragDesc").show();
            $("#fileListTable").hide();
         }
         for (var i = 0; i < files.length; i++) {
            // 파일 이름
            var fileName = files[i].name;

            var fileNameArr = fileName.split("\.");
            // 확장자
            var ext = fileNameArr[fileNameArr.length - 1];
            var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
            console.log("fileSize=" + fileSize);
            if (fileSize <= 0) {
               console.log("0kb file return");
               return;
            }
            var fileSizeKb = fileSize / 1024;
            var fileSizeMb = fileSizeKb / 1024;

            var fileSizeStr = "";
            if ((1024 * 1024) <= fileSize) { // 파일 용량이 1메가 이상인 경우 
               console.log("fileSizeMb=" + fileSizeMb.toFixed(2));
               fileSizeStr = fileSizeMb.toFixed(2) + " Mb";
            } else if ((1024) <= fileSize) {
               console.log("fileSizeKb=" + parseInt(fileSizeKb));
               fileSizeStr = parseInt(fileSizeKb) + " kb";
            } else {
               console.log("fileSize=" + parseInt(fileSize));
               fileSizeStr = parseInt(fileSize) + " byte";
            }
            if ($.inArray(ext, [ 'hwp', 'doc', 'docx', 'xls', 'xlsx',
                  'ppt', 'pptx', 'txt', 'png', 'pdf', 'jpg', 'jpeg',
                  'gif', 'zip' ]) <= 0) {
               // 확장자 체크
               alert("등록이 불가능한 파일 입니다.(" + fileName + ")");
            } else if (fileSizeMb > uploadSize) {
               // 파일 사이즈 체크
               alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
               break;
            } else {
               // 전체 파일 사이즈
               totalFileSize += fileSizeMb;
               // 파일 배열에 넣기
               fileList[fileIndex] = files[i];
               // 파일 사이즈 배열에 넣기
               fileSizeList[fileIndex] = fileSizeMb;
               // 업로드 파일 목록 생성
               addFileList(fileIndex, fileName, fileSizeStr);
               // 파일 번호 증가
               fileIndex++;
            }
         }
      } else {
         alert("ERROR");
      }
   }
   // 업로드 파일 목록 생성
   function addFileList(fIndex, fileName, fileSizeStr) {
      var html = "";
      html += "<tr id='fileTr_" + fIndex + "'>";
      html += "    <td id='dropZone' class='left' >";
      html += fileName
            + " ("
            + fileSizeStr
            + ") "
            + "<input value='삭제' type='button' href='#' onclick='deleteFile("
            + fIndex + "); return false;'>"
      html += "    </td>"
      html += "</tr>";
      console.log(fileName);

      $('#fileTableTbody').append(html);
   }
   // 업로드 파일 삭제
   function deleteFile(fIndex) {
      console.log("deleteFile.fIndex=" + fIndex);
      // 전체 파일 사이즈 수정
      totalFileSize -= fileSizeList[fIndex];
      // 파일 배열에서 삭제
      delete fileList[fIndex];
      // 파일 사이즈 배열 삭제
      delete fileSizeList[fIndex];
      // 업로드 파일 테이블 목록에서 삭제
      $("#fileTr_" + fIndex).remove();
      console.log("totalFileSize=" + totalFileSize);

      if (totalFileSize > 0) {
         $("#fileDragDesc").hide();
         $("#fileListTable").show();
      } else {
         $("#fileDragDesc").show();
         $("#fileListTable").hide();
      }
   }
   // 파일 등록
   function uploadFile() {
      // 등록할 파일 리스트
      var uploadFileList = Object.keys(fileList);
      // 파일이 있는지 체크
      if (uploadFileList.length == 0) {
         // 파일등록 경고창
         alert("파일이 없습니다.");
         return;
      }
      // 용량을 500MB를 넘을 경우 업로드 불가
      if (totalFileSize > maxUploadSize) {
         // 파일 사이즈 초과 경고창
         alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
         return;
      }
      if (confirm("등록 하시겠습니까?")) {
         // 등록할 파일 리스트를 formData로 데이터 입력
         //var form = $('#uploadForm')[0];
         var formData = new FormData();
         for (var i = 0; i < uploadFileList.length; i++) {
            console.log(uploadFileList[i]);
            console.log(fileList[uploadFileList[i]].name);
            formData.append('files', fileList[uploadFileList[i]]);
         }

         console.log(formData);
         console.log("전");
         $.ajax({
                  url : "upload.file",
                  data : formData,
                  type : 'post',
                  enctype : 'multipart/form-data',
                  processData : false,
                  contentType : false,
                  dataType : 'json',
                  cache : false,
                  success : function(result) {
                     //result = JSON.parse(result)                      
                     console.log(result);
                     console.log("후");
                     if (result.fileName.length != 0) {
                        alert("성공");
                        //location.reload();
                        location.href = "${pageContext.request.contextPath}/list.file"
                     } else {
                        alert("실패");
                        location.reload();
                     }
                  },
                  error : function(request, status, error) {
                     console.log(request.status + "error:" + error)
                     console.log("fail");
                  }

               });
      }
   }
   //allCheck하기
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
   $("#deleteBtn").on("click",function(){
                  var checkArray = [];

                  $("input[name=RowCheck]:checked").each(function(i) { //jQuery로 for문 돌면서 check 된값 배열에 담는다
                     checkArray.push($(this).val());
                  });
                  if (checkArray.length == 0) {
                     alert("삭제할 파일을 선택하세요.")
                  } else {
                     if (confirm("삭제하시겠습니까?") == true) { //확인
                        console.log(checkArray);
                        console.log(1);
                        $
                              .ajax({
                                 type : 'POST',
                                 url : 'delete.file',
                                 dataType : 'json',
                                 data : {
                                    checkArray : JSON
                                          .stringify(checkArray)
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
                                       location.href = "${pageContext.request.contextPath}/list.file"
                                    } else {
                                       alert("삭제에 실패하셨습니다.")
                                    }

                                 }
                              });
                        checkArray = new Array();
                     } else {
                        console.log("안돼");
                        location.reload(true);
                     }
                  }

               })
</script>
</html>