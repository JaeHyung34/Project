package shareOclock.message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import configuration.Configuration;

public class MessageDAO {

	private Connection getConnection() throws Exception {
		return Configuration.dbs.getConnection();
	}

	// 메시지 초기화면 진입 
	public List<MessageDTO> viewAllMsg() throws Exception {
		String sql = "select * from tb_message order by msg_seq desc";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
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
			}
			return list;
		}
	}
	// 메시지 삽입
	public int insertMsg(MessageDTO dto ) throws Exception {
		String sql = "insert into tb_message values(msg_seq.nextval, ?, ?, ?, sysdate,'n')";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, dto.getMessage_sender());
			pstat.setString(2, dto.getMessage_receiver());
			pstat.setString(3, dto.getMessage_contents());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	
	// 메시지 모두 읽음으로 표시
	public int readAll(String receiver) throws Exception {
		String sql = "update tb_message set msg_read = 'y' where msg_receiver=?";
		try (
				Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, receiver);
			return pstat.executeUpdate();
		}
	}
	
	// 메시지 읽음으로 표시
	public int read(int seq) throws Exception {
		String sql = "update tb_message set msg_read='y' where msg_seq=?";
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
	//
}
