package bean;

import java.util.List;

public class ResultBean {
	public String result;
	private String type;
	
	private List<CheckBean> user;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public ResultBean() {
		this.result = "fail";
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	public List<CheckBean> getUser() {
		return user;
	}

	public void setUser(List<CheckBean> user) {
		this.user = user;
	}

}
