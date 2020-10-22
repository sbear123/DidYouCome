package dyc.action.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;

import bean.CheckBean;
import bean.UserBean;
import bean.DB.GetUserDBBean;
import dyc.action.Action;

public class GetUserJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		CheckBean json = new CheckBean(); 
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class);
		
		System.out.println(str);
		
		json = GetUserDBBean.getInstance().getUserData(requestUser.getUserid());
		
		return gson.toJson(json, CheckBean.class);
	}
}
