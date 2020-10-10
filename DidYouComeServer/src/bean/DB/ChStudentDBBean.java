package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CheckBean;

public class ChStudentDBBean extends CommonDBBean{
	//Singleton
	private static ChStudentDBBean instance = new ChStudentDBBean();
	private ChStudentDBBean() {}
	public static ChStudentDBBean getInstance() {
		return instance;
	}
	
	public List<CheckBean> list(String userid) {
		CheckBean result = null;
		List<CheckBean> list = new ArrayList<>();
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from user where userid=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				result = new CheckBean();
				result.setCheck(rs.getString("check"));
				result.setName(rs.getString("name"));
				result.setTime(rs.getString("time"));
				list.add(result);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		closeConnection(conn);
		return list;
	}
}