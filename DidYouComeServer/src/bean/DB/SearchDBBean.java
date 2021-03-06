package bean.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CheckBean;

public class SearchDBBean extends CommonDBBean{
	//Singleton
	private static SearchDBBean instance = new SearchDBBean();
	private SearchDBBean() {}
	public static SearchDBBean getInstance() {
		return instance;
	}
	
	public List<CheckBean> list(String id, String name) {
		CheckBean result = null;
		List<CheckBean> list = new ArrayList<>();
		Connection conn = getConnection();
		if(conn==null) return null;
		System.out.println("conn");
		
		String sql = "select * from user where name LIKE ? and type=0 and school=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ("%"+name+"%"));
			pstmt.setInt(2, getschool(id, conn));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				result = new CheckBean();
				result.setCheck(rs.getInt("check"));
				if (result.getCheck() == 1) {
					result.setCheckType("입실");
				}else {
					result.setCheckType("퇴실");
				}
				result.setName(rs.getString("name"));
				result.setTime(rs.getString("time"));
				list.add(result);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn);
		}
		
		return list;
	}
	
	private int getschool(String id, Connection conn) {
		int school = 0;
		
		String sql = "select * from user where userid=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				school = rs.getInt("school");
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return school;
	}
}