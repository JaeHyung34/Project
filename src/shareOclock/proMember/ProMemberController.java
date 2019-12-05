package shareOclock.proMember;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import shareOclock.member.MemberDTO;



@WebServlet("*.pm")
public class ProMemberController extends HttpServlet {	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String requestURI = request.getRequestURI();
		String cxtPath = request.getContextPath();
		String cmd = requestURI.substring(cxtPath.length());
		String contextRootPath = request.getContextPath();
		System.out.println(contextRootPath);
		try {
			if(cmd.contentEquals("/list.pm")) {
				System.out.println("list안에 들어왔나요?");
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
				ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname);
				System.out.println(pm_nickname);
				ProMemberDAO daoNick = ProMemberDAO.getInstance();			
				List<ProMemberDTO> pmListNick = daoNick.selectByNickname(pm_nickname);
				String pm_check = pmListNick.get(0).getPm_check();
				request.setAttribute("pm_checklogin", pm_check);
				ProMemberDAO dao = ProMemberDAO.getInstance();			
				List<ProMemberDTO> pmList = dao.selectPM(pro_seq);
				request.setAttribute("pmList", pmList);
				//System.out.println(pmList.get(0).getPm_img());
				//String pm_check = request.getParameter("header");//? 이것도 nickname
				request.getRequestDispatcher("proMember/list.jsp").forward(request, response);
				System.out.println("확인");
			}else if(cmd.contentEquals("/memberList.pm")) {
				System.out.println("memberList안에 들어왔나요?");
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
				ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname);
				List<MemberDTO> mList = ProMemberDAO.getInstance().selectMemeber(pm_nickname);
				request.setAttribute("mList", mList);
				System.out.println(mList.get(0).getMb_img());
				System.out.println(mList.get(0).getMb_email());
				System.out.println(mList.get(0).getMb_nickname());
				System.out.println(mList.get(0).getMb_name());
				System.out.println("proMember/newList.jsp");
				request.getRequestDispatcher("proMember/newList.jsp").forward(request, response);
				System.out.println("확인");
			}else if(cmd.contentEquals("/updateList.pm")) {
				System.out.println("updateList안에 들어왔나요?");
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
				ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname);
				ProMemberDAO dao = ProMemberDAO.getInstance();
				System.out.println("전");
				List<MemberDTO> upList = dao.updateList(pro_seq);
				if(upList != null) {
					request.setAttribute("upList", upList);
					//System.out.println(upList.get(0).getMb_img());
					//System.out.println("proMember/update.jsp");
					request.getRequestDispatcher("proMember/updateList.jsp").forward(request, response);
					System.out.println("확인");
				}else {
					response.sendRedirect("proMember/list.jsp");

				}
				
			}else if(cmd.contentEquals("/insert.pm")) {
				System.out.println("insert안에 들어왔나요?");
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				String header = (String)request.getSession().getAttribute("loginInfo"); //head닉네임
				ProMemberDAO.getInstance().isValidMember(pro_seq, header);
				String nicknames = request.getParameter("checkArray");
				//리스트들의 f_seq들을 찾아 삭제 리스트들의 숫자를 꺼내서 하나하나 삭제해야한다. 
				System.out.println("dsfajklf;");
				System.out.println(nicknames);
				nicknames = nicknames.replaceAll("\"", "");
				nicknames = nicknames.replace("[", "");
				nicknames = nicknames.replace("]", "");
				System.out.println("nicknames:"+nicknames);
				String [] nicknameA = nicknames.split(",");
				System.out.println(nicknameA[0]);
				//int result = 0;
				JsonObject jo= new JsonObject();

				for(int i =0; i<nicknameA.length; i++) {
					System.out.println("for문 안");
					String pm_nickname = nicknameA[i];
					System.out.println(pm_nickname);
					ProMemberDAO dao = ProMemberDAO.getInstance();
					ArrayList<String> result = dao.getProfile(pm_nickname);
					String pm_img = result.get(0);
					System.out.println("pm_img:"+pm_img);
					String pm_name = result.get(2);
					System.out.println("메소드전");
					String pm_email="a@naver.com";
					ProMemberDTO dto = new ProMemberDTO(0,"M",pm_img, pm_nickname, pm_name, pm_email, pro_seq);
					//ProMemberDTO dto = new ProMemberDTO(0,"M",pm_img, pm_nickname, pm_name, pm_email, pro_seq);
					int resultInsert = ProMemberDAO.getInstance().insert(dto);
					System.out.println(resultInsert);
					System.out.println("메소드후");
					//jo.addProperty("count"+i, "success");
					if(resultInsert > 0) {					
						System.out.println("성공이잖오");
						jo.addProperty("count"+i, "success");
						System.out.println("result성공");
					}else {
						jo.addProperty("count"+i, "fail");
						break;
					}
				}
				response.getWriter().append(jo.toString());
			}else if(cmd.contentEquals("/delete.pm")) {
				System.out.println("delete.pm in");
				String pm_nickname = request.getParameter("pm_nickname");
				String header = (String)request.getSession().getAttribute("loginInfo"); //head닉네임
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				ProMemberDAO.getInstance().isValidMember(pro_seq, header);		
				System.out.println(pm_nickname);
				ProMemberDAO dao = ProMemberDAO.getInstance();
				int result = dao.delete(pm_nickname);
				JsonObject jo = new JsonObject();
				if(result > 0) {
					jo.addProperty("result", "success");
				}else {
					jo.addProperty("result", "fail");
				}
				response.getWriter().append(jo.toString());
			}else if(cmd.contentEquals("/update.pm")) {
				System.out.println("update안에 들어왔나요?");
				String header = (String)request.getSession().getAttribute("loginInfo"); //header의 닉네임
				int pro_seq = (int)request.getSession().getAttribute("projectInfo");
				ProMemberDAO.getInstance().isValidMember(pro_seq, header);
				String nicknames = request.getParameter("checkArray");
				//리스트들의 f_seq들을 찾아 삭제 리스트들의 숫자를 꺼내서 하나하나 삭제해야한다. 
				System.out.println("dsfajklf;");
				System.out.println(nicknames);
				nicknames = nicknames.replaceAll("\"", "");
				nicknames = nicknames.replace("[", "");
				nicknames = nicknames.replace("]", "");
				System.out.println("nicknames:"+nicknames);
				String [] nicknameA = nicknames.split(",");
				System.out.println(nicknameA[0]);
				//int result = 0;
				JsonObject jo= new JsonObject();

				for(int i =0; i<nicknameA.length; i++) {
					System.out.println("for문 안");
					String pm_nickname = nicknameA[i];
					System.out.println(pm_nickname);
					ProMemberDAO dao = ProMemberDAO.getInstance();
					ArrayList<String> result = dao.getProfile(pm_nickname);
					String pm_img = result.get(0);
					System.out.println("pm_img:"+pm_img);
					String pm_name = result.get(2);
					System.out.println("메소드전");
					String pm_email = result.get(3);
					ProMemberDTO dto = new ProMemberDTO(0,"M",pm_img, pm_nickname, pm_name, pm_email, pro_seq);
					int resultInsert = ProMemberDAO.getInstance().insert(dto);
					System.out.println(resultInsert);
					System.out.println("메소드후");
					//jo.addProperty("count"+i, "success");
					if(resultInsert > 0) {					
						System.out.println("성공이잖오");
						jo.addProperty("count"+i, "success");
						System.out.println("result성공");
					}else {
						jo.addProperty("count"+i, "fail");
						break;
					}
				}
				response.getWriter().append(jo.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
