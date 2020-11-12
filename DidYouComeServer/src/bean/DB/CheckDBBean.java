package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.CheckBean;

public class CheckDBBean  extends CommonDBBean{
	//Singleton
	private static CheckDBBean instance = new CheckDBBean();
	private CheckDBBean() {}
	public static CheckDBBean getInstance() {
		return instance;
	}
	
	public CheckBean check(String userid) {
		CheckBean result = null;
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from user where userid=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result = new CheckBean();
				result.setCheck(rs.getInt("check"));
				if (result.getCheck() == 1) {
					result.setCheckType("입실");
				}else {
					result.setCheckType("퇴실");
				}
				result.setName(rs.getString("name"));
				result.setTime(rs.getString("time"));
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
