package shareOclock.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader ;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import configuration.Utils;

@WebServlet("*.login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqURI = request.getRequestURI();
		String Path = request.getContextPath();
		String realpath = reqURI.substring(Path.length());
		System.out.println(realpath);

		if(realpath.contentEquals("/naver.login")) {
		    String clientId = "lx_KvvNWm6q8tm8wfE0E";//애플리케이션 클라이언트 아이디값";
		    String redirectURI = URLEncoder.encode("http://192.168.60.7/Project/callback.login", "UTF-8");
		    SecureRandom random = new SecureRandom();
		    String state = new BigInteger(130, random).toString();
		    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		    apiURL += "&client_id=" + clientId;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&state=" + state;
			request.getSession().setAttribute("state", state);
			response.sendRedirect(apiURL);
		}else if(realpath.contentEquals("/kakao.login")) {
			String email = request.getParameter("mb_email");
			String pw = "naverKakao";
			System.out.println(email +" :  kakao" );
			MemberDTO result = null;
			if(email != null) {
				try {
					result = MemberDAO.getInstance().getLogin(email, Utils.encrpyt(pw));
					System.out.println(result +" kakako");
					if(result != null) {
						request.getSession().setAttribute("loginInfo", result.getMb_nickname()); 
					}
					Gson gson = new Gson();
					String resultJSON = "";
					resultJSON = gson.toJson("/Project/member/loginCheck.jsp");
					response.getWriter().append(resultJSON);
					System.out.println("로그인성공??");

				}catch(Exception e) {
					System.out.print("DB 오류");
					e.printStackTrace();
				}
			}
		}else if(realpath.contentEquals("/member.login")) {
			String email = request.getParameter("mb_email");
			String pw = request.getParameter("mb_pw");
			System.out.println(email +" :  " + pw);
			MemberDTO result = null;
			if(email != null && pw != null) {
				try {
					result = MemberDAO.getInstance().getLogin(email, Utils.encrpyt(pw));
					if(result != null) {
						System.out.println("로그인성공??");
						if(result.getMb_check().equals("A")) {
							request.getSession().setAttribute("ManagerInfo", result.getMb_nickname()); 

						}else {
							request.getSession().setAttribute("loginInfo", result.getMb_nickname()); 
						}
					}
					response.sendRedirect("/Project/member/loginCheck.jsp");
				}catch(Exception e) {
					System.out.print("DB 오류");
					e.printStackTrace();
				}
			}
		}else if(realpath.contentEquals("/logout.login")) {
			request.getSession().invalidate();
			System.out.println("로그아웃되었습니당 세션삭제 완료");
			request.getSession().setAttribute("logOutCheck", true); // logOutCheck 정보 넘기는곳
			response.sendRedirect("/Project/member/logOutCheck.jsp");
		}else if(realpath.contentEquals("/removelogIOut.login")) {		// 안쓰면 지움
			request.getSession().invalidate();
			System.out.println("모두삭제되었습니당 세션삭제 완료");
			response.sendRedirect("/Project/index.jsp");
		}else if(realpath.contentEquals("/callback.login")) {
			String check =  (String) request.getSession().getAttribute("state");
			System.out.println(check);
			if(check != null){
				String clientId = "lx_KvvNWm6q8tm8wfE0E";//애플리케이션 클라이언트 아이디값";
			    String clientSecret = "ihAmfvwBdR";//애플리케이션 클라이언트 시크릿값";
			    String code = request.getParameter("code");
			    String state = request.getParameter("state");
			    String redirectURI = URLEncoder.encode("http://localhost:8080/ProjectManager/callback.jsp", "UTF-8");
			    String apiURL;
			    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			    apiURL += "client_id=" + clientId;
			    apiURL += "&client_secret=" + clientSecret;
			    apiURL += "&redirect_uri=" + redirectURI;
			    apiURL += "&code=" + code;
			    apiURL += "&state=" + state;
			    String access_token = "";
			    String refresh_token = "";
			    System.out.println("apiURL="+apiURL);
			    try {
			      URL url = new URL(apiURL);
			      HttpURLConnection con = (HttpURLConnection)url.openConnection();
			      con.setRequestMethod("GET");
			      int responseCode = con.getResponseCode();
			      BufferedReader br;
			      if(responseCode==200) { // 정상 호출
			        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			      } else {  // 에러 발생
			        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			      }
			      String inputLine;
			      StringBuffer res = new StringBuffer();
			      while ((inputLine = br.readLine()) != null) {
			        res.append(inputLine);
			      }
			      br.close();
			      if(responseCode==200) {
			    	JsonParser parser = new JsonParser();
					JsonElement element = parser.parse(res.toString());
					String token = element.getAsJsonObject().get("access_token").getAsString();
					String header = "Bearer " + token; 
					try {
						apiURL = "https://openapi.naver.com/v1/nid/me";
						url = new URL(apiURL);
						con = (HttpURLConnection)url.openConnection();
						con.setRequestMethod("GET");
						con.setRequestProperty("Authorization", header);
						responseCode = con.getResponseCode();
						BufferedReader br2;
						if(responseCode==200) {
							br2 = new BufferedReader(new InputStreamReader(con.getInputStream()));
						} else { 
							br2 = new BufferedReader(new InputStreamReader(con.getErrorStream()));
						}
						StringBuffer responseBuffer = new StringBuffer();
						while ((inputLine = br2.readLine()) != null) {
							responseBuffer.append(inputLine);
						}
						br2.close();
				 		JsonElement data = parser.parse(responseBuffer.toString());
				 		String mb_nickname = data.getAsJsonObject().get("response").getAsJsonObject().get("id").getAsString();
				 		String mb_email = data.getAsJsonObject().get("response").getAsJsonObject().get("email").getAsString();
				 		String mb_name = data.getAsJsonObject().get("response").getAsJsonObject().get("name").getAsString();					
						System.out.println(mb_nickname);
						System.out.println(mb_email);
						System.out.println(mb_name);
						System.out.println(responseBuffer.toString());
						MemberDTO dto = new MemberDTO(mb_email, mb_name, mb_nickname);
						MemberDTO result = MemberDAO.getInstance().selectEmail(mb_email);
						
						request.getSession().invalidate();
						System.out.println("result"+result);
						if(result == null) {
							request.setAttribute("naverInfo", dto);
							RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
							rd.forward(request, response);
						}else {
							request.getSession().setAttribute("loginInfo", result.getMb_nickname()); 
							response.sendRedirect("/Project/member/loginCheck.jsp");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
			      }
			    } catch (Exception e) {
					e.printStackTrace();
			    }
			}else {
				request.getSession().invalidate();
				response.sendRedirect("/Project/index.jsp");
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
