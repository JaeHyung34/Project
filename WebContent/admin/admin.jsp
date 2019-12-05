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
<style>
body {
	margin: auto;
	text-align: center;
}

.todaycounter, .totalcounter, .projectcounter, .sharecounter {
	font-size: 50px;
	font-weight: 500;
	width: 200px;
	height: 200px;
	vertical-align: middle;
	line-height: 100px;
	text-align: center;
	padding-top: 45px;
}

.card-title {
	text-align: center;
}

.projectcounter {
	
}
</style>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
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
				href="#" onclick="generalmemberSiteMove()">
				<div class="sidebar-brand-icon">
					<i class="fas fa-radiation"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					신선놀음 <sup>1.5</sup>
				</div>
			</a>


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
						<a class="collapse-item text-light bg-dark"
							href="#" onclick="generalmemberSiteMove()">일반회원
							조회/삭제</a> <a class="collapse-item text-light bg-dark"
							href="#" onclick="blackmemberSiteMove()">블랙회원
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
						<a class="collapse-item text-light bg-dark"
							href="#" onclick="adminProjectSiteMove()">프로젝트
							조회/삭제</a>
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
							<a class="dropdown-item"
								href="#" onclick="generalmemberSiteMove()">
								<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 회원관리
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item"
								href="#" onclick="adminProjectSiteMove()">
								<i class="fas fa-tasks fa-sm fa-fw mr-2 text-gray-400"></i> 프로젝트
								관리
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
			<iframe id="iframe" class=embed-responsive-item
				style="width: 100%; height: 100vh; border: none; border-left: 1px"
				> </iframe>
			 <span class="d-block p-2 bg-gray-400 text-dark h5"
				style="margin-bottom: 0px; text-align: center; line-height: 70px; height: 10%">방문자
				현황</span>
			<a
				href="${pageContext.request.contextPath}/black.black">블랙</a> <a
				href="${pageContext.request.contextPath}/memberList.black">일반</a>

			<div class="card mb-12 w-100 text-light bg-dark h-200">
				<div class="row no-gutters">
					<div class="col-md-1  text-light bg-dark h-200"></div>
					<div class="col-md-4">
						<div class="card-body bg-dark text-light">
							<h5 class="card-title">오늘의 방문자</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="todaycounter"
									data-count="${sessionScope.todayCount}">0</div>
							</h1>
							<p class="card-text"></p>
						</div>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-4">
						<div class="card-body">
							<h5 class="card-title">전체 방문자</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="totalcounter"
									data-count="${sessionScope.totalCount}">0</div>
							</h1>
							<p class="card-text">
								<small class="text-muted"></small>
							</p>
						</div>
					</div>

				</div>
			</div>

			<span class="d-block p-2 bg-gray-400 text-dark h5"
				style="margin-bottom: 0px; text-align: center; line-height: 70px; height: 10%">프로젝트
				현황</span>
			<%-- <a
				href="${pageContext.request.contextPath}/black.black">블랙</a> <a
				href="${pageContext.request.contextPath}/memberList.black">일반</a> --%>

			<%-- <div class="card mb-12 w-80 text-light bg-dark h-200">
				<div class="row no-gutters">
					<div class="col-md-1  text-light bg-dark h-200"></div>
					<div class="col-md-4">
						<div class="card-body">
							<h5 class="card-title">개설된 프로젝트</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="projectcounter"
									data-count="${sessionScope.pro_totalCount}">0</div>
							</h1>
							<p class="card-text"></p>
						</div>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-4">
						<div class="card-body">
							<h5 class="card-title">공유된 업무</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="sharecounter" data-count="">0</div>
							</h1>
							<p class="card-text">
								<small class="text-muted"></small>
							</p>
						</div>
					</div>

				</div>
			</div> --%>

			<!-- 메인 콘텐츠 끝 -->

		</div>
	</div>
	<script>
		function blackmemberSiteMove() {
			$("#iframe")
					.attr("src",
							"${pageContext.request.contextPath}/blackmember/blackList.jsp");
		}
		
		function generalmemberSiteMove() {
			$("#iframe")
					.attr("src",
							"${pageContext.request.contextPath}/generalmember/memberList.jsp");
		}
		
		function adminProjectSiteMove() {
			$("#iframe")
					.attr("src",
							"${pageContext.request.contextPath}/adminProject/project.jsp");
		}

		$('.todaycounter').each(function() {
			var $this = $(this), countTo = $this.attr('data-count');

			$({
				countNum : $this.text()
			}).animate({
				countNum : countTo
			},

			{

				duration : 500,
				easing : 'linear',
				step : function() {
					$this.text(Math.floor(this.countNum));
				},
				complete : function() {
					$this.text(this.countNum);
					//alert('finished');
				}

			});
		});
		$('.totalcounter').each(function() {
			var $this = $(this), countTo = $this.attr('data-count');

			$({
				countNum : $this.text()
			}).animate({
				countNum : countTo
			},

			{

				duration : 1000,
				easing : 'linear',
				step : function() {
					$this.text(Math.floor(this.countNum));
				},
				complete : function() {
					$this.text(this.countNum);
					//alert('finished');
				}

			});
		});
		$('.projectcounter').each(function() {
			var $this = $(this), countTo = $this.attr('data-count');

			$({
				countNum : $this.text()
			}).animate({
				countNum : countTo
			},

			{

				duration : 1000,
				easing : 'linear',
				step : function() {
					$this.text(Math.floor(this.countNum));
				},
				complete : function() {
					$this.text(this.countNum);
					//alert('finished');
				}

			});
		});
		$('.sharecounter').each(function() {
			var $this = $(this), countTo = $this.attr('data-count');

			$({
				countNum : $this.text()
			}).animate({
				countNum : countTo
			},

			{

				duration : 1000,
				easing : 'linear',
				step : function() {
					$this.text(Math.floor(this.countNum));
				},
				complete : function() {
					$this.text(this.countNum);
					//alert('finished');
				}

			});
		});
	</script>

</body>
</html>
	
