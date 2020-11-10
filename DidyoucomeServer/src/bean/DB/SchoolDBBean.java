package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SchoolDBBean extends CommonDBBean{
	//Singleton
	private static SchoolDBBean instance = new SchoolDBBean();
	private SchoolDBBean() {}
	public static SchoolDBBean getInstance() {
		return instance;
	}
	
	int result = 0;
	private Connection conn;
	
	public int change(String userid, String school) {
		conn = getConnection();
		if(conn==null) return 0;
	
		String sql1 = "select * from school where name=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, school);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				changeUser(userid, rs.getInt("id"));
			} else {
				changeUser(userid, makeShool(school));
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
				e.printStackTrace();
		}

		closeConnection(conn);
		return result;
	}
	
	public void changeUser(String userid, int shool) {
		Connection conn = getConnection();
		if(conn==null) return;
		System.out.println("conn");
		
		String sql = "UPDATE user SET `school` =? WHERE (`userid`=?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shool);
			pstmt.setString(2, userid);
			
			result = pstmt.executeUpdate();
			if(pstmt!=null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		closeConnection(conn);
	}
	

	private int makeShool(String name) {
		int id = 0;
		String sql = "insert into school(`name`) values (?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			
			pstmt.executeUpdate();
			if(pstmt!=null) pstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sql1 = "select * from school where name=?";
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
}