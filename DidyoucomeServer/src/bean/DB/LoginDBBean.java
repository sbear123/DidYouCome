package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.UserBean;

public class LoginDBBean extends CommonDBBean{
	//Singleton
	private static LoginDBBean instance = new LoginDBBean();
	private LoginDBBean() {}
	public static LoginDBBean getInstance() {
		return instance;
	}
	
	public UserBean login(String userid, String password) {
		UserBean user=null;
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from user where userid=? and password=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2,  password);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				user = new UserBean();
				user.setUserId(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		closeConnection(conn);
		return user;
	}
}
