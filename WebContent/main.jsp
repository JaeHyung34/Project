<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>제목을 입력하세요</title>
<jsp:include page="/cdn/cdn.jsp" flush="false" />
</head>
 
<body id="page-top">
 <c:choose>
      <c:when test="${loginInfo != null}">
	      <!-- Page Wrapper -->
		<div id="wrapper">
		
			<!-- Scroll to Top Button-->
			<a class="scroll-to-top rounded" href="#page-top">
				<i class="fas fa-angle-up"></i>
			</a>
			
			<!-- Sidebar -->
	
			<ul class="navbar-nav bg-gradient-secondary sidebar sidebar-dark accordion d-none d-md-block" id="accordionSidebar">
			
			<!-- Sidebar - Brand -->
				<a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
	
					<div class="sidebar-brand-icon">
						<i class="fas fa-radiation"></i>
					</div>
					<div class="sidebar-brand-text mx-3">신선놀음 <sup>1.5</sup></div>
				</a>
				
				<!-- Divider -->
				<hr class="sidebar-divider my-0">
	
				<!-- Nav Item - Dashboard -->
				<li class="nav-item active">
					<a class="nav-link" href="#" onclick="viewProjectMove()"> 
						<i class="fas fa-project-diagram"></i> 
						<span>프로젝트 <span class="badge badge-danger badge-pill">new</span></span>
					</a>
				</li>
	
				<!-- Divider -->
				<hr class="sidebar-divider my-0">
	
				<!-- Nav Item - Dashboard -->
				<li class="nav-item active">
					<a class="nav-link" href="${pageContext.request.contextPath}/message/msg_index.jsp">
						<i class="fas fa-project-diagram"></i>
						<span>쪽지함</span> 
						<span class="badge badge-danger badge-pill">new</span>
					</a>
				</li>
	
				<!-- Divider -->
				<hr class="sidebar-divider">
	
				<!-- Heading -->
				<div class="sidebar-heading">재형</div>
	
				<!-- Nav Item - 로그인 -->
				<li class="nav-item">
					<a class="nav-link" href="#"> 
						<i class="fas fa-fw fa-chart-area"></i>
						<span>정재형</span>
					</a>
				</li>
	
				<!-- Divider -->
				<hr class="sidebar-divider">
	
				<!-- Heading - 달력 -->
				<div class="sidebar-heading">은비</div>
	
				<!-- Nav Item -->
				<li class="nav-item">
					<a class="nav-link" href="#" onclick="viewProjectMove()"> 
						<i class="fas fa-fw fa-chart-area"></i>
						<span>조은비</span>
					</a>
				</li>
	
				<!-- Heading - 게시판 -->
				<div class="sidebar-heading">유진</div>
	
				<!-- Nav Item -->
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/list.file"> 
						<i class="fas fa-fw fa-chart-area"></i> <span>파일</span></a></li>
						<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/list.pm"> 
						<i class="fas fa-fw fa-chart-area"></i> <span>멤버</span>
					</a>
				</li>
						
				<!-- Divider -->
				<hr class="sidebar-divider">
	
				<!-- Heading -->
				<div class="sidebar-heading">익호</div>
	
				<!-- Nav Item - 관리자 페이지 -->
	
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberList.admin">
						<i class="fas fa-fw fa-chart-area"></i> <span>신익호</span>
				</a></li>
				
				<!-- Divider -->
				<hr class="sidebar-divider">
	
				<!-- Heading -->
				<div class="sidebar-heading">내 정보</div>
	
				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item">
					<a class="nav-link collapsed" href="#"	data-toggle="collapse" data-target="#collapseMyInfo"> 
						<i class="fas fa-fw fa-folder"></i> <span>내 정보 보기 </span>
					</a>
					<div id="collapseMyInfo" class="collapse" data-parent="#accordionSidebar">
						<div class="bg-white py-2 collapse-inner rounded">
							<h6 class="collapse-header">정보 :</h6>
							<a class="collapse-item mb-" href="#" onclick="modifySiteMove()">내 정보 수정</a> 
							<a class="collapse-item bg-info" href="#"  onclick="logOutSiteMove()">로그아웃</a> 
							<a class="collapse-item " href="#"  onclick="withdrawalSiteMove()">회원탈퇴</a> 
						</div>
					</div>
				</li>
				<!-- Divider -->
				<hr class="sidebar-divider">
	
				<!-- Heading -->
				<div class="sidebar-heading">임시</div>
	
				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item">
					<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"> 
						<i class="fas fa-fw fa-folder"></i> <span>Pages</span>
					</a>
					<div id="collapsePages" class="collapse" data-parent="#accordionSidebar">
						<div class="bg-white py-2 collapse-inner rounded">
							<h6 class="collapse-header">Login Screens:</h6>
							<a class="collapse-item" href="login.html">Login</a> 
							<a class="collapse-item" href="register.html">Register</a>
							<a class="collapse-item" href="forgot-password.html">Forgot Password</a>
							<div class="collapse-divider"></div>
							<h6 class="collapse-header">Other Pages:</h6>
							<a class="collapse-item" href="404.html">404 Page</a> 
							<a class="collapse-item" href="blank.html">Blank Page</a>
						</div>
					</div>
				</li>
	
				<!-- Divider -->
				<hr class="sidebar-divider d-none d-md-block" />
	
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
				<nav class="navbar navbar-expand navbar-light bg-primary topbar mb-4 static-top shadow w-100 d-xs-block d-md-none">
				
					<!-- Sidebar Toggle (Topbar) -->
					<ul class="navbar-nav">
					
						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown">
								<i class="fa fa-bars"></i>
								<span id="msgAlert" class="badge badge-danger badge-counter">N</span>
							</a>
							
							 <!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
								<a class="dropdown-item" href="#">
									<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 내 프로젝트 <span id="alert" class="badge badge-danger badge-counter">N</span>
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#"> 
									<i	class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 조은비
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#"> <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 전유진 </a>
							</div>
						</li>
					</ul>
					
					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1">
							<a class="nav-link" href="${pageContext.request.contextPath}/message/msg_index.jsp"> 
								<i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts --> <span id="msgAlert" class="badge badge-danger badge-counter">N</span>
							</a>
						</li>
						<div class="topbar-divider d-none d-sm-block"></div>
	
						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"> 
								<img class="img-profile rounded-circle" src="cdn/img/default_profile.png">
							</a> 
							
							<!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
								<a class="dropdown-item" href="#"> 
									<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 내 정보 보기
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item bg-info" href="#" data-toggle="modal" data-target="#logoutModal"> 
									<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									로그아웃
								</a>
							</div>
						</li>
					</ul>
				</nav>
				<!-- End of Topbar -->
				<!-- 메인 콘텐츠 시작 부분 -->
					<iframe id="iframe"  class =embed-responsive-item style="width:100%;height:100vh;border:none;border-left:1px" src="${pageContext.request.contextPath}/member/modifyInfo.jsp">
					</iframe>
				<!-- 메인 콘텐츠 끝 -->
			</div>
		</div>
	
		<script>
		function modifySiteMove(){
			$("#iframe").attr("src","${pageContext.request.contextPath}/member/modifyInfo.jsp");
		}	
		function logOutSiteMove(){
			$(location).attr('href', "${pageContext.request.contextPath}/logout.login");
		}
		function withdrawalSiteMove(){
			var result = confirm("정말  탈퇴 하시겠습니까?");
			if (result) {
				$(location).attr('href', "${pageContext.request.contextPath}/withdrawal.member");
			}
		}
		function viewProjectMove(){
			$("#iframe").attr("src","${pageContext.request.contextPath}/view.pro");
		}
		
		</script>
      </c:when>
      <c:otherwise>
         <script>
			location.href="index.jsp";
         </script>
      </c:otherwise>
   </c:choose>
	
</body>
</html>