package shareOclock.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import configuration.Utils;

public class MemberDAO {
	public static MemberDAO instance;
	public synchronized static MemberDAO getInstance() {
		if (instance == null) {
			System.out.println("디비가 생성되었다.");
			instance = new MemberDAO();
		}
		return instance;
	}
	Connection getConnection() throws Exception {
		return Configuration.dbs.getConnection();
	}
	public MemberDTO getLogin(String email, String pw) throws Exception {
		String sql = "select * from tb_member where mb_email=? and mb_pw=?";
		MemberDTO dto = null;
		try (Connection conn = getConnection();
			PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, email);
			pstat.setString(2, pw);
			try (ResultSet rs = pstat.executeQuery();) {
				if(rs.next()) {
					dto = new MemberDTO(rs.getString("mb_email"),rs.getString("mb_pw") , rs.getString("mb_name"), rs.getString("mb_nickname"), rs.getString("mb_group") , rs.getString("mb_phone"), rs.getString("mb_check"));
				}	
				return dto;
			}
		}
	}
	public boolean nickNameCheck(String nickName) throws Exception {
		String sql = "select * from tb_member where mb_nickname = ?";
		try (
			Connection conn = getConnection(); 
			PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, nickName);
			try (ResultSet rs = pstat.executeQuery();) {
				return rs.next();
			}
		}
	}
	public boolean emailCheck(String email) throws Exception {
		String sql = "select * from tb_member where mb_email = ?";
		try (
			Connection conn = getConnection(); 
			PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, email);
			try (ResultSet rs = pstat.executeQuery();) {
				return rs.next();
			}
		}
	}
	public int modifyPw(String email, String pw) throws Exception {
		String sql = "update tb_member set mb_pw=? where mb_email=?";
		try (Connection con = getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);) {
			System.out.println("디비가 실행" + pw);
			pstat.setString(1, Utils.encrpyt(pw));
			pstat.setString(2, email);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int insert(MemberDTO dto)  throws Exception{
		String sql = "insert into tb_member (mb_email,mb_pw, mb_name,mb_nickname,  mb_group, mb_phone, mb_check ) values(?,?,?,?,?,?,?)";
		try (Connection conn = getConnection(); 
			 PreparedStatement pstat = conn.prepareStatement(sql);){
			System.out.println("naverKakao  : "+dto.getMb_pw());
			pstat.setString(1, dto.getMb_email());
			pstat.setString(2, Utils.encrpyt(dto.getMb_pw()));
			pstat.setString(3, dto.getMb_name());
			pstat.setString(4, dto.getMb_nickname());
			String content = dto.getMb_group();
			if(content != null && !content.equals("")){
				pstat.setString(5, dto.getMb_group());
			}
			else{
				pstat.setNull(5, java.sql.Types.NULL);
			}
			pstat.setString(6, dto.getMb_phone());
			pstat.setString(7, dto.getMb_check());
			int result = pstat.executeUpdate();
			conn.commit();
			return result;
		}
	}
	

	
	public MemberDTO selectInfo(String mb_nickName) throws SQLException, Exception {
		String sql = "select * from tb_member where mb_nickname=?";
		try (Connection conn = getConnection(); PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, mb_nickName);
			try (ResultSet rs = pstat.executeQuery();) {
				MemberDTO dto = null;
				if (rs.next()) {
					dto = new MemberDTO(rs.getString("mb_email"),rs.getString("mb_pw") , rs.getString("mb_name"), rs.getString("mb_nickname"), rs.getString("mb_group") , rs.getString("mb_phone"), rs.getString("mb_check"));
				}
				return dto;
			}
		}
	}
	
	public int modifyMember(MemberDTO dto) throws SQLException, Exception {
		String sql = "update tb_member set mb_pw=?, mb_name=?, mb_nickname=?, mb_group=?, mb_phone=? where mb_email=?";
		try (Connection con = getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, Utils.encrpyt(dto.getMb_pw()));
			pstat.setString(2, dto.getMb_name());
			pstat.setString(3, dto.getMb_nickname());
			String content = dto.getMb_group();
			
			if(content != null && !content.equals("")){
				pstat.setString(4, dto.getMb_group());
			}
			else{
				pstat.setNull(4, java.sql.Types.NULL);
			}
			
			pstat.setString(5, dto.getMb_phone());
			pstat.setString(6, dto.getMb_email());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteMember(String mb_nickName) throws SQLException, Exception {
		String sql = "delete from tb_member where mb_nickName=?";
		try (Connection conn = getConnection(); PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, mb_nickName);
			int result = pstat.executeUpdate();
			conn.commit();
			return result;

		}
	}
	public MemberDTO selectEmail(String mb_email) throws SQLException, Exception {
		String sql = "select * from tb_member where mb_email=?";
		try (Connection conn = getConnection(); PreparedStatement pstat = conn.prepareStatement(sql);) {
			pstat.setString(1, mb_email);
			try (ResultSet rs = pstat.executeQuery();) {
				MemberDTO dto = null;
				if (rs.next()) {
					dto = new MemberDTO(rs.getString("mb_email"),rs.getString("mb_pw") , rs.getString("mb_name"), rs.getString("mb_nickname"), rs.getString("mb_group") , rs.getString("mb_phone"), rs.getString("mb_check"));
				}
				return dto;
			}
		}
	}
	
//===================================== 신익호 =================================================
		
	// 일반회원 삭제
		public int deleteGeneralMember(String email) throws Exception {
			String sql = "delete from tb_member where mb_email = ?";
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, email);
				int result = pstmt.executeUpdate();
				con.commit();
				return result;
			}
		}
	
		// 멤버테이블 목록 조회(블랙에 없는 회원만 조회)
	      public List<MemberDTO> searchAllMemberView()throws Exception{
	         String sql = "select mb_email, mb_name from tb_member where mb_check != 'A' minus select bl_email, bl_name from tb_blacklist";
	         try(
	               Connection con = this.getConnection();
	               PreparedStatement pstmt = con.prepareStatement(sql);
	               ResultSet rs = pstmt.executeQuery();
	               ){
	            List<MemberDTO> list = new ArrayList<MemberDTO>();
	            while(rs.next()) {
	               String email = rs.getString("mb_email");
	               String name = rs.getString("mb_name");
	               MemberDTO dto = new MemberDTO(email, null, name, null,null,null,null);
	               list.add(dto);
	            }
	            return list;
	         }
	      }
	
		// 멤버 아이디 클릭 시 modal 상세조회
		public MemberDTO searchByEmailMemberView(String mb_email)throws Exception{
			String sql = "select * from tb_member where mb_email = ?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);
					){
				pstmt.setString(1, mb_email);
				try(ResultSet rs = pstmt.executeQuery();){
					if(rs.next()) {
						String email = rs.getString("mb_email");
						String name = rs.getString("mb_name");
						String nickname = rs.getString("mb_nickname");
						String group = "없음";
						if(rs.getString("mb_group") != null) {
							group = rs.getString("mb_group");
						}

						System.out.println(group);
						String phone = rs.getString("mb_phone");
						MemberDTO dto = new MemberDTO(email, null, name, nickname,group,phone,null);
						return dto;
					}
					return null;
				}
			}
		}
		
		// 일반회원에서 블랙 회원으로 추가 시 이름 꺼내오기
		public String addBlckmemberFromGeneralmember(String email) throws Exception{
			String sql = "select mb_name from tb_member where mb_email = ?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);
					){
				pstmt.setString(1, email);
				try(ResultSet rs = pstmt.executeQuery();){
					if(rs.next()) {					
						String mb_name = rs.getString("mb_name");
						return mb_name;
					}
				}
			}
			return null;
		}
}
