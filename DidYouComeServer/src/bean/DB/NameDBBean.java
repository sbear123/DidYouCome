package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class NameDBBean extends CommonDBBean{
	//Singleton
	private static NameDBBean instance = new NameDBBean();
	private NameDBBean() {}
	public static NameDBBean getInstance() {
		return instance;
	}
	
	public int change(String userid, String name) {
		int result = 0;
		Connection conn = getConnection();
		if(conn==null) return 0;
		System.out.println("conn");
		
		String sql = "UPDATE user SET `name`=? WHERE (`userid`=?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
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