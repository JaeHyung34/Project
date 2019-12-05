package shareOclock.file;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import shareOclock.proMember.ProMemberDAO;



@WebServlet("*.file")
public class FileController extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setCharacterEncoding("utf-8");
      //upload.setHeaderEncoding("UTF-8");
      //fileItem.getString("UTF-8");
      response.setContentType("text/html;charset=utf-8");
      String requestURI = request.getRequestURI();
      String cxtPath = request.getContextPath();
      String cmd = requestURI.substring(cxtPath.length());
      String contextRootPath = this.getServletContext().getRealPath("/"); 
      System.out.println("뿌리경로:"+contextRootPath);

      try {
         if(cmd.contentEquals("/upload.file")) {
            System.out.println("upload.file에 도착했나요?");
            int pro_seq = (int)request.getSession().getAttribute("projectInfo");
            String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
            try {
               if(ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname)) {
                  String uploadPath = request.getServletContext().getRealPath("/files"); //파일경로를 알아야한다. 뒤에 붙이는기능을하기 때문에 /files를 붙인다. //getServletContext() : ServletContainer의 맥락 환경정보 관리 인스턴스
                  //client가 경로를 보내고 서버가 가져와 db에 경로를 저장하기 위해 uploadPath 구함
                  File uploadFilePath = new File(uploadPath);
                  if(!uploadFilePath.exists()) {
                     uploadFilePath.mkdir();
                  } 
                  System.out.println("폴더만든후경로:"+uploadPath);

                  //서비스클래스 (JAVA) 파일로 처리하는것이 좋다.          
                  //1. multiport/form-data 여부 확인 //파일업로드 요청이 있는지 확인
                  boolean isMultipart = ServletFileUpload.isMultipartContent(request);             
                  if (isMultipart) {
                     // 2. 메모리나 파일로 업로드 파일 보관하는 FileItem의 Factory 설정//디스크 기반 파일 항목에 대한 팩토리 작성
                     DiskFileItemFactory factory = new DiskFileItemFactory();
                     factory.setSizeThreshold(10*1024*1024); //메모리에 저장할 최대 size
                     ServletContext serveltContext  = this.getServletConfig().getServletContext();
                     File store =(File)serveltContext.getAttribute("javax.servelt.context.tempdir");
                     factory.setRepository(store); //파일 임시 저장소
                     // 3. 업로드 요청을 처리하는 ServletFileUpload 생성//안전한 임시 위치가 사용되도록 저장소를 구성      //새로운 파일 업로드 핸들러
                     ServletFileUpload upload = new ServletFileUpload(factory);
                     upload.setSizeMax(10*1024*1024);
                     // 4. 업로드 요청 파싱해서 FileItem 목록 구함//요청을 파싱    
                     List<FileItem> items = upload.parseRequest(request);   
                     Iterator<FileItem> iter = items.iterator();   
                     JsonObject jso = new JsonObject();
                     int cnt = 1;
                     while(iter.hasNext()){
                        FileItem item = iter.next();
                        // 파일인지 여부 확인 : isFormFile() -> type=file 이외의 폼 데이터 인지 확인
                        if (item.isFormField()) { // 텍스트 입력인 경우
                           String name = item.getFieldName(); //태그 name
                           String value = item.getString("utf-8"); 
                           System.out.println("일반 폼 필드 :" + name+ "-" + value);
                        }else{
                           String fieldName = item.getFieldName();
                           System.out.println(fieldName);
                           String fileName = item.getName(); //파일이름
                           System.out.println(fileName);
                           boolean isInMemory = item.isInMemory();
                           long sizeInBytes = item.getSize(); //파일 사이즈
                           System.out.println("파일 이름 :" + fileName);

                           //업로드 파일명을 현재시간으로 변경후 저장
                           String fileExt = fileName.substring(fileName.lastIndexOf("."));

                           String newfileName = fileName + cnt;
                           cnt++;
                           String uploadedFileName = newfileName + fileExt;
                           System.out.println(fileExt);
                           System.out.println(uploadedFileName);

                           File uploadedFile = new File(uploadPath+"/"+uploadedFileName);
                           //contextRootPath + "/files/"
                           item.write(uploadedFile);
                           System.out.println("uploadedFile:"+uploadedFile);
                           System.out.println("uploadedFile.getPath():"+uploadedFile.getPath()); //db에저장된 경로?
                           item.delete();
                           FilesDTO dto = new FilesDTO(0,uploadedFileName,fileName,null,pm_nickname,0,pro_seq);
                           int result = FilesDAO.getInstance().insert(dto);
                           jso.addProperty("fileName",uploadedFileName);                              
                        }
                     }         
                     System.out.println(jso);
                     Gson g = new Gson();
                     response.getWriter().append(jso.toString());               
                  }
               }
            }catch(Exception e) {
               e.printStackTrace();
               response.sendRedirect("/error.jsp");
            }
         }else if(cmd.contentEquals("/list.file")) {
            System.out.println("list.file에 도착했나요?");
            int pro_seq = (int)request.getSession().getAttribute("projectInfo");
            String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
            try {
               if(ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname)) {
                  List<FilesDTO> list = FilesDAO.getInstance().getAllFiles(pro_seq);
                  request.setAttribute("list", list);
                  request.getRequestDispatcher("file/list.jsp").forward(request, response);
                  System.out.println("도착완료");
               }
            }catch(Exception e) {
               e.printStackTrace();
               response.sendRedirect("/error.jsp");
            }
         }else if(cmd.contentEquals("/download.file")) {
            System.out.println("/download.file에 들어왔나요?");
            int pro_seq = (int)request.getSession().getAttribute("projectInfo");
            String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
            try {
               if(ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname)) {
                  String fileName = request.getParameter("fileName");
                  System.out.println(fileName);
                  String path = request.getServletContext().getRealPath("/files");//getServletContext() -> application
                  String fullPath = path + "/" + fileName;
                  System.out.println(fullPath);

                  File f = new File(fullPath);
                  try(

                        FileInputStream fis= new FileInputStream(f);
                        DataInputStream fileDis= new DataInputStream(fis);
                        ServletOutputStream sos = response.getOutputStream();
                        ){
                     byte[] fileContents = new byte[(int)f.length()];
                     fileDis.readFully(fileContents);
                     //------------------------------------------------------
                     response.reset();
                     response.setContentType("application/octet-stream");
                     String encFileName = new String(fileName.getBytes("utf8"),"iso-8859-1");
                     response.setHeader("Content-Disposition", "attachment; filename=\""+encFileName+"\""); 
                     response.setHeader("Content-Length", String.valueOf(f.length()));
                     sos.write(fileContents);
                     sos.flush();   
                  }
               }
            }catch(Exception e) {
               e.printStackTrace();
               response.sendRedirect("/error.jsp");
            }
         }else if(cmd.contentEquals("/downloadCount.file")) {            
            System.out.println("/downloadCount.file에 들어왔나요?");
            int pro_seq = (int)request.getSession().getAttribute("projectInfo");
            String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
            try {
               if(ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname)) {
                  int f_seq = Integer.parseInt(request.getParameter("f_seq"));
                  int downloadCount = FilesDAO.getInstance().downloadCount(f_seq);
                  System.out.println(downloadCount);
                  if(downloadCount > 0) {
                     JsonObject jso = new JsonObject();
                     int dCnt = FilesDAO.getInstance().getFileByfileSeq(f_seq);
                     jso.addProperty("dCnt", dCnt);
                     jso.addProperty("f_seq", f_seq);
                     Gson g = new Gson();
                     String str = g.toJson(jso);
                     System.out.println(str);
                     response.getWriter().append(str);
                     System.out.println(dCnt);
                     System.out.println("성공");
                  }else{
                     System.out.println("실패");
                  }
               }
            }catch(Exception e) {
               e.printStackTrace();
               response.sendRedirect("/error.jsp");
            }
         }else if(cmd.contentEquals("/delete.file")) {
            System.out.println("delete.file에 도착했나요?");
            int pro_seq = (int)request.getSession().getAttribute("projectInfo");
            String pm_nickname = (String)request.getSession().getAttribute("loginInfo");
            try {
               if(ProMemberDAO.getInstance().isValidMember(pro_seq, pm_nickname)){
                  String ca = request.getParameter("checkArray");
                  //리스트들의 f_seq들을 찾아 삭제 리스트들의 숫자를 꺼내서 하나하나 삭제해야한다. 
                  System.out.println("ddd");
                  System.out.println(ca);
                  ca = ca.replaceAll("\"", "");
                  ca=ca.replace("[", "");
                  ca=ca.replace("]", "");
                  System.out.println(ca);
                  String [] words = ca.split(",");
                  System.out.println(Integer.parseInt(words[0]));
                  JsonObject jo= new JsonObject();
                  for(int i =0; i<words.length; i++) {
                     int f_seq = Integer.parseInt(words[i]);
                     System.out.println(f_seq);
                     System.out.println("메소드전");
                     int result = FilesDAO.getInstance().delete(f_seq);
                     System.out.println(result);
                     System.out.println("메소드후");
                     //jo.addProperty("count"+i, "success");
                     if(result > 0) {               
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
            }catch(Exception e) {
               e.printStackTrace();
               response.sendRedirect("/error.jsp");
            }
         }//else if문 close
      }catch (Exception e) { //전체 try close
         e.printStackTrace();
      }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}