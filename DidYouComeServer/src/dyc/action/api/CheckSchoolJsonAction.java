package dyc.action.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;

import bean.ResultBean;
import bean.UserBean;
import bean.DB.CheckSchoolDBBean;
import dyc.action.Action;

public class CheckSchoolJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class); 
		
		ResultBean user = CheckSchoolDBBean.getInstance().check(requestUser.getSchool());
		
		return gson.toJson(user, UserBean.class);
	}
}