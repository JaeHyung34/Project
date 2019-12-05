package shareOclock.member;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("*.member")
public class MemberController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
    	String reqURI = request.getRequestURI();
		String Path = request.getContextPath();
		String realpath = reqURI.substring(Path.length());
		System.out.println("reqURI" + realpath );
        
		if(realpath.contentEquals("/forgetPassword.member")) {
			// 이메일 체크하는 부분
			String email = request.getParameter("email");
			System.out.println(email);
			boolean result = false;
			try {
				result = MemberDAO.getInstance().emailCheck(email);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(result) {
				//mail server 설정
				String host = "smtp.naver.com";   // 해당 이름으로 smpt 서버 만들것
				String user = "lov3112"; 			//자신의 네이버 계정
				String password = "1q2w3e4R";//자신의 네이버 패스워드
				//메일 받을 주소
				String to_email = email;
				//SMTP 서버 정보를 설정한다.
				Properties props = new Properties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", 465);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "true");

				//인증 번호 생성기
				StringBuffer temp =new StringBuffer();
				Random rnd = new Random();
				for(int i=0;i<10;i++){
					int rIndex = rnd.nextInt(3);
					switch (rIndex) {
					case 0:
						// a-z
						temp.append((char) ((int) (rnd.nextInt(26)) + 97));
						break;
					case 1:
						// A-Z
						temp.append((char) ((int) (rnd.nextInt(26)) + 65));
						break;
					case 2:
						// 0-9
						temp.append((rnd.nextInt(10)));
						break;
					}
				}
				String AuthenticationKey = temp.toString();

				try {
					int modify = MemberDAO.getInstance().modifyPw(email, AuthenticationKey);
					if(modify > 0) {
						Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(user,password);
							}
						});
						//email 전송
						MimeMessage msg = new MimeMessage(session);
						msg.setFrom(new InternetAddress(user, "ShareOclock"));
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
						//메일 제목
						msg.setSubject("안녕하세요 Share O'Clock 인증 메일입니다.");
						//메일 내용
						msg.setText("인증 번호는 :"+temp);
						Transport.send(msg);
						System.out.println("이메일 전송");
						System.out.println(AuthenticationKey);

					}
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			Gson gson = new Gson();
			String resultJSON = gson.toJson(result);
			response.getWriter().append(resultJSON);
		}else if(realpath.contentEquals("/emailCertifiedSend.member")) {
			// 이메일 체크하는 부분
			String email = request.getParameter("email");
			System.out.println(email);
			boolean result = false;
			//mail server 설정
			String host = "smtp.naver.com";   // 해당 이름으로 smpt 서버 만들것
			String user = "lov3112"; 			//자신의 네이버 계정
			String password = "1q2w3e4R";//자신의 네이버 패스워드
			//메일 받을 주소
			String to_email = email;
			//SMTP 서버 정보를 설정한다.
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", 465);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");

			//인증 번호 생성기
			StringBuffer temp =new StringBuffer();
			Random rnd = new Random();
			for(int i=0;i<10;i++){
				int rIndex = rnd.nextInt(3);
				switch (rIndex) {
				case 0:
					// a-z
					temp.append((char) ((int) (rnd.nextInt(26)) + 97));
					break;
				case 1:
					// A-Z
					temp.append((char) ((int) (rnd.nextInt(26)) + 65));
					break;
				case 2:
					// 0-9
					temp.append((rnd.nextInt(10)));
					break;
				}
			}
			String AuthenticationKey = temp.toString();
			try {
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(user,password);
					}
				});
				//email 전송
				MimeMessage msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(user, "ShareOclock"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
				//메일 제목
				msg.setSubject("안녕하세요 Share O'Clock 인증 메일입니다.");
				//메일 내용
				msg.setText("인증 번호는 :"+temp);
				Transport.send(msg);
				System.out.println("이메일 전송");
				System.out.println(AuthenticationKey);
			 	result = true;
			}catch (Exception e) {
				e.printStackTrace();
			}
			Gson gson = new Gson();
			String resultJSON = gson.toJson(result);
			response.getWriter().append(resultJSON);
			request.getSession().setAttribute("emailCertified", AuthenticationKey); // 로그인정보
		}else if(realpath.contentEquals("/emailCheck.member")) {
			// 이메일 체크하는 부분
		    String emailCertified = (String) request.getSession().getAttribute("emailCertified");
			String number = request.getParameter("number");
			boolean result = false;
			if(emailCertified != null && number != null) {
				if(emailCertified.equals(number)) {
					result = true;
				}
			}
			request.getSession().invalidate();
			Gson gson = new Gson();
			String resultJSON = gson.toJson(result);
			response.getWriter().append(resultJSON);
			
		}else if(realpath.contentEquals("/signMember.member")) {
			String mb_email = request.getParameter("mb_email");
			String mb_pw = request.getParameter("mb_pw");
			String mb_name = request.getParameter("mb_name");
			String mb_nickname = request.getParameter("mb_nickname");
			String mb_group = request.getParameter("mb_group");
			String mb_phone = request.getParameter("mb_phone");
			System.out.println(mb_email+" : " + mb_nickname + " : 회원가입"+mb_pw);
			if(mb_pw == null || mb_pw == "" ) {
				mb_pw = "naverKakao";
			}
			System.out.println("naverKakao"+mb_pw);
			MemberDTO dto = new MemberDTO(mb_email, mb_pw, mb_name, mb_nickname, mb_group, mb_phone, "M");
			int result = 0;
			try {
				result = MemberDAO.getInstance().insert(dto);
				if(result > 0) {
//					Gson gson = new Gson();
//					String resultJSON = gson.toJson(1result);
					request.getSession().setAttribute("signupCheck", mb_name); // signupCheck 정보 넘기는곳
					response.sendRedirect("/Project/member/signupCheck.jsp");
				}
			} catch (Exception e) {	
				System.out.print("DB 오류다");
				e.printStackTrace();
			}
		}else if(realpath.contentEquals("/emailOverlapCheck.member")) {
			String mb_email = request.getParameter("mb_email");
			System.out.println(mb_email+" : ");
			boolean result = false;
			try {
				result = MemberDAO.getInstance().emailCheck(mb_email);
				Gson gson = new Gson();
				String resultJSON = "";
				System.out.println("현재 이메일 체크  " + result);
				resultJSON = gson.toJson(result);
				response.getWriter().append(resultJSON);
			} catch (Exception e) {	
				System.out.print("DB 오류다");
				e.printStackTrace();
			}
		}else if(realpath.contentEquals("/nickNameOverlapCheck.member")) {
			String mb_nickname = request.getParameter("mb_nickname");
			System.out.println(" : " + mb_nickname);
			boolean result = false;
			try {
				result = MemberDAO.getInstance().nickNameCheck(mb_nickname);
				Gson gson = new Gson();
				String resultJSON = "";
				resultJSON = gson.toJson(result);
				response.getWriter().append(resultJSON);
			} catch (Exception e) {	
				System.out.print("DB 오류다");
				e.printStackTrace();
			}
		}else if(realpath.contentEquals("/member/modify.member")) {
			String mb_email = request.getParameter("mb_email");
			String mb_pw = request.getParameter("mb_pw");
			String mb_name = request.getParameter("mb_name");
			String mb_nickName = request.getParameter("mb_nickName");
			String mb_group = request.getParameter("mb_group");
			String mb_phone = request.getParameter("mb_phone");
			MemberDTO dto = new MemberDTO(mb_email, mb_pw, mb_name, mb_nickName, mb_group, mb_phone, "A");
			int result = 0;
			try {
				result = MemberDAO.getInstance().modifyMember(dto);
				if(result > 0) {
//					Gson gson = new Gson();
//					String resultJSON = gson.toJson(result);
					request.getSession().setAttribute("modifyCheck", result); // 로그인정보
					response.sendRedirect("/Project/member/modifyCheck.jsp");
				}
			} catch (Exception e) {	
				System.out.print("DB 오류다");
				e.printStackTrace();
			}
		}else if(realpath.contentEquals("/member/myInfo.member")) {	
		    String mb_nickName = (String) request.getSession().getAttribute("loginInfo");
			MemberDTO dto = null;
			System.out.println("mb_nickName"+mb_nickName);
			try {
				dto = MemberDAO.getInstance().selectInfo(mb_nickName);		
				request.setAttribute("dto", dto);
				System.out.println("mb_nickName"+dto.getMb_email());

			} catch (Exception e) {
				e.printStackTrace();
			}					
			Gson gson = new Gson();
			String resultJSON = gson.toJson(dto);
			response.getWriter().append(resultJSON);
		}else if(realpath.contentEquals("/withdrawal.member")) {
		    String mb_nickName = (String) request.getSession().getAttribute("loginInfo");
			int result = 0;
			System.out.println("mb_nickName" + mb_nickName);
			try {
				result = MemberDAO.getInstance().deleteMember(mb_nickName);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getSession().invalidate();
			request.getSession().setAttribute("withdrawalCheck", true);
			response.sendRedirect("/Project/member/withdrawalCheck.jsp");
		}
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
