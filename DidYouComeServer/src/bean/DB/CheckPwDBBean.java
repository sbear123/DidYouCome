package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bean.ResultBean;

public class CheckPwDBBean extends CommonDBBean{
	//Singleton
	private static CheckPwDBBean instance = new CheckPwDBBean();
	private CheckPwDBBean() {}
	public static CheckPwDBBean getInstance() {
		return instance;
	}
	
	public ResultBean check(String userid, String password) {
		ResultBean result = new ResultBean();
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from user where userid=? and password=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result.setResult("ok");
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn);
		}
		
		return result;
	}
	
}
