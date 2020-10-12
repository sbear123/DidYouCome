package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TimeBean;


public class CheckOutDBBean extends CommonDBBean{
	//Singleton
	private static CheckOutDBBean instance = new CheckOutDBBean();
	private CheckOutDBBean() {}
	public static CheckOutDBBean getInstance() {
		return instance;
	}
	
	public int checkOut(String userid) {
		int result = 0;
		Connection conn = getConnection();
		if(conn==null) return 0;
		System.out.println("conn");
		TimeBean time = new TimeBean();
		
		String sql = "UPDATE user SET `check` =?,`time`=? WHERE (`userid` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
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