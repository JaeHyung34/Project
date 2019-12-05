package shareOclock.proMember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import shareOclock.member.MemberDTO;

public class ProMemberDAO {
	public static ProMemberDAO instance;

	public synchronized static ProMemberDAO getInstance() {
		if (instance == null) {
			System.out.println("디비 생성");
			instance = new ProMemberDAO();
		}
		return instance;
	}
	Connection getConnection() throws Exception {
		return Configuration.dbs.getConnection();
	}
	//은비 유진 공용 
	public int deleteProjectMember(int pro_seq) throws Exception{ // 프로젝트 멤버 삭제
		String sql = "delete from tb_project_member where pro_seq=?";
		try(Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, pro_seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	//은비 유진 공용 	끝

	// 유진 전용	
	public int insert(ProMemberDTO dto) throws Exception{ // 프로젝트 멤버 추가
		String sql = "insert into tb_project_member values(pm_seq.nextval,'M',?,?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getPm_img());
			pstat.setString(2, dto.getPm_nickname());
			pstat.setString(3, dto.getPm_name());
			pstat.setString(4, dto.getPm_email());
			pstat.setInt(5, dto.getPro_seq());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int delete(String pm_nickname) throws Exception{
		String sql = "delete from tb_project_member where pm_nickname = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, pm_nickname);      
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public ArrayList<String> getProfile(String mb_nickname) throws Exception{
		String sql = "select mb_img, mb_nickname, mb_name from tb_member where mb_nickname = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, mb_nickname);
			ArrayList<String> arr = new ArrayList<>();
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					String mb_img = rs.getString("mb_img");
					String mb_nickname1 = rs.getString("mb_nickname");
					String mb_name = rs.getString("mb_name");
					System.out.println(mb_img + mb_nickname1 + mb_name);
					arr.add(mb_img);
					arr.add(mb_nickname1);
					arr.add(mb_name);
				}
			}
			return arr;
		}
	}

	public int update(ProMemberDTO dto) throws Exception{
		String sql = "insert into tb_project_member values(pm_seq.nextval,'M',?,?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getPm_img());
			pstat.setString(2, dto.getPm_nickname());
			pstat.setString(3, dto.getPm_name());
			pstat.setString(4, dto.getPm_email());
			pstat.setInt(5, dto.getPro_seq());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public List<ProMemberDTO> selectPM(int pro_seq) throws Exception{
		String sql = "select * from tb_project_member  where pro_seq = ? order by pm_seq, pm_name";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, pro_seq);
			try(ResultSet rs = pstat.executeQuery();)
			{
				List<ProMemberDTO> list = new ArrayList<>();
				while(rs.next()) {
					int pm_seq = rs.getInt("pm_seq");
					String pm_check = rs.getString("pm_check");
					String pm_img = rs.getString("pm_img");
					String pm_nickname = rs.getString("pm_nickname");
					String pm_name = rs.getString("pm_name");
					String pm_email = rs.getString("pm_email");
					int pro_seq1 = rs.getInt("pro_seq");
					ProMemberDTO dto = new ProMemberDTO(pm_seq,pm_check, pm_img, pm_nickname, pm_name, pm_email, pro_seq1);
					list.add(dto);
				}
				return list;
			}
		}
	}
	public List<ProMemberDTO> selectByNickname(String pm_nickname) throws Exception{
		String sql = "select * from tb_project_member where pm_nickname = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, pm_nickname);
			try(ResultSet rs = pstat.executeQuery();){
				List<ProMemberDTO> list = new ArrayList<>();
				while(rs.next()) {
					int pm_seq = rs.getInt("pm_seq");
					String pm_check = rs.getString("pm_check");
					String pm_img = rs.getString("pm_img");
					String pm_nickname1 = rs.getString("pm_nickname");
					String pm_name = rs.getString("pm_name");
					String pm_email = rs.getString("pm_email");
					int pro_seq = rs.getInt("pro_seq");
					ProMemberDTO dto = new ProMemberDTO(pm_seq,pm_check, pm_img, pm_nickname1, pm_name, pm_email, pro_seq);
					list.add(dto);
				}
				return list;
			}
		}
	}
	public List<MemberDTO> selectMemeber(String pm_nickname) throws Exception{
		String sql = "select * from tb_member where not mb_nickname in (?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, pm_nickname);
			try(ResultSet rs = pstat.executeQuery();){
				List<MemberDTO> list = new ArrayList<>();
				while(rs.next()) {
					System.out.println("while안");
					String mb_img = rs.getString("mb_img");
					String mb_nickname = rs.getString("mb_nickname");
					String mb_pw = rs.getString("mb_pw");
					String mb_name = rs.getString("mb_name");	
					String mb_email = rs.getString("mb_email");	
					String mb_group = rs.getString("mb_group");
					String mb_phone = rs.getString("mb_phone");
					String mb_check = rs.getString("mb_check");
					MemberDTO dto = new MemberDTO(mb_img, mb_nickname, null, mb_name, mb_email, null, null, "M");
					list.add(dto);
				}
				return list;
			}
		}
	}
   public List<MemberDTO> updateList(int pro_seq) throws Exception{
      String sql = "select * from tb_member where mb_nickname not in (select pm_nickname from tb_project_member where pro_seq = ?)";
      try(
            Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ){
         pstat.setInt(1, pro_seq);
         try(ResultSet rs = pstat.executeQuery();){
            List<MemberDTO> list = new ArrayList<>();
            while(rs.next()) {
               String mb_img = rs.getString("mb_img");
               String mb_nickname = rs.getString("mb_nickname");
               String mb_pw = rs.getString("mb_pw");
               String mb_name = rs.getString("mb_name");   
               String mb_email = rs.getString("mb_email");   
               String mb_group = rs.getString("mb_group");
               String mb_phone = rs.getString("mb_phone");
               String mb_check = rs.getString("mb_check");
               MemberDTO dto = new MemberDTO(mb_img, mb_nickname, null, mb_name, mb_email, null, null, "M");
               list.add(dto);
            }
            return list;
         }
      }
   }

	// 유진 전용 끝

	// 은비 전용
	public int insertProjectMember(String pm_check, String pm_img, String pm_nickname, String pm_name, String pm_email, int pro_seq) throws Exception{ //프로젝트 헤더 추가
		String sql = "insert into tb_project_member values(pm_seq.nextval,?,?,?,?,?,?)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, pm_check);
			pstat.setString(2, pm_img);
			pstat.setString(3, pm_nickname);
			pstat.setString(4, pm_name);
			pstat.setString(5, pm_email);
			pstat.setInt(6, pro_seq);

			int result = pstat.executeUpdate();
			con.commit();
			return result;			
		}
	}

	public List<Integer> getSeqByNickname(String nickname) throws Exception{ // 닉네임으로 자기가 속한 프로젝트 seq 얻기
		String sql = "select pro_seq from tb_project_member where pm_nickname=?";
		try(Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				List<Integer> list = new ArrayList<>();
				while(rs.next()) {
					int seq = rs.getInt("pro_seq");
					list.add(seq);
				}return list;
			}
		}
	}

	public int getCountBySeq(int seq) throws Exception{ // 한 프로젝트에 속한 멤버 수 얻기 
		String sql = "select count(*) from tb_project_member where pro_seq=?";
		try(Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					int count = rs.getInt(1);
					return count;
				}return -1;			
			}	
		}
	}	

	public boolean isValidMember(int pro_seq, String nickname) throws Exception{ // 해당 프로젝트의 멤버인지 확인
		String sql = "select *  from tb_project_member where pro_seq=? and pm_nickname=?";
		try(Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, pro_seq);
			pstat.setString(2, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					return true;
				}return false;
			}
		}
	}


	public boolean isProjectHeader(int pro_seq, String nickname) throws Exception{ // 해당 프로젝트의 헤더인지 확인
		String sql = "select pm_check from tb_project_member where pro_seq=? and pm_nickname=?";
		try(Connection con = Configuration.dbs.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, pro_seq);
			pstat.setString(2, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					String pm_check = rs.getString(1);
					if(pm_check.contentEquals("H")) {
						return true;
					}
				}return false;
			}
		}
	}

	public List<String> getDetailedInfo(String nickname) throws Exception{
		String sql = "select mb_img, mb_name, mb_email from tb_member where mb_nickname=?";
		try(Connection con = Configuration.dbs.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				List<String> list = new ArrayList<>();
				if(rs.next()) {
					String mb_img = rs.getString("mb_img");
					String mb_name = rs.getString("mb_name");
					String mb_email = rs.getString("mb_email");
					list.add(mb_img);
					list.add(mb_name);
					list.add(mb_email);
				}return list;
			}
		}
	}

	// 은비 전용 끝
}
