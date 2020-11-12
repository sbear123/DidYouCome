package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.UserBean;

public class GetUserDBBean extends CommonDBBean{
	//Singleton
	private static GetUserDBBean instance = new GetUserDBBean();
	private GetUserDBBean() {}
	public static GetUserDBBean getInstance() {
		return instance;
	}
	
	public UserBean getUserData(String userid) {
		Connection conn = getConnection();
		UserBean result = new UserBean();
		if(conn==null) return result;
		System.out.println("conn");
		
		String sql = "select * from user where userid=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				if (rs.getInt("check") == 1) {
					result.setCheckType("입실");
				}else {
					result.setCheckType("퇴실");
				}
				result.setName(rs.getString("name"));
				GetSchoolDBBean school = new GetSchoolDBBean();
				result.setSchool(school.name(rs.getInt("school"),conn));
				result.setPassword(rs.getString("password"));
				result.setTime(rs.getString("time"));
				result.setUserId(rs.getString("userid"));
				
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