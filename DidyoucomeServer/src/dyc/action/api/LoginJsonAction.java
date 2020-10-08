package dyc.action.api;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;

import bean.ResultBean;
import bean.UserBean;
import bean.DB.LoginDBBean;
import dyc.action.Action;

public class LoginJsonAction implements Action {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		ResultBean result = new ResultBean(); // return�뿉 �뵲�씪 �떖�씪吏��뒗 遺�遺� 
		
		// input
		String str = IOUtils.toString(request.getReader());
		UserBean requestUser = gson.fromJson(str, UserBean.class); // input�뿉 �뵲�씪 �떖�씪吏��뒗 遺�遺� 
		
		System.out.println(str);
		
		UserBean user = LoginDBBean.getInstance().login(requestUser.getUserId(), requestUser.getPassword());
		if(user!=null)
			result.result="ok";
		
		return gson.toJson(result, ResultBean.class);
	}
}
