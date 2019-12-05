package shareOclock.task;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import shareOclock.proMember.ProMemberDAO;

@WebServlet("*.pt")
public class TaskController extends HttpServlet {
   
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
      response.setContentType("text/html;charset=UTF-8");  // request+response utf-8 처리
      
      String requestURI = request.getRequestURI();
      String ctxPath = request.getContextPath();
      String cmd = requestURI.substring(ctxPath.length());
      System.out.println(cmd);
      
      if(cmd.contentEquals("/createTask.pt")){ // 일정 생성
         String user = (String) request.getSession().getAttribute("loginInfo"); // 접속자 정보 가져오기
         int pro_seq = (int) request.getSession().getAttribute("projectInfo"); // 접근 프로젝트 seq 가져오기
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) { // 해당 프로젝트 멤버일 시에만 접근 가능
               String title = xssProtectSummer(request.getParameter("title")); // 일정 타이틀 가져오기
               System.out.println(title);
               String contents = xssProtectSummer(request.getParameter("summernote")); // 일정 내용 가져오기
               System.out.println(contents);
               String startDate = request.getParameter("startDate"); // 일정 시작일자 가져오기
               System.out.println(startDate);
               String endDate = request.getParameter("endDate"); // 일정 마감일자 가져오기
               System.out.println(endDate);
               String priority = request.getParameter("priority"); // 일정 우선순위 가져오기 
               System.out.println(priority);

               try {
                  TaskDAO.getInstance().insertTask(new TaskDTO(0, pro_seq, user, priority, title, contents, startDate, endDate)); // 일정 생성
                  System.out.println("일정 추가 성공");
                  response.sendRedirect("viewTask.pt"); // 일정 게시판 controller로 넘어가기
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/viewTask.pt")) { // 일정 게시판 출력 
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               try {
                  List<TaskDTO> dto = TaskDAO.getInstance().selectAll(pro_seq); // 프로젝트 seq에 따른 일정 모두 가져오기 
                  System.out.println("전송성공");
                  request.setAttribute("TaskDTO", dto);
                  request.getRequestDispatcher("task/viewTask.jsp").forward(request, response); // 일정 게시판 jsp로 이동
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/viewCalendar.pt")) { // 일정 캘린더 페이지
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         String user = (String) request.getSession().getAttribute("loginInfo");
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               Gson g = new Gson();
               try {
                  List<TaskDTO> dto = TaskDAO.getInstance().selectAll(pro_seq); // 프로젝트 seq에 따른 일정 모두 가져오기 
                  System.out.println("전송성공");
                  response.getWriter().append(g.toJson(dto).toString()); // 일정 정보 캘린더에 뿌리기
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }         
      }else if(cmd.contentEquals("/viewContents.pt")) { // 일정 상세정보 보기 
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         int pt_seq = Integer.parseInt(request.getParameter("pt_seq")); // 일정 seq
         String user = (String) request.getSession().getAttribute("loginInfo");
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         System.out.println("pt_seq : " + pt_seq);
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               try {
                  String taskContent = TaskDAO.getInstance().selectContents(pt_seq); // 일정 seq에 따른 일정 내용 가져오기
                  response.getWriter().append("{\"txt\" : \"" + taskContent + "\"}");
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
         }
      }else if(cmd.contentEquals("/detailTask.pt")) {
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         System.out.println(22);
         int pt_seq = Integer.parseInt(request.getParameter("pt_seq"));
         System.out.println(33);
         String user = (String) request.getSession().getAttribute("loginInfo");
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         System.out.println("pt_seq : " + pt_seq);
         Gson g = new Gson();
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
                              
               TaskDTO dto = TaskDAO.getInstance().selectBySeq(pt_seq); // 일정 seq에 따른 일정 정보 가져오기
               JsonObject taskDTO = g.fromJson(g.toJson(dto),JsonObject.class); // json형 변환
               JsonObject obj = new JsonObject(); 
               
               obj.add("dtoView",taskDTO);
               obj.addProperty("user", user);
               response.getWriter().append(obj.toString());               
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
         }
      }else if(cmd.contentEquals("/modifyTask.pt")) { // 일정 게시판에서 일정 수정
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               System.out.println("여기가 문제...??");
               int pt_seq = Integer.parseInt(request.getParameter("hiddenSeq"));
               System.out.println("pt_seq : " + pt_seq);
               String title = xssProtectSummer(request.getParameter("titleView")); // 일정 타이틀 가져오기
               System.out.println(title);
               String contents = xssProtectSummer(request.getParameter("summernoteView")); // 일정 내용 가져오기
               System.out.println(contents);
               String startDate = request.getParameter("startDateView"); // 일정 시작일자 가져오기
               System.out.println(startDate);
               String endDate = request.getParameter("endDateView"); // 일정 마감일자 가져오기
               System.out.println(endDate);
               String priority = request.getParameter("priorityView"); // 일정 우선순위 가져오기 
               System.out.println(priority);
               
               try {
                  int result = TaskDAO.getInstance().modifyTask(new TaskDTO(pt_seq, pro_seq, user, priority, title, contents, startDate, endDate));
                   // 일정 수정 메서드
                  if(result > 0) {
                     System.out.println("일정 수정 성공");
                     response.sendRedirect("viewTask.pt");
                  }else {
                     response.sendRedirect("error.jsp");
                  }
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/deleteTask.pt")) { // 일정 게시판에서 일정 삭제 
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               int pt_seq = Integer.parseInt(request.getParameter("pt_seq")); // 삭제할 일정 seq 받기
               JsonObject obj = new JsonObject();
               try {
               int result = TaskDAO.getInstance().deleteTask(pt_seq); // 일정 삭제 
               if(result > 0) {
                  obj.addProperty("result", "completed");
                  response.getWriter().append(obj.toString()); // 성공
               }
               }catch(Exception e) {
                  e.printStackTrace();
                  obj.addProperty("result", "fail");
                  response.getWriter().append(obj.toString()); // 실패
               }
            }
         }catch(Exception e) {
            e.printStackTrace();            
            response.sendRedirect("error.jsp");
         }
      }else if(cmd.contentEquals("/modifyC_Task.pt")) { // 일정 캘린더에서 일정 수정
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               int pt_seq = Integer.parseInt(request.getParameter("hiddenSeq")); // 수정할 일정 seq 받기
               System.out.println("pt_seq : " + pt_seq);
               String title = xssProtectSummer(request.getParameter("titleView")); // 일정 타이틀 가져오기
               System.out.println(title);
               String contents = xssProtectSummer(request.getParameter("summernoteView")); // 일정 내용 가져오기
               System.out.println(contents);
               String startDate = request.getParameter("startDateView"); // 일정 시작일자 가져오기
               System.out.println(startDate);
               String endDate = request.getParameter("endDateView"); // 일정 마감일자 가져오기
               System.out.println(endDate);
               String priority = request.getParameter("priorityView"); // 일정 우선순위 가져오기 
               System.out.println(priority);
               
               try {
                  int result = TaskDAO.getInstance().modifyTask(new TaskDTO(pt_seq, pro_seq, user, priority, title, contents, startDate, endDate)); 
                  // 일정 수정 메서드
                  if(result > 0) {
                     System.out.println("일정 수정 성공");
                     response.sendRedirect("task/viewCalendar.jsp");
                  }else {
                     response.sendRedirect("error.jsp");
                  }
               } catch (Exception e) {
                  e.printStackTrace();
                  response.sendRedirect("error.jsp");
               }
            }
         }catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
         }
      }else if(cmd.contentEquals("/deleteC_Task.pt")) { // 일정 캘린더에서 일정 삭제
         String user = (String) request.getSession().getAttribute("loginInfo");
         int pro_seq = (int) request.getSession().getAttribute("projectInfo");
         System.out.println("pro_seq : " + pro_seq);
         System.out.println("user : " + user);
         
         try {
            if(ProMemberDAO.getInstance().isValidMember(pro_seq, user)) {
               int pt_seq = Integer.parseInt(request.getParameter("pt_seq")); // 삭제할 일정 seq 받기
               JsonObject obj = new JsonObject();
               try {
               int result = TaskDAO.getInstance().deleteTask(pt_seq); // 일정 삭제 완료
               if(result > 0) {
                  obj.addProperty("result", "completed");
                  response.getWriter().append(obj.toString()); // 성공
               }
               }catch(Exception e) {
                  e.printStackTrace();
                  obj.addProperty("result", "fail");
                  response.getWriter().append(obj.toString()); // 실패
               }
            }
         }catch(Exception e) {
            e.printStackTrace();            
            response.sendRedirect("error.jsp");
         }
      }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }
}