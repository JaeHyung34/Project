package shareOclock.message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import configuration.Configuration;
import shareOclock.blackList.BlackList_DAO;

public class MessageDAO {

	private Connection getConnection() throws Exception {
		return Configuration.dbs.getConnection();
	}

	// 메시지 삽입
	public int insertMsg(MessageDTO dto ) throws Exception {
		String sql = "insert into tb_message values(msg_seq.nextval, ?, ?, ?, sysdate,'N')";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, dto.getMessage_sender());
			pstat.setString(2, dto.getMessage_receiver());
			pstat.setString(3, dto.getRealMessage_contents());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	 // 메시지대상을 이메일로 조회하여 가져오기
	   public String getEmail(String mb_email) throws  Exception {
	      String sql = "select * from tb_member where mb_email=?";
	      try (Connection conn = getConnection(); PreparedStatement pstat = conn.prepareStatement(sql);) {
	         pstat.setString(1, mb_email);
	         try (ResultSet rs = pstat.executeQuery();) {
	            if (rs.next()) {
	               return rs.getString(1);
	            }
	            return null;
	         }
	      }
	   }
	// 메시지 모두 읽음으로 표시
	public int readAll(String sender) throws Exception {
		String sql = "update tb_message set msg_read = 'Y' where msg_sender=?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, sender);
			return pstat.executeUpdate();
		}
	}

	// 메시지 읽음으로 표시
	public int read(int seq) throws Exception {
		String sql = "update tb_message set msg_read='Y' where msg_seq=?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	// 쪽지 조회 
	public MessageDTO getMsgBySeq(int seq) throws Exception {
		String sql = "select * from tb_message where msg_seq=?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setInt(1, seq);
			try (
					ResultSet rs = pstat.executeQuery();
					) {
				MessageDTO dto = null;
				if (rs.next()) {
					String sender = rs.getString(2);
					String receiver = rs.getString(3);
					String contents = rs.getString(4);
					Timestamp time = rs.getTimestamp(5);
					String read = rs.getString(6);
					dto = new MessageDTO(seq,sender,receiver,contents,time,read);
				}
				return dto;
			}
		}
	}
	// 쪽지 삭제
	public int deleteMsg(int seq) throws Exception {
		String sql = "delete from tb_message where msg_seq = ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	// total Msgs 
	public int totalMsgs() throws Exception {
		String sql = "select count(*) from tb_message"; // id값을 추가할 것
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				) {
			rs.next();
			return rs.getInt(1);
		}
	}
	// Pagination
	public String pagination(int entryPage, int totalMsgs, String href) throws Exception {
		int articlesPerPage = Configuration.recordCountPerPage;
		int naviPerPage = 5;
		int totalArticles = totalMsgs;

		int totalPage = totalArticles / articlesPerPage;
		if (totalArticles % articlesPerPage != 0)
			totalPage += 1;

		if (entryPage > totalPage)
			entryPage = totalPage;
		if (entryPage < 1) 
			entryPage = 1;

		int startNavi = (entryPage - 1) / 10 * naviPerPage + 1;
		int lastNavi = startNavi + naviPerPage - 1;
		if (lastNavi > totalPage)
			lastNavi = totalPage;

		StringBuilder sb = new StringBuilder();
		sb.append("<li class='page-item ");
		if (startNavi == 1) sb.append("disabled");
		sb.append("'>");
		sb.append("<a class='page-link' "
				+ "href='"+ href + "?entry=" + (startNavi - 1)
				+ "' tabindex='-1'>&lt;</a></li>");
		for (int i = startNavi; i <= lastNavi; i++) {
			sb.append("<li class='page-item ");
			if (i == entryPage) sb.append("active");
			sb.append("'><a class='page-link' href='" + href + "?entry=");
			sb.append(i + "'>" + i);
			sb.append("</a></li>");
		}
		sb.append("<li class='page-item ");
		if (lastNavi == totalPage) sb.append("disabled");
		sb.append("'>");
		sb.append("<a class='page-link' "
				+ "href='" + href + "?entry=" + (lastNavi + 1)
				+ "' tabindex='-1'>&gt;</a></li>");

		return sb.toString();
	}	

	// 메시지 초기화면 진입 
	public List<MessageDTO> viewAllMsg(int entryPage) throws Exception {
		String sql = "select * from (select tb_message.*, "
				+ "row_number() over(order by msg_seq desc) as c from tb_message) "
				+ "where c between ? and ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			int msgsPerPage = Configuration.recordCountPerPage;
			int startMsgSeq = (entryPage - 1) * msgsPerPage + 1;
			int lastMsgSeq = startMsgSeq + msgsPerPage - 1;
			pstat.setInt(1, startMsgSeq);
			pstat.setInt(2, lastMsgSeq);
			try (
				ResultSet rs = pstat.executeQuery();
					) {
				List<MessageDTO> list = new ArrayList<>();
				while (rs.next()) {
					int seq = rs.getInt(1);
					String sender = rs.getString(2);
					String receiver = rs.getString(3);
					String content = rs.getString(4);
					Timestamp time = rs.getTimestamp(5);
					String read = rs.getString(6);
					list.add(new MessageDTO(seq,sender,receiver,content,time,read));
				} return list;
			}
		}
	}
	public int getTotalSearchedArticles(String sender, String contents) throws Exception {
		String sql = "select count(*) from tb_message where msg_sender like ? and msg_contents like ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, sender);
			pstat.setString(2, contents);
			try (
				ResultSet rs = pstat.executeQuery();
					) {
				rs.next();
				return rs.getInt(1);
			}
		}
	};
	// search pagination
	public String searchPagination(int entryPage, int totalMsgs, String href, String option, String searchWord) throws Exception {
		int articlesPerPage = Configuration.recordCountPerPage;
		int naviPerPage = 5;
		int totalArticles = totalMsgs;

		int totalPage = totalArticles / articlesPerPage;
		if (totalArticles % articlesPerPage != 0)
			totalPage += 1;

		if (entryPage > totalPage)
			entryPage = totalPage;
		if (entryPage < 1) 
			entryPage = 1;

		int startNavi = (entryPage - 1) / 10 * naviPerPage + 1;
		int lastNavi = startNavi + naviPerPage - 1;
		if (lastNavi > totalPage)
			lastNavi = totalPage;

		StringBuilder sb = new StringBuilder();
		sb.append("<li class='page-item ");
		if (startNavi == 1) sb.append("disabled");
		sb.append("'>");
		sb.append("<a class='page-link' "
				+ "href='"+ href + "?entry=" + (startNavi - 1)
				+ "&option=" + option + "&search=" + searchWord + "' tabindex='-1'>&lt;</a></li>");
		for (int i = startNavi; i <= lastNavi; i++) {
			sb.append("<li class='page-item ");
			if (i == entryPage) sb.append("active");
			sb.append("'><a class='page-link' href='" + href + "?entry=");
			sb.append(i + "&option=" + option + "&search=" + searchWord + "'>" + i);
			sb.append("</a></li>");
		}
		sb.append("<li class='page-item ");
		if (lastNavi == totalPage) sb.append("disabled");
		sb.append("'>");
		sb.append("<a class='page-link' "
				+ "href='" + href + "?entry=" + (lastNavi + 1)
				+ "&option=" + option + "&search=" + searchWord + "' tabindex='-1'>&gt;</a></li>");

		return sb.toString();
	}	
	// searchResult  
	public List<MessageDTO> searchResult(int entryPage, String sender, String contents) throws Exception {
		String sql = "select * from (select tb_message.*, "
				+ "row_number() over(order by msg_seq desc) as c from tb_message where msg_sender like ? and msg_contents like ?) "
				+ "where c between ? and ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			int msgsPerPage = Configuration.recordCountPerPage;
			int startMsgSeq = (entryPage - 1) * msgsPerPage + 1;
			int lastMsgSeq = startMsgSeq + msgsPerPage - 1;
			pstat.setString(1, sender);
			pstat.setString(2, contents);
			pstat.setInt(3, startMsgSeq);
			pstat.setInt(4, lastMsgSeq);
			try (
				ResultSet rs = pstat.executeQuery();
					) {
				List<MessageDTO> list = new ArrayList<>();
				while (rs.next()) {
					int seq = rs.getInt(1);
					sender = rs.getString(2);
					String receiver = rs.getString(3);
					String content = rs.getString(4);
					Timestamp time = rs.getTimestamp(5);
					String read = rs.getString(6);
					list.add(new MessageDTO(seq,sender,receiver,content,time,read));
				} return list;
			}
		}
	}

}