package bean;

import java.util.List;

public class ResultBean {
	public String result;
	private String school;
	private String type;
	private String name;
	
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

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
