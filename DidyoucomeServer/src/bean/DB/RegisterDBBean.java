package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TimeBean;
import bean.UserBean;

public class RegisterDBBean extends CommonDBBean {
	//Singleton
		private static RegisterDBBean instance = new RegisterDBBean();
		private RegisterDBBean() {}
		public static RegisterDBBean getInstance() {
			return instance;
		}
		
		int result = 0;
		private Connection conn;
		
		public int register(UserBean user) {
			conn = getConnection();
			TimeBean time = new TimeBean();
			String sql = "INSERT INTO user (`userid`, `password`, `name`, `school`, `type`, `check`, `time`) VALUES (?,?,?,?,?,?,?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUserid());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setInt(4, user.getSchoolnum());
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				pstmt.setString(7, time.getTime());
				
				result = pstmt.executeUpdate();
				if(pstmt!=null) pstmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			closeConnection(conn);
			return result;
		}
}
