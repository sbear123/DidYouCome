package dyc.action.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;

import bean.CheckBean;
import bean.UserBean;
import bean.DB.CheckDBBean;
import dyc.action.Action;

public class CheckJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		CheckBean check = new CheckBean();
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class); 
		
		check = CheckDBBean.getInstance().check(requestUser.getUserid());
		
		return gson.toJson(check, CheckBean.class);
	}
}
