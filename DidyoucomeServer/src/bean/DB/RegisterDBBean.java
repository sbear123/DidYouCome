package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
			if(conn==null) return 0;
		
			String sql1 = "select * from school where name=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, user.getSchool());
				
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					user.setSchoolnum(rs.getInt("id"));
					makeUser(user);
				} else {
					user.setSchoolnum(makeShool(user.getSchool()));
					makeUser(user);
				}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
					e.printStackTrace();
			}
	
			closeConnection(conn);
			return result;
		}
		
		private int makeShool(String name) {
			String sql = "insert into school(`name`) values (?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				
				pstmt.executeUpdate();
				if(pstmt!=null) pstmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			GetSchoolDBBean school = new GetSchoolDBBean();
			return school.id(name);
		}
		
		private void makeUser(UserBean user) {
			String sql = "INSERT INTO user (`userid`, `password`, `name`, `school`, `type`, `check`) VALUES (?,?,?,?,?,?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUserid());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setInt(4, user.getSchoolnum());
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				
				result = pstmt.executeUpdate();
				if(pstmt!=null) pstmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
}
