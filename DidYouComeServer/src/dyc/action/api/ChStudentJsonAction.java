package dyc.action.api;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;
import java.util.List;

import bean.CheckBean;
import bean.UserBean;
import bean.DB.ChStudentDBBean;
import dyc.action.Action;

public class ChStudentJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		List<CheckBean> list = new ArrayList<>();
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class); 
		
		list = ChStudentDBBean.getInstance().list(requestUser.getUserid());
		
		String json = gson.toJson(list).toString();
		
		return json;
	}
}
