package shareOclock.task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import configuration.Utils;

public class TaskDAO {

   public static TaskDAO instance;

   public synchronized static TaskDAO getInstance() {
      if (instance == null) {
         System.out.println("디비 생성");
         instance = new TaskDAO();
      }
      return instance;
   }
   Connection getConnection() throws Exception {
      return Configuration.dbs.getConnection();
   }

   public int insertTask(TaskDTO dto) throws Exception{
      String sql = "insert into tb_project_task values(pt_seq.nextval,?,?,?,?,TO_DATE(?, 'YYYY-MM-DD'),TO_DATE(?, 'YYYY-MM-DD'),?)";
      try(Connection con = Configuration.dbs.getConnection();
         PreparedStatement pstat = con.prepareStatement(sql);){
         pstat.setString(1, dto.getPt_writer());
         pstat.setString(2, dto.getPt_priority());
         pstat.setString(3, dto.getPt_title());
         pstat.setString(4, dto.getPt_contents());
         pstat.setString(5, dto.getPt_startDate());
         pstat.setString(6, dto.getPt_endDate());
         pstat.setInt(7, dto.getPro_seq());
         int result = pstat.executeUpdate();
         con.commit();
         return result;
      }
   }

   public List<TaskDTO> selectAll(int pro_seq) throws Exception{
      String sql = "select * from tb_project_task where pro_seq=? order by pt_startDate";
      try(Connection con = Configuration.dbs.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ){
         pstat.setInt(1, pro_seq);
         try(ResultSet rs = pstat.executeQuery();){
            List<TaskDTO> list = new ArrayList<>();
            while(rs.next()) {
               int pt_seq = rs.getInt("pt_seq");
               int pro_seqOut = rs.getInt("pro_seq");
               String pt_writer = rs.getString("pt_writer");
               String pt_priority = rs.getString("pt_priority");
               String pt_title = rs.getString("pt_title");
               String pt_contents = rs.getString("pt_contents");
               Timestamp pt_startDate = rs.getTimestamp("pt_startDate");
               Timestamp pt_endDate = rs.getTimestamp("pt_endDate");
               TaskDTO dto = new TaskDTO(pt_seq, pro_seqOut, pt_writer, pt_priority, pt_title, pt_contents, Utils.formedDate(pt_startDate) , Utils.formedDate(pt_endDate));
               list.add(dto);   
            }return list;
         }
      }
   }
   
   public String selectContents(int pt_seq) throws Exception{
      String sql = "select pt_contents from tb_project_task where pt_seq=?";
      try(Connection con = Configuration.dbs.getConnection();
         PreparedStatement pstat = con.prepareStatement(sql);){
         pstat.setInt(1, pt_seq);
         try(ResultSet rs = pstat.executeQuery();){
            if(rs.next()) {
               String pt_contents = rs.getString("pt_contents");
               return pt_contents;
            }return null;
         }
      }
   }
   
   public TaskDTO selectBySeq(int seq) throws Exception{
      String sql = "select * from tb_project_task where pt_seq=?";
      try(Connection con = Configuration.dbs.getConnection();
         PreparedStatement pstat = con.prepareStatement(sql);){
         pstat.setInt(1, seq);
         try(ResultSet rs = pstat.executeQuery();){
            if(rs.next()) {
               int pt_seq = rs.getInt("pt_seq");
               int pro_seq = rs.getInt("pro_seq");
               String pt_writer = rs.getString("pt_writer");
               String pt_priority = rs.getString("pt_priority");
               String pt_title = rs.getString("pt_title");
               String pt_contents = rs.getString("pt_contents");
               Timestamp pt_startDate = rs.getTimestamp("pt_startDate");
               Timestamp pt_endDate = rs.getTimestamp("pt_endDate");
               TaskDTO dto = 
                     new TaskDTO(pt_seq, pro_seq, pt_writer, pt_priority, pt_title, 
                           pt_contents, Utils.formedDate(pt_startDate), Utils.formedDate(pt_endDate));
               return dto;
            }return null;
         }
      }
   }
   
   public int modifyTask(TaskDTO dto) throws Exception{
      String sql = "update tb_project_task set pt_priority=?, pt_title=?, pt_contents=?,"
            + " pt_startDate=to_date(?, 'YYYY-MM-DD'), pt_endDate=to_date(?, 'YYYY-MM-DD') "
            + "where pt_seq=?";
      try(Connection con = Configuration.dbs.getConnection();
         PreparedStatement pstat = con.prepareStatement(sql);){
         pstat.setString(1, dto.getPt_priority());
         pstat.setString(2, dto.getPt_title());
         pstat.setString(3, dto.getPt_contents());
         pstat.setString(4, dto.getPt_startDate());
         pstat.setString(5, dto.getPt_endDate());
         pstat.setInt(6, dto.getPt_seq());
         
         int result = pstat.executeUpdate();
         con.commit();
         return result;
      }
   }
   
   public int deleteTask(int pt_seq) throws Exception{
      String sql = "delete from tb_project_task where pt_seq=?";
      try(Connection con = Configuration.dbs.getConnection();
         PreparedStatement pstat = con.prepareStatement(sql)){
         pstat.setInt(1, pt_seq);
         
         int result = pstat.executeUpdate();
         con.commit();
         return result;         
      }
   }
}