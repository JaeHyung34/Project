package shareOclock.project;

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

import shareOclock.proMember.ProMemberDAO;

@WebServlet("*.pro")
public class ProjectController extends HttpServlet {

   private String xssProtect(String text) { // 스크립트 공격 방지 메서드 
      text = text.replaceAll("&", "&amp;");
      text = text.replaceAll("<", "&lt;");
      text = text.replaceAll(">", "&gt;");
      return text;
   }
   
   private String xssProtectSummer(String text) { // 스크립트 공격 방지 메서드 
      text = text.replaceAll("<script>", "<Cross-site Scripting Prevention>");
      text = text.replaceAll("</script>", "</Cross-site Scripting Prevention>");
      return text;
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html;charset=UTF-8"); // request+response utf-8 처리

      String requestURI = request.getRequestURI();
      String ctxPath = request.getContextPath();
      String cmd = requestURI.substring(ctxPath.length());
      System.out.println(cmd); 

      if(cmd.contentEquals("/view.pro")){ // 내 프로젝트 모두 보기
         
//         request.getSession().setAttribute("loginInfo", "아빠공룡"); // 테스트용 임의값 셋팅
         String nickname = (String) request.getSession().getAttribute("loginInfo"); // 접속 사용자 닉네임 추출
         ProMemberDAO dao = ProMemberDAO.getInstance();
         try {
            List<Integer> seqList = dao.getSeqByNickname(nickname);   // 사용자가 속한 프로젝트 번호 추출            
            List<MyProjectDTO> dto = new ArrayList<>();
            System.out.println(seqList);

            for(int i=0; i < seqList.size(); i++) { // 프로젝트 번호에 따른 프로젝트명, 프로젝트내용, 프로젝트헤더, 프로젝트인원수 추출
               int count = dao.getCountBySeq(seqList.get(i));
               System.out.println(count);
               List<MyProjectDTO> myProject = ProjectDAO.getInstance().getProjectBySeq(seqList.get(i));
               if(myProject != null) {
                   System.out.println(myProject.get(0).getMyPro_title());
                   MyProjectDTO list = new MyProjectDTO(seqList.get(i), 
		                               myProject.get(0).getMyPro_header(),
		                               myProject.get(0).getMyPro_title(),
		                               myProject.get(0).getMyPro_contents(), 
		                               count,
		                               myProject.get(0).getMyPro_startDate(),
		                               myProject.get(0).getMyPro_endDate());
                   System.out.println(seqList.get(i)+" : "+myProject.get(0).getMyPro_title()+" : "+myProject.get(0).getMyPro_contents()+" : "
                         + myProject.get(0).getMyPro_startDate()+" : "+myProject.get(0).getMyPro_endDate()); 
                   dto.add(list);
               }
            }
            request.setAttribute("projectList", dto);
            request.getRequestDispatcher("/project/projectAll.jsp").forward(request, response); // 내 프로젝트 페이지에 뿌리기
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
         }

      }else if(cmd.contentEquals("/create.pro")) { // 프로젝트 생성
         String user = (String) request.getSession().getAttribute("loginInfo");
         System.out.println("user : " + user);
         String title = xssProtectSummer(request.getParameter("title")); // 프로젝트 타이틀 가져오기
         String contents = xssProtectSummer(request.getParameter("contents")); // 프로젝트 내용 가져오기
         String startDate = request.getParameter("startDate"); // 프로젝트 시작일자 가져오기
         String endDate = request.getParameter("endDate"); // 프로젝트 마감일자 가져오기
         
         try {
            int pro_seq = ProjectDAO.getInstance().getProjectSeq(); // 프로젝트 seq 뽑아내기 
            ProjectDAO.getInstance().insertProject(new ProjectDTO(pro_seq, title, contents, startDate, endDate)); // 프로젝트 생성
            
            List <String> list = ProMemberDAO.getInstance().getDetailedInfo(user);
            ProMemberDAO.getInstance().insertProjectMember("H", list.get(0),user, list.get(1), list.get(2), pro_seq); // 프로젝트 생성 사용자 pro_member 테이블에 Header로 추가
            System.out.println("프로젝트 생성 완료");
            response.sendRedirect("view.pro"); // 내 프로젝트 페이지 넘어가기
         } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/viewProject.pro")) {
         String user = (String) request.getSession().getAttribute("loginInfo");
         int seq = Integer.parseInt(request.getParameter("seq"));
         System.out.println("seq : " + seq);
         System.out.println("user : " + user);
         try {
            if(ProMemberDAO.getInstance().isValidMember(seq, user)) { // 프로젝트 seq와 접속자 매칭 검사
               request.getSession().setAttribute("projectInfo", seq); // 프로젝트 시 클릭 시 해당 프로젝트  seq 세션에 담기 
               System.out.println(cmd);
               response.sendRedirect("/Project/viewTask.pt"); // 해당 프로젝트 일정 페이지로 넘어가기
            }else {
               response.sendRedirect("view.pro");
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/detailProject.pro")){ // 프로젝트 수정화면에 정보 띄우기
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = Integer.parseInt(request.getParameter("pro_seq"));
         System.out.println("seq : " + pro_seq);
         System.out.println("user : " + user);
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               ProjectDTO dto = ProjectDAO.getInstance().getDetailBySeq(pro_seq); // 선택 프로젝트 정보 가져오기
               Gson g = new Gson();
               response.getWriter().append(g.toJson(dto)); // 프로젝트 정보 뿌리기
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/modifyProject.pro")) { // 프로젝트 수정 입력
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = Integer.parseInt(request.getParameter("pro_seq"));
         System.out.println("seq : " + pro_seq);
         System.out.println("user : " + user);
         
         ProMemberDAO dao = ProMemberDAO.getInstance();
         JsonObject obj = new JsonObject();
         
         try {
            if(dao.isProjectHeader(pro_seq, user)) {
               String title = xssProtectSummer(request.getParameter("title")); // 프로젝트 타이틀 가져오기
               String contents = xssProtectSummer(request.getParameter("contents")); // 프로젝트 내용 가져오기
               String startDate = request.getParameter("startDate"); // 프로젝트 시작일자 가져오기
               String endDate = request.getParameter("endDate"); // 프로젝트 마감일자 가져오기
               ProjectDTO dto = new ProjectDTO(pro_seq, title, contents, startDate, endDate);
               int result = ProjectDAO.getInstance().modifyProject(dto); // 프로젝트 수정
               if(result > 0) {
                  obj.addProperty("result", "completed");
                  response.getWriter().append(obj.toString()); // 성공
                  return;
               }else{
                  obj.addProperty("result", "fail");
                  response.getWriter().append(obj.toString()); // 실패
                  return;
               }
            }else{
               obj.addProperty("result", "inaccessible");
               response.getWriter().append(obj.toString()); // 권한없음
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/deleteProject.pro")) { // 프로젝트 삭제
         String user = (String) request.getSession().getAttribute("loginInfo");
         String seqList = request.getParameter("pro_seq");
                  
         seqList = seqList.replaceAll("\"", "");
         String[] items = seqList.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "").split(",");
         int[] results = new int[items.length]; // pro_seq 배열을 int형 배열로 반환해주는 과정 
         
         int result1 = 0;
         int result2 = 0;
         ProMemberDAO dao = ProMemberDAO.getInstance();
         JsonObject obj = new JsonObject();
         
         for (int i = 0; i < items.length; i++) { // 가져온 seq 수만큼 삭제 for문
            try {
               if(dao.isProjectHeader(Integer.parseInt(items[i]), user)) { // 헤더일때만 삭제처리
                  result1 = ProjectDAO.getInstance().deleteProject(Integer.parseInt(items[i])); // 프로젝트 테이블에서 삭제
                  result2 = dao.deleteProjectMember(Integer.parseInt(items[i]));  // 프로젝트 멤버 테이블에서 삭제
                    System.out.println(items[i]);
               }else{
                  obj.addProperty("result", "inaccessible");
                  response.getWriter().append(obj.toString()); // 권한 없음
                  return;
               }
             } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("/error.jsp");
             };
         }
         if(result1 > 0) {
            if(result2 > 0) {
               obj.addProperty("result", "completed");
               response.getWriter().append(obj.toString()); // 성공
               return;
            }
         }else {
            obj.addProperty("result", "fail");
            response.getWriter().append(obj.toString()); // 실패
            return;
         }
      }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}