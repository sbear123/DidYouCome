package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


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
		
		String sql = "UPDATE user SET check =? WHERE userid = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "퇴실");
			pstmt.setString(2, userid);
			
			result = pstmt.executeUpdate();
			if(pstmt!=null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		closeConnection(conn);
		return result;
	}
}