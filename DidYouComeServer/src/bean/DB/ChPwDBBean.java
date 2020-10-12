package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ChPwDBBean extends CommonDBBean{
	//Singleton
	private static ChPwDBBean instance = new ChPwDBBean();
	private ChPwDBBean() {}
	public static ChPwDBBean getInstance() {
		return instance;
	}
	
	public int change(String userid, String password) {
		int result = 0;
		Connection conn = getConnection();
		if(conn==null) return 0;
		System.out.println("conn");
		
		String sql = "UPDATE user SET `password`=? WHERE (`userid` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
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