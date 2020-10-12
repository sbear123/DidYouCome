package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TimeBean;


public class CheckInDBBean extends CommonDBBean{
	//Singleton
	private static CheckInDBBean instance = new CheckInDBBean();
	private CheckInDBBean() {}
	public static CheckInDBBean getInstance() {
		return instance;
	}
	
	public int checkIn(String userid) {
		int result = 0;
		Connection conn = getConnection();
		if(conn==null) return 0;
		System.out.println("conn");
		TimeBean time = new TimeBean();
		
		String sql = "UPDATE user SET `check`=?,`time`=? WHERE (`userid` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setString(2, time.getTime());
			pstmt.setString(3, userid);
			
			result = pstmt.executeUpdate();
			if(pstmt!=null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		closeConnection(conn);
		return result;
	}
}