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

<title>관리자 페이지</title>
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

<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript" ></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" type="text/javascript" ></script>	
<script>
        jQuery(function($){
            $("#foo-table").DataTable();
        });
        
       
    </script>

</head>

<body id="page-top">
	<c:choose>
      <c:when test="${ManagerInfo == null}">
         <script>
			location.href="../index.jsp";
         </script>
      </c:when>
    
   </c:choose>
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gray-800 sidebar sidebar-dark accordion d-none d-md-block"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="${pageContext.request.contextPath}/admin.admin">
				<div class="sidebar-brand-icon">
					<i class="fas fa-radiation"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					신선놀음 <sup>1.5</sup>
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<!-- <li class="nav-item active"><a class="nav-link" href="#"> <i
					class="fas fa-project-diagram"></i> <span>새 프로젝트 <span
						class="badge badge-danger badge-pill">new</span>
				</span></a></li> -->

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="${pageContext.request.contextPath}/message/msg_index.jsp">
					<i class="fas fa-project-diagram"></i> <span>쪽지함</span> <span
					class="badge badge-danger badge-pill">new</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">회원</div>

			<!-- Nav Item - 로그인 -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseMemberInfo"> <i
					class="fas fa-fw fa-folder"></i> <span>회원 관리 </span>
			</a>
				<div id="collapseMemberInfo" class="collapse"
					data-parent="#accordionSidebar">
					<div class="bg-dark py-2 collapse-inner rounded">
						<h6 class="collapse-header">회원 :</h6>
						<a class="collapse-item text-light bg-dark" href="${pageContext.request.contextPath}/memberList.admin">일반회원
							조회/삭제</a> <a class="collapse-item text-light bg-dark" href="${pageContext.request.contextPath}/blackmember.black">블랙회원
							조회/삭제</a>
					</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading - 달력 -->
			<div class="sidebar-heading">프로젝트</div>

			<!-- Nav Item -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseProjectInfo"> <i
					class="fas fa-fw fa-folder"></i> <span>프로젝트 관리 </span>
			</a>
				<div id="collapseProjectInfo" class="collapse"
					data-parent="#accordionSidebar">
					<div class="bg-dark py-2 collapse-inner rounded">
						<h6 class="collapse-header">프로젝트 :</h6>
						<a class="collapse-item text-light bg-dark" href="${pageContext.request.contextPath}/adminProject.adProject">프로젝트 조회/삭제</a>
					</div></li>


			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">내 정보</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseMyInfo"> <i
					class="fas fa-fw fa-folder"></i> <span>내 정보 보기 </span>
			</a>
				<div id="collapseMyInfo" class="collapse"
					data-parent="#accordionSidebar">
					<div class="bg-dark py-2 collapse-inner rounded">
						<i class="fas fa-fw fa-user text-light"></i> <a
							class="collapse-item text-light bg-dark" href="#">로그아웃</a>
					</div></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">임시</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>Pages</span>
			</a>
				<div id="collapsePages" class="collapse"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Login Screens:</h6>
						<a class="collapse-item" href="login.html">Login</a> <a
							class="collapse-item" href="register.html">Register</a> <a
							class="collapse-item" href="forgot-password.html">Forgot
							Password</a>
						<div class="collapse-divider"></div>
						<h6 class="collapse-header">Other Pages:</h6>
						<a class="collapse-item" href="404.html">404 Page</a> <a
							class="collapse-item" href="blank.html">Blank Page</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<div>
					<button class="rounded-circle border-0" id="sidebarToggle"></button>
				</div>
			</div>
		</ul>

		<!-- Main Content -->
		<div id="content">


			<!-- Topbar // 모바일환경일 때에만 노출되는 상위네비바 -->
			<nav
				class="navbar navbar-expand navbar-light bg-gray-800 topbar static-top shadow w-100 d-xs-block d-md-none">

				<!-- Sidebar Toggle (Topbar) -->
				<ul class="navbar-nav">
					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown"> <i class="fa fa-bars"></i>
							<span id="msgAlert" class="badge badge-danger badge-counter">N</span>
					</a> <!-- Dropdown - User Information -->
						<div
							class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/memberList.admin"> <i
								class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 회원관리
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/adminProject.adProject"> <i
								class="fas fa-tasks fa-sm fa-fw mr-2 text-gray-400"></i> 프로젝트 관리
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#"> <i
								class="fas fa-pen fa-sm fa-fw mr-2 text-gray-400"></i> 게시물 관리
							</a>
						</div></li>
				</ul>

				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-auto">

					<!-- Nav Item - Alerts -->
					<li class="nav-item dropdown no-arrow mx-1"><a
						class="nav-link"
						href="${pageContext.request.contextPath}/message/msg_index.jsp">
							<i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts --> <span
							id="msgAlert" class="badge badge-danger badge-counter">N</span>
					</a></li>

					<div class="topbar-divider d-none d-sm-block"></div>

					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown"> <img
							class="img-profile rounded-circle" src="img/default_profile.png">
					</a> <!-- Dropdown - User Information -->
						<div
							class="dropdown-menu dropdown-menu-right bg-light shadow animated--grow-in">

							<div class="dropdown-divider"></div>
							<a class="dropdown-item collapse-item text-dark" href="#"
								data-toggle="modal" data-target="#logoutModal"> <i
								class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								로그아웃
							</a>
						</div></li>
				</ul>
			</nav>
			<!-- End of Topbar -->

			<!-- 메인 콘텐츠 시작 부분 -->
			<div class="container">
				<h2>Member List</h2>
				<p>일반 회원 리스트</p>
				<form method="post" id="frm">
					<table class="table table-bordered text-center" id="foo-table">
						<thead class="thead-light">
							<tr>
								<th class="text-center">번호</th>
								<th class="text-center">아이디</th>
								<th class="text-center">이름</th>
								<th class="text-center">처리</th>
							</tr>
						</thead>
						<tbody id="emp_rows">
							<c:forEach items="${list }" var="list" varStatus="status">
								<tr>
									<td>${status.count }
									<td><button type="button" class="memberInfo btn btn-link"
											id="${list.mb_email }" data-toggle="modal"
											data-target="#exampleModal" data-whatever="${list.mb_email }">${list.mb_email }</button>
									<td>${list.mb_name }</td>
									<td><button type="button" id="${list.mb_email }"
											class="deleteBtn btn btn-sm btn-danger">삭제</button> &nbsp;
										<button type="button" data-toggle="modal1"
											id="${list.mb_email }" data-target="#insertBlack"
											class="blackBtn btn btn-sm btn-dark">블랙</button></td>
									 
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="d-flex justify-content-center"><ul class="pagination">${pages}</ul></div>
				</form>
			</div>

			<!-- 상세 정보 -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">회원 정보</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<label for="recipient-email" class="col-form-label">
										아이디</label> <input type="text" class="form-control"
										id="recipent-email">
								</div>
								<div class="form-group">

									<label for="recipient-name" class="col-form-label">이름</label> <input
										type="text" class="form-control" id="recipent-name">
								</div>
								<div class="form-group">
									<label for="recipient-nickname" class="col-form-label">닉네임</label>
									<input type="text" class="form-control" id="recipent-nickname">
								</div>
								<div class="form-group">
									<label for="recipient-group" class="col-form-label">소속
										그룹</label> <input type="text" class="form-control" id="recipent-group">
								</div>
								<div class="form-group">
									<label for="recipient-phone" class="col-form-label">연락처</label>
									<input type="text" class="form-control" id="recipent-phone">
								</div>

							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>

			<!-- <div class="modal fade" id="exampleModal1" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">회원 정보</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<label for="mail" class="col-form-label">회원 아이디</label> <input
										type="text" class="form-control" id="mail"> <input
										type="button" value="검색" onclick="windowopenPopup();">
								</div>
								<div class="form-group">
									<label for="name" class="col-form-label">회원 이름</label> <input
										type="text" class="form-control" id="name">
								</div>
								<div class="form-group">
									<label for="message-text" class="col-form-label">사유</label>
									<textarea class="form-control" id="reasontext"></textarea>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="button" id="addBlackMember">추가하기</button>
						</div>
					</div>
				</div>
			</div> -->
			<div class="modal fade" id="insertBlack" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">회원 정보</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form action="${pageContext.request.contextPath}/Newblack.black"
								method="post" id="addForm">
								<div class="form-group">
									<label for="member-email" class="col-form-label"> 아이디</label> <input
										type="text" class="form-control" id="member-email"
										name="member-email">
								</div>
								<div class="form-group">
									<label for="member-name" class="col-form-label">이름</label> <input
										type="text" class="form-control" id="member-name"
										name="member-name">
								</div>
								<div class="form-group">
									<label for="member-reason" class="col-form-label">사유</label>
									<textarea class="form-control" id="member-reason"
										name="member-reason"></textarea>
								</div>

								<div class="modal-footer">
									<button type="button" class="btn-sm btn btn-light" id="addblack"
										>추가</button>
									<button type="button" class="btn-sm btn btn-light"
										data-dismiss="modal">닫기</button>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>


			<!-- 메인 콘텐츠 끝 -->
		</div>

	</div>
	<script>
		
		$("#addblack").on("click",function(){
			$("#addForm").submit();
		});
		
		
		$('.blackBtn').on("click", function() {
			var i = $(this).attr("id");
			console.log(i);
			$.ajax({
				url : "addBlackmember.admin",
				dataType : "json",
				type : "post",
				data : {
					mb_email : i,
				}
			}).done(function(resp) {
				$("#insertBlack").modal();
				$("#member-email").val(resp.mb_email);
				$("#member-name").val(resp.mb_name);

			}).fail(function(resp) {
				console.log("실패");
			});
		});

		$(".deleteBtn").on(
				"click",
				function() {
					console.log("dsd");
					var email = $(this).attr("id");

					var result = confirm("정말 삭제하시겠습니까?");
					if (result) {
						$("#frm").attr(
								"action",
								"${pageContext.request.contextPath}/delete.admin?email="
										+ email);
						$("#frm").submit();
					}
				});

		$(".memberInfo").on("click", function() {
			var i = $(this).attr("id");
			console.log(i);
			$.ajax({
				url : "detailmember.admin",
				dataType : "json",
				type : "post",
				data : {
					mb_email : i
				}
			}).done(function(resp) {
				$("#recipent-email").val(resp.mb_email);
				$("#recipent-name").val(resp.mb_name);
				$("#recipent-nickname").val(resp.mb_nickname);
				$("#recipent-group").val(resp.mb_group);
				$("#recipent-phone").val(resp.mb_phone);

			}).fail(function(resp) {
				console.log("실패");
			});
		});

		/* $(".addBlackMemberBtn").on(
				"click",
				function() {
					if ($("input:checkbox[class='generalCheck']")
							.is(":checked") == true) {
						var i = $()
						console.log(i);
					} else {
						alert("선택된 회원이 없습니다. 다시 확인해주세요.");
						return;
					}
					$.ajax({
						url : "addBlackmember.admin",
						dataType : "json",
						type : "post",
						data : {
							mb_email : i
						}

					}).done(function(resp) {
						$("#recipent-email").val(resp.mb_email);
						$("#recipent-name").val(resp.mb_name);

					}).fail(function(resp) {
						console.log("실패");
					});
				}); */

		/* $("#deleteBtn")
				.on(
						"click",
						function() {
							
								var result = confirm("정말 삭제하시겠습니까?");
								if (result) {
									$("#frm")
											.attr("action",
													"${pageContext.request.contextPath}/delete.admin");
									$("#frm").submit();
								} else {
									return;
								}
							} else {
								alert("선택한 회원이 없습니다. 회원을 선택해주세요.");
							}

						}); */

		/* $("#addBlackMember").on(
				"click",
				function() {
					if ($("input:checkbox[class='generalCheck']")
							.is(":checked") == true) {

						var email1 = mb_email.value;
						var bl_name = $("#name").val();
						var bl_reason = $("#reasontext").val();
						console.log(email1);
						console.log(bl_name);
						console.log(bl_reason);
					}
					$.ajax({
						url : "Newblack.black",
						dataType : "json",
						data : {
							email : email1,
							name : bl_name,
							reason : bl_reason
						}
					}).done(function(resp) {
						$("#exampleModal1").css("display", "block");
						console.log(resp);
					}).fail(function() {

						$("#exampleModal1").slideUp(2000);
						$(".modal-backdrop").attr("class", "");
						alert("회원이 아닙니다. 다시 입력해주세요.");
					});
				}); */
	</script>
</body>
</html>

