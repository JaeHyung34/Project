<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="cdn/cdn.jsp" flush="false" />

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- crisp 메신저 -->
<script type="text/javascript">
		window.$crisp = [];
		window.CRISP_WEBSITE_ID = "91fe4c64-51fc-42bb-a431-0c5f4dd24861";
		(function() {
			d = document;
			s = d.createElement("script");
			s.src = "https://client.crisp.chat/l.js";
			s.async = 1;
			d.getElementsByTagName("head")[0].appendChild(s);
		})();
	</script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Start Index</title>
<link rel="stylesheet" href="cdn/css/start_main.css" type="text/css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<!-- wow CDN -->
<script src="cdn/WOW-master/WOW-master/dist/wow.min.js"></script>
<script>
        new WOW().init();
    </script>
<!-- CSS animate CDN -->
<link rel="stylesheet" type="text/css" href="cdn/css/animate.css">
<link rel="stylesheet" type="text/css" href="cdn/css/index.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style>
	.todaycounter, .totalcounter, .projectcounter, .sharecounter {
		font-size: 50px;
		font-weight: 500;
		width: 200px;
		height: 200px;
		vertical-align: middle;
		line-height: 100px;
		text-align: center;
		padding-top: 45px;
	}x
	.card-title {
		text-align: center;
	}
</style>

</head>
<body>

	<div class="container-fluid ml-0 mr-0 px-0">
		<div class="top wow fadeIn fixed-top" data-wow-duration="2s">
			<button data-toggle="modal" data-target="#joinMenu" type="button"
				id="joinModalBtn" class="btn btn-lg float-right mt-5 mr-5">회원가입</button>
			<button data-toggle="modal" data-target="#loginMenu" type="button"
				id="loginModalBtn" class="btn btn-lg float-right mt-5 mr-5">로그인</button>
		</div>
		<div class="box1 wow fadeInUp" data-wow-duration="1s"></div>
		<div class="box2 wow fadeInUp" data-wow-duration="1s">
			<div class="card mb-12 w-100 text-light bg-dark h-200">
				<div class="row no-gutters d-flex justify-content-around">
					<div class="col-md-2">
						<div class="card-body bg-dark text-light">
							<h5 class="card-title">오늘의 방문자</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="todaycounter"
									data-count='${sessionScope.todayCount}'>0</div>
							</h1>
							<p class="card-text"></p>
						</div>
					</div>
					<div class="col-md-2">
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
					<div class="col-md-2">
						<div class="card-body">
							<h5 class="card-title">개설된 프로젝트</h5>
							<h1 class="card-text d-flex justify-content-center">
								<div class="projectcounter"
									data-count="${sessionScope.pro_totalCount}">0</div>
							</h1>
							<p class="card-text">
								<small class="text-muted"></small>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="box3 wow fadeInUp" data-wow-duration="1s"></div>
		</div>
	</div>


	<!-- 로그인 메뉴 -->
	<div class="modal fade" id="loginMenu" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalCenterTitle">Share O'
						Clock에 오신 것을 환영합니다!</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="user"
						action="${pageContext.request.contextPath}/member.login"
						method="post">
						<div class="form-group">
							<input type="email" required="required" name=mb_email
								class="form-control form-control-user" id="loginInputEmail"
								aria-describedby="emailHelp"
								placeholder="Enter Email Address...">
						</div>
						<div class="form-group">
							<input type="password" autocomplete="off" required="required"
								name=mb_pw class="form-control form-control-user"
								id="loginInputPassword" placeholder="Password">
						</div>
						<div class="form-group">
							<div class="custom-control custom-checkbox small">
								<input type="checkbox" class="custom-control-input"
									id="customCheck"> <label class="custom-control-label"
									for="customCheck">아이디 기억하기</label>
							</div>
						</div>
						<button class="btn btn-primary btn-user btn-block" id="loginBtn">로그인</button>
						<a href="naver.login" class="btn btn-naver btn-user btn-block">
							<img src="resources/img/naver_icon.PNG"
							style="width: 25px; height: 25px"> 네이버 로그인
						</a> <a href="javascript:loginWithKakao()" id="custom-login-btn"
							class="btn btn-kakao btn-user btn-block"> <img
							src="resources/img/kakao_icon.png"
							style="width: 25px; height: 25px"> 카카오 로그인
						</a>
						<hr>
						<div class="text-center">
							<a class="middle" href="#" onclick="forgetMove()">암호를 잊으셨나요?</a>
						</div>
						<div class="text-center">
							<a class="middle" href="#" onclick="signMove()">계정 생성하기</a>
						</div>
					</form>
				</div>
				<div class="modal-footer ">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원가입 메뉴 -->

	<div class="modal fade" id="joinMenu" tabindex="-1">
		<div class="modal-dialog modal-dialog">
			<div class="modal-content">
				<!-- join modal header -->
				<div class="modal-header">
					<div class="px-3">
						<h5 class="modal-title">회원가입</h5>
					</div>
					<button type="button" class="close bg-white border-0"
						data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<!-- join modal body -->
				<form class="user" onsubmit="return validate()"
					action="signMember.member" method="post">
					<div class="modal-body py-0">
						<div class="form-row">
							<div class="col-9 mt-2" id=signDivEmail>
								<label for="signInputEmail">이메일</label> <input type="text"
									id="signInputEmail" name=mb_email class="form-control"
									placeholder="이메일형식을 입력하세요" oninput=signEmailCheck()>
								<div class="valid-feedback ml-3">OK</div>
								<div class="invalid-feedback ml-3">Not Ok</div>
							</div>
							<div class="col-3 mt-2" id=signDivCertifiedSend>
								<label for="btn_emailCertifiedSend">메일전송</label> <input
									type=button class="btn btn-primary" id=btn_emailCertifiedSend
									value=전송>
							</div>
							<div class="form-row col-12 mb-0" id=signDivCertified>
								<div class="col-6 mb-4 mt-2">
									<input type="text" id="certifiedNumber" class="form-control"
										placeholder="인증번호를 입력하세요">
								</div>
								<div class="col-6 mb-4 mt-2">
									<input type=button class="btn btn-primary"
										id=btn_certifiedCheckSend value=인증>
								</div>
							</div>
							<div class="form-row col-12 mb-0" id=signDivPassword>
								<div class="col-6 mb-4 mt-2">
									<label for="">비밀번호</label> <input type="password"
										autocomplete="off" name=mb_pw id="signInputPassword"
										class="form-control" placeholder="비밀번호를 입력하세요"
										oninput=signPasswordCheck()>
									<div class="ml-3 valid-feedback">Yes</div>
									<div class="invalid-feedback ml-3">Not Ok</div>
								</div>
								<div class="col-6 mb-4 mt-2">
									<label for="signRepeatPassword">비밀번호 확인</label> <input
										type="password" id="signRepeatPassword" autocomplete="off"
										class="form-control" placeholder="비밀번호 확인"
										oninput=signRepeatPasswordCheck()>
									<div class="valid-feedback ml-3">Ok</div>
									<div class="invalid-feedback ml-3">Not Ok</div>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group">
						<div class="form-row col-12">
							<div class="col-6">
								<label for="">아이디</label> <input type="text" id=signInputID
									name="mb_nickname" class="form-control"
									placeholder="고유한 아이디를 입력하세요" oninput=signNickNameCheck()>
								<div class="valid-feedback ml-3">Ok</div>
								<div class="invalid-feedback ml-3">Not Ok</div>
							</div>
							<div class="col-6">
								<label for="">이름</label> <input type="text" id="signInputName"
									name="mb_name" class="form-control" placeholder="이름을 입력하세요"
									oninput=signNameCheck()>
								<div class="valid-feedback ml-3">Ok</div>
								<div class="invalid-feedback ml-3">Not Ok</div>
							</div>
						</div>
						<div class="form-row col-12 mt-2">
							<label for="">전화번호</label> <input type="text" id="signInputPhone"
								name=mb_phone class="form-control" placeholder="전화번호를 입력하세요"
								oninput=signPhoneCheck()>
							<div class="valid-feedback ml-3">Ok</div>
							<div class="invalid-feedback ml-3">Not Ok</div>
						</div>
						<div class="form-row col-12 mt-2">
							<label for="">그룹</label> <input type="text" id="signInputGroup"
								name=mb_group class="form-control"
								placeholder="소속을 입력해주세요(없으면 비워주세요)" oninput=signGroupCheck()>
							<div class="valid-feedback ml-3">Ok</div>
							<div class="invalid-feedback ml-3">Not Ok</div>
						</div>
					</div>
					<div class="modal-footer">
						<!-- join modal footer -->
						<button class="btn btn-primary" id=btn_signInfoSend>제출</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 비밀번호 값 이메일로 전달-->

	<div class="modal fade" id="forgetPwMenu" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="forgetPwModalCenterTitle">Share O'
						Clock에 오신 것을 환영합니다!</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="card o-hidden border-0 shadow-lg my-5">
						<div class="card-body p-0">
							<!-- Nested Row within Card Body -->
							<div class="row">
								<div class="col-lg-12">
									<div class="p-5">
										<div class="text-center">
											<h1 class="h4 text-gray-900 mb-2">비밀번호를 잊으셨습니까?</h1>
											<p class="mb-4">이메일 주소를 보내시면 비밀번호를 보내드리겠습니다!</p>
										</div>
										<form class="user">
											<div class="form-group">
												<input type="email" class="form-control form-control-user"
													id="forgetPwInputEmail" aria-describedby="emailHelp"
													placeholder="이메일 주소를 입력하세요...">
											</div>
											<a class="btn btn-primary btn-user btn-block"
												id="btn_forgetEmailSend"> 비밀번호 초기화 </a>
										</form>
										<hr>
										<div class="text-center">
											<a class="small" href="#" onclick="signMove()">계정 생성하기</a>
										</div>
										<div class="text-center">
											<a class="small" href="#" onclick="loginMove()">계정이 이미
												있습니까? 로그인하세요! </a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer ">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
<!-- Footer -->
<footer class="page-footer font-small stylish-color-dark pt-4">

  <!-- Footer Links -->

   
    <!-- Grid row -->
    <div class="row mt-3">

      <!-- Grid column -->
      <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">

        <!-- Content -->
        <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
        <p>Here you can use rows and columns to organize your footer content. Lorem ipsum dolor sit amet,
          consectetur
          adipisicing elit.</p>

      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">

        <!-- Links -->
        <h6 class="text-uppercase font-weight-bold">사이트소개</h6>
        <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
        <p>
          <a href="#!">사용 방법</a>
        </p>
        <p>
          <a href="#!">방문자확인</a>
        </p>
        <p>
          <a href="#!">사원소개</a>
        </p>

      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">

        <!-- Links -->
        <h6 class="text-uppercase font-weight-bold">참고 사이트</h6>
        <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
        <p>
          <a href="ttps://www.naver.com">Naver</a>
        </p>
        <p>
          <a href="https://www.daum.net">Daum</a>
        </p>
        <p>
          <a href="https://www.google.co.kr/">Google</a>
        </p>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
      <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">

        <!-- Links -->
        <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
        <p>
          <i class="fas fa-home mr-3"></i> 서울특별시 중구 남대문로 120 대일빌딩 </p>
        <p>
          <i class="fas fa-envelope mr-3"></i> shareOclock@naver.com</p>
        <p>
          <i class="fas fa-phone mr-3"></i> + 1544 - 9970</p>
        <p>
          <i class="fas fa-print mr-3"></i> + 010 - 1234 - 1234</p>

      </div>
      <!-- Grid column -->

    </div>
    <!-- Grid row -->


  </div>
  <!-- Footer Links -->

  <hr>

  <!-- Call to action -->
  <ul class="list-unstyled list-inline text-center py-2">
    <li class="list-inline-item">
      <h5 class="mb-1">Register for free</h5>
    </li>
    <li class="list-inline-item">
      <a href="#!" class="btn btn-danger btn-rounded">Sign up!</a>
    </li>
  </ul>
  <!-- Call to action -->

  <hr>

  <!-- Social buttons -->
  <ul class="list-unstyled list-inline text-center">
    <li class="list-inline-item">
      <a class="btn-floating btn-fb mx-1">
        <i class="fab fa-facebook-f"> </i>
      </a>
    </li>
    <li class="list-inline-item">
      <a class="btn-floating btn-tw mx-1">
        <i class="fab fa-twitter"> </i>
      </a>
    </li>
    <li class="list-inline-item">
      <a class="btn-floating btn-gplus mx-1">
        <i class="fab fa-google-plus-g"> </i>
      </a>
    </li>
    <li class="list-inline-item">
      <a class="btn-floating btn-li mx-1">
        <i class="fab fa-linkedin-in"> </i>
      </a>
    </li>
    <li class="list-inline-item">
      <a class="btn-floating btn-dribbble mx-1">
        <i class="fab fa-dribbble"> </i>
      </a>
    </li>
  </ul>
  <!-- Social buttons -->

  <!-- Copyright -->
  <div class="footer-copyright text-center py-3">© 2020 Copyright:
    <a href="https://mdbootstrap.com/education/bootstrap/"> ShareOClock.com</a>
  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->


	<script>
		$('.todaycounter').each(function() {
			var $this = $(this), countTo = $this.attr('data-count');
	
			$({
				countNum : $this.text()
			}).animate({
				countNum : countTo
			},
	
			{
	
				duration : 2000,
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
	
				duration : 2000,
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
	
				duration : 2000,
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
	    var emailCheck = true;
	    var idCheck = true;
	    $(document).ready(function(){
	    	var naverInfo = '${naverInfo}';
	    	console.log('${naverInfo}');
	    	if(naverInfo != null && naverInfo != "" ){
	    		$('#joinMenu').modal({
					keyboard: true,
		            show: true
				});
	            $("#signInputEmail").attr('readonly',true);
	            $("#signDivEmail").attr('class','col-12 mt-2');
	            $("#signDivCertifiedSend").hide();
	            $("#signDivPassword").hide();
	            $("#signDivCertified").hide();
				$("#signInputEmail").val('${naverInfo.mb_email}');
				$("#signInputID").val('${naverInfo.mb_nickname}');
				$("#signInputName").val('${naverInfo.mb_name}');
				signNickNameCheck();
				signNameCheck();
	            $("#signInputPassword").attr('disabled',true);
	            naverKakao = true;
	            checkCertified = true;
	    	}else{
	            $("#signInputPassword").attr('disabled',false);
	            $("#signInputEmail").removeAttr('readonly');
	            $("#signDivEmail").attr('class','col-8 mt-2');
	            $("#signDivPassword").show();
	            $("#signDivCertifiedSend").show();
	            $("#signDivCertified").show();  
	    		//alert("네이버아디없당");
	            naverKakao = false;
	            checkCertified = false;
	
	    	}
	    }) 
	    //	회원가입시 정규식 체크부분
	
	    function validate() {
		    	console.log("emailCheck : "+ emailCheck);
		    	console.log("idCheck : "+ idCheck);
				var getMail =  RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
			    var getPw= RegExp(/^[A-Za-z0-9]{6,15}$/);
			    var getId = RegExp(/^[A-Za-z0-9]{5,12}$/);
			    var getName = RegExp(/^[가-힣A-Za-z]+$/);
			    var getPhone = RegExp(/^\d{2,3}\d{3,4}\d{4}$/); //형식 설정
			    
			    //이메일 공백 확인
			    if($("#signInputEmail").val() == ""){
			      alert("이메일 입력해주세요");
			      $("#signInputEmail").focus();
			      return false;
			    }
			    //이메일 유효성 검사
			    if(!getMail.test($("#signInputEmail").val()) && !naverKakao){
			      alert("이메일 형식에 맞게 작성해주세요.2");
			      $("#signInputEmail").val("");
			      $("#signInputEmail").focus();
			      return false;
			    }
			    if(!emailCheck){
				    alert("이메일이 중복되었습니다 확인해주세요.");
			    	return false;
			    }		 
				if(!checkCertified){
					alert("비밀번호 인증을 해주세요");
				    return false;
	
				}
			    //비밀번호 공백 확인
			    console.log($("#signInputPassword").val() );
			    if($("#signInputPassword").val() == "" && !naverKakao){
			      alert("비밀번호 입력해주세요");
			      $("#signInputPassword").focus();
			      return false;
			    }
			    //비밀번호 유효성 검사
			    if(!getPw.test($("#signInputPassword").val()) && !naverKakao) {
				    alert("6~15 자리로 입력해주세요.(영어,숫자만 가능합니다.)");
				    $("#signInputPassword").val("");
				    $("#signInputPassword").focus();
				    return false;
			    }
			    //이메일과 비밀번호랑 같은지
			    if ($("#signInputEmail").val()==($("#signInputPassword").val())  && !naverKakao) {
			    alert("이메일과 비밀번호가 같습니다 확인해주세요.");
			    $("#signInputPassword").val("");
			    $("#signInputPassword").focus();
			    return false;
			    }
			    //비밀번호와 확인이 같은지
			    if($("#signInputPassword").val() != ($("#signRepeatPassword").val())  && !naverKakao){ 
			    alert("비밀번호가 같지않습니다.");
			    $("#signInputPassword").val("");
			    $("#signRepeatPassword").val("");
			    $("#signInputPassword").focus();
			    return false;
			   }
			   //아이디 공백 확인
			    if($("#signInputID").val() == ""){
			      alert("아이디를 입력해주세요");
			      $("#signInputID").focus();
			      return false;
			    }
			    //아이디 유효성 검사
			    if(!getId.test($("#signInputID").val())){
			      alert("5~12 자리수로 아이디를 입력해주세요.")
			      $("#signInputID").val("");
			      $("#signInputID").focus();
			      return false;
			    }
			    
			    if(!idCheck){
				    alert("아이디가 중복되었습니다 확인해주세요.");
					$("#signInputID").focus();
			    	return false;
			    }
	
			    //이름 공백 확인
			    if($("#signInputName").val() == ""){
			        alert("이름을 입력해주세요");
			        $("#signInputName").focus();
			        return false;
			      }
			    //이름 유효성 검사
			    if (!getName.test($("#signInputName").val())) {
			      alert("이름을 제대로 입력해주세요");
			      $("#signInputName").val("");
			      $("#signInputName").focus();
			      return false;
			    }
			    //전화번호 공백 확인
			    if($("#signInputPhone").val() == ""){
			        alert("전화번호를 입력해주세요");
			        $("#signInputPhone").focus();
			        return false;
			      }
			    //전화번호 유효성 검사
			    if (!getPhone.test($("#signInputPhone").val())) {
			      alert("전화번호를 제대로 입력해주세요");
			      $("#signInputPhone").val("");
			      $("#signInputPhone").focus();
			      return false;
			    }
	
				return true;
			  }
	 		// 모달 이동 제어부분
			function signEmailCheck() {
			    var getMail =  RegExp(/[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/i);

	 			if(!getMail.test($("#signInputEmail").val()) && !naverKakao){
					emailCheck = false;	
					$("#signInputEmail").next().next().text("이메일 형식에 맞게 입력해주세요.");
					$("#signInputEmail").removeClass("is-valid");
					$("#signInputEmail").addClass("is-invalid");
				}else{
					$("#signInputEmail").removeClass("is-invalid");
					$("#signInputEmail").addClass("is-valid");
					$.ajax({ 
						url: "emailOverlapCheck.member", 
						data: { mb_email: $("#signInputEmail").val()}, 
						method: "post", 
						dataType: "json",
				        async:false
					}).done(function(data){ 
						console.log("emailOverlapCheck  :  " + data);
						if(data){
							emailCheck = false;					
							$("#signInputEmail").removeClass("is-valid");
							$("#signInputEmail").addClass("is-invalid");
							$("#signInputEmail").next().next().text("이메일이 중복되었습니다.");
	
						}else{
							emailCheck = true;
							
						}
					}).fail(function(){ 
						alert("서버오류!!");
					});
				}
			    
			};	
			function signNickNameCheck() {
			    $.ajax({ 
					url: "nickNameOverlapCheck.member", 
					data: {	mb_nickname: $("#signInputID").val()}, 
					method: "post", 
					dataType: "json",
			        async:false
				}).done(function(data){ 
					console.log(data);
					var getId = RegExp(/^[A-Za-z0-9]{5,12}$/);
	
					if(data){
	
						idCheck = false;					
						$("#signInputID").removeClass("is-valid");
						$("#signInputID").addClass("is-invalid");
						$("#signInputID").next().next().text("아이디가 중복되었습니다.");
	
					}else{
						
						console.log("여기실행인데   "+getId.test($("#signInputID").val()));
	
						idCheck = true;
						if(getId.test($("#signInputID").val())){
							$("#signInputID").removeClass("is-invalid");
							$("#signInputID").addClass("is-valid");
						}else{
							$("#signInputID").next().next().text("영어 숫자 5~12만 가능합니다");
							$("#signInputID").removeClass("is-valid");
							$("#signInputID").addClass("is-invalid");
						}
					}
					return true;
				}).fail(function(){ 
					alert("서버오류!!");
				});
			};
	
			function signRepeatPasswordCheck() {
				var getPw= RegExp(/^[A-Za-z0-9]{6,15}$/);
				if(getPw.test($("#signRepeatPassword").val())){
					$("#signRepeatPassword").removeClass("is-invalid");
					$("#signRepeatPassword").addClass("is-valid");
				}else{
					$("#signRepeatPassword").removeClass("is-valid");
					$("#signRepeatPassword").addClass("is-invalid");
					$("#signRepeatPassword").next().next().text("영어 또는 숫자로 6~15");
				}
			}
	
			function signNameCheck() {
				 var getName = RegExp(/^[가-힣A-Za-z]{2,15}$/);
				if(getName.test($("#signInputName").val())){
					$("#signInputName").removeClass("is-invalid");
					$("#signInputName").addClass("is-valid");
				}else{
					$("#signInputName").removeClass("is-valid");
					$("#signInputName").addClass("is-invalid");
					$("#signInputName").next().next().text("한글 영어 숫자로 2~15");
				}
			}
	
			function signGroupCheck() {
				$("#signInputGroup").removeClass("is-invalid");
				$("#signInputGroup").addClass("is-valid");
			}
	
			function signPhoneCheck() {
			    var getPhone = RegExp(/^\d{2,3}\d{3,4}\d{4}$/); //형식 설정
				if(getPhone.test($("#signInputPhone").val())){
					$("#signInputPhone").removeClass("is-invalid");
					$("#signInputPhone").addClass("is-valid");
				}else{
					$("#signInputPhone").removeClass("is-valid");
					$("#signInputPhone").addClass("is-invalid");
					$("#signInputPhone").next().next().text("전화번호를 입력해주세요");
				}
			}
			
			function signPasswordCheck() {
				var getPw= RegExp(/^[A-Za-z0-9]{6,15}$/);
				console.log("여기가실행5   " + getPw.test($("#signInputPassword").val()));
				if(getPw.test($("#signInputPassword").val())){
					$("#signInputPassword").removeClass("is-invalid");
					$("#signInputPassword").addClass("is-valid");
				}else{
					$("#signInputPassword").removeClass("is-valid");
					$("#signInputPassword").addClass("is-invalid");
					$("#signInputPassword").next().next().text("영어 또는 숫자로 6~15");
				}
			};
			function forgetMove() {
				$('#loginMenu').modal('hide');
				$('#joinMenu').modal('hide');
				$('#forgetPwMenu').modal({
					keyboard: true,
		            show: true
				});
			};
			function signMove() {
				$('#loginMenu').modal('hide');
				$('#forgetPwMenu').modal('hide');
				$('#joinMenu').modal({
					keyboard: true,
		            show: true
				});
			};
			function loginMove() {
				$('#joinMenu').modal('hide');
				$('#forgetPwMenu').modal('hide');
				$('#loginMenu').modal({
					keyboard: true,
		            show: true
				});
			};
			
			
			// 아이디 저장하는 쿠키 생성 및 부르는 부분
		  	function cookieAsJSON() {
				var cookieJSON = {};
				var cookie = document.cookie;
				var trimedCookie = cookie.replace(/ /g, "");
				var entryArr = trimedCookie.split(";");
				for (var i = 0; i < entryArr.length; i++) {
					var entry = entryArr[i].split("=");
					cookieJSON[entry[0]] = entry[1];
				}
				return cookieJSON;
			};
			$(function() {
				if (document.cookie != "") {
					var cookie = cookieAsJSON();
					$("#loginInputEmail").val(cookie.id);
					$("#customCheck").prop("checked", "true");
				}
			});
			$("#loginBtn").on("click",function(){
				var exDate = new Date();
				if ($("#customCheck").prop("checked")) {
					exDate.setDate(exDate.getDate() + 30);
					var id = $("#loginInputEmail").val();
					document.cookie = "id=" + id + ";expires=" + exDate.toString();
				} else {
					exDate.setDate(exDate.getDate() - 1);
					document.cookie = "id=;expires=" + exDate.toString();
				}
			})
			$("#customCheck").on("change", function() {
				var exDate = new Date();
				if ($("#customCheck").prop("checked")) {
					exDate.setDate(exDate.getDate() + 30);
					var id = $("#loginInputEmail").val();
					document.cookie = "id=" + id + ";expires=" + exDate.toString();
				} else {
					exDate.setDate(exDate.getDate() - 1);
					document.cookie = "id=;expires=" + exDate.toString();
				}
			});
			
			
			// 비밀번호 찾는 모달창 버튼 클릭시
			 $("#btn_forgetEmailSend").on("click",function(){
					var email = $("#forgetPwInputEmail").val();
					if(email != ""){
						$.ajax({ 
							url: "forgetPassword.member", 
							data: { email: email }, 
							method: "post", 
							dataType: "json" 
						}).done(function(data){ 
							console.log(data);
							if(data){
								alert("성공적으로 이메일을 전송하였습니다 이메일을 확인해주세요.");
							}else{
								alert("이메일을 전송하지 못했습니다. 작성하신 이메일을 확인해주세요.");
							}
						}).fail(function(){ 
							alert("서버오류!!");
							$(location).attr("href", "/login.jsp");
						});
					}else{
						alert("이메일을 입력해주세요.");
					}
			  })
			  
			 $("#btn_emailCertifiedSend").on("click",function(){
				var email = $("#signInputEmail").val();
				console.log("이메일전송중~3    :   " + emailCheck);
				if(email != "" && emailCheck==true){
					$.ajax({ 
						url: "emailCertifiedSend.member", 
						data: { email: email }, 
						method: "post", 
						dataType: "json" 
					}).done(function(data){ 
						console.log(data);
						if(data){
							alert("이메일을 전송하였습니다. 확인해주세요");
						}
					}).fail(function(){ 
						alert("서버오류!!");
					});
				}else{
					alert("이메일을 입력 또는 형식에 맞게 입력해주세요.");
				}
			 })
		    
	  		 $("#btn_certifiedCheckSend").on("click",function(){
				var number = $("#certifiedNumber").val();
				if(number != ""){
					$.ajax({ 
						url: "emailCheck.member", 
						data: { number: number }, 
						method: "post", 
						dataType: "json" 
					}).done(function(data){ 
						console.log(data);
						if(data){
							alert("성공적으로 인증되었습니다.");
				            $("#signInputEmail").attr('readonly',true);
				            $("#signDivCertifiedSend").hide();
				            $("#signDivCertified").hide();
				            checkCertified = true;
						}
					}).fail(function(){ 
						alert("서버오류!!");
						$(location).attr("href", "/login.jsp");
					});
				}else{
					alert("이메일을 입력해주세요.");
				}
		  	})
	  	</script>

	<script type='text/javascript'>
	  //<![CDATA[
	    // 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('38b031e1013e4101511e461da920af47');
	    

	    function loginWithKakao() {

			$("#signInputEmail").val('');
			$("#signInputID").val('');
			$("#signInputName").val('');
		      // 로그인 창을 띄웁니다.
		      Kakao.Auth.login({
		        success: function(authObj) {
		        	Kakao.API.request({
			          url: '/v2/user/me',
			          success: function(res) {
			        	console.log(res);
			        	console.log("수정2");
			            alert(JSON.stringify(res));

			            naverKakao = true;
			            checkCertified = true;
			            $("#signInputEmail").attr('readonly',true);
			            $("#signDivEmail").attr('class','col-12 mt-2')
			            $("#signDivCertifiedSend").hide();
			            $("#signDivCertified").hide();
						$("#signInputEmail").val(res.id);
						$("#signInputName").val(res.properties.nickname);

						signEmailCheck();
			            console.log("kakaoemailCheck  :  " + emailCheck);
			            $("#signDivPassword").attr('disabled',true);
			            $("#signDivPassword").hide();

			            //  res.id
					    if(!emailCheck){
					    	  $.ajax({ 
									url: "kakao.login", 
									data: { mb_email: $("#signInputEmail").val()}, 
									method: "post",
									dataType: "json"
								}).done(function(data){ 
									console.log(data);
									$(location).attr("href", data);
									
								}).fail(function(){ 
									alert("서버오류!!");
								});
					    }		    
			            signMove();

					  },
			          fail: function(error) {
			            alert(JSON.stringify(error));
			          }
				  	});
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
	    };
	  //]]>.
	</script>

</body>
</html>