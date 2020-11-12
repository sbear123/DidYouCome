package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TimeBean;
import bean.UserBean;


public class CheckOutDBBean extends CommonDBBean{
	//Singleton
	private static CheckOutDBBean instance = new CheckOutDBBean();
	private CheckOutDBBean() {}
	public static CheckOutDBBean getInstance() {
		return instance;
	}
	
	public UserBean checkOut(String userid) {
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		TimeBean time = new TimeBean();
		
		String sql = "UPDATE user SET `check` =?,`time`=? WHERE (`userid` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
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
		user.setCheckType("퇴실");
		user.setTime(time.getTime());
		
		return user;
	}
}