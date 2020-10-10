package dyc.action.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;

import bean.ResultBean;
import bean.UserBean;
import bean.DB.CheckInDBBean;
import dyc.action.Action;

public class CheckInJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		ResultBean result = new ResultBean();
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class); 
		
		int count = CheckInDBBean.getInstance().checkIn(requestUser.getUserid());
		if(count==1)
			result.result="ok";
		
		return gson.toJson(result, ResultBean.class);
	}
}
