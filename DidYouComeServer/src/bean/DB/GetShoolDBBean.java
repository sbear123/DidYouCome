package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetShoolDBBean extends CommonDBBean{
	public String name(int id) {
		String name = "";
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from shool where id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		closeConnection(conn);
		return name;
	}
	
	public int id(String name) {
		int id = 0;
		Connection conn = getConnection();
		if(conn==null) return 0;
		System.out.println("conn");
		
		String sql = "select * from shool where name=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
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
		
		closeConnection(conn);
		return id;
	}
}
