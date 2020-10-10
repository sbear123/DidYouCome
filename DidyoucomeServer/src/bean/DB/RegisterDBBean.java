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
		
			String sql1 = "select * from shool where name=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, user.getShool());
				
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					user.setShoolnum(rs.getInt("id"));
					makeUser(user);
				} else {
					user.setShoolnum(makeShool(user.getShool()));
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
			int id = 0;
			String sql = "insert into shool(name) values (?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				
				pstmt.executeUpdate();
				if(pstmt!=null) pstmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			String sql1 = "select * from shool where name=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, name);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					id = rs.getInt("id");
				}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return id;
		}
		
		private void makeUser(UserBean user) {
			String sql = "insert into user(userid, password, name, shool, type) values (?,?,?,?,?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUserid());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setInt(4, user.getShoolnum());
				pstmt.setBoolean(5, false);
				
				result = pstmt.executeUpdate();
				if(pstmt!=null) pstmt.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
}
