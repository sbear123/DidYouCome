package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.ResultBean;

public class CheckSchoolDBBean  extends CommonDBBean{
	//Singleton
	private static CheckSchoolDBBean instance = new CheckSchoolDBBean();
	private CheckSchoolDBBean() {}
	public static CheckSchoolDBBean getInstance() {
		return instance;
	}
	
	public ResultBean check(String school) {
		ResultBean result = new ResultBean();
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from school where name=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, school);
			
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
