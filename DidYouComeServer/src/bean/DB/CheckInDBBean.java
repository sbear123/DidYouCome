package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TimeBean;
import bean.UserBean;


public class CheckInDBBean extends CommonDBBean{
	//Singleton
	private static CheckInDBBean instance = new CheckInDBBean();
	private CheckInDBBean() {}
	public static CheckInDBBean getInstance() {
		return instance;
	}
	
	public UserBean checkIn(String userid) {
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		TimeBean time = new TimeBean();
		
		String sql = "UPDATE user SET `check`=?,`time`=? WHERE (`userid` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setString(2, time.getTime());
			pstmt.setString(3, userid);
			
			pstmt.executeUpdate();
			if(pstmt!=null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn);
		}
		
		UserBean user = new UserBean();
		user.setCheckType("입실");
		user.setTime(time.getTime());
		
		return user;
	}
}